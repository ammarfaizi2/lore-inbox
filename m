Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423012AbWJaJ0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423012AbWJaJ0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423022AbWJaJ0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:26:30 -0500
Received: from ns1.suse.de ([195.135.220.2]:52118 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423013AbWJaJ02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:26:28 -0500
From: Neil Brown <neilb@suse.de>
To: Jens Axboe <jens.axboe@oracle.com>
Date: Tue, 31 Oct 2006 20:26:21 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17735.5821.446351.439032@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 002 of 6] md: Change lifetime rules for 'md' devices.
In-Reply-To: message from Jens Axboe on Tuesday October 31
References: <20061031164814.4884.patches@notabene>
	<1061031060051.5046@suse.de>
	<20061031002245.dfd1bb66.akpm@osdl.org>
	<17735.4830.610969.866898@cse.unsw.edu.au>
	<20061031091547.GD14055@kernel.dk>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 31, jens.axboe@oracle.com wrote:
> On Tue, Oct 31 2006, Neil Brown wrote:
> > 
> > I'm guessing we need
> > 
> > diff .prev/block/elevator.c ./block/elevator.c
> > --- .prev/block/elevator.c	2006-10-31 20:06:22.000000000 +1100
> > +++ ./block/elevator.c	2006-10-31 20:06:40.000000000 +1100
> > @@ -926,7 +926,7 @@ static void __elv_unregister_queue(eleva
> >  
> >  void elv_unregister_queue(struct request_queue *q)
> >  {
> > -	if (q)
> > +	if (q && q->elevator)
> >  		__elv_unregister_queue(q->elevator);
> >  }
> > 
> > 
> > Jens?  md never registers and elevator for its queue.
> 
> Hmm, but blk_unregister_queue() doesn't call elv_unregister_queue()
> unless q->request_fn is set. And in that case, you must have an io
> scheduler attached.

Hmm.. yes.  Oh, I get it.  I have

	blk_cleanup_queue(mddev->queue);
	mddev->queue = NULL;
	del_gendisk(mddev->gendisk);
	mddev->gendisk = NULL;

That's the wrong order, isn't it. :-(

Thanks,
NeilBrown
