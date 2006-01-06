Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWAFCNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWAFCNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWAFCNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:13:33 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:21465 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932533AbWAFCNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:13:33 -0500
Date: Thu, 5 Jan 2006 19:13:29 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>
Message-Id: <20060106021328.6714.45831.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 0/10] Time: Generic Timeofday Subsystem (v B15-mm)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,

	This patchset  provides a generic timekeeping subsystem that is 
independent of the timer interrupt. This allows for robust and correct
behavior in cases of late or lost ticks, avoids interpolation errors, 
reduces duplication in arch specific code, and allows or assists future
changes such as high-res timers, dynamic ticks, or realtime preemption.
Additionally, it provides finer nanosecond resolution values to the
clock_gettime functions.

The patch set provides the minimal NTP changes, the clocksource 
abstraction, the core timekeeping code as well as the code to convert 
i386. I have started on converting more arches, but for now I'm only 
submmiting code for i386.

As requested, I've reworked this patchset so it builds and boots every step 
of the way, resulting in one less patch in the patchset. This was done 
somewhat quickly and tested with my slow laptop, so it may be config 
dependent, but I think it should be ok. I've also tried to improve the 
patch descriptions as requested, but please let me know if they need 
more work.

Changes since the last release:
o Builds each step in the patchset
o Improved patch descriptions
o Reduced use of inline (might need more of this)
o Simplified timespec_add_ns()
o Removed unncessary additions (timer_pit sysfs bits)

The patchset applies against the 2.6.15-rc5-git + the hrtimer patch-set 
already in -mm (same as the last release).

It should replace the following patches currently in -mm:

time-reduced-ntp-rework-part-1.patch
time-reduced-ntp-rework-part-2.patch
time-clocksource-infrastructure.patch
time-generic-timekeeping-infrastructure.patch
time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
time-i386-conversion-part-2-move-timer_tscc-to-tscc.patch
time-i386-conversion-part-3-rework-tsc-support.patch
time-i386-conversion-part-4-acpi-pm-variable-renaming-and-config-change.patch
time-i386-conversion-part-5-enable-generic-timekeeping.patch
time-i386-conversion-part-6-remove-old-code.patch
time-i386-clocksource-drivers.patch

Please note the slight re-ordering of the patches and that one patch has 
been removed from the set.

The complete patchset (including code for x86-64) can be found here:
	http://sr71.net/~jstultz/tod/

I'd like to thank the following people who have contributed ideas, 
criticism, testing and code that has helped shape this work: 
	George Anzinger, Nish Aravamudan, Max Asbock, Serge Belyshev,
Dominik Brodowski, Thomas Gleixner, Darren Hart, Christoph Lameter, 
Matt Mackal, Keith Mannthey, Ingo Molnar, Martin Schwidefsky, Frank
Sorenson, Ulrich Windl, Jonathan Woithe, Darrick Wong, Roman Zippel 
and any others whom I've accidentally left off this list.

Andrew, please consider for inclusion into your tree.

thanks 
-john
