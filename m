Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbXALBLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbXALBLN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 20:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbXALBLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 20:11:13 -0500
Received: from aun.it.uu.se ([130.238.12.36]:56696 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbXALBLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 20:11:13 -0500
Date: Fri, 12 Jan 2007 02:08:12 +0100 (MET)
Message-Id: <200701120108.l0C18CnN028291@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: PIIX3 support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007 17:13:38 +0000, Alan <alan@lxorguk.ukuu.org.uk> wrote:
>This I believe completes the PIIX range of support for libata
>
>This adds the table entries needed for the PIIX3, both a new PCI
>identifier and a new mode list. It also fixes an erroneous access to PCI
>configuration 0x48 on non UDMA capable chips.

Works fine here on a 430HX box (ASUS T2P4).
I'm appending kernel messages for boots with the IDE driver and
with the updated libata driver, in case you want to compare them.

I did notice that ata_piix identified the disk as
"QUANTUM FIREBALL A5U." when IDE correctly identified it as
"QUANTUM FIREBALL CR8.4A".

/Mikael

[2.6.20-rc4 with CONFIG_BLK_DEV_PIIX=y]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 0000:00:07.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: QUANTUM FIREBALL CR8.4A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB) w/418KiB Cache, CHS=16383/16/63, (U)DMA
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >

[2.6.20-rc4 + alan's patch with CONFIG_ATA_PIIX=y]
ata_piix 0000:00:07.1: version 2.00ac7
ata1: PATA max MWDMA2 cmd 0x1F0 ctl 0x3F6 bmdma 0xE800 irq 14
ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xE808 irq 15
scsi0 : ata_piix
ata1.00: ATA-4, max UDMA/66, 16514064 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for MWDMA2
scsi1 : ata_piix
scsi 0:0:0:0: Direct-Access     ATA      QUANTUM FIREBALL A5U. PQ: 0 ANSI: 5
SCSI device sda: 16514064 512-byte hdwr sectors (8455 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 16514064 512-byte hdwr sectors (8455 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
