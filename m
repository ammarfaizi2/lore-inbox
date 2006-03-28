Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWC1WvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWC1WvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWC1WvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:51:20 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:4821 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S964774AbWC1WvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:51:19 -0500
Date: Tue, 28 Mar 2006 23:51:12 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: PI patch against 2.6.16-rt9
In-Reply-To: <20060328212448.GA7120@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603282324030.22822-100000@lifa02.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <simlo@phys.au.dk> wrote:
>
> > > in short: wow do you ensure that the boosting is still part of the same
> > > dependency chain where it started off?
> >
> > I don't insure that. But does it matter?!?
>
> yes.

How does it matter?

>
> > If the task is still blocked on a lock and the owner of that lock
> > might need boosting. The boosting operation itself will always be
> > _correct_ as the pi_lock is held when it is done. But the task doing
> > the boosting might have preempted for so long that there is nothing
> > left to do - and then it simply stops unless deadlock detection is on.
>
> well, another possibility is that the task got blocked again, and we'll
> continue boosting _the wrong chain_. I.e. we'll add extra priority to
> task(s) that might not deserve it at all (it doesnt own the lock we are
> interested in anymore).
>

This can't happen. We are always looking at the first waiter on
task->pi_waiter task->pi_lock held when doing the boosting. If task
has released the lock the entry task->pi_waiter is gone and no boosting
will take place!

> i.e. we must observe the boosting chain in a time-coherent form. We must
> observe an actual "frozen" (all locks held) state of the system that we
> _know_ forms a correct dependency chain at that moment, to be able to
> propagate the priority one step forward. The act of 'boosting' must be
> atomic.
>
The i.e. refers to wrong conclusion and therefore the above can't be
concluded.

Esben

> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

