Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbVLFEN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbVLFEN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbVLFEN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:13:57 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:7892 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751599AbVLFEN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:13:56 -0500
Date: Mon, 5 Dec 2005 21:13:49 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       <nikita@clusterfs.com>, Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Message-Id: <20051206041348.9843.85752.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B13)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Just a quick rebase ontop of Thomas' patches!

	The following patchset applies against 2.6.15-rc5 + the hrtimer patch-
set and provides a generic timekeeping subsystem that is independent of the 
timer interrupt. This allows for robust and correct behavior in cases 
of late or lost ticks, avoids interpolation errors, reduces duplication 
in arch specific code, and allows or assists future changes such as 
high-res timers, dynamic ticks, or realtime preemption. Additionally, 
it provides finer nanosecond resolution values to the clock_gettime 
functions.

The patch set provides the minimal NTP changes, the clocksource 
abstraction, the core timekeeping code as well as the code to convert 
the i386 and x86-64 archs. I have started on converting more arches, 
but for now I'm focusing on i386 and x86-64.

New in this release: 
o Wrapped documentation lines @80c
o Rebased ontop of Thomas' hrtimer patchset
	http://www.tglx.de/projects/ktimers/patches-2.6.15-rc5-hrtimer.tar.bz2
o Dropped back to using timer_lists since periodic_hook can be called late

Still on the TODO list:
o Resolve Jonathan Woithe's problem report

I'd like to thank the following people who have contributed ideas, 
criticism, testing and code that has helped shape this work: 

	George Anzinger, Nish Aravamudan, Max Asbock, Dominik 
Brodowski, Thomas Gleixner, Darren Hart, Christoph Lameter, Matt 
Mackal, Keith Mannthey, Ingo Molnar, Martin Schwidefsky, Frank 
Sorenson, Ulrich Windl, Darrick Wong, Roman Zippel and any others whom 
I've accidentally left off this list.

thanks 
-john
