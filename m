Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSKSBVF>; Mon, 18 Nov 2002 20:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbSKSBVF>; Mon, 18 Nov 2002 20:21:05 -0500
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.234.83]:16004 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S264945AbSKSBVE>;
	Mon, 18 Nov 2002 20:21:04 -0500
Date: Mon, 18 Nov 2002 20:27:32 -0500
Message-Id: <200211190127.gAJ1RWg11023@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net,
       ltp-list@lists.sourceforge.net, jim.houston@ccur.com,
       plars@linuxtestproject.org
Subject: Re: LTP - gettimeofday02 FAIL
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

I just tried gettimeofday02 on an old pentium-pro dual processor, and yes
the time goes backwards with a 2.5.48 kernel.

I believe that this is the result of lost ticks.  It has gotten much
easier to lose a tick since HZ was changed to 1000.  When the timer
interrupt is delayed, the other processors will continue to keep reasonable
time (based on the TSC), but when the timer interrupt eventually happens,
it will add one tick's worth of nanoseconds to xtime.tv_nsec and set
last_tsc_low to the current tsc value.  The other processors now base
their time on this new last_tsc_low and  will see time go backwards.
I accidentally configured in the ACPI power management code and was
disappointed to find that it routinely caused a 9 milli-second interrupt
lock-out (on my 1GHz Athlon).  With the old 100 Hz clock, this delay would
be detected by reading the PIT timer.  With 1000 Hz, the timer would  reload
several times and all we see is a fraction of a tick.

I'm interested in this because I'm working on my "alternative Posix timers
patch".  It gets confused when time backs up.

Jim Houston - Concurrent Computer Corp.
