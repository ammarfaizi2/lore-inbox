Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277723AbRJROJl>; Thu, 18 Oct 2001 10:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277722AbRJROJd>; Thu, 18 Oct 2001 10:09:33 -0400
Received: from adsl-65-65-114-205.dsl.rcsntx.swbell.net ([65.65.114.205]:4869
	"EHLO router.localdomain") by vger.kernel.org with ESMTP
	id <S277721AbRJROJT>; Thu, 18 Oct 2001 10:09:19 -0400
Date: Thu, 18 Oct 2001 09:07:10 -0500 (CDT)
From: Michael Schout <mschout@gkg.net>
X-X-Sender: <mschout@mike.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS in 2.2.19 : Unable to handle kernel NULL pointer dereference
Message-ID: <20011018090557.C39861-100000@mike.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

OOPS in 2.2.19 : Unable to handle kernel NULL pointer dereference

[2.] Full description of the problem/report:

kernel 2.2.19 produces this oops randomly on my machine, often locking up the
machine or portions of the machine entirely.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, filesystem, raid, smp

[4.] Kernel version (from /proc/version):

Linux version 2.2.19 (root@deathstar.gkg-com.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Fri Apr 27 10:49:53 CDT 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Options used: -V (default)
              -o /lib/modules/2.2.19 (specified)
              -k /proc/ksyms (specified)
              -l /proc/modules (specified)
              -m /boot/System.map-2.2.19 (specified)
              -c 1 (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000134
current->tss.cr3 = 172b1000, %%cr3 = 172b1000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[remove_from_queues+188/344]
EFLAGS: 00010206
eax: 00000100   ebx: df622e40   ecx: df622e40   edx: efd0ba10
esi: df622e40   edi: 00000000   ebp: c07ff820   esp: dfec3f1c
ds: 0018   es: 0018   ss: 0018
Process postmaster (pid: 29139, process nr: 46, stackpage=dfec3000)
Stack: df622e40 c012cf91 df622e40 c07ff820 00009990 dfec2000 00000015 c0121397
       c07ff820 00000015 0000001f 00000005 00000015 dfec2000 c0126746 00000005
       00000015 dfec2000 00000015 00000100 08255230 c012729b 00000015 dfec2000
Call Trace: [try_to_free_buffers+53/164] [shrink_mmap+259/352] [try_to_free_pages+66/176] [__get_free_pages+175/748] [getname+25/148] [sys_open+13/172] [system_call+52/56] [_stext+43/164]
Code: 89 50 34 c7 01 00 00 00 00 89 02 c7 41 34 00 00 00 00 ff 0d

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	89 50 34             	mov    %edx,0x34(%eax) <===
Code:  00000003 Before first symbol               3:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
Code:  00000009 Before first symbol               9:	89 02                	mov    %eax,(%edx)
Code:  0000000b Before first symbol               b:	c7 41 34 00 00 00 00 	movl   $0x0,0x34(%ecx)
Code:  00000012 Before first symbol              12:	ff 0d 00 00 00 00    	decl   0x0

[6.] A small shell script or example program which triggers the
     problem (if possible)

None available.  This happens randomly.  Sometimes within a few days, sometimes
it takes weeks.

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux deathstar.gkg-com.com 2.2.19 #1 SMP Fri Apr 27 10:49:53 CDT 2001 i686 unknown

Gnu C                  egcs-2.91.66
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10r
modutils               2.3.21
e2fsprogs              1.18
pcmcia-cs              3.1.8
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         3c59x DAC960

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.143
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips        : 999.42

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.143
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips        : 999.42

[7.3.] Module information (from /proc/modules):

3c59x                  22480   2 (autoclean)
DAC960                 60848   3

[7.4.] SCSI information (from /proc/scsi/scsi)

# cat /proc/rd/c0/current_status
***** DAC960 RAID Driver Version 2.2.10 of 1 February 2001 *****
Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex DAC960PTL1 PCI RAID Controller
  Firmware Version: 4.08-0-37, Channels: 1, Memory Size: 8MB
  PCI Bus: 0, Device: 18, Function: 1, I/O Address: Unassigned
  PCI Address: 0xFC8FE000 mapped at 0xF0810000, IRQ Channel: 18
  Controller Queue Depth: 124, Maximum Blocks per Command: 128
  Driver Queue Depth: 123, Scatter/Gather Limit: 33 of 33 Segments
  Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 255/63
  Physical Devices:
    0:0  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0NXK100007008KQ52
         Disk Status: Online, 17782784 blocks
    0:1  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P60T00007012R69K
         Disk Status: Online, 17782784 blocks
    0:2  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P4VE00007012R7QV
         Disk Status: Online, 17782784 blocks
    0:3  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P3V700001005HKUC
         Disk Status: Standby, 17782784 blocks
    0:4  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P3SW000070113RRF
         Disk Status: Online, 17782784 blocks
    0:5  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P1MV00007012RDGX
         Disk Status: Online, 17782784 blocks
  Logical Drives:
    /dev/rd/c0d0: RAID-5, Online, 71131136 blocks, Write Thru
  No Rebuild or Consistency Check in Progress

[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

This problem seems to occur when writing to the dac960 array usually.  I dont
know if that is coincidence or if the dac960 is the problem?

[X.] Other notes, patches, fixes, workarounds:

I've reported this (or a similar) oops several other times.  See:

http://groups.google.com/groups?selm=Pine.LNX.4.10.10106271124500.17066-100000%40galaxy.gkg-com.com
http://groups.google.com/groups?selm=linux.raid.Pine.LNX.4.10.10107161322570.12406-100000%40galaxy.gkg-com.com
http://groups.google.com/groups?selm=linux.raid.Pine.LNX.4.10.10108271318300.31572-100000%40galaxy.gkg-com.com

Nobody seems to have any ideas on how to fix / whats causing it.

Mike

