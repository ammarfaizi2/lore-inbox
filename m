Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSGDDjg>; Wed, 3 Jul 2002 23:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317324AbSGDDjf>; Wed, 3 Jul 2002 23:39:35 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50448 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317306AbSGDDje>; Wed, 3 Jul 2002 23:39:34 -0400
Date: Wed, 3 Jul 2002 23:36:07 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Rob Landley <landley@trommello.org>, Tom Rini <trini@kernel.crashing.org>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <Pine.LNX.4.44.0207031006050.3017-100000@e2>
Message-ID: <Pine.LNX.3.96.1020703232322.2248C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> it might be a candidate for inclusion once it has _proven_ stability and
> robustness (in terms of tester and developer exposion), on the same order
> of magnitude as the 2.4 kernel - but that needs time and exposure in trees
> like the -ac tree and vendor trees. It might not happen at all, during the
> lifetime of 2.4.

It has already proven to be stable and robust in the sense that it isn't
worse than the stock scheduler on typical loads and is vastly better on
some.
> 
> Note that the O(1) scheduler isnt a security or stability fix, neither is
> it a driver backport. It isnt a feature backport that enables hardware
> that couldnt be used in 2.4 before. The VM was a special case because most
> people agreed that it truly sucked, and even though people keep
> disagreeing about that decision, the VM is in a pretty good shape now -
> and we still have good correlation between the VM in 2.5, and the VM in
> 2.4. The 2.4 scheduler on the other hand doesnt suck for 99% of the
> people, so our hands are not forced in any way - we have the choice of a
> 'proven-rock-solid good scheduler' vs. an 'even better, but still young
> scheduler'.

Here I disagree. Sure behaves like a stability fix to me. On a system with
a mix of interractive and cpu-bound processes, including processes with
hundreds of threads, you just can't get reasonable performance balancing
with nice() because it is totally impractical to keep tuning a thread
which changes from hog to disk io to socket waits with a human in the
loop. The new scheduler notices this stuff and makes it work, I don't even
know for sure (as in tried it) if you can have different nice on threads
of the same process. 

This is not some neat feature to buy a few percent better this or that,
this is roughly 50% more users on the server before it falls over, and no
total bogs when many threads change to hog mode at once.

You will not hear me saying this about preempt, or low-latency, and I bet
that after I try lock-break this weekend I won't fell that I have to have
that either. The O(1) scheduler is self defense against badly behaved
processes, and the reason it should go in mainline is so it won't depend
on someone finding the time to backport the fun stuff from 2.5 as a patch
every time.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

