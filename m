Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265565AbSJSJJg>; Sat, 19 Oct 2002 05:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSJSJJg>; Sat, 19 Oct 2002 05:09:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2254 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265565AbSJSJJb>;
	Sat, 19 Oct 2002 05:09:31 -0400
Date: Sat, 19 Oct 2002 11:15:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Jan Dittmer <jan@jandittmer.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Message-ID: <20021019091518.GG871@suse.de>
References: <200210190241.49618.jan@jandittmer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210190241.49618.jan@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19 2002, Jan Dittmer wrote:
> Box runs nevertheless. Disabled tcq at runtime.
> Do you need more information? Their seems to be no more fs corruption, as 
> reported earlier.
> 
> jan
> 
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 00:07.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
> hda: IC35L060AVVA07-0, ATA DISK drive
> hda: DMA disabled
> IDE init is ugly:Call Trace:
>  [<c02722cf>] ide_do_drive_cmd+0x8f/0x180
>  [<c026f4e8>] ide_diag_taskfile+0x88/0xa0
>  [<c026f516>] ide_raw_taskfile+0x16/0x20
>  [<c027dc17>] ide_tcq_configure+0x77/0xe0
>  [<c027dcc6>] ide_enable_queued+0x46/0xb0
>  [<c027de28>] __ide_dma_queued_on+0x48/0x50
>  [<c026b675>] ide_init_queue+0x75/0x80
>  [<c026b936>] init_irq+0x2b6/0x380
>  [<c026be56>] hwif_init+0x106/0x220
>  [<c026b54c>] probe_hwif_init+0x1c/0x70
>  [<c027bded>] ide_setup_pci_device+0x3d/0x70
>  [<c026a583>] via_init_one+0x33/0x40
>  [<c010508f>] init+0x2f/0x180
>  [<c0105060>] init+0x0/0x180
>  [<c01054f5>] kernel_thread_helper+0x5/0x10
> 
> hda: bad special flag: 0x03
> IDE init is ugly:Call Trace:
>  [<c02722cf>] ide_do_drive_cmd+0x8f/0x180
>  [<c026f4e8>] ide_diag_taskfile+0x88/0xa0
>  [<c026f516>] ide_raw_taskfile+0x16/0x20
>  [<c027dc46>] ide_tcq_configure+0xa6/0xe0
>  [<c027dcc6>] ide_enable_queued+0x46/0xb0
>  [<c027de28>] __ide_dma_queued_on+0x48/0x50
>  [<c026b675>] ide_init_queue+0x75/0x80
>  [<c026b936>] init_irq+0x2b6/0x380
>  [<c026be56>] hwif_init+0x106/0x220
>  [<c026b54c>] probe_hwif_init+0x1c/0x70
>  [<c027bded>] ide_setup_pci_device+0x3d/0x70
>  [<c026a583>] via_init_one+0x33/0x40
>  [<c010508f>] init+0x2f/0x180
>  [<c0105060>] init+0x0/0x180
>  [<c01054f5>] kernel_thread_helper+0x5/0x10
> 
> hda: tagged command queueing enabled, command queue depth 32

It's not an oops, and it's not causes by TCQ either. The above is simply
a reminder to fix the ide init sequence, because it's probe sequence
tries to use drive->disk before it has been set up. That is worked
around, but stack is dumped for good measure. So you can feel
comfortable using 2.5.44 regardless.

But I'm curious about TCQ on your system, since another VIA user
reported problems. Does it appear to work for you?

-- 
Jens Axboe

