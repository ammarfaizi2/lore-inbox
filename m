Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314499AbSEFPSJ>; Mon, 6 May 2002 11:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314505AbSEFPSI>; Mon, 6 May 2002 11:18:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314499AbSEFPSF>;
	Mon, 6 May 2002 11:18:05 -0400
Date: Mon, 6 May 2002 17:17:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: aia21@cantab.net, wstinsonfr@yahoo.fr, linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.5.13 severe file system corruption experienced follozing e2fsck ...
Message-ID: <20020506151759.GC1481@suse.de>
In-Reply-To: <5.1.0.14.2.20020505200138.00b2d660@pop.cus.cam.ac.uk> <20020505183451.98763.qmail@web14102.mail.yahoo.com> <5.1.0.14.2.20020505200138.00b2d660@pop.cus.cam.ac.uk> <5.1.0.14.2.20020506093027.00aca720@pop.cus.cam.ac.uk> <20020506085033.GD820@suse.de> <20020506154345.39f12ad5.sebastian.droege@gmx.de> <20020506134803.GF18817@suse.de> <20020506171435.29fb592d.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06 2002, Sebastian Droege wrote:
> On Mon, 6 May 2002 15:48:03 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > On Mon, May 06 2002, Sebastian Droege wrote:
> > > On Mon, 6 May 2002 10:50:33 +0200
> > > Jens Axboe <axboe@suse.de> wrote:
> > > 
> > > > On Mon, May 06 2002, Anton Altaparmakov wrote:
> > > > > At 06:55 06/05/02, Jens Axboe wrote:
> > > > > >On Sun, May 05 2002, Anton Altaparmakov wrote:
> > > > > >> Note even with that fix IDE (at least TCQ) is really easy to crash when 
> > > > > >you
> > > > > >> put the system under heavier I/O (at least on my via box)...
> > > > > >
> > > > > >If you have stumpled upon a tcq bug, I'd like to know more about it.
> > > > > 
> > > > > Back trace (sorry didn't have ckermit running so didn't catch the whole 
> > > > > output and was too lazy to write it all down): blk_queue_invalidate_tags, 
> > > > > tcq_invalidate_queue, ide_dmaq_complete, ide_dmaq_intr, ata_irq_request, 
> > > > > ide_dmaq_intr, handle_IRQ_event, do_IRQ, ideprobe_init.
> > > > 
> > > > Same problem as Sebastian I'm sure, in which case the backtrace holds no
> > > > info for me, the IDE messages printed _before_ the panic would be
> > > > helpful though :-)
> > > Ok here they are (or do you mean the ide initialisation?):
> > > 
> > > [normal stuff]
> > > 
> > > ide_tcq_intr_timeout: timeout waiting for service interrupt...
> > > ide_tcq_intr_timeout: hwgroup not busy
> > > hda: invalidating pending queue (10)
> > > kernel BUG at ll_rw_blk.c:407!
> > 
> > Thanks, yes these were the messages I meant. Could you try 2.4.19-pre8
> > plus patches just posted?
> Ok... tested
> it panics with a NULL pointer dereference at 00000004 after
> 
> hda: IBM-DTTA-351010, ATA DISK drive
> hdb: WDC WD800BB-00BSA0, ATA DISK drive
> hdc: CD-W512EB, ATAPI CD/DVD-ROM drive
> hdd: CD-532E-B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> [panic]
> 
> Sorry but I have no more time for testing and oops handcopying today
> I'll do that tomorrow

Ok thanks, it's probably the auto_poll check though. Could you try one
more boot, just commenting out the call to ide_tcq_check_autopoll() in
ide_enable_queued()? It's in drivers/ide/ide-tcq.c.

-- 
Jens Axboe

