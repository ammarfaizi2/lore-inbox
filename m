Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWEJX6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWEJX6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWEJX6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:58:00 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:58754 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965097AbWEJX57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:57:59 -0400
Subject: [PATCHSET] Time: Generic Timekeeping Subsystem (v C2)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Tim Mann <mann@vmware.com>,
       Jim Cromie <jim.cromie@gmail.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 16:57:56 -0700
Message-Id: <1147305476.12500.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Here is an updated version of the smaller, reworked and improved
patchset, most of which is currently in -mm. 

Its been awhile since the last update, so there are lots of little fixes
and a few new patches that will probably need additional testing. Big
thanks to: Tim Mann, Jim Cromie, Roman Zippel, and OGAWA Hirofumi
(hopefully I didn't forget anyone) for submitting fixes and ideas for
improvements

Summary:
	This patchset provides a generic timekeeping infrastructure that can be
independent of the timer interrupt. This allows for robust and correct
behavior in cases of late or lost ticks, avoids interpolation errors,
reduces duplication in arch specific code, and assists future changes
such as high-res timers, dynamic ticks, or realtime preemption.
Additionally, it provides finer nanosecond resolution values to the
clock_gettime functions. The patchset also converts the i386, x86-64,
and powerpc arches to use this new infrastructure.

Changes since the C1 release:
o Fix for clock=pit bugs - Tim (needs testing)
o Avoid mults in ntp adjstument- Roman
o spelling fixes - Jim and Tim
o clocksourcemask macro - Jim
o pmtmr fixups and improvements- OGAWA
o functional x86-64 vsyscall gtod
o functional powerpc port
o ktime_t based accounting and accessors (needs testing)
o i386 xtime cleanups
o run timekeeping via a timer (needs more testing)

On my TODO list:
o Continue integrating Roman's ideas and suggestions
o Re-add any bits needed for -HRT and -RT trees
o More attention on x86-64 and powerpc
o Continue merging new bits into -mm
o Try to restore cleanups via small patches

The patchset applies against the current 2.6.17-rc3-git.

The complete patchset can be found here:
	http://sr71.net/~jstultz/tod/

I'd like to thank the following people who have contributed ideas,
criticism, testing and code that has helped shape this work: 
	George Anzinger, Nish Aravamudan, Max Asbock, Serge Belyshev, Dominik
Brodowski, Adrian Bunk, Jim Cromie, Thomas Gleixner, Darren Hart, OGAWA
Hirofumi, Christoph Lameter, Matt Mackal, Tim Mann, Keith Mannthey, Ingo
Molnar, Andrew Morton, Paul Munt, Martin Schwidefsky, Frank Sorenson,
Ulrich Windl, Jonathan Woithe, Darrick Wong, Roman Zippel and any others
whom I've accidentally left off this list.

thanks
-john


