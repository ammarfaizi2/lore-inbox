Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBNHvv>; Wed, 14 Feb 2001 02:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBNHva>; Wed, 14 Feb 2001 02:51:30 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:15335 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129027AbRBNHvO>; Wed, 14 Feb 2001 02:51:14 -0500
Message-ID: <3A8A38E7.569FD70E@Home.net>
Date: Wed, 14 Feb 2001 02:51:03 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: dilinger@mp3revolution.net
CC: linux-kernel@vger.kernel.org
Subject: Re: piix.c and tuning question
In-Reply-To: <20010214023538.A26558@incandescent.mp3revolution.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmmm this is my chipset:

Which motherboard do you have?

00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]

i've had irq timeouts but they were due to a slow CD-ROM causing the two DMA drives to timeout (don't
know why).

ive never seen ide_dmaproc though.

This is my following hdparm config

hdparm -d 1 -X34 -u1 -k 1 /dev/hdb
hdparm -d 1 -X34 -u1 -k 1 /dev/hda

for both drives, one of them us a UDMA66 but this Pentium 200Mhz cant do UDMA even ;/

I have a AP53/AX AcerOpen Motherboard.

Shawn.

dilinger@mp3revolution.net wrote:

> I have a box w/ the following controllers:
>
> 00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
> 00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
> 00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
>
> I regularly see the following, during high i/o:
>
> Feb 14 02:15:27 inkbay kernel: hdd: timeout waiting for DMA
> Feb 14 02:15:27 inkbay kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> Feb 14 02:15:27 inkbay kernel: hdd: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> Feb 14 02:21:13 inkbay kernel: hdc: DMA disabled
> Feb 14 02:21:13 inkbay kernel: hdd: DMA disabled
> Feb 14 02:21:22 inkbay kernel: hdd: timeout waiting for DMA
> Feb 14 02:21:22 inkbay kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> Feb 14 02:21:22 inkbay kernel: hdd: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>
> (the DMA being disabled was me manually doing an hdparm -d0)
>
> According to Documentation/Configure.help:
>
> Intel PIIXn chipsets support
> CONFIG_BLK_DEV_PIIX
>   This driver adds PIO mode setting and tuning for all PIIX IDE
>   controllers by Intel.  Since the BIOS can sometimes improperly tune
>   PIO 0-4 mode settings, this allows dynamic tuning of the chipset
>   via the standard end-user tool 'hdparm'.
>
>   Please read the comments at the top of drivers/ide/piix.c.
>
>   If you say Y here, you should also say Y to "PIIXn Tuning support",
>   below.
>
>   If unsure, say N.
>
> PIIXn Tuning support
> CONFIG_PIIX_TUNING
>   This driver extension adds DMA mode setting and tuning for all PIIX
>   IDE controllers by Intel. Since the BIOS can sometimes improperly
>   set up the device/adapter combination and speed limits, it has
>   become a necessity to back/forward speed devices as needed.
>
>   Case 430HX/440FX PIIX3 need speed limits to reduce UDMA to DMA mode
>   2 if the BIOS can not perform this task at initialization.
>
>   If unsure, say N.
>
> Obviously, the BIOS is not performing the DMA mode reduction, and must
> be done maually.  However, that's about all the information I can gather
> about this problem.  Has anyone looked at the top of piix.c (other than
> the IDE maintainer, that is)?  It's quite cryptic:
>  * | PIO 4 | MW2 | e3 | a3 | b |        piix_tune_drive(drive, 4);
>  *
>  * sitre = word40 & 0x4000; primary
>  * sitre = word42 & 0x4000; secondary
>  *
>  * 44 8421|8421    hdd|hdb
>  *
>  * 48 8421         hdd|hdc|hdb|hda udma enabled
>  *
>  *    0001         hda
> Wtf is a sitre?  What are these odd numbers?  And where is any useful
> info that, as a piix driver _user_, I might be able to use?  Is it
> merely DMA which I want to tune, or do I want to mess w/ PIO modes
> (marked as dangerous in hdparm) as well?
>
> --
> "... being a Linux user is sort of like living in a house inhabited
> by a large family of carpenters and architects. Every morning when
> you wake up, the house is a little different. Maybe there is a new
> turret, or some walls have moved. Or perhaps someone has temporarily
> removed the floor under your bed." - Unix for Dummies, 2nd Edition
>         -- found in the .sig of Rob Riggs, rriggs@tesser.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

