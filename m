Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314208AbSDRALW>; Wed, 17 Apr 2002 20:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314209AbSDRALV>; Wed, 17 Apr 2002 20:11:21 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:22519 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S314208AbSDRALT>;
	Wed, 17 Apr 2002 20:11:19 -0400
Message-ID: <02e001c1e66d$8e927070$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "Dave Jones" <davej@suse.de>
Subject: 2.5.8-dj1 with IDE TCQ doesn't survive boot
Date: Wed, 17 Apr 2002 20:11:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

Tried 2.5.8-dj1 here with IDE TCQ and it doesn't make it through bootup. The lockup (no oops) happens at various places, usually
during a disk-intensive operation like starting PostgreSQL. Disk & chipset detection always goes ok; the lockup is much later in the
boot cycle. Nothing shows up in the logs.

A kernel without TCQ boots reliably.

Boot drive is hda (IBM-DTTA-351680). System is SMP ppro, no preempt.

--Adam

Chipset/disk detection looks like this:

Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]: IDE controller on PCI slot 001
Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]: chipset revision 0
Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]: not 100% native mode: will prr
PIIX: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] MWDMA16 controller on pc1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTTA-351680, ATA DISK drive
hdc: WDC AC21200H, ATA DISK drive
hdd: CD-ROM CDU311, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide: unexpected interrupt
hda: tagged command queueing enabled, command queue depth 8
hda: 33022080 sectors (16907 MB) w/462KiB Cache, CHS=34944/15/63, (U)DMA
ide: unexpected interrupt
hdc: 2503872 sectors (1282 MB) w/128KiB Cache, CHS=2484/16/63, DMA
hdd: ATAPI 8X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
 hda: [PTBL] [2055/255/63] hda1 hda2 hda3
 hdc: [PTBL] [621/64/63] hdc1


Relevant .config entries:

CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_FULL=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=8
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y


