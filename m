Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWJ3NtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWJ3NtG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWJ3NtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:49:06 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:49348 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751454AbWJ3NtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:49:03 -0500
Message-ID: <454602B3.7000306@in.ibm.com>
Date: Mon, 30 Oct 2006 19:18:35 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, "Martin T. Setek" <martitse@ifi.uio.no>
CC: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: [PATCH: 2.6.18.1] delayacct: cpu_count in taskstats updated
 correctly
References: <20061026223653.bc871cf2.akpm@osdl.org>
In-Reply-To: <20061026223653.bc871cf2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Begin forwarded message:
> 
> Date: Fri, 27 Oct 2006 05:18:17 +0200 (CEST)
> From: Martin Tostrup Setek <martitse@student.matnat.uio.no>
> To: nagar@watson.ibm.com
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH: 2.6.18.1] delayacct: cpu_count in taskstats updated correctly
> 
> 
> from: Martin T. Setek <martitse@ifi.uio.no>
> 
> cpu_count in struct taskstats should be the same as the corresponding 
> (third) value found in /proc/<pid>/schedstat
> Signed-off-by: <martitse@ifi.uio.no>
> ---
> Index: linux-2.6.18.1/kernel/delayacct.c
> ===================================================================
> --- linux-2.6.18.1.orig/kernel/delayacct.c
> +++ linux-2.6.18.1/kernel/delayacct.c
> @@ -124,7 +124,7 @@ int __delayacct_add_tsk(struct taskstats
>   	t2 = tsk->sched_info.run_delay;
>   	t3 = tsk->sched_info.cpu_time;
> 
> -	d->cpu_count += t1;
> +	d->cpu_count = t1;
> 
>   	jiffies_to_timespec(t2, &ts);
>   	tmp = (s64)d->cpu_delay_total + timespec_to_ns(&ts);
> -

I was off from work and just saw this message.

The first field "d" in __delayacct_add_task() acts as an accumulator of
statistics (specially useful for fill_tgid() and called just once for
fill_pid() with cpu_count of "d" initialized to 0).

We sum up in d->cpu_count, since the same value of "d" is passed each time from
fill_tgid(). The proposed change is incorrect as we would overwrite the value
each time.

Balbir

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
