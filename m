Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263517AbRFNVRt>; Thu, 14 Jun 2001 17:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263488AbRFNVRj>; Thu, 14 Jun 2001 17:17:39 -0400
Received: from ip116.gte31.rb1.bel.nwlink.com ([207.202.209.116]:2616 "EHLO
	lily.altaserv.net") by vger.kernel.org with ESMTP
	id <S263517AbRFNVR0>; Thu, 14 Jun 2001 17:17:26 -0400
Date: Thu, 14 Jun 2001 14:17:11 -0700 (PDT)
From: <chuckw@altaserv.net>
X-X-Sender: <chuckw@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.2.19 -> 80% Packet Loss 
Message-ID: <Pine.LNX.4.33.0106141325210.20189-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. When pinging a machine using kernel 2.2.19 I consistently get an 80%
packet loss when doing a ping -f with a packet size of 64590 or higher.


2. A "ping -f -s 64589" to a machine running kernel 2.2.19 results in 0%
packet loss. By incrementing the packetsize by one "ping -f -s 64590"  or
higher, I consistently see 80% packet loss. ifconfig on the receiving
machine shows no anomolies.


3. 2.2.19, ping, flood, 64589, 64590, 80%, packet, loss


4. Linux version 2.2.19-7.0.1 (root@porky.devel.redhat.com) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Apr 10 00:55:03
EDT 2001


5. There was no oops associated with this.


6. >>EOF
/bin/ping -f -s 64589
/bin/ping -f -s 64590
EOF


7.1  /usr/src/linux-2.2.19/scripts/ver_linux
Linux orchid 2.2.19-7.0.1 #1 Tue Apr 10 00:55:03 EDT 2001 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10r
modutils               2.3.21
e2fsprogs              1.18
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         autofs nfsd lockd sunrpc 3c59x agpgart usb-uhci
usbcore


7.2 cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 751.725
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr xmm
bogomips	: 1500.77


7.3 cat /proc/modules
autofs                  9424   3 (autoclean)
nfsd                  182752   8 (autoclean)
lockd                  45264   1 (autoclean) [nfsd]
sunrpc                 61808   1 (autoclean) [nfsd lockd]
3c59x                  21584   1 (autoclean)
agpgart                18960   0 (unused)
usb-uhci               18736   0 (unused)
usbcore                43120   1 [usb-uhci]


7.4 No SCSI devices


7.5 /sbin/ifconfig (after sending it several pings with 80% packet loss)

eth0      Link encap:Ethernet  HWaddr 00:60:97:D7:60:E4
          inet addr:10.0.0.102  Bcast:10.0.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3972983 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5466442 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:12 Base address:0xa800

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:210 errors:0 dropped:0 overruns:0 frame:0
          TX packets:210 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0


X. This has only been tested/observed on a 10Mb as well as a newer 100Mb
LAN. This has also been observed on machines running kernel 2.2.17. Non
Linux machines (NT and Win98) were tested in the same manner and do not
show the same symptoms. I reviewed the LKML archives, grep'd in the
sources and did a string on the kernel binary and was not able to find any
useful reference to 64590, 64589 or ping losses due to packet size.

-- 
Chuck Wolber
System Administrator
AltaServ Corporation
(425)576-1202
ten.vresatla@wkcuhc

Quidquid latine dictum sit, altum viditur.

