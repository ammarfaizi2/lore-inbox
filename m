Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWGEBeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWGEBeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 21:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWGEBeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 21:34:05 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:34693 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932438AbWGEBeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 21:34:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
Date: Wed, 5 Jul 2006 11:33:42 +1000
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest> <200607051044.05257.kernel@kolivas.org> <44AB1294.6070600@bigpond.net.au>
In-Reply-To: <44AB1294.6070600@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607051133.42595.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 July 2006 11:15, Peter Williams wrote:
> Con Kolivas wrote:
> > some quick comments within code below.
> >
> > On Wednesday 05 July 2006 09:35, Peter Williams wrote:
> >> -	unlikely((p)->policy != SCHED_NORMAL && (p)->policy != SCHED_BATCH)
> >> +	unlikely((p)->policy != SCHED_NORMAL && (p)->policy < SCHED_BATCH)
> >
> > idleprio tasks should be able to get rt_policy as well
>
> I don't understand what you mean here.  A task can only have one
> scheduling policy.  The simple (direct) definition of has_rt_policy() is
> (p->policy == SCHED_FIFO || p->policy == SCHED_RR) and the one defined
> is just a rearrangement of that with a view to minimizing overhead in
> the majority of invocations.

I meant they could get rt priority. This does look correct, sorry.

> >> +			 * Tasks currently in the background will be
> >> +			 * at BGND_PRIO priority and preemption
> >> +			 * should be enough to keep them in check provided we
> >> +			 * don't let them adversely effect tasks on the expired
> >
> > ok I'm going to risk a lart and say "affect" ?
>
> I have to refer you to the Oxford English Dictionary.

I was hoping you would.

> According to it 
> (when used as a verb):
>
> affect:  1. like, love 2. like to use, practice or wear 3. aim at, seek
> 4. use or display ostentatiously 5. assume a false appearance 6. attack
> as a disease 7. move or touch.
>
> effect:  1. bring about (an event or result) 2. produce (a state or
> condition) 3. make, construct or build

Let's take this discussion offlist for my benefit, as I'd like to nut this 
out. I still see it as affect with those definitions.

-- 
-ck
