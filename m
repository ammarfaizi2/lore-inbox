Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbSKTLTS>; Wed, 20 Nov 2002 06:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbSKTLTS>; Wed, 20 Nov 2002 06:19:18 -0500
Received: from chico.rediris.es ([130.206.1.3]:10739 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id <S265854AbSKTLTQ>;
	Wed, 20 Nov 2002 06:19:16 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel oopsing in ftp.es.debian.org.
Date: Wed, 20 Nov 2002 12:26:18 +0100
User-Agent: KMail/1.4.3
Cc: ender@debian.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211201226.18015.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, dear kernel developers.

	I'm just desperated. ftp.es.debian.org is oopsing again and again with a lot
of errors and I don't know what's happening.

	It seems that Apache is the process that's causing most of the oopsen, but it'll
probably be due to the lot of HTTP requests the machine is serving. After that, all the
processes you try begin to segfault or oops. Only the reset button works. :-(

	I've followed Doc/oops-tracing.txt and Reporting Linux Kernel bugs webpage for
reporting to you a couple of oops.

	Following is a lot of info:

=======
root@ulises:~# ksymoops -m /boot/System.map-2.4.20-rc2
ksymoops 2.4.6 on i686 2.4.20-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-rc2/ (default)
     -m /boot/System.map-2.4.20-rc2 (default)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Reading Oops report from the terminal
Nov 19 11:38:32 ulises kernel:  <1>Unable to handle kernel paging request at virtual address 9567b14c
Nov 19 11:38:32 ulises kernel:  printing eip:
Nov 19 11:38:32 ulises kernel: c012d183
Nov 19 11:38:32 ulises kernel: Oops: 0000
Nov 19 11:38:32 ulises kernel: CPU:    0
Nov 19 11:38:32 ulises kernel: EIP:    0010:[__free_pages_ok+499/656]    Not tainted
Nov 19 11:38:32 ulises kernel: EFLAGS: 00010002
Nov 19 11:38:32 ulises kernel: eax: 2e75ec4d   ebx: 7b56368c   ecx: db900000   edx: d4282660
Nov 19 11:38:32 ulises kernel: esi: dffea0c0   edi: 00000246   ebp: 000001f0   esp: db97fe7c
Nov 19 11:38:32 ulises kernel: ds: 0018   es: 0018   ss: 0018
Nov 19 11:38:32 ulises kernel: Process apache (pid: 1071, stackpage=db97f000)
Nov 19 11:38:32 ulises kernel: Stack: d4282660 dbb9b4c0 db97fed0 dffe4240 c01456bb dffea0c0 000001f0 d4282660
Nov 19 11:38:32 ulises kernel:        dbb9b4c0 db97fed0 00000007 c01f45c0 c01f45fb dffe4240 db97fee8 d4282660
Nov 19 11:38:32 ulises kernel:        dcd65960 db97ff14 bffffc2c 3137315b 005d3537 c01f4464 bffffc2c db97ff14
Nov 19 11:38:32 ulises kernel: Call Trace:    [clean_inode+187/192] [sys_shutdown+0/64] [sys_shutdown+59/64] [sys_recvfrom+212/272] [sock_getsockopt+453/800]
Nov 19 11:38:32 ulises kernel:   [sys_swapon+1563/1760] [sys_swapon+1594/1760] [notify_change+198/240] [getrusage+24/576] [sock_no_sendpage+3/176] [setup_irq+159/160]
Nov 19 11:38:32 ulises kernel:
Nov 19 11:38:32 ulises kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23 8b 41 04 8b 11 89 42 04

Nov 19 11:38:32 ulises kernel:  <1>Unable to handle kernel paging request at virtual address 9567b14c
Nov 19 11:38:32 ulises kernel: c012d183
Nov 19 11:38:32 ulises kernel: Oops: 0000
Nov 19 11:38:32 ulises kernel: CPU:    0
Nov 19 11:38:32 ulises kernel: EIP:    0010:[__free_pages_ok+499/656]    Not tainted
Nov 19 11:38:32 ulises kernel: EFLAGS: 00010002
Nov 19 11:38:32 ulises kernel: eax: 2e75ec4d   ebx: 7b56368c   ecx: db900000   edx: d4282660
Nov 19 11:38:32 ulises kernel: esi: dffea0c0   edi: 00000246   ebp: 000001f0   esp: db97fe7c
Nov 19 11:38:32 ulises kernel: ds: 0018   es: 0018   ss: 0018
Nov 19 11:38:32 ulises kernel: Process apache (pid: 1071, stackpage=db97f000)
Nov 19 11:38:32 ulises kernel: Stack: d4282660 dbb9b4c0 db97fed0 dffe4240 c01456bb dffea0c0 000001f0 d4282660
Nov 19 11:38:32 ulises kernel:        dbb9b4c0 db97fed0 00000007 c01f45c0 c01f45fb dffe4240 db97fee8 d4282660
Nov 19 11:38:32 ulises kernel:        dcd65960 db97ff14 bffffc2c 3137315b 005d3537 c01f4464 bffffc2c db97ff14
Nov 19 11:38:32 ulises kernel: Call Trace:    [clean_inode+187/192] [sys_shutdown+0/64] [sys_shutdown+59/64] [sys_recvfrom+212/272] [sock_getsockopt+453/800]
Nov 19 11:38:32 ulises kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23 8b 41 04 8b 11 89 42 04
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax
Code;  00000004 Before first symbol
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  00000007 Before first symbol
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  0000000a Before first symbol
   a:   75 23                     jne    2f <_EIP+0x2f> 0000002f Before first symbol
Code;  0000000c Before first symbol
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000f Before first symbol
   f:   8b 11                     mov    (%ecx),%edx
Code;  00000011 Before first symbol
  11:   89 42 04                  mov    %eax,0x4(%edx)

=======
	Information from ver_linux:

Linux ulises 2.4.20-rc2 #16 mar nov 19 10:34:01 CET 2002 i686 AMD Athlon(tm) Processor AuthenticAMD GNU/Linux

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.30-WIP
fsck.jfs: not found
reiserfsprogs          3.6.3
cardmgr: not found
pppd: not found
isdnctrl: not found
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded
=======
	The machine is Debian sarge (testing), the kernel has no modules loaded, has
1 CPU Athlon 1 GHz, 3 IDE disks (two 80 GB disks in a RAID 0 and a 13 GB one for system),
chipset VIA KT133, and a vanilla 2.4.20-rc2 kernel.

	It was also segfaulting previously with 2.4.20-pre8.

	Output of lspci:

root@ulises:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
00:0c.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02)

	The machine has the following partitions:
root@ulises:~# mount
/dev/hda2 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda1 on /boot type ext3 (rw)
/dev/hda3 on /var type ext3 (rw)
/dev/hda6 on /home type ext3 (rw)
/dev/md0 on /mirror type reiserfs (rw)

	The machine will hang in a few hours from now. It's very possible that
if I harass it with web queries the box will be down in a few minutes.

	Please don't hesitate to ask for further information.

	Thank you very much in advance,


		David.
-- 
 Why is a cow? Mu. (Ommmmmmmmmm)
--
Servicios de red - Network services
Centro de Comunicaciones CSIC/RedIRIS
Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.49.05

