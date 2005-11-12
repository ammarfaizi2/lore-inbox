Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVKLEsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVKLEsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVKLEsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:48:54 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:51893 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751326AbVKLEsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:48:53 -0500
Date: Fri, 11 Nov 2005 21:48:50 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Message-Id: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	I had hoped to submit this to -mm today, but since Ingo pointed
out an issue in the __delay code, I'm going to wait a week so the new fix
can be better tested.

	The following patchset applies against 2.6.14-mm2 (with some offsets 
and fuzz) and provides a generic timekeeping subsystem that is independent
of the timer interrupt. This allows for robust and correct behavior in
cases of late or lost ticks, avoids interpolation errors, reduces
duplication in arch specific code, and allows or assists future changes
such as high-res timers, dynamic ticks, or realtime preemption.
Additionally, it provides finer nanosecond resolution values to the
clock_gettime functions.

The patch set provides the minimal NTP changes, the clocksource
abstraction, the core timekeeping code as well as the code to convert
the i386 and x86-64 archs. I have started on converting more arches, but
for now I'm focusing on i386 and x86-64.

Thomas Gleixner has been quite helpful in deeply reviewing and
suggesting changes to the code, so many thanks to him for his help!

New in this release: 
o Use ktimer for periodic_hook 
o minor performance tweaks
o i386 __delay fix 
o docs and howtos in Documentation/timekeeping.txt

Still on the TODO list: 
o Get a weeks worth of testing 
o Submit to -mm (planned for the next release)

I'd like to thank the following people who have contributed ideas,
criticism, testing and code that has helped shape this work: 

George Anzinger, Nish Aravamudan, Max Asbock, Dominik Brodowski, Thomas
Gleixner, Darren Hart, Christoph Lameter, Matt Mackal, Keith Mannthey,
Ingo Molnar, Martin Schwidefsky, Frank Sorenson, Ulrich Windl, Darrick
Wong, Roman Zippel and any others whom I've accidentally forgotten.

Please let me know if you have any comments or feedback.

thanks 
-john
