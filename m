Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVEaMKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVEaMKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 08:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVEaMKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 08:10:15 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:40593 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261879AbVEaMJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 08:09:59 -0400
Date: Tue, 31 May 2005 14:09:09 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <429C4112.2010808@andrew.cmu.edu>
Message-Id: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005, James Bruce wrote:

> Nick Piggin wrote:
> > I have never been in any doubt as to the specific claims I have
> > made. I continually have been talking about hard realtime from
> > start to finish, and it appears that everyone now agrees with me
> > that for hard-RT, a nanokernel solution is better or at least
> > not obviously worse at this stage.
> 
> It is only better in that if you need provable hard-RT *right now*, then 
> you have to use a nanokernel.  

What do you mean by "provable"? Security critical? Forget about
nanokernels then. The WHOLE system has to be validated. If you want to a
system good enough to put (a lot of) money on it: Test, test, test.

I can't see it would be easier prove that a nano-kernel with various
needed mutex and queuing mechanism works correct than it is to prove that
the Linux scheduler with mutex and queueing mechanisms works correctly.
Both systems does the same thing and is most likely based on the same
principles!
If a module in Linux disables interrupts for a non-deterministic amount
of time, it destroys the RT in both scenarious. With the nanokernel, 
the Linux kernel is patched not to disable interrupts, but if someone
didn't use the official local_irq_disable() macro the patch didn't work
anyway...
The only way you can be absolutely sure Linux doesn't hurt RT is to run
it in a full blown virtuel machine where it doesn't have access to disable
interrupts and otherwise interfere with the nano-kernel.

> The RT patch doesn't provide guaranteed 
> hard-RT yet[1], but it may in the future.  Any RT application programmer 
> would rather write for a single image system than a split kernel.  So if 
> it does eventually provide hard-RT, just about every new RT application 
> will target it (due to it being easier to program for).  In addition it 
> radically improves soft-RT performance *now*, which a nanokernel doesn't 
> help with at all.  "Best" would be getting preempt-RT to become 
> guaranteed hard-RT, or if that proves impossible, to have a nanokernel 
> in addition to preempt-RT's good statistical soft-RT guarantees.

I think it is nearly there. A few things needs to be revisited and a lot
of code paths you would have liked to use isn't RT (ioctl forinstance
still hits BKL :-( ).

> 
> I think where we violently disagree is that in your earlier posts you 
> seemed to imply that a nanokernel hard-RT solution obviates the need for 
> something like preempt-RT.  That is not the case at all, and at the 
> moment they are quite orthogonal.  In the future they may not be 
> orthogonal, because *if* preempt-RT patch becomes guaranteed hard-RT, it 
> would pretty much relegate nanokernels to only those applications 
> requiring formal verification.

And I state that for those applications the nanokernel isn't good enough,
either. Otherwise I completely agree with you. 
The nanokernel does have one thing PREEMPT_RT doesn't: Very short
latencies. To cap the interrupt latencies in Linux even further some
tricks will have to be made - and these would hurt performance. These
tricks are more or less what a nanokernel does: Running the whole of
Linux, including the scheduler, and all regions protected with raw
spinlocks with interrupts fully enabled.

Esben

> 
>   - Jim Bruce
> 

