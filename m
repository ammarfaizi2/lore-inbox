Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317304AbSGXOiu>; Wed, 24 Jul 2002 10:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSGXOiu>; Wed, 24 Jul 2002 10:38:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30185 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317304AbSGXOit>; Wed, 24 Jul 2002 10:38:49 -0400
Date: Wed, 24 Jul 2002 16:41:36 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: <martin@dalecki.de>, Adam Kropelin <akropel1@rochester.rr.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: cpqarray broken since 2.5.19
In-Reply-To: <20020724141954.GF5159@suse.de>
Message-ID: <Pine.SOL.4.30.0207241632350.15605-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Jens Axboe wrote:

> On Wed, Jul 24 2002, Marcin Dalecki wrote:
> >
> > >
> > >Jens, the same is in cciss.c.
> > >Please remove locking from blk_stop_queue() (as you suggested) or intrduce
> > >unlocking in request_functions.
> > >
> > Bartek I think the removal is just for reassertion that the
> > locking is the problem. You can't remove it easly from
> > blk_stop_queue() unless you make it mandatory that blk_stop_queue
> > has to be run with the lock already held. Or in other words
> > basically -> Don't use blk_stop_queue() outside of ->request_fn.
>
> Of couse Bart is advocating just making sure that every caller of
> blk_stop_queue() _has_ the queue_lock before calling it, not removing
> the locking there.
>
> --
> Jens Axboe

And I'm also advocating for __blk_start_queue() ideal for usage in
ata_end_request(). And moving spin_lock scope to cover test_and_set_bit()
in blk_start_queue() (for coherency and avoiding spurious calls to
q->request_fn() ).

However IDE_BUSY -> QUEUE_STOPPED_FLAG is braindamaged idea.

--
Bartlomiej

