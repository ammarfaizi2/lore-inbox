Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268131AbTCFRdw>; Thu, 6 Mar 2003 12:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbTCFRdw>; Thu, 6 Mar 2003 12:33:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64519 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268131AbTCFRdv>; Thu, 6 Mar 2003 12:33:51 -0500
Date: Thu, 6 Mar 2003 09:42:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303061819160.14218-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303060936301.7206-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Ingo Molnar wrote:
> 
> another thing. What really happens in the 'recompile job' thing is not
> that X gets non-interactive. Most of the time it _is_ interactive.

This is not what I've seen.

When X is interactive, and is competing against other interactive jobs, 
you don't get multi-second slowdowns. X still gets 10% of the CPU, it just 
gets it in smaller chunks.

The multi-second "freezes" are the thing that bothered me, and those were
definitely due to the fact that X was competing as a _non_interactive
member against other non-interactive members, causing it to still get 10%
of the CPU, but only every few seconds. So you'd get a very bursty
behaviour with very visible pauses.

It's ok to slow X down. Nobody in their right mind would expect X to track 
the mouse 100% when scrolling and the machine load is 15+. I certainly 
don't.

But having X just _pause_ for several seconds gets to me. I can't easily 
make it happen any more thanks to having ridiculous hardware, and I think 
X itself has gotten better thanks to more optimizations in both clients 
and X itself (ie if the CPU requirements of X go down from 5% to 3%, it 
gets a _lot_ harder to trigger).

But it was definitely there. 3-5 second _pauses_. Not slowdowns.

		Linus

