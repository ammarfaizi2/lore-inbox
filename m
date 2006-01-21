Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWAUAAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWAUAAa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWAUAAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:00:30 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:22697 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750747AbWAUAA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:00:29 -0500
Subject: [PATCHSET] Time: Generic Timeofday Subsystem (v B17)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       George Anzinger <george@mvista.com>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 16:00:26 -0800
Message-Id: <1137801626.27699.279.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Yes, B17 already. I didn't bother to announce the B16 release, since it
was just a sync w/ the patches included into -mm. This announcement is
mainly for upstream users of my patch (-kthrt and -rt trees), or anyone
who wants to play with the patches outside of -mm. Anyway here it is:

	This patchset provides a generic timekeeping subsystem that is
independent of the timer interrupt. This allows for robust and correct
behavior in cases of late or lost ticks, avoids interpolation errors,
reduces duplication in arch specific code, and allows or assists future
changes such as high-res timers, dynamic ticks, or realtime preemption.
Additionally, it provides finer nanosecond resolution values to the
clock_gettime functions.

	The patch set provides the minimal NTP changes, the clocksource
abstraction, the core timekeeping code as well as the code to convert
i386. I have started on converting more arches, but for now I'm focusing
on code for i386 and x86-64.

Changes since the B16 release:
o Avoids clocksource churn
o Blacklist silent cpufreq changing thinkpad
o Sync up w/ patches in 2.6.16-rc1-mm2

Outstanding issues:
o TSC cpufreq caused stalls at bootup (working on this one)

Still on my TODO list:
o Squish any bugs that pop up from testing in -mm and -rt
o Finer grained ntp adjustment accounting (Suggested by Roman)
o A few spots could use some optimization (Again, suggested by Roman)
o Clean and split up x86-64 patch
o powerpc/ppc, s390, arm, ia64, alpha, sparc, sparc64 work


The patchset applies against the current 2.6.16-rc1-git.

The complete patchset can be found here:
	http://sr71.net/~jstultz/tod/


I'd like to thank the following people who have contributed ideas,
criticism, testing and code that has helped shape this work: 
	George Anzinger, Nish Aravamudan, Max Asbock, Serge Belyshev, Dominik
Brodowski, Thomas Gleixner, Darren Hart, Christoph Lameter, Matt Mackal,
Keith Mannthey, Ingo Molnar, Martin Schwidefsky, Frank Sorenson, Ulrich
Windl, Jonathan Woithe, Darrick Wong, Roman Zippel and any others whom
I've accidentally left off this list.

As always, feedback, suggestions and bug-reports are always appreciated.

thanks 
-john


