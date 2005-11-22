Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVKVBfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVKVBfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVKVBfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:35:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:23705 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964826AbVKVBfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:35:23 -0500
Date: Mon, 21 Nov 2005 18:35:16 -0700
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
Message-Id: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The following patchset applies against 2.6.15-rc1-mm2 and provides a
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
o Proper sysfs entries (available_clocksources, current_clocksource)
o disable pit clocksource on large smp (it doesn't scale)
o dropped cyclone calibration
o added extra paraniod checks
o NUMAQ should not use TSC
o AMD SMP tsc fallback (similar to x86-64's logic)

Still on the TODO list:
o Fix Frank Sorenson's c3tsc overcompensation problem
o More testing 
o Submit to -mm (as soon as the c3tsc issue is resolved)

I'd like to thank the following people who have contributed ideas,
criticism, testing and code that has helped shape this work: 

	George Anzinger, Nish Aravamudan, Max Asbock, Dominik Brodowski, Thomas
Gleixner, Darren Hart, Christoph Lameter, Matt Mackal, Keith Mannthey,
Ingo Molnar, Martin Schwidefsky, Frank Sorenson, Ulrich Windl, Darrick
Wong, Roman Zippel and any others whom I've accidentally forgotten.

I'll be out of town for the next couple of days on holiday, so forgive
me if I don't respond until after Friday. However, do please let me know 
if you have any comments or feedback and I'll address them as soon as I 
get back.

thanks 
-john
