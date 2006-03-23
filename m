Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWCWDF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWCWDF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWCWDF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:05:59 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:23212 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932117AbWCWDF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:05:58 -0500
Date: Wed, 22 Mar 2006 20:05:47 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       george@wildturkeyranch.net, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mackerras <paulus@samba.org>
Message-Id: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCHSET 0/10] Time: Generic Timekeeping (v.C1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	Here is an updated version of the smaller, reworked and 
improved patchset I mailed out monday. Please consider for inclusion 
into your tree.

Again, the majority of this new incremental design should be credited 
to Roman Zippel, but it is my implementation, so he gets the credit and 
I get the blame. :)

Summary:
	This patchset provides a generic timekeeping infrastructure 
that are independent of the timer interrupt. This allows for robust and 
correct behavior in cases of late or lost ticks, avoids interpolation 
errors, reduces duplication in arch specific code, and allows or 
assists future changes such as high-res timers, dynamic ticks, or 
realtime preemption. Additionally, it provides finer nanosecond 
resolution values to the clock_gettime functions. The patchset also 
converts the i386 arch to use this new infrastructure.

Changes since the C0 release:
o Cut out functions that are no longer used
o Re-arranged patch chunks so each patch makes more sense.
o Few small fixes.
o Improved comments.

On my TODO list:
o More attention on x86-64 and powerpc
o Re-add bits needed for inclusion into HRT and RT
o Try to restore cleanups via small patches

The patchset applies against the current 2.6.16-git.

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
