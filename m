Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbRBVUzu>; Thu, 22 Feb 2001 15:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129261AbRBVUzl>; Thu, 22 Feb 2001 15:55:41 -0500
Received: from deuel.as.uaf.edu ([137.229.23.186]:14603 "EHLO deuel.as.uaf.edu")
	by vger.kernel.org with ESMTP id <S129199AbRBVUzd>;
	Thu, 22 Feb 2001 15:55:33 -0500
From: "Joshua J. Kugler" <isd@as.uaf.edu>
Organization: ASUAF Information Services
Date: Thu, 22 Feb 2001 11:54:27 -0900
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: (Random?) File System Corruption
MIME-Version: 1.0
Message-Id: <01022211542702.26286@isd.as.uaf.edu>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
(Seemingly) random file system corruption

[2.] Full description of the problem/report:
The other day, I downloaded the latest version (at the time) of the kernel: 
2.4.1.  I had made the kernel a couple times, and had done "make distclean" a 
couple times.  About the third time I did "make distclean," I got a whole 
series of "operations not allowed."  I went to look at the files it couldn't 
work on, and found this when I did an "ls -la."

/usr/src/linux/drivers/acorn/scsi:

drwxr-xr-x   2 root     root         4096 Feb 16 22:02 ./
drwxr-xr-x   6 root     root         4096 Feb 16 22:02 ../
-rw-r--r--   1 root     root          992 Jan 13  2000 Config.in
?r-xr-x--t 12338 24419    11574    4294967295 May  2  1991 acornscsi-io.S
?---r-xr-t 25449 14896    28192    4294967295 Apr 24  2006 acornscsi.c
br-sr-xrw- 29487 25955    25460     99,  47 Feb 21  1996 acornscsi.h
cr-sr-S-wt 28015 25971    29296     10,  41 Sep 17  2028 cumana_1.c
br-srwS-wT 13873 26989    12082     48,  56 Mar 30  2029 cumana_1.h
?r--r-xrwx 8224 11574    8232     893005874 Feb  5  1987 cumana_2.c

And...
/usr/src/linux/drivers/fc4:

c---r-x--x 15732 19779    28261    114, 117 Jul 24  2026 Config.in


And:
/usr/src/linux-2.4.1/drivers/sgi/char:

b--Sr-S--T 12131 25449    29797     47,  99 Dec 27  1992 graphics.h
?r--r-x-wx 11630 8249     28530    4294967295 May 14  2031 graphics_syms.c
br-xrw-r-T 28530 29487    28719     41, 104 Apr  1  2029 linux_logo.h
?--xrw---T 12591 28015    12848    4294967295 Apr  1  2029 newport.c
cr-SrwS-wT 8224 13873    10272    116, 115 Dec  1  1991 sgicons.c
c---r-x--- 25903 8224     8249     115, 109 Sep  9  2028 sgiserial.h
cr-Sr-S--T 12136 29797    29485     46, 107 Mar 12  1995 shmiq.c
b--srw--wx 12328 28719    8308      45,  48 Jan  6  1992 streamable.c
c--Sr----- 8260 12848    19779    106, 100 May 28  2000 usema.c
d--x--sr-x 14641 10272    11069    1847599136 Nov 29  2031 usema.h/

More info: The last time I did a make, I used "-j 30." This a dual PIII 500 
with 512 MB of RAM and an 18GB system drive (3 9GB drives on RAID 5).  Memory 
usage never went over about 256 MB.  CPU usage hit close to 100% a couple 
times.

[3.] Keywords (i.e., modules, networking, kernel):

file system curruption

[4.] Kernel version (from /proc/version):

Linux version 2.2.17-jjk-20001024 (root@xxxxx.xx.xxx.edu) (gcc version 2.95.2 
19991024 (release)) #2 SMP Wed Oct 25 13:33:18 AKDT 2000

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

Do not know how to reproduce.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux deuel.as.uaf.edu 2.2.17-jjk-20001024 #2 SMP Wed Oct 25 13:33:18 AKDT 
2000 i686 unknown
Kernel modules         2.1.121
Gnu C                  2.95.2
Gnu Make               3.77
Binutils               2.9.5.0.16
Linux C Library        2.1.2
Dynamic linker         ldd (GNU libc) 2.1.2
Procps                 2.0.6
Mount                  2.9y
Net-tools              1.53
Console-tools          0.2.2
Sh-utils               2.0
cat: /proc/modules: No such file or directory
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 498.754
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov 
pat pse36 mmx fxsr xmm
bogomips        : 996.15

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 498.754
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov 
pat pse36 mmx fxsr xmm
bogomips        : 996.15


