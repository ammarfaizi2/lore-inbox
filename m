Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271913AbRIIGtS>; Sun, 9 Sep 2001 02:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271916AbRIIGtJ>; Sun, 9 Sep 2001 02:49:09 -0400
Received: from swat.thok.org ([4.36.43.84]:2052 "HELO swat.thok.org")
	by vger.kernel.org with SMTP id <S271913AbRIIGtA>;
	Sun, 9 Sep 2001 02:49:00 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_BLK_DEV_SL82C105 should not be PPC/ARM specific
In-Reply-To: <20010906223001.A63F613DC7@kuroneko> <20010907000817.G23583@flint.arm.linux.org.uk>
From: Mark Eichin <eichin@thok.org>
Date: 09 Sep 2001 02:49:20 -0400
In-Reply-To: Russell King's message of "Fri, 7 Sep 2001 00:08:17 +0100"
Message-ID: <xe1pu90svtb.fsf@swat.thok.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That patch (plus bludgeoning the config) certainly *works* on this
chipset, but it doesn't get DMA support; logs follow.  If I run hdparm
to put it into using_dma mode, and then try to access it, using_dma
mode gets turned off after some delay...

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
W82C105: IDE controller on PCI bus 00 dev 10
PCI: No IRQ known for interrupt pin A of device 00:02.0. Probably
buggy MP table.
W82C105: chipset revision 6
W82C105: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcd0-0xfcd7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfcd8-0xfcdf, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 4W100H6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 195711264 sectors (100204 MB) w/2048KiB Cache, CHS=194158/16/63,
(U)DMA
 hda:hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
LDM:  DEBUG (ldm.c, 876): validate_partition_table: Found basic MS-DOS
partition, not a 
dynamic disk.
 hda1 hda2

# hdparm -v  /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 63086/16/63, sectors = 195711264, start = 0
# hdparm -t  /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in 57.65 seconds =  1.11 MB/sec
# hdparm -v  /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 63086/16/63, sectors = 195711264, start = 0
