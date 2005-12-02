Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVLBDZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVLBDZz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 22:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVLBDZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 22:25:55 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:51369 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964823AbVLBDZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 22:25:55 -0500
Date: Thu, 1 Dec 2005 20:25:52 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051202032551.19357.51421.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The following patchset applies against 2.6.15-rc3-mm1 and provides a
generic timekeeping subsystem that is independent of the timer
interrupt. This allows for robust and correct behavior in cases of late
or lost ticks, avoids interpolation errors, reduces duplication in arch
specific code, and allows or assists future changes such as high-res
timers, dynamic ticks, or realtime preemption. Additionally, it provides
finer nanosecond resolution values to the clock_gettime functions.

The patch set provides the minimal NTP changes, the clocksource
abstraction, the core timekeeping code as well as the code to convert
the i386 and x86-64 archs. I have started on converting more arches, but
for now I'm focusing on i386 and x86-64.

New in this release: 
o Merged Ingo's whitespace/style fixups (*Many* thanks for this help!)
o Addressed Ingo's TODO items.
o Merged cpufreq SMP fix
o Dropped tsc-interp clocksource (wasn't being used)
o Improved NUMAQ bits

Still on the TODO list:
o Submit to -mm

I'd like to thank the following people who have contributed ideas,
criticism, testing and code that has helped shape this work: 

	George Anzinger, Nish Aravamudan, Max Asbock, Dominik Brodowski, Thomas
Gleixner, Darren Hart, Christoph Lameter, Matt Mackal, Keith Mannthey,
Ingo Molnar, Martin Schwidefsky, Frank Sorenson, Ulrich Windl, Darrick
Wong, Roman Zippel and any others whom I've accidentally forgotten.

thanks 
-john
