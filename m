Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSGaRLf>; Wed, 31 Jul 2002 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318408AbSGaRLf>; Wed, 31 Jul 2002 13:11:35 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:22544
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318407AbSGaRLe>; Wed, 31 Jul 2002 13:11:34 -0400
Date: Wed, 31 Jul 2002 10:08:34 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mukesh Rajan <mrajan@ics.uci.edu>
cc: linux-kernel@vger.kernel.org, mlord@pobox.com
Subject: Re: IDE, putting HD to sleep causes "lost interrupt"
In-Reply-To: <Pine.SOL.4.20.0207310013490.15380-100000@hobbit.ics.uci.edu>
Message-ID: <Pine.LNX.4.10.10207310958520.25961-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because you need to call

hdparm -w /dev/hda		<--- Reset Device
hdparm -C /dev/hda		<--- query status, repeat until good.
hdparm -X** /dev/hda		<--- transfer rate mode set
hdparm -m** /dev/hda		<--- set multiple
hdparm -d* /dev/hda		<--- set DMA

You effectively kill (disable command mode) the drive has to be kick
started.

Cheers,

On Wed, 31 Jul 2002, Mukesh Rajan wrote:

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
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

