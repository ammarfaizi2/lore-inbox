Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbVKAWXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVKAWXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVKAWXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:23:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:47023 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751342AbVKAWXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:23:20 -0500
Subject: [RFC][PATCH 0/12] Generic Timeofday Subsystem (v B9)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:23:14 -0800
Message-Id: <1130883795.27168.457.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The following patchset applies against 2.6.14-rc5-mm1 (with a bit of
offset/fuzz) and provides a generic timekeeping subsystem that is
independent of the timer interrupt. The allows for robust and correct
behavior in cases of late or lost ticks, avoids interpolation errors,
and allows or assists future changes such as high-res timers, dynamic
ticks, and real-time preemption. Additionally, since timekeeping is done
with nanosecond granularity, it provides finer nanosecond resolution
values to the clock_gettime and related functions.

The patch set consists of the minimal NTP changes, the clocksource
abstraction, the core timekeeping code as well as the code to convert
the i386 and x86-64 archs. I have started on converting other arches,
but for now I'm focusing on i386 and x86-64.

Thomas Gleixner has been *very* helpful in reviewing and suggesting
changes to the code, so many thanks to him for his help!

New in this release:
o CONFIG option name change
o Added is_continuous flag to clocksource structure
o Moved to a switchless clocksource_read() function
o Reworked the vsyscall implementation to handle new read code
o Rebased ontop of Thomas' ktimer work already in -mm
o Transitioned to using primarily ktime_t units instead of nsec_t
o Moved TSC and HPET clocksource implementations to be closer to related
arch code
o Many comment and minor code cleanups

Still on the TODO list:
o Further minor coding style cleanups (let me know if you see any!)
o Further x86-64 arch cleanups.
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

