Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312294AbSDEF2X>; Fri, 5 Apr 2002 00:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312302AbSDEF2O>; Fri, 5 Apr 2002 00:28:14 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47366
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312294AbSDEF15>; Fri, 5 Apr 2002 00:27:57 -0500
Date: Thu, 4 Apr 2002 21:26:37 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide timer trbl ...
In-Reply-To: <20020404195046.GA29089@matchmail.com>
Message-ID: <Pine.LNX.4.10.10204042125040.10148-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are you using "taskfile io" if so stop for now until I can give Alan a
patch update.  If you are not using "taskfile io" it means there is a new
problem.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Thu, 4 Apr 2002, Mike Fedyk wrote:

> On Tue, Mar 12, 2002 at 04:21:52PM +0200, Zwane Mwaikambo wrote:
> > On Mon, 11 Mar 2002, Alan Cox wrote:
> > 
> > > In all the command cases thats because the previous command state has
> > > completed. I'm pretty sure there is one path alone wrong and its in the 
> > > WIP DMA timeout stuff
> > 
> > I don't know if you guys have come across the ide timer added twice 
> > problem personally, but its pretty easy to reproduce by dropping the 
> > device from DMA to PIO. 100% reproducible over here with my ide cdrom.
> 
> It looks like this issue has moved over to 2.4-ac now.
> 
> I too am able to reproduce this on two drives in PIO mode.
> 
> There are only two drives, hda and hdc.  I was copying from hda to md0 (one
> half of a new RAID1 array that will (completed now as of this writing) be on
> hda and hdc.
> 
> I can provide more information upon request.
> 
> Mike
> 
> 2.4.19-pre4-ac3
> 
> Apr  3 03:43:19 gw kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on md(9,0), internal journal
> Apr  3 03:43:19 gw kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Apr  3 03:44:58 gw kernel: hda: status timeout: status=0xd0 { Busy }
> Apr  3 03:45:05 gw kernel: hda: ide_set_handler: handler not null; old=c01b9630, new=c01bab40
> Apr  3 03:45:05 gw kernel: bug: kernel timer added twice at c01ba9a2.
> Apr  3 03:45:05 gw kernel: hda: no DRQ after issuing MULTWRITE
> Apr  3 03:45:05 gw kernel: ide0: reset: success
> 
> System.map:
> c01ba940 T ide_set_handler
> c01ba9c0 T current_capacity
> 
> 00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 03)
> 00:01.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
> 00:01.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
> 00:01.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II] (rev 01)
> 00:06.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
> 00:07.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 02)
> 00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 54)
> 00:0b.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (rev 16)
> 
> >From 2.4.19-pre3-ac4 (logs not saved from pre4-ac3, but can be reproduced
> upon request...):
> 
> PIIX3: IDE controller on PCI bus 00 dev 09
> PIIX3: chipset revision 0
> PIIX3: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
> hda: WDC AC32500H, ATA DISK drive
> hdc: WDC AC32500H, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: Disabling (U)DMA for WDC AC32500H
> hda: 4999680 sectors (2560 MB) w/128KiB Cache, CHS=620/128/63
> hdc: Disabling (U)DMA for WDC AC32500H
> hdc: 4999680 sectors (2560 MB) w/128KiB Cache, CHS=4960/16/63
> 