[7.3.] Module information (from /proc/modules):

No modules used, all compiled in to kernel.

[7.4.] SCSI information (from /proc/scsi/scsi)

scsi:
Attached devices: none

/proc/scsi/sym53c8xx/0
General information:
  Chip sym53c876, device id 0xf, revision id 0x37
  IO port address 0x1400, IRQ number 10
  Using memory mapped IO at virtual address 0xe0003400
  Synchronous period factor 12, max commands per lun 32

/proc/scsi/sym53c8xx/1
General information:
  Chip sym53c876, device id 0xf, revision id 0x37
  IO port address 0x1800, IRQ number 5
  Using memory mapped IO at virtual address 0xe0007800
  Synchronous period factor 12, max commands per lun 32

/proc/rd/c0/current_status:

***** DAC960 RAID Driver Version 2.2.8 of 19 August 2000 *****
Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex DAC960PTL1 PCI RAID Controller
  Firmware Version: 4.06-0-57, Channels: 1, Memory Size: 32MB
  PCI Bus: 0, Device: 14, Function: 1, I/O Address: Unassigned
  PCI Address: 0xFA104000 mapped at 0xE0000000, IRQ Channel: 11
  Controller Queue Depth: 128, Maximum Blocks per Command: 128
  Driver Queue Depth: 127, Scatter/Gather Limit: 33 of 33 Segments
  Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 128/32
  SAF-TE Enclosure Management Enabled
  Physical Devices:
    0:0  Vendor: IBM       Model: DNES-309170Y      Revision: SA30
         Serial Number:         AJ0P9506
         Disk Status: Online, 17915904 blocks
    0:1  Vendor: IBM       Model: DNES-309170Y      Revision: SA30
         Serial Number:         AJ0P9546
         Disk Status: Online, 17915904 blocks
    0:2  Vendor: IBM       Model: DNES-309170Y      Revision: SA30
         Serial Number:         AJ0P9531
         Disk Status: Online, 17915904 blocks
    0:6  Vendor: ESG-SHV   Model: SCA HSBP M5       Revision: 1.65
  Logical Drives:
    /dev/rd/c0d0: RAID-5, Online, 35831808 blocks, Write Thru
  No Rebuild or Consistency Check in Progress

 /proc/rd/c0/initial_status:

***** DAC960 RAID Driver Version 2.2.8 of 19 August 2000 *****
Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex DAC960PTL1 PCI RAID Controller
  Firmware Version: 4.06-0-57, Channels: 1, Memory Size: 32MB
  PCI Bus: 0, Device: 14, Function: 1, I/O Address: Unassigned
  PCI Address: 0xFA104000 mapped at 0xE0000000, IRQ Channel: 11
  Controller Queue Depth: 128, Maximum Blocks per Command: 128
  Driver Queue Depth: 127, Scatter/Gather Limit: 33 of 33 Segments
  Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 128/32
  SAF-TE Enclosure Management Enabled
  Physical Devices:
    0:0  Vendor: IBM       Model: DNES-309170Y      Revision: SA30
         Serial Number:         AJ0P9506
         Disk Status: Online, 17915904 blocks
    0:1  Vendor: IBM       Model: DNES-309170Y      Revision: SA30
         Serial Number:         AJ0P9546
         Disk Status: Online, 17915904 blocks
    0:2  Vendor: IBM       Model: DNES-309170Y      Revision: SA30
         Serial Number:         AJ0P9531
         Disk Status: Online, 17915904 blocks
    0:6  Vendor: ESG-SHV   Model: SCA HSBP M5       Revision: 1.65
  Logical Drives:
    /dev/rd/c0d0: RAID-5, Online, 35831808 blocks, Write Thru


[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Cannot think of other things to include.


[X.] Other notes, patches, fixes, workarounds:

None known.

-- 
Joshua Kugler
Associated Students of the University of Alaska Fairbanks
Information Services Director
isd@as.uaf.edu
907-474-7601
