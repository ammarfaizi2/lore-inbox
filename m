Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTKJOoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 09:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTKJOoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 09:44:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15332 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263573AbTKJOoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 09:44:12 -0500
Date: Mon, 10 Nov 2003 15:44:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH] cfq-prio #2
Message-ID: <20031110144412.GK32637@suse.de>
References: <20031110140052.GC32637@suse.de> <3FAF9DAE.3070307@cyberone.com.au> <20031110142302.GF32637@suse.de> <3FAFA1E8.8080800@cyberone.com.au> <20031110143939.GJ32637@suse.de> <3FAFA401.5080404@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFA401.5080404@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11 2003, Nick Piggin wrote:
> 
> 
> Jens Axboe wrote:
> 
> >On Tue, Nov 11 2003, Nick Piggin wrote:
> >
> >>
> >>You acked the change actually :P
> >>I guess it was done in mainline when AS was merged.
> >>
> >
> >Probably missed the semantic change of may_queue.
> >
> 
> Anyway I won't bother digging up the email, its been done now.

Yeah too late to change now...

> >>>>Maybe my version should be called elv_force_queue?
> >>>>
> >>>>
> >>>I just hate to see more of these, really. The original idea for
> >>>may_queue was just that, may this process queue io or not. We can make
> >>>it return something else, though, to indicate whether the process must
> >>>be able to queue. Is it really needed?
> >>>
> >>>
> >>Its quite important. If the queue is full, and AS is waiting for a process
> >>to submit a request, its got a long wait.
> >>
> >>Maybe a lower limit for per process nr_requests. Ie. you may queue if this
> >>queue has less than 128 requests _or_ you have less than 8 requests
> >>outstanding. This would solve my problem. It would also give you a much 
> >>more
> >>appropriate scaling for server workloads, I think. Still, thats quite a
> >>change in behaviour (simple to code though).
> >>
> >
> >That basically belongs inside your may_queue for the io scheduler, imo.
> >
> 
> You can force it to disallow the request, but you can't force it to allow
> one (depending on a successful memory allocation, of course).

Well that's back two mails then, make may_queue return whether you must
queue, may queue, or can't queue.

-- 
Jens Axboe

