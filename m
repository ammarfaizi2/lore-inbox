Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbRE3Ni7>; Wed, 30 May 2001 09:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbRE3Nij>; Wed, 30 May 2001 09:38:39 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:2010 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S262485AbRE3Ni2>; Wed, 30 May 2001 09:38:28 -0400
Date: Wed, 30 May 2001 14:37:15 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: Jens Axboe <axboe@kernel.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, cut three
In-Reply-To: <20010530152412.C17136@suse.de>
Message-ID: <Pine.LNX.4.21.0105301431530.7153-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 May 2001, Jens Axboe wrote:
> On Wed, May 30 2001, Mark Hemment wrote:
> >   This can lead to attempt_merge() releasing the embedded request
> > structure (which, as an extract copy, has the ->q set, so to
> > blkdev_release_request() it looks like a request which originated from
> > the block layer).  This isn't too healthy.
> > 
> >   The fix here is to add a check in __scsi_merge_requests_fn() to check
> > for ->special being non-NULL.
> 
> How about just adding 
> 
> 	if (req->cmd != next->cmd
> 	    || req->rq_dev != next->rq_dev
> 	    || req->nr_sectors + next->nr_sectors > q->max_sectors
> 	    || next->sem || req->special)
>                 return;
> 
> ie check for special too, that would make sense to me. Either way would
> work, but I'd rather make this explicit in the block layer that 'not
> normal' requests are left alone. That includes stuff with the sem set,
> or special.


  Yes, that is an equivalent fix.

  In the original patch I wanted to keep the change local (ie. in the SCSI
layer).  Pushing the check up the generic block layer makes sense.

  Are you going to push this change to Linus, or should I?
  I'm assuming the other scsi-layer changes in Alan's tree will eventually
be pushed.

Mark

