Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSDOTLz>; Mon, 15 Apr 2002 15:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313182AbSDOTLy>; Mon, 15 Apr 2002 15:11:54 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:51468 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313181AbSDOTLx>;
	Mon, 15 Apr 2002 15:11:53 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jens Axboe <axboe@suse.de>
Date: Mon, 15 Apr 2002 21:11:34 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] IDE TCQ #4
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <276280417F3@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Apr 02 at 21:00, Jens Axboe wrote:
> > 
> > NULL pointer ...
> 
> Could you decode that? It doesn't look like any of your drives support
> TCQ, it should have enabled them right here:

They were already decoded... Also others reported that - after accessing
/proc/ide/ide0/hda/identify system dies... I believe that passing
hand-created request to ide_raw_taskfile corrupts drive->free_req,
and so subsequent drive command after this cat finds that 
drive->free_req.next is NULL and dies.
 
> > Uniform Multi-Platform E-IDE driver ver.:7.0.0
> > ide: system bus speed 33MHz
> > VIA Technologies, Inc. Bus Master IDE: IDE controller on PCI slot 00:07.1
> > VIA Technologies, Inc. Bus Master IDE: chipset revision 16
> > VIA Technologies, Inc. Bus Master IDE: not 100%% native mode: will probe irqs later
> > VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
> >     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> > hda: WDC WD1200JB-00CRA0, ATA DISK drive
> > hdc: TOSHIBA MK6409MAV, ATA DISK drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > ide: unexpected interrupt
> 
> hda: tagged command queueing enabled, command queue depth 8
> 
> is missing, TCQ is not supported on this drive.

I expected that too, but I thought that unexpected interrupt may
have something related with this. Strange. I'll try to find some 
better identify parser than my eyes.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
