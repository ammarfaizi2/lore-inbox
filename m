Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267737AbTAHFC7>; Wed, 8 Jan 2003 00:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbTAHFC7>; Wed, 8 Jan 2003 00:02:59 -0500
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:30106 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267737AbTAHFC5>; Wed, 8 Jan 2003 00:02:57 -0500
Date: Wed, 8 Jan 2003 00:16:51 -0500
To: linux-kernel@vger.kernel.org
Subject: IDE DMA disabled with via82cxxx on kernels >= 2.5.35
Message-ID: <20030108051651.GA6511@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two machines with VIA chipsets.  Recent 2.5 
kernels boot with "DMA disabled".  

On Athlon, hdparm -tT /dev/hda is about 8 times higher 
on 2.4 than 2.5 kernels.  hdparm -i says dma is (on) though.

I tried CONFIG_BLK_DEV_IDEDMA_FORCED=y, but that didn't 
eliminated the "DMA disabled" message.  Other IDE settings are:

CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

boot message:
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L040AVER07-0, ATA DISK drive
hda: IRQ probe failed (0xffffffba)
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)

I also have a K6/2 with a VIA chipset.  2.5.34 and earlier were fine.
2.5.34-mm4 and subsequent 2.5.x kernels boot with "DMA disabled".

lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)

The K6/2 boots with:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 51536U3, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
hda: DMA disabled
hdb: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

