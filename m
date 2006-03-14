Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751948AbWCNW2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbWCNW2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCNW2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:28:34 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:3983 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S1751944AbWCNW2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:28:34 -0500
Date: Tue, 14 Mar 2006 23:28:28 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
In-Reply-To: <20060314221111.GA7118@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603142322320.1291-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <simlo@phys.au.dk> wrote:
>
> > On Tue, 14 Mar 2006, Ingo Molnar wrote:
> >
> > >
> > > * Esben Nielsen <simlo@phys.au.dk> wrote:
> > >
> > > [...]
> > > no. We have to run deadlock detection to avoid things like circular lock
> > > dependencies causing an infinite schedule+wakeup 'storm' during priority
> > > boosting. (like possible with your wakeup based method i think)
> > No, all tasks would just settle on the highest priority and then the
> > wakeups would stop.
>
> you are right, that shouldnt be possible. But how about other, SMP
> artifacts? What if the woken up task runs on another CPU, and the whole
> chain of boosting is thus delayed?
>

Yes, it will take longer that way. But it still ought to be
_deterministic_. PI has never been a cheap. It is only safe guard against
priority inversion.

I am not saying using the scheduler is the best solution and certainly not
the cheapest solution. It just popped up in my head and it seemed to work
and was relatively easy to implement.

Esben


> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

