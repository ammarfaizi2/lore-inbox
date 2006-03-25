Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWCYFFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWCYFFa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 00:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWCYFFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 00:05:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:31621 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751024AbWCYFF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 00:05:29 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <44248DE7.80001@bigpond.net.au>
References: <1143198208.7741.8.camel@homer>
	 <200603242237.38100.kernel@kolivas.org>  <44248DE7.80001@bigpond.net.au>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 06:06:12 +0100
Message-Id: <1143263172.7930.15.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-25 at 11:25 +1100, Peter Williams wrote:
> Con Kolivas wrote:

> >>  	if (!rt_task(p))
> >> -		p->prio = recalc_task_prio(p, now);
> >> +		p->prio = recalc_task_prio(p, comp);
> > 
> > Seems wasteful of a very expensive (on 32bit) unsigned long long on 
> > uniprocessor builds.
> 
> Unsigned long long is necessary in order to avoid overflow when dealing 
> with nano seconds but (if you reorganized the expressions and made the 
> desired precedence explicit) you could probably use something smaller 
> for the difference between the two timestamp_lats_tick values.  More 
> importantly, I think that the original code which used the computed 
> "now" was correct as otherwise the task's timestamp will not have the 
> correct time for its CPU.

I can live with it either way.  On my SMT box, the rounding is much
worse than the actual drift, that's microseconds, but the rounding turns
it into milliseconds.

> Of course, this all hinges on the differences between the run queues' 
> timestamp_last_tick fields being a true measure of the time drift 
> between them.  I've never been wholly convinced of that but as long as 
> any error is much smaller than the drift it's probably worth doing.

On a real SMP, this adjusting of timestamps probably helps (dunno, no
have), on my box it's doomed to do more harm than good.  To me, the only
thing that really matters is ignoring the bogus transition.

	-Mike

