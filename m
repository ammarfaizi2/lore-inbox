Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRDEXrh>; Thu, 5 Apr 2001 19:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRDEXrT>; Thu, 5 Apr 2001 19:47:19 -0400
Received: from munch-it.turbolinux.com ([38.170.88.129]:42997 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S129638AbRDEXq7>;
	Thu, 5 Apr 2001 19:46:59 -0400
Date: Thu, 5 Apr 2001 16:46:08 -0700
From: Prasanna P Subash <psubash@turbolinux.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Marcus Meissner <mm@jet.caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: [Problem] 3c90x on 2.4.3-ac3
Message-ID: <20010405164608.A3565@turbolinux.com>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE80E@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE80E@orsmsx35.jf.intel.com>; from Grover, Andrew on Thu, Apr 05, 2001 at 11:40:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 05, 2001 at 11:40:36AM -0700, Grover, Andrew wrote:
> I'm confused. 3c59x.c has a little acpi WOL stuff, but that's it.



I tried "#ifdef 0"-ing the set_WOL function body( empty function ) in
3c59x.c and enabled acpi and built another kernel
and I still have the problem.

So its NOT a problem with the ACPI code in 3c59x.c per se.


I noticed that the following message was from net/core/netfilter.c( i
got this message on running dhclient )

ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN

so i diabled netfilter also, and I still had the issue.



I assigned a static IP. ifconfig showed me the right info.
"route" however froze most of the times. I have 2 routes

172.16.12.0     *               255.255.252.0   U     0      0        0 eth0
default         172.16.12.1     0.0.0.0         UG    0      0        0 eth0

It would freeze after the first one most often. If it did'nt, do a ping www.google.com,
which will drop all the packets, and try route again, and it would freeze after the first route.

I strace'd route and noticed that I was waiting on "poll". I have attached the strace 
info on route.


> 
> What specifically is ACPI doing to break things? Are ACPI and the NIC
> sharing any resources?

I dont know about sharing resources. I have attached my dmesg.

The whole thing works like a charm under APM however.

I'm gonna try increasing vortex_debug level to see what happens.

would be glad to furnish more info...


-Prasanna Subash
psubash@turbolinux.com



> 
> Regards -- Andy
> 
> > -----Original Message-----
> > From: Prasanna P Subash [mailto:psubash@turbolinux.com]
> > Sent: Thursday, April 05, 2001 11:12 AM
> > To: Marcus Meissner
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: [Problem] 3c90x on 2.4.3-ac3
> > Importance: High
> > 
> > 
> > Thats right. ACPI was what made 3c90x not work :( With APM it 
> > works perfectly.
> > 
> > Thanks Marcus.
> > 
> > On Thu, Apr 05, 2001 at 10:14:56AM +0200, Marcus Meissner wrote:
> > > In article <20010404180709.A564@turbolinux.com> you wrote:
> > > 
> > > > hi lkml,
> > > > 	I just built 2.4.3-ac3 with my old 2.4.2 .config and 
> > somehow networking does not work. 
> > > > dhclient eventually froze the machine.
> > > 
> > > > here is what dhclient complains.
> > > 
> > > > [root@psubash linux]# cat /tmp/error.txt
> > > > skb: pf=2 (unowned) dev=lo len=328
> > > > PROTO=17 0.0.0.0:68 255.255.255.255:67 L=328 S=0x10 I=0 
> > F=0x0000 T=16
> > > > DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 14
> > > > ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
> > > > skb: pf=2 (unowned) dev=lo len=328
> > > > PROTO=17 0.0.0.0:68 255.255.255.255:67 L=328 S=0x10 I=0 
> > F=0x0000 T=16
> > > > DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 9
> > > > DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
> > > > DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 12
> > > > ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
> > > > skb: pf=2 (unowned) dev=lo len=328
> > > 
> > > > Here is my ver_linux info
> > > 
> > > ...
> > > > CONFIG_ACPI=y
> > > 
> > > The ACPI powermanagement for the 3c59x devices appears to 
> > be a bit broken.
> > > 
> > > Disable ACPI support. Recompile. Reboot. Watch problem 
> > disappear hopefully.
> > > 
> > > Ciao, Marcus
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="route.txt"

execve("/sbin/route", ["route"], [/* 26 vars */]) = 0
brk(0)                                  = 0x80527a8
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=33735, ...}) = 0
old_mmap(NULL, 33735, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=5173447, ...}) = 0
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\215\1"..., 4096) = 4096
old_mmap(NULL, 947548, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001d000
mprotect(0x400fd000, 30044, PROT_NONE)  = 0
old_mmap(0x400fd000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xdf000) = 0x400fd000
old_mmap(0x40101000, 13660, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40101000
close(3)                                = 0
mprotect(0x4001d000, 917504, PROT_READ|PROT_WRITE) = 0
mprotect(0x4001d000, 917504, PROT_READ|PROT_EXEC) = 0
munmap(0x40014000, 33735)               = 0
personality(PER_LINUX)                  = 0
getpid()                                = 490
brk(0)                                  = 0x80527a8
brk(0x80527c8)                          = 0x80527c8
brk(0x8053000)                          = 0x8053000
open("/proc/net/route", O_RDONLY)       = 3
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(4, 1), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
write(1, "Kernel IP routing table\n", 24) = 24
write(1, "Destination     Gateway         "..., 78) = 78
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
read(3, "Iface\tDestination\tGateway \tFlags"..., 4096) = 384
open("/etc/nsswitch.conf", O_RDONLY)    = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1782, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
read(4, "#\n# /etc/nsswitch.conf\n#\n# An ex"..., 4096) = 1782
brk(0x8054000)                          = 0x8054000
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40016000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=33735, ...}) = 0
old_mmap(NULL, 33735, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40105000
close(4)                                = 0
open("/lib/libnss_files.so.2", O_RDONLY) = 4
fstat(4, {st_mode=S_IFREG|0755, st_size=290873, ...}) = 0
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\36"..., 4096) = 4096
old_mmap(NULL, 37944, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4010e000
mprotect(0x40117000, 1080, PROT_NONE)   = 0
old_mmap(0x40117000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x8000) = 0x40117000
close(4)                                = 0
munmap(0x40105000, 33735)               = 0
gettimeofday({986489119, 618805}, NULL) = 0
getpid()                                = 490
open("/etc/resolv.conf", O_RDONLY)      = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=108, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
read(4, "domain dev.us.tlan\nsearch dev.us"..., 4096) = 108
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40016000, 4096)                = 0
open("/etc/networks", O_RDONLY)         = -1 ENOENT (No such file or directory)
write(1, "172.16.12.0     *               "..., 77) = 77
socket(PF_UNIX, SOCK_STREAM, 0)         = 4
connect(4, {sin_family=AF_UNIX, path="                                                                                       /var/run/.nscd_socket"}, 110) = -1 ENOENT (No such file or directory)
close(4)                                = 0
open("/etc/host.conf", O_RDONLY)        = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=26, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
read(4, "order hosts,bind\nmulti on\n", 4096) = 26
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40016000, 4096)                = 0
open("/etc/hosts", O_RDONLY)            = 4
fcntl(4, F_GETFD)                       = 0
fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=333, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
read(4, "# TurboLinux /etc/hosts table\n# "..., 4096) = 333
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40016000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=33735, ...}) = 0
old_mmap(NULL, 33735, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40105000
close(4)                                = 0
open("/lib/libnss_nisplus.so.2", O_RDONLY) = 4
fstat(4, {st_mode=S_IFREG|0755, st_size=376814, ...}) = 0
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\35\0"..., 4096) = 4096
old_mmap(NULL, 44600, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40118000
mprotect(0x40122000, 3640, PROT_NONE)   = 0
old_mmap(0x40122000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x9000) = 0x40122000
close(4)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 4
fstat(4, {st_mode=S_IFREG|0755, st_size=512952, ...}) = 0
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P<\0\000"..., 4096) = 4096
brk(0x8055000)                          = 0x8055000
old_mmap(NULL, 92040, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40123000
mprotect(0x40136000, 14216, PROT_NONE)  = 0
old_mmap(0x40136000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x12000) = 0x40136000
old_mmap(0x40138000, 6024, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40138000
close(4)                                = 0
munmap(0x40105000, 33735)               = 0
uname({sys="Linux", node="psubash", ...}) = 0
open("/var/nis/NIS_COLD_START", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=33735, ...}) = 0
old_mmap(NULL, 33735, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40105000
close(4)                                = 0
open("/lib/libnss_nis.so.2", O_RDONLY)  = 4
fstat(4, {st_mode=S_IFREG|0755, st_size=368279, ...}) = 0
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\35"..., 4096) = 4096
old_mmap(NULL, 41344, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4013a000
mprotect(0x40143000, 4480, PROT_NONE)   = 0
old_mmap(0x40143000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x8000) = 0x40143000
close(4)                                = 0
munmap(0x40105000, 33735)               = 0
uname({sys="Linux", node="psubash", ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=33735, ...}) = 0
old_mmap(NULL, 33735, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40105000
close(4)                                = 0
open("/lib/libnss_dns.so.2", O_RDONLY)  = 4
fstat(4, {st_mode=S_IFREG|0755, st_size=70612, ...}) = 0
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\r\0"..., 4096) = 4096
old_mmap(NULL, 15336, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40016000
mprotect(0x40019000, 3048, PROT_NONE)   = 0
old_mmap(0x40019000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x2000) = 0x40019000
close(4)                                = 0
open("/lib/libresolv.so.2", O_RDONLY)   = 4
fstat(4, {st_mode=S_IFREG|0755, st_size=194221, ...}) = 0
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000%\0\000"..., 4096) = 4096
old_mmap(NULL, 62492, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40145000
mprotect(0x40151000, 13340, PROT_NONE)  = 0
old_mmap(0x40151000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0xb000) = 0x40151000
old_mmap(0x40152000, 9244, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40152000
close(4)                                = 0
munmap(0x40105000, 33735)               = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
connect(4, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("172.23.1.1")}}, 16) = 0
send(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0) = 42
time(NULL)                              = 986489119
poll([{fd=4, events=POLLIN}], 1, 5000)  = -1 EINTR (Interrupted system call)
time(NULL)                              = 986489122
poll([{fd=4, events=POLLIN}], 1, 2000)  = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("38.170.88.11")}}, 16) = 42
time(NULL)                              = 986489124
poll([{fd=4, events=POLLIN}], 1, 5000)  = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("38.170.88.12")}}, 16) = 42
time(NULL)                              = 986489129
poll([{fd=4, events=POLLIN}], 1, 5000)  = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("172.23.1.1")}}, 16) = 42
time(NULL)                              = 986489134
poll([{fd=4, events=POLLIN}], 1, 3000)  = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("38.170.88.11")}}, 16) = 42
time(NULL)                              = 986489137
poll([{fd=4, events=POLLIN}], 1, 3000)  = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("38.170.88.12")}}, 16) = 42
time(NULL)                              = 986489140
poll([{fd=4, events=POLLIN}], 1, 3000)  = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("172.23.1.1")}}, 16) = 42
time(NULL)                              = 986489143
poll([{fd=4, events=POLLIN}], 1, 6000)  = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("38.170.88.11")}}, 16) = 42
time(NULL)                              = 986489149
poll([{fd=4, events=POLLIN}], 1, 6000)  = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("38.170.88.12")}}, 16) = 42
time(NULL)                              = 986489155
poll([{fd=4, events=POLLIN}], 1, 6000)  = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("172.23.1.1")}}, 16) = 42
time(NULL)                              = 986489161
poll([{fd=4, events=POLLIN}], 1, 13000) = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("38.170.88.11")}}, 16) = 42
time(NULL)                              = 986489174
poll([{fd=4, events=POLLIN}], 1, 13000) = 0
close(4)                                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
sendto(4, "\321\301\1\0\0\1\0\0\0\0\0\0\0011\00212\00216\003172\7"..., 42, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("38.170.88.12")}}, 16) = 42
time(NULL)                              = 986489187
poll([{fd=4, events=POLLIN}], 1, 13000) = 0
close(4)                                = 0
write(1, "default         172.16.12.1     "..., 77) = 77
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40015000, 4096)                = 0
munmap(0x40014000, 4096)                = 0
_exit(0)                                = ?

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.4.3-ac3 (root@psubash) (gcc version 2.95.2.1 19991024 (release)) #12 Thu Apr 5 15:30:39 PDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ffdc00 (usable)
 BIOS-e820: 0000000007ffdc00 - 0000000007fffc00 (ACPI data)
 BIOS-e820: 0000000007fffc00 - 0000000008000000 (ACPI NVS)
 BIOS-e820: 00000000fffe7000 - 0000000100000000 (reserved)
