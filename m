Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRCKVDa>; Sun, 11 Mar 2001 16:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbRCKVDU>; Sun, 11 Mar 2001 16:03:20 -0500
Received: from bart.one-2-one.net ([195.94.80.12]:52997 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S129166AbRCKVDD>; Sun, 11 Mar 2001 16:03:03 -0500
Date: Sun, 11 Mar 2001 22:03:48 +0100 (CET)
From: Martin Diehl <home@mdiehl.de>
To: Lawrence MacIntyre <lpz@ciit.y12.doe.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE on 2.4.2
In-Reply-To: <3AA95226.FD878418@ciit.y12.doe.gov>
Message-ID: <Pine.LNX.4.21.0103111255150.10784-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Lawrence MacIntyre wrote:

> Uniform MultiPlatform E-IDE driver Revision 6.31
> ide: assuminmg 33 MHz system bus speed for PIO modes: override with
> idebus=xx
> SIS5513: IDE controller on PCI bus 00 dev 09
> PCI: Assigned IRQ 14 for device 00:01.1
> SIS5513: chipset revision 208
> SIS5513: not 100% native mode: will probe irqs later
> SIS5597
>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
> hda: Maxtor 90640D4, ATA DISK drive
> hdc: CD-ROM CDU55E, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> 
> At this point, the machine hangs...

interesting, I see the same thing except it hangs not before the disk
drives are initialized but afterwards, when initializing the CD-ROM
drives. (Compiling ide-cd as module permits successful boot but hangs
on insmod). This is with SiS5513 rev 208 IDE function from SiS5591
chipset with CONFIG_BLK_DEV_SIS5513 and autotune enabled (default).

For me, the workaround is disabling either one of the above (i.e. not
including SiS5513 support in the kernel or append'ing "hdx=noautotune"
for the cdrom-drives) and everything is fine again. You may want to use
hdparm to get udma2 working. Doing so provides relyable >14MB/s for a
5.4kRPM drive in UDMA(33), so my impression is this is only a tuning 
issue.

> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: Silicon Integrated Systems 5597/5598 Host (rev 2).
>       Medium devsel.  Master Capable.  Latency=32.  
>   Bus  0, device   1, function  0:
>     ISA bridge: Silicon Integrated Systems 85C503 (rev 1).
>       Medium devsel.  Master Capable.  No bursts.  
>   Bus  0, device   1, function  1:
>     IDE interface: Silicon Integrated Systems 85C5513 (rev 208).
>       Fast devsel.  IRQ 14.  Master Capable.  Latency=32.  
>       I/O at 0xe400 [0xe401].
>       I/O at 0xe000 [0xe001].
>       I/O at 0xd800 [0xd801].
>       I/O at 0xd400 [0xd401].
>       I/O at 0xd000 [0xd001].

I'm not absolutely sure, but I'm wondering why the driver enabled all
BAR's including the relocateable port areas which are useful in native
mode only. IMHO the driver should force compatibility mode. For me, only 
the last BAR containing the BM registers at 0xd000 is enabled.

Martin

