Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbRE3Nk7>; Wed, 30 May 2001 09:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbRE3Nkj>; Wed, 30 May 2001 09:40:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48657 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262485AbRE3Nkf>;
	Wed, 30 May 2001 09:40:35 -0400
Date: Wed, 30 May 2001 15:40:34 +0200
From: Jens Axboe <axboe@kernel.org>
To: Mark Hemment <markhe@veritas.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, cut three
Message-ID: <20010530154034.E17136@suse.de>
In-Reply-To: <20010530152412.C17136@suse.de> <Pine.LNX.4.21.0105301431530.7153-100000@alloc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105301431530.7153-100000@alloc>; from markhe@veritas.com on Wed, May 30, 2001 at 02:37:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30 2001, Mark Hemment wrote:
> On Wed, 30 May 2001, Jens Axboe wrote:
> > On Wed, May 30 2001, Mark Hemment wrote:
> > >   This can lead to attempt_merge() releasing the embedded request
> > > structure (which, as an extract copy, has the ->q set, so to
> > > blkdev_release_request() it looks like a request which originated from
> > > the block layer).  This isn't too healthy.
> > > 
> > >   The fix here is to add a check in __scsi_merge_requests_fn() to check
> > > for ->special being non-NULL.
> > 
> > How about just adding 
> > 
> > 	if (req->cmd != next->cmd
> > 	    || req->rq_dev != next->rq_dev
> > 	    || req->nr_sectors + next->nr_sectors > q->max_sectors
> > 	    || next->sem || req->special)
> >                 return;
> > 
> > ie check for special too, that would make sense to me. Either way would
> > work, but I'd rather make this explicit in the block layer that 'not
> > normal' requests are left alone. That includes stuff with the sem set,
> > or special.
> 
> 
>   Yes, that is an equivalent fix.
> 
>   In the original patch I wanted to keep the change local (ie. in the SCSI
> layer).  Pushing the check up the generic block layer makes sense.

Ok, so we agree.

>   Are you going to push this change to Linus, or should I?
>   I'm assuming the other scsi-layer changes in Alan's tree will eventually
> be pushed.

I'll push it, I'll do the end_that_request_first thing too.

-- 
Jens Axboe

