Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422732AbWJaJ2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWJaJ2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWJaJ2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:28:36 -0500
Received: from brick.kernel.dk ([62.242.22.158]:44325 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1422732AbWJaJ2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:28:35 -0500
Date: Tue, 31 Oct 2006 10:30:17 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 002 of 6] md: Change lifetime rules for 'md' devices.
Message-ID: <20061031093016.GE14055@kernel.dk>
References: <20061031164814.4884.patches@notabene> <1061031060051.5046@suse.de> <20061031002245.dfd1bb66.akpm@osdl.org> <17735.4830.610969.866898@cse.unsw.edu.au> <20061031091547.GD14055@kernel.dk> <17735.5821.446351.439032@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17735.5821.446351.439032@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31 2006, Neil Brown wrote:
> On Tuesday October 31, jens.axboe@oracle.com wrote:
> > On Tue, Oct 31 2006, Neil Brown wrote:
> > > 
> > > I'm guessing we need
> > > 
> > > diff .prev/block/elevator.c ./block/elevator.c
> > > --- .prev/block/elevator.c	2006-10-31 20:06:22.000000000 +1100
> > > +++ ./block/elevator.c	2006-10-31 20:06:40.000000000 +1100
> > > @@ -926,7 +926,7 @@ static void __elv_unregister_queue(eleva
> > >  
> > >  void elv_unregister_queue(struct request_queue *q)
> > >  {
> > > -	if (q)
> > > +	if (q && q->elevator)
> > >  		__elv_unregister_queue(q->elevator);
> > >  }
> > > 
> > > 
> > > Jens?  md never registers and elevator for its queue.
> > 
> > Hmm, but blk_unregister_queue() doesn't call elv_unregister_queue()
> > unless q->request_fn is set. And in that case, you must have an io
> > scheduler attached.
> 
> Hmm.. yes.  Oh, I get it.  I have
> 
> 	blk_cleanup_queue(mddev->queue);
> 	mddev->queue = NULL;
> 	del_gendisk(mddev->gendisk);
> 	mddev->gendisk = NULL;
> 
> That's the wrong order, isn't it. :-(

Yep, you want to reverse that :-)

-- 
Jens Axboe

