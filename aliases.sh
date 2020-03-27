cidr2list(){ #Ouptuts full list of IPs from a x.x.x.x/xx
	nmap -sL -n $1 | awk '/Nmap scan report/{print $NF}'
}

nmall(){ #runs nmap for all assets on parameter file and creates one folder per asset with the resuts inside
cat $1 | while read line 
do
	cidr2list $line | while read ip
	do
    	mkdir $ip
    	nmap -sS -A -PN -p- --script=http-title $ip > $ip/nmap.txt &
	done
done
}
