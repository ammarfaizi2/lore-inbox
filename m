Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbSLPXQ5>; Mon, 16 Dec 2002 18:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262442AbSLPXQ5>; Mon, 16 Dec 2002 18:16:57 -0500
Received: from vhe-381601.sshn.net ([195.169.208.40]:7172 "HELO
	crystal.crystals.local") by vger.kernel.org with SMTP
	id <S262425AbSLPXQy>; Mon, 16 Dec 2002 18:16:54 -0500
From: jiri.wichern@hccnet.nl
To: linux-kernel@vger.kernel.org
Date: Tue, 17 Dec 2002 00:24:50 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: PROBLEM: kernel 2.4.20 option CONFIG_BLK_STATS breaks /proc/partitons so "mount" can't mount devices by UUID.
Message-ID: <3DFE6ED2.7174.1395ABF@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short description of the problem: You can't mount hard drive 
volumes by using their UUID number when also using extra 
statistics for your block devices by the CONFIG_BLK_STATS 
kernel option.

-----------------
First of all: i dont know really if i should send this message to this 
group. I tried drew@colorado.edu, because he seemed the most 
likely "suspect" for his email adress was in the genhd.h file. The 
genhd.c/genhd.h kernel source files of kernel 2.4.20 use the 
CONFIG_BLK_STATS config option the most, but genhd.c had 
only Linus Torvalds as creator. I tried to find on internet the 
maintainer of the generic "block devices" part of the kernel; 
however i couldn't find him after a few google attempts.
I have also tried google for finding out if this problem was already 
known: no answers.
Maybe this should be a case for the maintainer of the "Mount" 
application. However, i would like to hear your opinion on that if it is 
so.

-------------------------
This is what actually happens:

When chosing the CONFIG_BLK_STATS kernel option in the 
configure menu and compiling the kernel (version 2.4.20), after 
rebooting; booting with the new kernel, the file /proc/partitions has 
extra statistic information about your block devices. However this 
extra information seems to hamper the possibility to mount 
volumes by UUID number; a feature also using the /proc/partitions 
file. This can ultimately result in a failure-to-mount filesystems at 
boottime resulting in a forced single user maintainance mode or re-
reboot of the system. (This is dependable on your inittab and 
/etc/rc.d files.)

------------------------------
Some version info:
Kernel: 2.4.20
Mount: mount-2.10l

Some kernel make config:
CPU: AMD Athlon/Duron
SCSI kernel modules: "Adaptec AIC7xxx support" "Sym53C8xx scsi support"
Everything is linked in one kernel file (no loose modules)

System hardware:
CPU: AMD Thunderbird 1400 @ 1050MHz (100MHz FSB)
Main board: MSI k7t master-s (onboard SCSI, 1 SCSI HDD connected; this one will mount as in fstab points to /dev/sda1, 2 and 3.)
extra SCSI adapter: dual UW symbios controller with DE 500 NIC on one PCI card (Digital/Compaq) (3 SCSI HD's on the second controller. These won't mount for i use to point at them by their UUID)

-----------------------------
More info:

bash-2.04# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux saphire 2.4.20 #3 Tue Dec 17 01:54:12 CET 2002 i686 unknown

Gnu C                  egcs-2.91.66
Gnu make               3.79
binutils               2.9.1.0.25
util-linux             2.10l
mount                  2.10l
modutils               2.3.11
e2fsprogs              1.18
Linux C Library        2.1.3
ldd: version 1.9.9
Procps                 2.0.6
Net-tools              1.55
Kbd                    0.99
Sh-utils               2.0
Modules Loaded

bash-2.04# comment: (No modules loaded)

bash-2.04# cat /proc/cpu
cat: /proc/cpu: No such file or directory
bash-2.04# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1050.088
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge 
mca cmov pat p
se36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2090.59

bash-2.04# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: DEC      Model: RZ2CD-KS (C) DEC Rev: 0306
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: MATSHITA Model: CD-R   CW-7502   Rev: 4.17
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 09 Lun: 00
  Vendor: COMPAQ   Model: BB00911CA0       Rev: 3B05
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 12 Lun: 00
  Vendor: DEC      Model: RZ2CD-KS (C) DEC Rev: 0306
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 13 Lun: 00
  Vendor: DEC      Model: RZ2CD-KS (C) DEC Rev: 0306
  Type:   Direct-Access                    ANSI SCSI revision: 02

bash-2.04# comment: (without CONFIG_BLK_STATS option)
bash-2.04# cat /proc/partitions
major minor  #blocks  name

   8     0    4190040 sda
   8     1    1047521 sda1
   8     2    1047552 sda2
   8     3    1571328 sda3
   8     4     519684 sda4
   8    16    8886762 sdb
   8    17    8886256 sdb1
   8    32    4190040 sdc
   8    33    4184901 sdc1
   8    48    4190040 sdd
   8    49    4184901 sdd1

comment: (with CONFIG_BLK_STATS option)

major minor  #blocks  name     rio rmerge rsect ruse wio wmerge 
wsect wuse running use aveq

   8     0    4190040 sda 263 2001 4534 1790 2 0 4 10 0 1330 1800
   8     1    1047521 sda1 255 1908 4326 1750 2 0 4 10 0 1290 1760
   8     2    1047552 sda2 3 45 96 10 0 0 0 0 0 10 10
   8     3    1571328 sda3 3 45 96 10 0 0 0 0 0 10 10
   8     4     519684 sda4 1 0 8 10 0 0 0 0 0 10 10
   8    16    8886762 sdb 1 3 8 10 0 0 0 0 0 10 10
   8    17    8886256 sdb1 0 0 0 0 0 0 0 0 0 0 0
   8    32    4190040 sdc 1 3 8 10 0 0 0 0 0 10 10
   8    33    4184901 sdc1 0 0 0 0 0 0 0 0 0 0 0
   8    48    4190040 sdd 1 3 8 10 0 0 0 0 0 10 10
   8    49    4184901 sdd1 0 0 0 0 0 0 0 0 0 0 0

I think other information is irrelevant.

---------------------------
Workaround: Only one i found so far: don't use the kernel option.

---------------------------
As this is my first kernel "bug" report i would very much appreciate 
if you could tell me if i did anything wrong here...

Regards, Jiri Wichern. Nijmegen, the Netherlands. A dedicated 
Linux fan since 1996.
