Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268246AbTCFRwH>; Thu, 6 Mar 2003 12:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268245AbTCFRwH>; Thu, 6 Mar 2003 12:52:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48905 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268039AbTCFRwF>; Thu, 6 Mar 2003 12:52:05 -0500
Date: Thu, 6 Mar 2003 10:00:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303061841480.15041-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303060956190.7720-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Ingo Molnar wrote:
> 
> > And my patch may spread it out _too_ much. Maybe we shouldn't give _all_
> > of the left-over interactivity to the waker. Maybe we should give just
> > half of it away..
> 
> yes, not spreading out could also make it possible to give it back via
> multiple wakeup links, interactivity will 'diffuse' along wakeups.

Yes, I think this could work well. What we could do is basically just
always spread the interactivity eavenly between the waker and the sleeper,
instead of my current "give the sleeper as much as we can, and if
anything is left over give some to the waker" approach.

So my current patch is extreme in that it tries to use up as much as 
possible of the "interactivity bonus points", but it is _not_ extreme in 
the sense that it doesn't inherit interactivity both ways. 

So my patch will _not_ try to balance a series of three or more processes, 
where only one is interactive. Because it will trigger only for the 
process _directly_ connected to the interactive one.

If we spread it out instead by always trying to balance the interactivity, 
it would spread out from the interactive one along any synchronous wakeup 
chain. Which is more extreme than I was willing to try with a first 
example..

		Linus

