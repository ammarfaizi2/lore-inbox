Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262095AbSJIVoq>; Wed, 9 Oct 2002 17:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262102AbSJIVoL>; Wed, 9 Oct 2002 17:44:11 -0400
Received: from mail.ipinfusion.com ([65.223.109.2]:40084 "EHLO
	gateway.ipinfusion.com") by vger.kernel.org with ESMTP
	id <S262095AbSJIVnn>; Wed, 9 Oct 2002 17:43:43 -0400
Message-ID: <3DA4A3A3.2090408@ipinfusion.com>
Date: Wed, 09 Oct 2002 14:46:11 -0700
From: Vividh Siddha <vividh@ipinfusion.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Interface address change netlink socket problem.(Patch attached)
Content-Type: multipart/mixed;
 boundary="------------080204080403070204080404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080204080403070204080404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[1.] One line summary of the problem:
When a interface address is changed using ifconfig, the netlink socket 
sends wrong intermediate messages.

[2.] Full description of the problem/report:
Imagine a interface eth0 with address 10.10.10.10, netmask 0xffffff00 
and broadcast 10.10.10.255.

For eg: if the following command is issued:
ifconfig eth0 10.10.10.50 netmask 0xffffff00 broadcast 10.10.10.255

The kernel sends the following three sets of messages on the netlink socket:

Interface address delete: (with address 10.10.10.10)
Interface address add   : (with address 10.10.10.50)

Interface address delete: (with address 10.10.10.50)
Interface address add   : (with address 10.10.10.50)

Interface address delete: (with address 10.10.10.50)
Interface address add   : (with address 10.10.10.50)

Ideally as only the interface address is changed only one address 
delete/add should be sent.

Attached patch solves this problem.

[3.] Keywords (i.e., modules, networking, kernel):
networking, kernel.

[4.] Kernel version (from /proc/version):
Linux version 2.4.19 (root@vividh.localdomain) (gcc version 2.96 
20000731 (Red Hat Linux 7.1 2.96-98)) #8 SMP Tue Oct 8 14:13:24 PDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)
None.

[6.] A small shell script or example program which triggers the
      problem (if possible)
None.

[7.] Environment
x86 Linux.

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux vividh.localdomain 2.4.19 #8 SMP Tue Oct 8 14:13:24 PDT 2002 i686 
unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         3c59x

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 0
model name	: Intel(R) Pentium(R) 4 CPU 1500MHz
stepping	: 10
cpu MHz		: 1483.119
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2955.67

[7.3.] Module information (from /proc/modules):
3c59x                  26016   2

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d800-d8ff : Intel Corp. 82801BA/BAM AC'97 Audio
dc40-dc7f : Intel Corp. 82801BA/BAM AC'97 Audio
dcd0-dcdf : Intel Corp. 82801BA/BAM SMBus
e000-efff : PCI Bus #02
   ec00-ec7f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
     ec00-ec7f : 02:0c.0
   ec80-ecff : 3Com Corporation 3c905B 100BaseTX [Cyclone]
     ec80-ecff : 02:08.0
ff60-ff7f : Intel Corp. 82801BA/BAM USB (Hub #2)
   ff60-ff7f : usb-uhci
ff80-ff9f : Intel Corp. 82801BA/BAM USB (Hub #1)
   ff80-ff9f : usb-uhci
ffa0-ffaf : Intel Corp. 82801BA IDE U100
   ffa0-ffa7 : ide0
   ffa8-ffaf : ide1


00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c9800-000cbfff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ff76fff : System RAM
00100000-002979f0 : Kernel code
002979f1-00334dff : Kernel data
0ff77000-0ff95fff : ACPI Tables
0ff96000-0fffffff : reserved
f0000000-f7ffffff : Intel Corp. 82850 850 (Tehama) Chipset Host Bridge (MCH)
f8000000-f9ffffff : PCI Bus #01
f8000000-f9ffffff : nVidia Corporation Riva TnT2 [NV5]
fc000000-fdffffff : PCI Bus #01
fc000000-fcffffff : nVidia Corporation Riva TnT2 [NV5]
fe100000-fe2fffff : PCI Bus #02
fe1ff800-fe1ff87f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
fe1ffc00-fe1ffc7f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffb00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
Irrelevant.

[7.6.] SCSI information (from /proc/scsi/scsi)
Irrelevant.

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
The attached file devinet.diff is a patch to the file 
linux/net/ipv4/devinet.c

This problem occurs on all kernel versions. A similar patch can be 
applied if someone faces this problem.

--------------080204080403070204080404
Content-Type: text/plain;
 name="devinet.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devinet.diff"

*** /tmp/download/linux-2.4.19/net/ipv4/devinet.c	Fri Aug  2 17:39:46 2002
--- devinet.c	Wed Oct  9 14:09:56 2002
***************
*** 609,624 ****
  				if (ifa->ifa_local == sin->sin_addr.s_addr)
  					break;
  				inet_del_ifa(in_dev, ifap, 0);
! 				ifa->ifa_broadcast = 0;
! 				ifa->ifa_anycast = 0;
  			}
  
  			ifa->ifa_address =
  			ifa->ifa_local = sin->sin_addr.s_addr;
  
  			if (!(dev->flags&IFF_POINTOPOINT)) {
- 				ifa->ifa_prefixlen = inet_abc_len(ifa->ifa_address);
- 				ifa->ifa_mask = inet_make_mask(ifa->ifa_prefixlen);
  				if ((dev->flags&IFF_BROADCAST) && ifa->ifa_prefixlen < 31)
  					ifa->ifa_broadcast = ifa->ifa_address|~ifa->ifa_mask;
  			} else {
--- 609,621 ----
  				if (ifa->ifa_local == sin->sin_addr.s_addr)
  					break;
  				inet_del_ifa(in_dev, ifap, 0);
! 
  			}
  
  			ifa->ifa_address =
  			ifa->ifa_local = sin->sin_addr.s_addr;
  
  			if (!(dev->flags&IFF_POINTOPOINT)) {
  				if ((dev->flags&IFF_BROADCAST) && ifa->ifa_prefixlen < 31)
  					ifa->ifa_broadcast = ifa->ifa_address|~ifa->ifa_mask;
  			} else {

--------------080204080403070204080404--

