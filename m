Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129594AbRCANkM>; Thu, 1 Mar 2001 08:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRCANkD>; Thu, 1 Mar 2001 08:40:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3590 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129584AbRCANjw>;
	Thu, 1 Mar 2001 08:39:52 -0500
Date: Thu, 1 Mar 2001 14:39:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
Message-ID: <20010301143943.P21518@suse.de>
In-Reply-To: <200102282127.VAA20600@gw.chygwyn.com> <Pine.LNX.4.10.10102281525420.6380-100000@penguin.transmeta.com> <20010301010751.Y21518@suse.de> <200103010314.TAA06827@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200103010314.TAA06827@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Feb 28, 2001 at 07:14:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28 2001, Linus Torvalds wrote:
> >I think most of the "we want to disable plugging" behaviour stems
> >from the way task queues behave. Once somebody starts a tq_disk
> >run, the list is fried and walked one by one. Both old loop
> >and nbd drop the io_request_lock and block, possibly waiting
> >for I/O to be done (at least the loop case, don't know about
> >ndb). But this I/O won't be done just because the target plug every
> >now and then just happens to be queued behind the nbd/loop one and a new
> >tq_disk run won't start it.
> 
> Ugh. 
> 
> How about loop/ndb intercepting the damn requests at the "elevator"
> layer - that way you see every one of them, and the actual request
> function might as well just be a no-op?

I've suggested that before, turn ndb into ndb_make_request style
driver and all of this will disappear. I'll give it a shot.

-- 
Jens Axboe

