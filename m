Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSFKO3N>; Tue, 11 Jun 2002 10:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317068AbSFKO3M>; Tue, 11 Jun 2002 10:29:12 -0400
Received: from host194.steeleye.com ([216.33.1.194]:47876 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317066AbSFKO3L>; Tue, 11 Jun 2002 10:29:11 -0400
Message-Id: <200206111429.g5BET8K02052@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Proposed changes to generic blk tag for use in SCSI (1/3) 
In-Reply-To: Message from Jens Axboe <axboe@suse.de> 
   of "Tue, 11 Jun 2002 07:50:14 +0200." <20020611055014.GA1117@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jun 2002 10:29:08 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

axboe@suse.de said:
> Ehm it's already there, one could argue that it's pretty core
> functionality for this type of stuff :-). It's called
> blk_queue_get_tag(q, tag), and it's in blkdev.h. However, I agree that
> we should just move it into ll_rw_blk.c. That gets better documented
> as well. Could you redo that part? 

I guessed it must be.  I grepped the IDE tree looking for anything with `get' 
or `find' in it, but came up empty.  It's actually called 
blk_queue_tag_request(), which is why I didn't find it.

Do you want me to keep this name if I move it?

axboe@suse.de said:
> I completely agree with this, blk_queue_start_tag() should not need to
> know about these things so just checking if the request is already
> marked tagged is fine with me. But please make that a warning, like 

Actually, I think it should be a BUG().  By the time a tagged request comes in 
to blk_queue_start_tag, we must already have corrupted the lists since we use 
the same list element (req->queuelist) to queue on both the tag queue and the 
request queue.

> And also _please_ fix the comment about REQ_CMD and not just the code,
> it's doesn't stand anymore. 

Will do...I didn't see much point altering the comment in the prototype until 
there was agreement that it was OK to do it this way.

James


