Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWCZVi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWCZVi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWCZVi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:38:27 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63198 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932136AbWCZVi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:38:26 -0500
Date: Sun, 26 Mar 2006 23:35:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: Are ALL_TASKS_PI on in 2.6.16-rt7?
Message-ID: <20060326213552.GA1963@elte.hu>
References: <20060326212738.GA32562@elte.hu> <Pine.LNX.4.44L0.0603262231110.8060-100000@lifa03.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603262231110.8060-100000@lifa03.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> On Sun, 26 Mar 2006, Ingo Molnar wrote:
> 
> >
> > * Esben Nielsen <simlo@phys.au.dk> wrote:
> >
> > > It just looks like also normal, non-rt tasks are boosting.
> >
> > correct. We'd like to make sure the PI code is correct - and for
> > PI-futex it makes sense anyway.
> >
> 
> It wont work 100% when a task is boosted to a normal, non-rt prio well
> since at scheduler_tick()
>  		p->prio = effective_prio(p);
> can be executed overwriting the boost.

yeah - but that's relatively rare, upon expiration of the timeslice.  
The following would probably solve it: scheduler_tick() could take the 
pi_lock (before taking the rq lock), update normal_prio, and then call 
into rt_mutex_getprio() [just like setscheduler does] to set the 
priority.

	Ingo
