Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266004AbRGCUrW>; Tue, 3 Jul 2001 16:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266002AbRGCUrM>; Tue, 3 Jul 2001 16:47:12 -0400
Received: from linux01.linuxforce.net ([207.106.68.238]:56072 "EHLO
	linux01.LinuxForce.net") by vger.kernel.org with ESMTP
	id <S266004AbRGCUq7>; Tue, 3 Jul 2001 16:46:59 -0400
From: Tim Peeler <thp@linux01.LinuxForce.net>
Date: Tue, 3 Jul 2001 16:47:12 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 kernel hang
Message-ID: <20010703164712.A21932@linux01.LinuxForce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary: 

   Kernel 2.2.19 hang [stuck on TLB IPI wait (CPU#0)]

Description:

   After recently upgrading the kernel on a production server to
   kernel 2.2.19 with the reiserfs patch and kernel-patch-2.2.19-ide
   from Andre Hendrick, the system became hung.  The server was
   responsive to ping but ssh and http service stopped working until
   we rebooted.  The hang did not happen instantly, but took several
   days of uptime before the system hung.  Looking through the logs
   we noticed that "stuck on TLB IPI wait (CPU#0) was logged 128 times
   in one second.  Also during that second, 4443 packets were rejected
   by the kernel coming in on eth0, of which 2681 were aimed at port
   137.  These packets came from 60 addresses not on our local network
   (packets destined to 137 on our local network are rejected, but not
   logged). Of other note was this kernel message: "dst cache overflow"
   "last message repeated 9 times".  Since this did not crash the
   machine, there is no oops output.  We were running the mon package
   from 3 other servers during this time and noticed shortly after
   the hang that several services were failing (ssh, http, etc). Even
   ping failed a few times.

Kernel Version:

   Linux version 2.2.19 (cjf@linux00) (gcc version 2.95.2 20000220 
   (Debian GNU/Linux)) #1 SMP Tue Jun 26 11:55:50 EDT 2001

Output from ver_linux:

Linux www.fi.edu 2.2.19 #1 SMP Tue Jun 26 11:55:50 EDT 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             2.10f
modutils               2.3.11
e2fsprogs              1.18
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         


CPU Info:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 933.040
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 psn mmx fxsr xmm
bogomips        : 1854.66

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 933.040
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 psn mmx fxsr xmm
bogomips        : 1861.22


SCSI Info:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: ARCHIVE  Model: Python 04106-XXX Rev: 743B
  Type:   Sequential-Access                ANSI SCSI revision: 02


Interrupts (/proc/interrupts):
           CPU0       CPU1       
  0:    5674938    5598011    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
 10:    1829310    1817099   IO-APIC-level  Mylex DAC960PTL1, eth0
 11:         18         18   IO-APIC-level  aic7xxx
 13:          1          0          XT-PIC  fpu
NMI:          0
ERR:          0


