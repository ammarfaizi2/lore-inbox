Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSGaMPM>; Wed, 31 Jul 2002 08:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSGaMPM>; Wed, 31 Jul 2002 08:15:12 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:45829 "EHLO
	rtr.ca") by vger.kernel.org with ESMTP id <S316757AbSGaMPL>;
	Wed, 31 Jul 2002 08:15:11 -0400
Message-ID: <3D47D59B.6B8CFED7@pobox.com>
Date: Wed, 31 Jul 2002 08:18:35 -0400
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mukesh Rajan <mrajan@ics.uci.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE, putting HD to sleep causes "lost interrupt"
References: <Pine.SOL.4.20.0207310013490.15380-100000@hobbit.ics.uci.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the answer is very simple, then:  DON'T DO THAT.

When an ATA (IDE) drive is put to sleep (-Y),
it *requires* a reset to revive it for any future commands.

The IDE driver doesn't know about the -Y, so it just attempts
I/O a few times before digging out the BIG hammer and doing a reset.

All is well.
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com


Mukesh Rajan wrote:
> 
> hi,
> 
> things work perfectly fine on my desktop. but on my laptop (toshiba
> satellite) if i try,
> 
> %hdparm -Y /dev/hda           <--- put to sleep followed by
> %hdparm -C /dev/hda           <--- query status
> 
> gives me
> 
> hda: lost interrupt
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x50 { DriveReady SeekComplete }
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x50 { DriveReady SeekComplete }
> hda: lost interrupt
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x50 { DriveReady SeekComplete }
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x50 { DriveReady SeekComplete }
> hda: DMA disabled
> ide0: reset: success
> 
> if i try the above from X, the machine freezes and i need to do hard
> reboot.
> 
> the boot message regarding ide are as follows
> 
> boot messages
> -------------
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> ALI15X3: IDE controller on PCI bus 00 dev 20
> PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using
> pci=biosirq.
> ALI15X3: chipset revision 195
> ALI15X3: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xeff0-0xeff7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xeff8-0xefff, BIOS settings: hdc:DMA, hdd:pio
> hda: TOSHIBA MK2018GAP, ATA DISK drive
> 
> the closest i think i got to on google is the following but there are no
> answers
> 
> http://mail.nl.linux.org/kernelnewbies/2001-01/msg00064.html
> 
> please help.
> 
> - mukesh
