Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTFGCGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 22:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTFGCGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 22:06:50 -0400
Received: from u212-239-160-174.adsl.pi.be ([212.239.160.174]:18701 "EHLO
	italy.lashout.net") by vger.kernel.org with ESMTP id S262497AbTFGCGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 22:06:48 -0400
Subject: Re: siI3112 crash on enabling dma
From: Adriaan Peeters <apeeters@lashout.net>
Reply-To: apeeters@lashout.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054948154.17185.45.camel@dhcp22.swansea.linux.org.uk>
References: <1054929160.1793.121.camel@localhost>
	 <1054948154.17185.45.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1054952415.1793.153.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Jun 2003 04:20:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-07 at 03:09, Alan Cox wrote:
> On Gwe, 2003-06-06 at 20:52, Adriaan Peeters wrote:
> > I tried 2.4.21-rc7-ac1 too, but the dma isn't enabled by default either.
> 
> That suprises me somewhat. 7-ac1 should force DMA on
> 
> > hda: Maxtor 6Y080M0, ATA DISK drive
> > hda: DMA disabled
> > hdc: Maxtor 6Y080M0, ATA DISK drive
> > hdc: DMA disabled
> 
> These are Maxtor drives with SATA convertors ? If so make sure the
> convertor is set for UDMA100 not UDMA133 mode. (See www.siimage.com
> support pages)

No, these are native SATA drives. The only jumper settings are the usual
master/slave jumpers, and slave mode is enabled (no jumpers). But that
shouldn't matter.

> 
> Can you send me a dmesg from 7ac1 please

Here you go:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SiI3112 Serial ATA: IDE controller at PCI slot 00:0c.0
PCI: Found IRQ 5 for device 00:0c.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:DMA, hdh:pio
hda: Maxtor 6Y080M0, ATA DISK drive
hdc: Maxtor 6Y080M0, ATA DISK drive
hde: CD-ROM 40X/AKU, ATAPI CD/DVD-ROM drive
hdg: QUANTUM BIGFOOT2550A, ATA DISK drive
blk: queue c0475ef4, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0xe081c080-0xe081c087,0xe081c08a on irq 5
ide1 at 0xe081c0c0-0xe081c0c7,0xe081c0ca on irq 5
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
ide3 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=158816/16/63
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=158816/16/63
hdg: attached ide-disk driver.
hdg: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: task_no_data_intr: error=0x04 { DriveStatusError }
hdg: 5033952 sectors (2577 MB) w/87KiB Cache, CHS=4994/16/63, DMA
hde: attached ide-cdrom driver.
hde: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
Partition check:
 hda: [PTBL] [9964/255/63] hda1 hda2 hda3
 hdc: [PTBL] [9964/255/63] hdc1 hdc2 hdc3
 hdg: [PTBL] [624/128/63] hdg1 hdg2
ide-floppy driver 0.99.newide
 ataraid/d0: ataraid/d0p1 ataraid/d0p2 ataraid/d0p3
Drive 0 is 78167 Mb (22 / 0) 
Drive 1 is 78167 Mb (3 / 0) 
Raid1 array consists of 2 drives. 

bari:~# hdparm -d /dev/hda

/dev/hda:
 using_dma    =  0 (off)
bari:~# hdparm -d /dev/hdc

/dev/hdc:
 using_dma    =  0 (off)
bari:~#

Thanks,

-- 
Adriaan Peeters <apeeters@lashout.net>

