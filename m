Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTKJOwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 09:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTKJOwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 09:52:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19686 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263922AbTKJOwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 09:52:12 -0500
Date: Mon, 10 Nov 2003 15:52:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH] cfq-prio #2
Message-ID: <20031110145212.GL32637@suse.de>
References: <20031110140052.GC32637@suse.de> <3FAF9DAE.3070307@cyberone.com.au> <20031110142302.GF32637@suse.de> <3FAFA1E8.8080800@cyberone.com.au> <20031110143939.GJ32637@suse.de> <3FAFA401.5080404@cyberone.com.au> <20031110144412.GK32637@suse.de> <3FAFA52A.3050600@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFA52A.3050600@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11 2003, Nick Piggin wrote:
> >>>>Its quite important. If the queue is full, and AS is waiting for a 
> >>>>process
> >>>>to submit a request, its got a long wait.
> >>>>
> >>>>Maybe a lower limit for per process nr_requests. Ie. you may queue if 
> >>>>this
> >>>>queue has less than 128 requests _or_ you have less than 8 requests
> >>>>outstanding. This would solve my problem. It would also give you a much 
> >>>>more
> >>>>appropriate scaling for server workloads, I think. Still, thats quite a
> >>>>change in behaviour (simple to code though).
> >>>>
> >>>>
> >>>That basically belongs inside your may_queue for the io scheduler, imo.
> >>>
> >>>
> >>You can force it to disallow the request, but you can't force it to allow
> >>one (depending on a successful memory allocation, of course).
> >>
> >
> >Well that's back two mails then, make may_queue return whether you must
> >queue, may queue, or can't queue.
> >
> 
> Yep, sounds good. I'll make a patch for it for 2.6.x > 0 sometime unless
> you beat me to it.

I'll include it in the next cfq patch, then it can be submitted when the
freeze unthaws a bit.

-- 
Jens Axboe

