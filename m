Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVDOA1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVDOA1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 20:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVDOA0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 20:26:08 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:45207 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261682AbVDOAXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 20:23:19 -0400
Message-ID: <425F096F.2020303@yahoo.com.au>
Date: Fri, 15 Apr 2005 10:23:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: fix never executed code due to expression always
 false
References: <Pine.LNX.4.62.0504150140250.3466@dragon.hyggekrogen.localhost> <425F064E.8050003@yahoo.com.au> <Pine.LNX.4.62.0504150213240.3466@dragon.hyggekrogen.localhost> <425F0735.6010407@yahoo.com.au> <Pine.LNX.4.62.0504150222390.3466@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504150222390.3466@dragon.hyggekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> 
> As per this patch perhaps? : 
> 

Thanks. I'll make sure it gets to the right place if nobody picks it up.

> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> --- linux-2.6.12-rc2-mm3-orig/kernel/sched.c	2005-04-11 21:20:56.000000000 +0200
> +++ linux-2.6.12-rc2-mm3/kernel/sched.c	2005-04-15 02:21:34.000000000 +0200
> @@ -2697,9 +2697,10 @@ need_resched_nonpreemptible:
>  	schedstat_inc(rq, sched_cnt);
>  	now = sched_clock();
>  	if (likely((long long)now - prev->timestamp < NS_MAX_SLEEP_AVG)) {
> -		run_time = now - prev->timestamp;
> -		if (unlikely((long long)now - prev->timestamp < 0))
> +		if (unlikely(((long long)now - (long long)prev->timestamp) < 0))
>  			run_time = 0;
> +		else
> +			run_time = now - prev->timestamp;
>  	} else
>  		run_time = NS_MAX_SLEEP_AVG;
>  
> @@ -2776,7 +2777,7 @@ go_idle:
>  
>  	if (!rt_task(next) && next->activated > 0) {
>  		unsigned long long delta = now - next->timestamp;
> -		if (unlikely((long long)now - next->timestamp < 0))
> +		if (unlikely(((long long)now - (long long)next->timestamp) < 0))
>  			delta = 0;
>  
>  		if (next->activated == 1)
> 
> 
> 


-- 
SUSE Labs, Novell Inc.

