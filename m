Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288733AbSANEhl>; Sun, 13 Jan 2002 23:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288742AbSANEhc>; Sun, 13 Jan 2002 23:37:32 -0500
Received: from [202.135.142.194] ([202.135.142.194]:65035 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288733AbSANEhV>; Sun, 13 Jan 2002 23:37:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: cross-cpu balancing with the new scheduler 
In-Reply-To: Your message of "Sun, 13 Jan 2002 18:49:16 -0800."
             <Pine.LNX.4.40.0201131842570.937-100000@blue1.dev.mcafeelabs.com> 
Date: Mon, 14 Jan 2002 15:37:27 +1100
Message-Id: <E16PysB-0006zU-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.40.0201131842570.937-100000@blue1.dev.mcafeelabs.com> yo
u write:
> On Mon, 14 Jan 2002, Rusty Russell wrote:
> 
> > This could be fixed by making "nr_running" closer to a "priority sum".
> 
> I've a very simple phrase when QA is bugging me with these corner cases :
> 
> "As Designed"

My point is: it's just a heuristic number.  It currently reflects the
number on the runqueue, but there's no reason it *has to* (except the
name, of course).

1) The nr_running() function can use rq->active->nr_active +
   rq->expired->nr_active.  And anyway it's only as "am I
   idle?".

2) The test inside schedule() can be replaced by checking the result
   of the sched_find_first_zero_bit() (I have a patch which does this
   to good effect, but for other reasons).

The other uses of nr_running are all "how long is this runqueue for
rebalancing", and Ingo *already* modifies his use of this number,
using the "prev_nr_running" hack.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
