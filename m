Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262125AbSJJSs1>; Thu, 10 Oct 2002 14:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbSJJSs1>; Thu, 10 Oct 2002 14:48:27 -0400
Received: from mario.gams.at ([194.42.96.10]:21572 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S262125AbSJJSsX> convert rfc822-to-8bit;
	Thu, 10 Oct 2002 14:48:23 -0400
Message-Id: <200210101854.g9AIs4K23018@frodo.gams.co.at>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20pre8aa2 failed assertions in ip_{conntrack,nat}_core.c
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 10 Oct 2002 20:54:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all !

[1.] 2.4.20pre8aa2 failed assertions in ip_{conntrack,nat}_core.c

[2.] Full description of the problem/report:
I'm running 2.4.20pre8aa2 with all the firewalling stuff enabled 
on a Pentium 75 and get occasionally
----  snip (lines broken to keep it readable) ----
Oct 10 20:00:04 fw kernel: ASSERT ip_conntrack_core.c:97
                             &ip_conntrack_lock readlocked 
Oct 10 20:00:04 fw kernel: ASSERT ip_conntrack_core.c:1067
                             &ip_conntrack_lock not readlocked 
Oct 10 20:00:04 fw kernel: ASSERT: ip_nat_core.c:841
                             &ip_conntrack_lock not readlocked 
Oct 10 20:00:04 fw kernel: ASSERT ip_conntrack_core.c:97
                             &ip_conntrack_lock readlocked 
Oct 10 20:00:04 fw kernel: ASSERT: ip_nat_core.c:841
                             &ip_conntrack_lock not readlocked 
----  snip  ----
Otherwise everything is working fine.

[3.] Keywords (i.e., modules, networking, kernel):
     networking, firewalling, connection-tracking

[4.] Kernel version (from /proc/version):
Linux version 2.4.20-pre8aa2 (...) (gcc version 2.95.4 20010319
(prerelease/franzo/20011204)) #2 Wed Oct 9 20:43:34 CEST 2002

[6.] A small shell script or example program which triggers the
     problem (if possible)
Simply http'ing or ftp'ing trigger it occasionally. The symptom is 
that a particular (TCP-)connection "freezes".

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11b
mount                  2.10r
modutils               2.4.18
e2fsprogs              1.25
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 4
cpu MHz         : 75.021
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 149.50

[7.3.] Module information (from /proc/modules):
No modules enabled.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
10#cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0300-031f : eth1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
e400-e47f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
  e400-e47f : 00:09.0
e800-e80f : Intel Corp. 82371FB PIIX IDE [Triton I]
  e800-e807 : ide0
  e808-e80f : ide1
11#cat /proc/iomem   
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-05ffffff : System RAM
  00100000-002116b5 : Kernel code
  002116b6-00258d57 : Kernel data
10000000-13ffffff : S3 Inc. 86c968 [Vision 968 VRAM] rev 0
e7000000-e700007f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
Omitted since it is far more than 80 chars wide and IMHO not 
interesting in this case. Can actually send it if someone wishes.

[7.6.] SCSI information (from /proc/scsi/scsi)
No SCSI hardware.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
Actually don't know really in this case. Is there any interesting?

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


