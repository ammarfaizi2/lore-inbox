Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316568AbSE3KeA>; Thu, 30 May 2002 06:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSE3KeA>; Thu, 30 May 2002 06:34:00 -0400
Received: from p508EAD2B.dip.t-dialin.net ([80.142.173.43]:20489 "EHLO
	wilmskamp.dyndns.org") by vger.kernel.org with ESMTP
	id <S316568AbSE3Kd5> convert rfc822-to-8bit; Thu, 30 May 2002 06:33:57 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Oliver <oliver@wilmskamp.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: File corrupting bug in kernel 2.2.19 as well as 2.2.20 ?
Date: Thu, 30 May 2002 12:33:59 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205301233.59618.oliver@wilmskamp.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi everybody,

i have experienced strange happenings on the internet server in our LAN 
here.

first of all:
the machine (quite old ;) ) is a pentium 120 MHz, 40 MB RAM, with two 
harddisks (for the models please see below), one cdrom, four network 
adapters (three pci and one isa) and a mainboard with VIA chipset (see 
below as well). it is running on debian linux potato 2.2 rev.4 (which was 
being shipped with kernel 2.2.19 back when i got it).

the issue:
it has happened maybe four times in a period of two months that the machine 
had remounted the root fs (ext2) in ro-mode. that indicated that at least 
one error had occurred, and then the system decided to remount ro cause 
thats what fstab tells it to do in case of an error. running fsck 
afterwards would find a lot of messy things in the filesystem (see below 
as well). what i found occasionaly after such an "event" was that some 
files seemed to be corrupted (e.g. /etc/apache/httpd.conf, 
/var/lib/dpkg/available and others). those files had some parts replaced 
with ...^@^@^@^@^@... stuff, which are zero-bytes (0x00) (again: there 
were only some parts REPLACED in these files, the filelength had NOT 
changed). thats not too funny for a running server as you can imagine ;) .

well anyway, what i have found out so far is, that this mess seems to have 
occured always at the same time of day, which is, when the cron.daily 
scripts were being run by the cron daemon in the morning at 6:25 am. and i 
dont think the problem is being caused by the hardware (which i thought at 
first) because i changed the (root-) harddisk, the mainboard from 
INTEL-chipset to VIA, the RAM and even the IDE cable on the primary ide 
port but the problem still persisted. so i believe now it might be a 
problem of the kernel. i have tried both 2.2.19 and 2.2.20, but not 2.2.21 
yet. in 2.2.19 and 2.2.20 the problem seems to be the same.

a (likely) special issues of this machine are that the cron job, when 
working on the cron.daily-scripts might consume all the RAM (which is only 
40 MB and there is not much available without the cronjobs anyway) and 
then swapping starts and also the cronjobs start (which are quite many in 
a debian distribution in /etc/cron.daily), so might there be a problem in 
the VM concerning swapping while lots of jobs are running ?

maybe someone knows something about it ;)


thanks,

oliver


ps: for now i have out-commented the cron.daily stuff in /etc/crontab and 
since then nothing has happened anymore, but of course this can only be a 
temporary solution.



+++
oliver@schlumpf:/var/lib/dpkg$ uname -a
Linux schlumpf 2.2.20 #1 SMP Fri May 10 00:18:33 CEST 2002 i586 unknown
+++

+++ about the installed cron package +++
oliver@schlumpf:/var/lib/dpkg$ dpkg -s cron
Package: cron
Status: install ok installed
Priority: important
Section: admin
Installed-Size: 121
Maintainer: Steve Greenland <stevegr@debian.org>
Version: 3.0pl1-57.3
Depends: libc6 (>= 2.1.2), bsdutils, debianutils (>= 1.7)
Recommends: smail | sendmail | mail-transport-agent
Suggests: anacron (>= 2.0-1), logrotate, lockfile-progs
+++

+++ content of /proc/pci +++
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies VT 82C585 Apollo VP1/VPX (rev 2).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  
Latency=32.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies VT 82C586 Apollo ISA (rev 0).
      Medium devsel.  Master Capable.  No bursts.
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies VT 82C586 Apollo IDE (rev 2).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  
Latency=32.
      I/O at 0x6000 [0x6001].
      Non-prefetchable 32 bit memory at 0xe0800000 [0xe0800000].
  Bus  0, device   8, function  0:
    Ethernet controller: Realtek 8029 (rev 0).
      Medium devsel.  IRQ 11.
      I/O at 0x6100 [0x6101].
  Bus  0, device   9, function  0:
    Ethernet controller: Realtek 8029 (rev 0).
      Medium devsel.  IRQ 10.
      I/O at 0x6200 [0x6201].
  Bus  0, device  10, function  0:
    VGA compatible controller: ARK Logic 2000MT (rev 0).
      Medium devsel.  Fast back-to-back capable.
      Prefetchable 32 bit memory at 0xe0000000 [0xe0000008].
  Bus  0, device  11, function  0:
    Ethernet controller: Winbond NE2000-PCI (rev 0).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.
      I/O at 0x6300 [0x6301].
