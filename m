Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSGXOlY>; Wed, 24 Jul 2002 10:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSGXOlY>; Wed, 24 Jul 2002 10:41:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24463 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317341AbSGXOlW>;
	Wed, 24 Jul 2002 10:41:22 -0400
Date: Wed, 24 Jul 2002 16:44:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: martin@dalecki.de, Adam Kropelin <akropel1@rochester.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: cpqarray broken since 2.5.19
Message-ID: <20020724144403.GR15201@suse.de>
References: <20020724141954.GF5159@suse.de> <Pine.SOL.4.30.0207241632350.15605-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0207241632350.15605-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24 2002, Bartlomiej Zolnierkiewicz wrote:
> 
> On Wed, 24 Jul 2002, Jens Axboe wrote:
> 
> > On Wed, Jul 24 2002, Marcin Dalecki wrote:
> > >
> > > >
> > > >Jens, the same is in cciss.c.
> > > >Please remove locking from blk_stop_queue() (as you suggested) or intrduce
> > > >unlocking in request_functions.
> > > >
> > > Bartek I think the removal is just for reassertion that the
> > > locking is the problem. You can't remove it easly from
> > > blk_stop_queue() unless you make it mandatory that blk_stop_queue
> > > has to be run with the lock already held. Or in other words
> > > basically -> Don't use blk_stop_queue() outside of ->request_fn.
> >
> > Of couse Bart is advocating just making sure that every caller of
> > blk_stop_queue() _has_ the queue_lock before calling it, not removing
> > the locking there.
> >
> > --
> > Jens Axboe
> 
> And I'm also advocating for __blk_start_queue() ideal for usage in
> ata_end_request(). And moving spin_lock scope to cover test_and_set_bit()
> in blk_start_queue() (for coherency and avoiding spurious calls to
> q->request_fn() ).

Feel free to send me the patch to compliment the __blk_stop_queue() part
(which is in axboe@master:/home/axboe/BK/linux-2.5-block, btw).

> However IDE_BUSY -> QUEUE_STOPPED_FLAG is braindamaged idea.

I agree.

-- 
Jens Axboe

