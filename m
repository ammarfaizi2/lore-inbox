Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUDAOma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 09:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUDAOma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 09:42:30 -0500
Received: from imap.gmx.net ([213.165.64.20]:18091 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262215AbUDAOm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 09:42:27 -0500
X-Authenticated: #21910825
Message-ID: <406C2AFB.1030101@gmx.net>
Date: Thu, 01 Apr 2004 16:45:15 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6 kernels misdetect harddisk geometry, 2.4 kernels are fine
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the harddisk geometry recognized by 2.6 kernels differs from the geometry
recognized by 2.4 kernels. The 2.4 kernel version agrees with the BIOS and
fdisk/parted. The 2.6 kernel version seems senseless to me. Here is a diff
between bootup messages: (more info available if you need it)

--- /var/log/boot.msg24 2004-04-01 10:33:23.000000000 +0200
+++ /var/log/boot.msg26 2004-04-01 10:34:48.751069936 +0200
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a post-1991 82077
 RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
 loop: loaded (max 16 devices)
-Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
+Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
-VP_IDE: IDE controller at PCI slot 00:07.1
+VP_IDE: IDE controller at PCI slot 0000:00:07.1
 VP_IDE: chipset revision 6
 VP_IDE: not 100%% native mode: will probe irqs later
-ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
-VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
+VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
     ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
 hda: IBM-DTLA-307030, ATA DISK drive
-blk: queue c03e66c0, I/O limit 4095Mb (mask 0xffffffff)
-hdc: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
+hdc: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
 ide1 at 0x170-0x177,0x376 on irq 15
-hda: attached ide-disk driver.
-hda: host protected area => 1
-hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(100)
-ide-floppy driver 0.99.newide
-Partition check:
+hda: max request size: 128KiB
+hda: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
  hda: hda1 hda2 hda3
 ide-floppy driver 0.99.newide


Especially interesting are the lines:
-hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(100)
+hda: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)

You can see that both share the same sector count, but differing Megabytes
and differing CHS. This breaks nearly every partitioning program I know
and it makes supporting old ATARAID configurations a nightmare. (Some of
the RAID superblock locations depend on the BIOS idea of CHS.)

Is this change intentional or a bug?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