+++

+++
oliver@schlumpf:/proc/ide$ cat drivers
ide-cdrom version 4.58
ide-disk version 1.08
+++

+++
oliver@schlumpf:/proc/ide/ide0/hda$ cat model
QUANTUM BIGFOOT1280A (root fs, ext2)
+++

+++
oliver@schlumpf:/proc/ide/ide1/hdc$ cat model
QUANTUM FIREBALL ST3.2A (only for ftp, ext2)
+++

+++
oliver@schlumpf:/proc/ide/ide1/hdd$ cat model
TOSHIBA CD-ROM XM-5602B
+++

+++ this is what fsck said (sorry, quite long, so i shortened it a bit) +++
+++ (if you want the complete log, just tell me) +++
schlumpf:/home/david# fsck.ext2 /dev/hda3
e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
/dev/hda3 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Deleted inode 19958 has zero dtime.  Fix<y>? yes

Deleted inode 22468 has zero dtime.  Fix<y>? yes

Deleted inode 22469 has zero dtime.  Fix<y>? yes




Deleted inode 66427 has zero dtime.  Fix<y>? yes

Pass 2: Checking directory structure
Directory inode 20350, block 0, offset 2556: directory corrupted
Salvage<y>? yes

Directory inode 20351, block 0, offset 0: directory corrupted
Salvage<y>? yes

Missing '.' in directory inode 20351.
Fix<y>? yes

Setting filetype for entry '.' in ??? (20351) to 2.
Missing '..' in directory inode 20351.
Fix<y>? yes

Setting filetype for entry '..' in ??? (20351) to 2.

Pass 3: Checking directory connectivity
Unconnected directory inode 4949 (/var/spool/squid/06/???)
Connect to /lost+found<y>? yes

[... some more of the previous message ...]

Unconnected directory inode 4953 (/var/spool/squid/06/???)
Connect to /lost+found<y>? yes

'..' in /var/spool/squid/06/08 (20351) is <The NULL inode> (0), should be 
/var/spool/squid/06 (20350).
Fix<y>? yes

Unconnected directory inode 20374 (/var/spool/squid/06/???)
Connect to /lost+found<y>? yes

[... many more of the previous message ...]

Unconnected directory inode 128337 (/var/spool/squid/06/???)
Connect to /lost+found<y>? yes

Pass 4: Checking reference counts
Inode 2 ref count is 19, should be 20.  Fix<y>? yes

Inode 4949 ref count is 3, should be 2.  Fix<y>? yes

[... many many more of the previous message ...]

Inode 128336 ref count is 3, should be 2.  Fix<y>? yes

Inode 128337 ref count is 3, should be 2.  Fix<y>? yes

Pass 5: Checking group summary information
Block bitmap differences:  -12203 -12204 -12205 -12206 -41547 -41548 -41549 
-41550 -41551 -41552 -41553 -61786 -61787 -276132 -276133 -276134 -276135 
-276136 -276137 -276138 -276140 -276141 -276142 -276143 -276144 -276145 
-276146 -276148 -276149 -276150 -276151 -276152 -276153 -276154 -276156 
-276157 -276158 -276159 -276160 -276161 -276162
Fix<y>? yes

Free blocks count wrong for group #0 (655, counted=659).
Fix<y>? yes

Free blocks count wrong for group #1 (4203, counted=4212).
Fix<y>? yes

Free blocks count wrong for group #8 (1513, counted=1541).
Fix<y>? yes

Free blocks count wrong (81341, counted=81382).
Fix<y>? yes

Inode bitmap differences:  -19958 -22468 -22469 -66427
Fix<y>? yes

Free inodes count wrong for group #1 (8347, counted=8350).
Fix<y>? yes

Free inodes count wrong for group #4 (8363, counted=8364).
Fix<y>? yes

Free inodes count wrong (75148, counted=75152).
Fix<y>? yes


/dev/hda3: ***** FILE SYSTEM WAS MODIFIED *****
/dev/hda3: 63664/138816 files (1.1% non-contiguous), 195818/277200 blocks
+++

-- 
Tomorrow will be canceled due to lack of interest.

