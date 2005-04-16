Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262665AbVDPNwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbVDPNwS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 09:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVDPNwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 09:52:17 -0400
Received: from mail.dif.dk ([193.138.115.101]:9916 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262665AbVDPNwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 09:52:11 -0400
Date: Sat, 16 Apr 2005 15:54:59 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] sched: fix never executed code due to expression always
 false
In-Reply-To: <20050415075801.GA24974@elte.hu>
Message-ID: <Pine.LNX.4.62.0504161554190.2473@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504150140250.3466@dragon.hyggekrogen.localhost>
 <425F064E.8050003@yahoo.com.au> <Pine.LNX.4.62.0504150213240.3466@dragon.hyggekrogen.localhost>
 <425F0735.6010407@yahoo.com.au> <Pine.LNX.4.62.0504150222390.3466@dragon.hyggekrogen.localhost>
 <20050415075801.GA24974@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Ingo Molnar wrote:

> 
> * Jesper Juhl <juhl-lkml@dif.dk> wrote:
> 
> > As per this patch perhaps? : 
> > 
> > Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> this is still not enough (there was one more comparison to cover). Also, 
> it's a bit cleaner to just cast the left side to signed than cast every 
> member separately.
> 
> 	Ingo
> 
> --
> 
> fix signed comparisons of long long.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> --- linux/kernel/sched.c.orig
> +++ linux/kernel/sched.c
> @@ -2695,9 +2695,9 @@ need_resched_nonpreemptible:
>  
>  	schedstat_inc(rq, sched_cnt);
>  	now = sched_clock();
> -	if (likely((long long)now - prev->timestamp < NS_MAX_SLEEP_AVG)) {
> +	if (likely((long long)(now - prev->timestamp) < NS_MAX_SLEEP_AVG)) {
>  		run_time = now - prev->timestamp;
> -		if (unlikely((long long)now - prev->timestamp < 0))
> +		if (unlikely((long long)(now - prev->timestamp) < 0))
>  			run_time = 0;
>  	} else
>  		run_time = NS_MAX_SLEEP_AVG;
> @@ -2775,7 +2775,7 @@ go_idle:
>  
>  	if (!rt_task(next) && next->activated > 0) {
>  		unsigned long long delta = now - next->timestamp;
> -		if (unlikely((long long)now - next->timestamp < 0))
> +		if (unlikely((long long)(now - next->timestamp) < 0))
>  			delta = 0;
>  
>  		if (next->activated == 1)
> 

Right, that's a better version. Thanks.

-- 
Jesper

