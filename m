Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261534AbSJDIqC>; Fri, 4 Oct 2002 04:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSJDIqC>; Fri, 4 Oct 2002 04:46:02 -0400
Received: from carbon.btinternet.com ([194.73.73.92]:16842 "EHLO carbon")
	by vger.kernel.org with ESMTP id <S261534AbSJDIqB>;
	Fri, 4 Oct 2002 04:46:01 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: Andrew Morton <akpm@digeo.com>, szonyi calin <caszonyi@yahoo.com>
Subject: Re: Kernel 2.5.40 DMA and mm issues
Date: Fri, 4 Oct 2002 09:51:33 +0100
User-Agent: KMail/1.4.7
Cc: linux-kernel@vger.kernel.org
References: <20021004065223.24159.qmail@web40602.mail.yahoo.com> <3D9D4B28.44625C91@digeo.com>
In-Reply-To: <3D9D4B28.44625C91@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210040951.34071.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 9:02 am, Andrew Morton wrote:
> szonyi calin wrote:
> > ...
> > Here is /proc/meminfo after killing the updatedb:
> > MemTotal:       125576 kB
> > MemFree:          5540 kB
> > MemShared:           0 kB
> > Buffers:         21092 kB
> > Cached:          25124 kB
> > SwapCached:       1888 kB
> > Active:          15388 kB
> > Inactive:        33268 kB
> > HighTotal:           0 kB
> > HighFree:            0 kB
> > LowTotal:       125576 kB
> > LowFree:          5540 kB
> > SwapTotal:      248968 kB
> > SwapFree:       246892 kB
> > Dirty:              64 kB
> > Writeback:           0 kB
> > Mapped:           2512 kB
> > Slab:            69712 kB
> > Committed_AS:     3348 kB
> > PageTables:        192 kB
> > ReverseMaps:      2314
>
> That looks reasonable for an updatedb run.
>
> > hda: DMA disabled
>
> This is probably why it's taking tons of system time.
> -

I get the same 'DMA disabled' messages with 2.5 but DMA is never actually 
disabled so I wouldn't rely on them being accurate (see below)

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: Hardcoded IRQ 14 for device 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD400BB-00CAA0, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
hda: DMA disabled
hdb: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
-----------------------------------------------------------------------------------------------------------
gandalf:/home/sandersn# hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 4865/255/63, sectors = 78165360, start = 0
------------------------------------------------------------------------------------------------------------
gandalf:/home/sandersn# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.43 seconds =299.77 MB/sec
 Timing buffered disk reads:  64 MB in  1.52 seconds = 42.22 MB/sec








