Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751863AbWCRAj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWCRAj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWCRAj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:39:59 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:15779 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751863AbWCRAj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:39:58 -0500
Date: Fri, 17 Mar 2006 17:39:56 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>, george@wildturkeyranch.net,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>
Message-Id: <20060318003955.32251.80532.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCHSET 0/10] Time: Generic Timekeeping (v.C0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	So after after the last round of feedback on this series, I've 
gone back to the drawing board and have tried to further cut the patch 
set down to the bare minimum.
	
I've realized that much of the trouble getting this into mainline have 
come from my falling into the well known "here's a new subsystem that 
duplicates the old one, but is better and cleaner and fixes bugs" trap. 
Thus now I'm trying the time-tested "fix what is there with small 
patches" method (which I would have used from the start, but I didn't 
think I could make such drastic changes without breaking everyone 
first).

The majority of this new incremental design should be credited to Roman 
Zippel, but it is my implementation, so he gets the credit and I get 
the blame. :)

This is the rough first cut, so it will probably need a few extra 
passes to be cleaned up and ready for mainline. And while there should 
not be any behaviour changes, since this method also affects all arches 
from the start, extra testing will be needed to make sure it has been 
done correctly. Also more work is needed before this can be 
re-integrated w/ the -RT tree, as timekeeping is still done from 
interrupt context.


Summary:
	This patchset provides a generic timekeeping interfaces that 
are independent of the timer interrupt. This allows for robust and 
correct behavior in cases of late or lost ticks, avoids interpolation 
errors, reduces duplication in arch specific code, and allows or 
assists future changes such as high-res timers, dynamic ticks, or 
realtime preemption. Additionally, it provides finer nanosecond 
resolution values to the clock_gettime functions.


Changes since the B20 release:
o Threw out old NTP changes
o Threw out all code cleanups
o New minimal core implementation for all arches
o Added sysfs clocksource fix
o Added slow TSC detection

On my TODO list:
o Get x86-64 and powerpc patches back up and running
o Try to restore cleanups via small patches

The patchset applies against the current 2.6.16-rc6-git.

The complete patchset can be found here:
	http://sr71.net/~jstultz/tod/

I'd like to thank the following people who have contributed ideas, 
criticism, testing and code that has helped shape this work: 
	George Anzinger, Nish Aravamudan, Max Asbock, Serge Belyshev, 
Dominik Brodowski, Adrian Bunk, Thomas Gleixner, Darren Hart, Christoph 
Lameter, Matt Mackal, Keith Mannthey, Ingo Molnar, Andrew Morton, Paul 
Munt, Martin Schwidefsky, Frank Sorenson, Ulrich Windl, Jonathan 
Woithe, Darrick Wong, Roman Zippel and any others whom I've 
accidentally left off this list.

thanks
-john
