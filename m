Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317362AbSGXOmW>; Wed, 24 Jul 2002 10:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSGXOmV>; Wed, 24 Jul 2002 10:42:21 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30185 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317355AbSGXOmT>; Wed, 24 Jul 2002 10:42:19 -0400
Date: Wed, 24 Jul 2002 16:45:14 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <martin@dalecki.de>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: cpqarray broken since 2.5.19
In-Reply-To: <3D3EB940.2010708@evision.ag>
Message-ID: <Pine.SOL.4.30.0207241642360.15605-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Marcin Dalecki wrote:

> Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 24 Jul 2002, Marcin Dalecki wrote:
> >
> >
> >>>Jens, the same is in cciss.c.
> >>>Please remove locking from blk_stop_queue() (as you suggested) or intrduce
> >>>unlocking in request_functions.
> >>>
> >>
> >>Bartek I think the removal is just for reassertion that the
> >>locking is the problem. You can't remove it easly from
> >>blk_stop_queue() unless you make it mandatory that blk_stop_queue
> >>has to be run with the lock already held. Or in other words
> >>basically -> Don't use blk_stop_queue() outside of ->request_fn.
> >
> >
> > Yep, that how it should be only used.
> > However you are right these stop/start need some checking.
> >
> > About idea of using QUEUE_FLAG_STOPPED as IDE_BUSY right now is no go
> > and will never be.
>
> Hold on please. Becouse if you think one step further ->
> not blocking blk_stop_queue() in do_request or more
> precisely at places where the IDE_BUSY get's set 8-) you suddenly get
> completely rid of it if you replace the "back-calls" to do_request() in
> ata_irq_request() and ide_timer_expiry() with blk_start_queue()...
> No direct manipulation whatsever.

If you think it is good idea, go for it, as I don't work on your 2.5 IDE
anymore. Game is over, I will start my tree (based on 2.4) soon.

Don't say later you haven't been warned.

--
Bartlomiej

