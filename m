Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130431AbRAELVh>; Fri, 5 Jan 2001 06:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130423AbRAELV2>; Fri, 5 Jan 2001 06:21:28 -0500
Received: from Prins.externet.hu ([212.40.96.161]:25622 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S129675AbRAELVN>; Fri, 5 Jan 2001 06:21:13 -0500
Date: Fri, 5 Jan 2001 12:21:07 +0100 (CET)
From: Narancs 1 <narancs1@externet.hu>
To: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: lvm: hw error or misconfig?
Message-ID: <Pine.LNX.4.02.10101051206550.5748-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers!

(sorry for the long mail)

We have a compaq proliant server with NO raid and 5 scsi discs:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: COMPAQ   Model: BD00911934       Rev: 3B02
  Type:   Direct-Access                    ANSI SCSI revision: 02

bounded together to a volume group vg00.

This morning we received this strange message, and a file is not readable
anymore. It is i/o error-ed. unfort. this caused loosing important data.

Jan  5 11:30:21 matrix kernel: attempt to access beyond end of device
Jan  5 11:30:21 matrix kernel: 08:31: rw=0, want=8883914, limit=8883913
Jan  5 11:30:21 matrix kernel: dev 3a:00 blksize=1024 blocknr=8551735
sector=17767820 size=4096 count=1

Does it mean that some of the disks are hw errored or is it a
misconfiguration, error in lvm or kernel code?

How could I check the disks while they are in live work?
It would be a big pain to stop the system and reformat the drives, so on.
any idea?

kernel 2.2.17, lvm 0.8i a la debian woody.

thanks for your help, and hoping for fast answer
Narancs v1
---------------------------------------------------------
 cat /proc/scsi/sym53c8xx/0
General information:
  Chip sym53c876, device id 0xf, revision id 0x14
  IO port address 0x2000, IRQ number 23
  Using memory mapped IO at virtual address 0xe0800f00
  Synchronous period factor 12, max commands per lun 32

vgdisplay -v
--- Volume group ---
VG Name               vg00
VG Access             read/write
VG Status             available/resizable
VG #                  0
MAX LV                256
Cur LV                1
Open LV               1
MAX LV Size           255.99 GB
Max PV                256
Cur PV                5
Act PV                5
VG Size               41.1 GB
PE Size               4 MB
Total PE              10521
Alloc PE / Size       10521 / 41.1 GB
Free  PE / Size       0 / 0

--- Logical volume ---
LV Name               /dev/vg00/oracle
VG Name               vg00
LV Write Access       read/write
LV Status             available
LV #                  1
# open                1
LV Size               41.1 GB
Current LE            10521
Allocated LE          10521
Allocation            next free
Read ahead sectors    120
Block device          58:0


--- Physical volumes ---
PV Name (#)           /dev/sda3 (1)
PV Status             available / allocatable
Total PE / Free PE    2061 / 0

PV Name (#)           /dev/sdb2 (2)
PV Status             available / allocatable
Total PE / Free PE    2061 / 0

PV Name (#)           /dev/sdc2 (3)
PV Status             available / allocatable
Total PE / Free PE    2061 / 0

PV Name (#)           /dev/sdd1 (4)
PV Status             available / allocatable
Total PE / Free PE    2169 / 0

PV Name (#)           /dev/sde1 (5)
PV Status             available / allocatable
Total PE / Free PE    2169 / 0

cat /etc/fstab 
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>
<dump><pass>
/dev/sda2       /               ext2    defaults,errors=remount-ro      01
/dev/sda1       none            swap    sw                      0       0
/dev/sdb1       none            swap    sw                      0       0
/dev/sdc1       none            swap    sw                      0       0
proc            /proc           proc    defaults                        00
/dev/fd0        /floppy         auto    defaults,user,noauto            00
/dev/cdrom      /cdrom          iso9660 defaults,ro,user,noauto         00
/dev/vg00/oracle /u01           ext2    defaults                0       2

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
