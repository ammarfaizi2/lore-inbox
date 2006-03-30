Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWC3SXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWC3SXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWC3SXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:23:08 -0500
Received: from mail.gmx.de ([213.165.64.20]:37262 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751355AbWC3SXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:23:07 -0500
X-Authenticated: #14349625
Subject: Re: [rfc][patch] improved interactive starvation patch against
	2.6.16
From: Mike Galbraith <efault@gmx.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143728558.7840.11.camel@homer>
References: <1143713997.9381.28.camel@homer>
	 <20060330115540.GA4914@w.ods.org>  <1143728558.7840.11.camel@homer>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 20:23:24 +0200
Message-Id: <1143743004.7532.33.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 16:22 +0200, Mike Galbraith wrote:
> +		if (expired_starving(rq)) {
> +			int limit = MIN_TIMESLICE + CURRENT_BONUS(p);
> +			int runtime = now - p->timestamp;
> +
> +			runtime = NS_TO_JIFFIES(runtime);
> +			if (runtime >= limit && p->time_slice >= limit) {
> +
> +				dequeue_task(p, rq->active);
> +				enqueue_task(p, rq->expired);
> +				set_tsk_need_resched(p);
> +				if (p->prio < rq->best_expired_prio)
> +					rq->best_expired_prio = p->prio;
> +			}
> +		}

This bit isn't cutting it.  expired_starving() is routine enough that
short slicing (on this scale at least) is noticed.  Don't waste your
time with this one.

	-Mike

