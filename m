Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268153AbTCFROh>; Thu, 6 Mar 2003 12:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268156AbTCFROh>; Thu, 6 Mar 2003 12:14:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18608 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268153AbTCFROe>;
	Thu, 6 Mar 2003 12:14:34 -0500
Date: Thu, 6 Mar 2003 18:24:51 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303060858120.7206-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303061819160.14218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another thing. What really happens in the 'recompile job' thing is not
that X gets non-interactive. Most of the time it _is_ interactive. The
problem is that the gcc processes and make processes themselves, which do
use up a considerable portion of CPU time (generate a load of 4-5 with
make -j2), get rated as interactive as well. Shells, gnome-terminal, X
itself will be often preempted by these gcc and make processes. Making X
more interactive does not help in this case.

so my patchset attempts to tune things in the direction of making the
scheduler recognize the compile job as truly CPU-bound. It was a bad
interaction of child-inherits-priority plus child-wakeup priorities.

My suggestion to increase X's priority was just an unrelated suggestion -
if Andrew is dragging windows around then X does get 100% CPU-bound, and
the only good way to get out of that situation is to tell the system that
it's rightfully monopolizing the CPU, and that the user has no problem
with that.

I also had feedback from people who reniced X in the _other_ direction,
because they did not want their rare administration work done under X
impact the generic performance of the server.

	Ingo

