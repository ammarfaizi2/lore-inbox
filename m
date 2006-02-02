Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422682AbWBBBYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422682AbWBBBYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWBBBYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:24:54 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:35514 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422682AbWBBBYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:24:54 -0500
Subject: [PATCHSET] Time: Generic Timeofday Subsystem (v B18)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 17:24:49 -0800
Message-Id: <1138843489.10057.104.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Just a release to get a few fixes out the door for upstream users and
to allow people to play w/ the new powerpc work.

This patchset provides a generic timekeeping subsystem that is
independent of the timer interrupt. This allows for robust and correct
behavior in cases of late or lost ticks, avoids interpolation errors,
reduces duplication in arch specific code, and allows or assists future
changes such as high-res timers, dynamic ticks, or realtime preemption.
Additionally, it provides finer nanosecond resolution values to the
clock_gettime functions.

The patch set provides the minimal NTP changes, the clocksource
abstraction, the core timekeeping code as well as the code to convert
i386. I have started on converting more arches, but for now I'm only
submitting code for i386.

Changes since the B17 release:
o Documentation and register_clocksource fixes from Paul Munt
o clock=pmtmr boot option backwards compatibility
o prints clocksource name on inconsistency
o Disable TSC on C2 (fix for akpm's laptop)
o clocksource_lock fixes (suggested by akpm and mingo)
o Comment improvements
o First pass at converting powerpc (compiles but *not* boot tested!)

Outstanding issues:
o Mattia's TSC cpufreq caused stalls at bootup (still working on this
one)

Still on my TODO list:
o Work to get back into -mm
o Squish any bugs that pop up from testing
o Finer grained ntp adjustment accounting (Suggested by Roman)
o A few spots could use some optimization (Again, suggested by Roman)
o Clean and split up x86-64 and powerpc patches
o ppc, s390, arm, ia64, alpha, sparc, sparc64 work

The patchset applies against the current 2.6.16-rc1-git.

The complete patchset can be found here:
	http://sr71.net/~jstultz/tod/

I'd like to thank the following people who have contributed ideas, 
criticism, testing and code that has helped shape this work: 
	George Anzinger, Nish Aravamudan, Max Asbock, Serge Belyshev,
Dominik Brodowski, Thomas Gleixner, Darren Hart, Christoph Lameter, 
Matt Mackal, Keith Mannthey, Ingo Molnar, Andrew Morton, Paul Munt, 
Martin Schwidefsky, Frank Sorenson, Ulrich Windl, Jonathan Woithe, 
Darrick Wong, Roman Zippel and any others whom I've accidentally left 
off this list.

thanks 
-john


