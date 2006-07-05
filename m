Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWGEDGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWGEDGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 23:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWGEDGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 23:06:06 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:25673 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932303AbWGEDGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 23:06:05 -0400
Message-ID: <44AB2C9B.7000409@bigpond.net.au>
Date: Wed, 05 Jul 2006 13:06:03 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <200607051044.05257.kernel@kolivas.org>
In-Reply-To: <200607051044.05257.kernel@kolivas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 5 Jul 2006 03:06:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> some quick comments within code below.
> 
> On Wednesday 05 July 2006 09:35, Peter Williams wrote:
>> @@ -761,8 +770,18 @@ static void set_load_weight(struct task_
>>  		else
>>  #endif
>>  			p->load_weight = RTPRIO_TO_LOAD_WEIGHT(p->rt_priority);
>> -	} else
>> -		p->load_weight = PRIO_TO_LOAD_WEIGHT(p->static_prio);
>> +	} else {
>> +		/*
>> +		 * Reduce the probability of a task escaping the background
>> +		 * due to load balancing leaving it on a lighly used CPU
>> +		 * Can't use zero as that would kill load balancing when only
>> +		 * background tasks are running.
>> +		 */
>> +		if (bgnd_task(p))
>> +			p->load_weight = LOAD_WEIGHT(MIN_TIMESLICE / 2 ? : 1);
> 
> Why not just set it to 1 for all idleprio tasks? The granularity will be lost 
> at anything lower anyway and it avoids a more complex calculation.

I missed this one in my previous reply.  I agree, what you say makes 
sense.  I was in my "think too hard" mode and probably thinking 
(unnecessarily) about how it might effect the smoothed load calculations.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
