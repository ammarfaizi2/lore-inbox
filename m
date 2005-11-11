Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVKKNUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVKKNUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 08:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVKKNUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 08:20:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23087 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750730AbVKKNUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 08:20:30 -0500
Date: Fri, 11 Nov 2005 14:21:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] as-iosched: update alias handling
Message-ID: <20051111132134.GU3699@suse.de>
References: <20051110140859.GA26030@htj.dyndns.org> <20051110171743.GE3699@suse.de> <4373CB4C.6070602@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4373CB4C.6070602@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11 2005, Nick Piggin wrote:
> Jens Axboe wrote:
> >On Thu, Nov 10 2005, Tejun Heo wrote:
> >
> >>Unlike other ioscheds, as-iosched handles alias by chaing them using
> >>rq->queuelist.  As aliased requests are very rare in the first place,
> >>this complicates merge/dispatch handling without meaningful
> >>performance improvement.  This patch updates as-iosched to dump
> >>aliased requests into dispatch queue as other ioscheds do.
> >>
> >>Signed-off-by: Tejun Heo <htejun@gmail.com>
> >
> >
> >In theory the way 'as' handles the aliases is faster since we postpone
> >pushing them to the dispatch list at the same point (and they have
> >strong (if not identical) locality). But it is much simpler to just
> >shove the offending requests onto the dispatch list.
> >
> >It's really up to Nick - what do you think? Leaving patch below.
> >
> 
> I thought this was pretty cool, but in reality it could be that the
> cost / benefit actually goes the wrong way due to added complexity
> and rarity of alised requests.
> 
> Hmm... I can't bear to ack it ;) I'll close my eyes and let Jens
> make the call!

Heh well, I am a sucker for simplicity especially when it's for corner
cases where the more advanced solution will at most save you a full
seek.

> >>Jens, I've tested this change for several hours, but it might be
> >>better to postpone this change to next release.  It's your call.
> >>
> 
> It could go into mm now, but probably leave it for 2.6.16 unless
> you have some other reason to really need it.

Agree, I've shoved it into the 'post-2.6.15' branch.

-- 
Jens Axboe

