Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTFFTjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 15:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTFFTjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 15:39:09 -0400
Received: from u212-239-160-174.adsl.pi.be ([212.239.160.174]:50188 "EHLO
	italy.lashout.net") by vger.kernel.org with ESMTP id S262253AbTFFTjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 15:39:07 -0400
Subject: siI3112 crash on enabling dma
From: Adriaan Peeters <apeeters@lashout.net>
Reply-To: apeeters@lashout.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1054929160.1793.121.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jun 2003 21:52:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using 2.4.20-ac2, when I boot the system, SATA disks on a sil3112
controller (IWill IS150-R) are detected, but dma is not enabled.
The disks work perfectly in raid 1 mode, and I can enable dma using 
hdparm -X66 -d1 /dev/hda
hdparm -X66 -d1 /dev/hdc

But sometimes this fails and the entire system hangs. I suspect it
happens when I enable dma mode while there is some harddisk activity.

I tried 2.4.21-rc7-ac1 too, but the dma isn't enabled by default either.

If I can test some more, please let me know,

Regards,
Adriaan Peeters

PS: Please cc me when replying, I'm not subscribed to the list.

Interesting parts from dmesg:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SiI3112 Serial ATA: IDE controller at PCI slot 00:0c.0
PCI: Found IRQ 5 for device 00:0c.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide0: MMIO-DMA at 0xd081c000-0xd081c007, BIOS settings: hda:pio,
hdb:pio
    ide1: MMIO-DMA at 0xd081c008-0xd081c00f, BIOS settings: hdc:pio,
hdd:pio
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try
using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:DMA, hdh:pio
hda: Maxtor 6Y080M0, ATA DISK drive
hda: DMA disabled
hdc: Maxtor 6Y080M0, ATA DISK drive
hdc: DMA disabled
hde: CD-ROM 40X/AKU, ATAPI CD/DVD-ROM drive
hde: DMA disabled
hdg: QUANTUM BIGFOOT2550A, ATA DISK drive
hdg: DMA disabled
blk: queue c047d8c4, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0xd081c080-0xd081c087,0xd081c08a on irq 5
ide1 at 0xd081c0c0-0xd081c0c7,0xd081c0ca on irq 5
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
ide3 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=158816/16/63
hdc: host protected area => 1
hdc: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=158816/16/63
hdg: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: task_no_data_intr: error=0x04 { DriveStatusError }
hdg: 5033952 sectors (2577 MB) w/87KiB Cache, CHS=4994/16/63, DMA
hde: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
Partition check:
 hda:<6> [PTBL] [9964/255/63] hda1 hda2 hda3
 hdc:<6> [PTBL] [9964/255/63] hdc1 hdc2 hdc3
 hdg:<6> [PTBL] [624/128/63] hdg1 hdg2
ide-floppy driver 0.99.newide
 ataraid/d0: ataraid/d0p1 ataraid/d0p2 ataraid/d0p3
Drive 0 is 78167 Mb (22 / 0) 
Drive 1 is 78167 Mb (3 / 0) 
Raid1 array consists of 2 drives. 
-- 
Adriaan Peeters <apeeters@lashout.net>

