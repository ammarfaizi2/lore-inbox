Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135764AbRAJPFQ>; Wed, 10 Jan 2001 10:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135312AbRAJPFH>; Wed, 10 Jan 2001 10:05:07 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:8765 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S135762AbRAJPE7>; Wed, 10 Jan 2001 10:04:59 -0500
Message-Id: <200101100216.f0A2FKQ20260@emu.os2.ami.com.au>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Linux kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: SCSI F2513A and 640 Mbyte media and 2.4.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Jan 2001 10:15:39 +0800
From: John Summerfield <summer@OS2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The 2k sector support is imperfect;-(

The media are recognised correctly (I've not tried switching between 230 Nbyte 
and 640 Mbyte disks), BUT

Something can forget.

I started with a Linux disk containing my archive of RHL 5.2 rpms.

I did an rpm --verify of them all and they all checked out.
I then ejected the disk (using the eject command; this did not work correctly 
with the first 2.2 kernels) and inserted an OS/2 HPFS disk.


The disk checked out with sfdisk, but I can't mount it (Linux' HPFS support 
for these disks has never worked), so I ran a few commands to read data from 
t, culminating with dd to make a file of its contents.

When I started dd, one of the other commands (strings, I think) was running, 
so there was probably some thrashing at first


When dd finished, I could no longer read the partition table:
[root@dugite /root]# fdisk -l -b 2048 /dev/sda
[root@dugite /root]# fdisk  -b 2048 /dev/sda

Unable to read /dev/sda
[root@dugite /root]# dmesg | tail
sd.c:Bad block number requested I/O error: dev 08:01, sector 1
 I/O error: dev 08:01, sector 1241224
 I/O error: dev 08:01, sector 1241224
ll_rw_block: device 08:00: only 512-char blocks implemented (1024)
sd.c:Bad block number requested I/O error: dev 08:00, sector 0
 I/O error: dev 08:01, sector 1241224
ll_rw_block: device 08:00: only 512-char blocks implemented (1024)
sd.c:Bad block number requested I/O error: dev 08:00, sector 0
ll_rw_block: device 08:00: only 512-char blocks implemented (1024)
sd.c:Bad block number requested I/O error: dev 08:00, sector 0
[root@dugite /root]# sfdisk -l  /dev/sda

Disk /dev/sda: 606 cylinders, 64 heads, 32 sectors/track
Units = cylinders of 1048576 bytes, blocks of 1024 bytes, counting from 0

   Device Boot Start     End   #cyls   #blocks   Id  System
/dev/sda1   *      0+    605     606-   620528    7  HPFS/NTFS
/dev/sda2          0       -       0         0    0  Empty
/dev/sda3          0       -       0         0    0  Empty
/dev/sda4          0       -       0         0    0  Empty
[root@dugite /root]# 

Before the last sfdisk, I ejected the disk using the button on the drive and 
reinserted it.

[root@dugite /root]# uname -a
Linux dugite 2.4.0 #2 Wed Jan 10 08:06:30 WST 2001 i586 unknown
[root@dugite /root]# 
fwiw I compiled the kernel targetting K6 with gcc 2.95.

The SCSI chipset is AIC7xxx.

[root@dugite /root]# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 530 Host (rev 03)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b3)
00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:0b.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871 (rev 03)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 
3D-AGP (rev a3)
[root@dugite /root]# 

-- 
Cheers
John Summerfield
http://www2.ami.com.au/ for OS/2 & linux information.
Configuration, networking, combined IBM ftpsites index.

Note: mail delivered to me is deemed to be intended for me, for my disposition.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
