Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSHaNkU>; Sat, 31 Aug 2002 09:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSHaNkU>; Sat, 31 Aug 2002 09:40:20 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:19139 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S315388AbSHaNkT>;
	Sat, 31 Aug 2002 09:40:19 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre5-ac1 and Intel ICH3M EIDE woes
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 30 Aug 2002 23:42:08 +0200
Message-ID: <m3elcguiq7.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used to run 2.5.x as my laptop has the Intel ICH3M chips in it, and
on the plain 2.4.x it would fail during boot claiming "resource
collisions". In 2.4.19-ac4 or thereabouts it seemed to have been fixed
the the ac-releases, and I ran happily with 2.4 again. After seeing a
lot of IDE rearrangements lately I thought it was time for a YANK (Yet
Another New Kernel), and the ICH3M seems unhappy again about resource
collisions:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 00:1f.1
PCI: Device 00:1f.1 not available because of resource collisions
PCI: Assigned IRQ 11 for device 00:1f.1
ICH3M: Not fully BIOS configured!
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4019GAX, ATA DISK drive
hdc: SD-R2102, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78140160 sectors (40008 MB), CHS=5168/240/63, UDMA(100)
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3

However, unlike back in 2.4.18, this time I can run hdparm and get it
to run in UDMA mode (instead of the default PIO mode) and get the
performance back.

Relevant bits of the .config:

lapper:~/src/linux/linux-2.4-test$ grep IDE .config | grep -v ^# | sort
CONFIG_BLK_DEV_IDECD_BAILOUT=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDE=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE=y
CONFIG_IEEE1394_VIDEO1394=m
lapper:~/src/linux/linux-2.4-test$

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
