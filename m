Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVLPBHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVLPBHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVLPBHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:07:05 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:3227 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751252AbVLPBHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:07:03 -0500
Date: Thu, 15 Dec 2005 18:07:00 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 0/11] Time: Generic Timeofday Subsystem (v B14-mm)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	So after a number of releases and empty threats of sending in 
this code to Andrew, there has still been mostly silence regarding any 
objections to these patches. Thus I figure its time to stir the pot and 
really submit these patches for inclusion to -mm (and maybe, just maybe, 
catch Andrew before he leaves for vacation :)

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

The following patchset applies against the current 2.6.15-rc5-git + the 
hrtimer patch-set already in -mm and applies against 2.6.15-rc5-mm3 with
only minor collisions in Makefiles.

The complete patchset (sent yesterdray including code for x86-64) can 
be found here:
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
