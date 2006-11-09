Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754746AbWKIGad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbWKIGad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 01:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbWKIGad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 01:30:33 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:27366 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1754746AbWKIGac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 01:30:32 -0500
Message-ID: <4552CAD9.1080603@in.ibm.com>
Date: Thu, 09 Nov 2006 11:59:45 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Mauricio Lin <mauriciolin@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Jiffies wraparound is not treated in the schedstats
References: <3f250c710611081005v5fcf3236qfb10b47bab1ada5f@mail.gmail.com>
In-Reply-To: <3f250c710611081005v5fcf3236qfb10b47bab1ada5f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Lin wrote:
> Hi Balbir,
> 
> Do you know why in the sched_info_arrive() and sched_info_depart()
> functions the calculation of delta_jiffies does not use the time_after
> or time_before macro to prevent  the miscalculation when jiffies
> overflow?
> 
> For instance the delta_jiffies variable is simply calculated as:
> 
> delta_jiffies = now - t->sched_info.last_queued;
> 
> Do not you think the more logical way should be
> 
> if (time_after(now, t->sched_info.last_queued))
>    delta_jiffies = now - t->sched_info.last_queued;
> else
>    delta_jiffies = (MAX_JIFFIES - t->sched_info.last_queued) + now
> 

What's MAX_JIFFIES? Is it MAX_ULONG? jiffies is unsigned long
so you'll have to be careful with unsigned long arithmetic.

Consider that now is 5 and t->sched_info.last_queued is 10.

On my system

perl -e '{printf("%lu\n", -5 + (1<<32) - 1);}'
4294967291

perl -e '{printf("%lu\n", -5 );}'
4294967291


> I have included more variables to measure some issues of schedule in
> the kernel (following schedstat idea) and I noticed that jiffies
> wraparound has led to wrong values, since the user space tool when
> collecting the values is producing negative values.
> 

hmm.. jiffies wrapped around in sched_info_depart()? I've never seen
that happen. Could you post the additions and user space tool to look at?
What additional features are you planning to measure in the scheduler?

> Any comments?
> 
> Can I provide a patch for that?
> 

Please feel free to provide patches, this is open source!!

> BR,
> 
> Mauricio Lin.


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
