Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313168AbSDOTA0>; Mon, 15 Apr 2002 15:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313172AbSDOTAZ>; Mon, 15 Apr 2002 15:00:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27663 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313168AbSDOTAY>;
	Mon, 15 Apr 2002 15:00:24 -0400
Date: Mon, 15 Apr 2002 21:00:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020415190028.GZ12608@suse.de>
In-Reply-To: <275738D7E75@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Petr Vandrovec wrote:
> On 15 Apr 02 at 19:41, Petr Vandrovec wrote:
> > 
> > If I parsed file correctly (it is 83 decimal word, yes?), WD's
> > WDC WD1200JB-00CRA0 supports TCQ too. I'm still deciding which of
> > TCQ #X and IDE #YY patches should be aplied to 2.5.8 to get optimal
> > results (and I have to disconnect slaves...).
> 
> I applied TCQ#4 only...

That is fine.

> I have to swap my host, probably, or there is some other problem.
> I got two unexpected interrupts, then machine looked fine, but shortly 
> thereafter oops appeared. /proc/ide/ide0/hda/tcq showed 'not active'
> before it crashed. Machine is SMP.
> 
> NULL pointer ...

Could you decode that? It doesn't look like any of your drives support
TCQ, it should have enabled them right here:

> Uniform Multi-Platform E-IDE driver ver.:7.0.0
> ide: system bus speed 33MHz
> VIA Technologies, Inc. Bus Master IDE: IDE controller on PCI slot 00:07.1
> VIA Technologies, Inc. Bus Master IDE: chipset revision 16
> VIA Technologies, Inc. Bus Master IDE: not 100%% native mode: will probe irqs later
> VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> hda: WDC WD1200JB-00CRA0, ATA DISK drive
> hdc: TOSHIBA MK6409MAV, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide: unexpected interrupt

hda: tagged command queueing enabled, command queue depth 8

is missing, TCQ is not supported on this drive.

> hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=232581/16/63, UDMA(66)
> ide: unexpected interrupt
> hdc: 12685680 sectors (6495 MB), CHS=13424/15/63, UDMA(33)

(these unexpected interrupts are nothing to worry about, only if some
happen after this part it's a concern).

-- 
Jens Axboe

