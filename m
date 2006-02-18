Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWBRBFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWBRBFr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWBRBFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:05:46 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:18656 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751814AbWBRBFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:05:25 -0500
Subject: [PATCHSET] Time: Generic Timeofday Subsystem (v B19)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: george@wildturkeyranch.net, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 17:05:19 -0800
Message-Id: <1140224720.2401.7.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	First, my apologies, I've been out of it with a cold this week, so this
release i isn't quite where I'd like it to be. However, I wanted  to get
this out so the new changes can be reviewed. With this release I've
diverged a bit from the patches in -mm, but I plan to send the changes
to Andrew and sync back up next week. The biggest change is the
experimental ntp-error-fix patch which implements a suggestion from
Roman for more precise NTP error accounting.

This patchset provides a generic timekeeping subsystem that is
independent of the timer interrupt. This allows for robust and correct
behavior in cases of late or lost ticks, avoids interpolation errors,
reduces duplication in arch specific code, and allows or assists future
changes such as high-res timers, dynamic ticks, or realtime preemption.
Additionally, it provides finer nanosecond resolution values to the
clock_gettime functions.

The patch set provides the minimal NTP changes, the clocksource
abstraction, the core timekeeping code as well as the code to convert
i386. It also includes patches that convert powerpc and x86-64, but for
now I'm only focusing on getting the i386 bits merged.

Changes since the B18 release:
o New experimental ntp-error-accounting patch (suggested by Roman)
o Merged Adrian Bunk's small fixes
o Dropped nsec_t typedef (as suggested by Roman)
o Dropped the pmtmr cleanups (avoids conflicting w/ x86-64)
o Synced w/ changes from -mm

Outstanding issues:
o No reported problem from testing in -mm

Still on my TODO list:
o Sync back to -mm
o Possible rebasing ontop of Roman's NTP changes
o More cleanups for the NTP error accounting patch
o Add clocksource.resolution info for hrtimer
o Squish any bugs that pop up from testing
o Clean and split up x86-64 and powerpc patches
o ppc, s390, arm, ia64, alpha, sparc, sparc64, etc work

The patchset applies against the current 2.6.16-rc4-git.

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


