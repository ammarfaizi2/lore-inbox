Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSFOJOV>; Sat, 15 Jun 2002 05:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSFOJOU>; Sat, 15 Jun 2002 05:14:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64709 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315207AbSFOJOS>;
	Sat, 15 Jun 2002 05:14:18 -0400
Date: Sat, 15 Jun 2002 11:14:05 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Message-ID: <20020615091405.GB5990@suse.de>
In-Reply-To: <200206150910.CAA00831@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15 2002, Adam J. Richter wrote:
> >> 	So, I need a fourth location at in generic_make_request
> >> just before the call to q->make_request_fn, like so:
> >> 
> >> 	if (q->make_request_fn != __make_request) {
> >> 		int flags;
> >> 		spin_lock_irqsave(q->lock, flags);
> >> 		clear_hint(bio);
> >> 		spin_unlock_irqrestore(q->lock, flags);
> >> 	}
> >> 	ret = q->make_request_fn(q, bio);
> 
> >Irk, this is ugly. But how you are moving away from the initial goal (or
> >maybe this was your goal the whole time, just a single merge hint?) of
> >passing back the hint instead of maintaing it in the queue. So let me
> >ask, are you aware of the last_merge I/O scheduler hint? Which does
> >exactly this already...
> 
> 	The code that I think I more or less have in my head has not
> changed (aside from that fourth test).
> 
> 	Although I was not aware of q->last_merge, I see that it is
> not what I want.  I want up to one hint per request, for the last bio
> in the request.  bi_hint would be null for all bio's except possibly
> the last bio in a request.  I do not want just one hint per queue.

.. which, as far as I can see, brings us right back into the problems
with stalling the i/o and other nastiness. So far your approach seems
hackish at best, but ->

> 	If it is unclear what I mean, perhaps I really need to code it
> up to explain it. and we can discuss it from there.

go ahead and code it up if you want and we can discuss it some more.

-- 
Jens Axboe