On node 0 totalpages: 32765
zone(0): 4096 pages.
zone(1): 28669 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: BOOT_IMAGE=acpi ro root=305
Initializing CPU#0
Detected 548.744 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1094.45 BogoMIPS
Memory: 126400k/131060k available (1185k kernel code, 4272k reserved, 446k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Katmai) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 548.7596 MHz.
..... host bus clock speed is 99.7742 MHz.
cpu: 0, clocks: 997742, slice: 498871
CPU0<T0:997728,T1:498848,D:9,S:498871,C:997742>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd9b4, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 83949kB/27983kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
hda: IBM-DPTA-372050, ATA DISK drive
hdc: CREATIVE CD5230E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63
hdc: ATAPI 52X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 5 for device 00:0f.0
3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000,  00:50:da:82:0e:5e, IRQ 5
  product code 5842 rev 00.12 date 11-13-99
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
eth0: scatter/gather enabled. h/w checksums enabled
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf8000000
Creative EMU10K1 PCI Audio Driver, version 0.7, 12:19:15 Apr  5 2001
PCI: Found IRQ 10 for device 00:0e.0
emu10k1: EMU10K1 rev 7 model 0x8027 found, IO at 0x10a0-0x10bf, IRQ 10
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
PCI: Found IRQ 9 for device 00:07.2
uhci.c: USB UHCI at I/O 0x1080, IRQ 9
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
ACPI: Core Subsystem version [20010208]
ACPI: Subsystem enabled
ACPI: System firmware supports: C2 C3
ACPI: plvl2lat=10 plvl3lat=20
ACPI: C2 enter=143 C2 exit=35
ACPI: C3 enter=858 C3 exit=71
ACPI: Using ACPI idle
ACPI: If experiencing system slowness, try adding "acpi=no-idle" to cmdline
ACPI: System firmware supports: S0 S1 S5
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
eth0: using NWAY device table, not 8
IP-Config: Incomplete network configuration information.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 136512k swap-space (priority -1)
eth0: using NWAY device table, not 8

--OXfL5xGRrasGEqWY--
