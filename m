Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSFKOpS>; Tue, 11 Jun 2002 10:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSFKOpR>; Tue, 11 Jun 2002 10:45:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1748 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317096AbSFKOpQ>;
	Tue, 11 Jun 2002 10:45:16 -0400
Date: Tue, 11 Jun 2002 16:45:06 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Proposed changes to generic blk tag for use in SCSI (1/3)
Message-ID: <20020611144506.GI1117@suse.de>
In-Reply-To: <20020611055014.GA1117@suse.de> <200206111429.g5BET8K02052@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11 2002, James Bottomley wrote:
> axboe@suse.de said:
> > Ehm it's already there, one could argue that it's pretty core
> > functionality for this type of stuff :-). It's called
> > blk_queue_get_tag(q, tag), and it's in blkdev.h. However, I agree that
> > we should just move it into ll_rw_blk.c. That gets better documented
> > as well. Could you redo that part? 
> 
> I guessed it must be.  I grepped the IDE tree looking for anything with `get' 
> or `find' in it, but came up empty.  It's actually called 
> blk_queue_tag_request(), which is why I didn't find it.
> 
> Do you want me to keep this name if I move it?

Nah the name sucks, you see I didn't even remember it myself either. Why
not just change the name to something sane, like blk_queue_get_tag() or
blk_queue_find_tag(). I think yours (the latter) describes it best. Just
ide accordingly as well, that's the sole current user.

> axboe@suse.de said:
> > I completely agree with this, blk_queue_start_tag() should not need to
> > know about these things so just checking if the request is already
> > marked tagged is fine with me. But please make that a warning, like 
> 
> Actually, I think it should be a BUG().  By the time a tagged request
> comes in to blk_queue_start_tag, we must already have corrupted the
> lists since we use the same list element (req->queuelist) to queue on
> both the tag queue and the request queue.

Agree, make it a BUG_ON() or something.

> > And also _please_ fix the comment about REQ_CMD and not just the code,
> > it's doesn't stand anymore. 
> 
> Will do...I didn't see much point altering the comment in the
> prototype until there was agreement that it was OK to do it this way.

Fine.

-- 
Jens Axboe

