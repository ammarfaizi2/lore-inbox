Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317344AbSGDG4Z>; Thu, 4 Jul 2002 02:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSGDG4Y>; Thu, 4 Jul 2002 02:56:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:25021 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317344AbSGDG4X>;
	Thu, 4 Jul 2002 02:56:23 -0400
Date: Thu, 4 Jul 2002 08:56:01 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rob Landley <landley@trommello.org>, Tom Rini <trini@kernel.crashing.org>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <Pine.LNX.3.96.1020703232322.2248C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0207040846340.3309-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Jul 2002, Bill Davidsen wrote:

> > it might be a candidate for inclusion once it has _proven_ stability and
> > robustness (in terms of tester and developer exposion), on the same order
> > of magnitude as the 2.4 kernel - but that needs time and exposure in trees
> > like the -ac tree and vendor trees. It might not happen at all, during the
> > lifetime of 2.4.
> 
> It has already proven to be stable and robust in the sense that it isn't
> worse than the stock scheduler on typical loads and is vastly better on
> some.

this is your experience, and i'm happy about that. Whether it's the same
experience for 90% of Linux users, time will tell.

> > Note that the O(1) scheduler isnt a security or stability fix, neither is
> > it a driver backport. It isnt a feature backport that enables hardware
> > that couldnt be used in 2.4 before. The VM was a special case because most
> > people agreed that it truly sucked, and even though people keep
> > disagreeing about that decision, the VM is in a pretty good shape now -
> > and we still have good correlation between the VM in 2.5, and the VM in
> > 2.4. The 2.4 scheduler on the other hand doesnt suck for 99% of the
> > people, so our hands are not forced in any way - we have the choice of a
> > 'proven-rock-solid good scheduler' vs. an 'even better, but still young
> > scheduler'.
> 
> Here I disagree. Sure behaves like a stability fix to me. On a system
> with a mix of interractive and cpu-bound processes, including processes
> with hundreds of threads, you just can't get reasonable performance
> balancing with nice() because it is totally impractical to keep tuning a
> thread which changes from hog to disk io to socket waits with a human in
> the loop. The new scheduler notices this stuff and makes it work, I
> don't even know for sure (as in tried it) if you can have different nice
> on threads of the same process.

(yes, it's possible to nice() individual threads.)

> This is not some neat feature to buy a few percent better this or that,
> this is roughly 50% more users on the server before it falls over, and
> no total bogs when many threads change to hog mode at once.

are these hard numbers? I havent seen much hard data yet from real-life
servers using the O(1) scheduler. There was lots of feedback from
desktop-class systems that behave better, but servers used to be pretty
good with the previous scheduler as well.

> You will not hear me saying this about preempt, or low-latency, and I
> bet that after I try lock-break this weekend I won't fell that I have to
> have that either. The O(1) scheduler is self defense against badly
> behaved processes, and the reason it should go in mainline is so it
> won't depend on someone finding the time to backport the fun stuff from
> 2.5 as a patch every time.

well, the O(1) scheduler indeed tries to put up as much defense against
'badly behaved' processes as possible. In fact you should try to start up
your admin shells via nice -20, that gives much more priority than it used
to under the previous scheduler - it's very close to the RT priorities,
but without the risks. This works in the other direction as well: nice +19
has a much stronger meaning (in terms of preemption and timeslice
distribution) than it used to.

	Ingo

