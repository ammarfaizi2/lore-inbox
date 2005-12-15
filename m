Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVLOCAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVLOCAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVLOCAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:00:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:21385 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751261AbVLOCAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:00:07 -0500
Date: Wed, 14 Dec 2005 19:00:03 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, nikita@clusterfs.com,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051215020002.25589.55922.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B14)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The following patchset applies against 2.6.15-rc5-git + the 
hrtimer patch-set and provides a generic timekeeping subsystem that 
is independent of the timer interrupt. This allows for robust and 
correct behavior in cases of late or lost ticks, avoids interpolation 
errors, reduces duplication in arch specific code, and allows or assists 
future changes such as high-res timers, dynamic ticks, or realtime 
preemption. Additionally, it provides finer nanosecond resolution values 
to the clock_gettime functions.

The patch set provides the minimal NTP changes, the clocksource 
abstraction, the core timekeeping code as well as the code to convert 
the i386 and x86-64 archs. I have started on converting more arches, 
but for now I'm focusing on i386 and x86-64.

The current patchset can be found here:
	http://sr71.net/~jstultz/tod/

New in this release: 
x clock_was_set
x x86-64 vsyscall fix suggested by Serge Belyshev.
x dropped c3tsc for ACPI PM
x dropped ACPI PM rate verification (causing false positives)

Still on the TODO list:
o nothing?

I'd like to thank the following people who have contributed ideas, 
criticism, testing and code that has helped shape this work: 

	George Anzinger, Nish Aravamudan, Max Asbock, Serge Belyshev,
Dominik Brodowski, Thomas Gleixner, Darren Hart, Christoph Lameter, 
Matt Mackal, Keith Mannthey, Ingo Molnar, Martin Schwidefsky, Frank
Sorenson, Ulrich Windl, Jonathan Woithe, Darrick Wong, Roman Zippel 
and any others whom I've accidentally left off this list.

thanks 
-john
