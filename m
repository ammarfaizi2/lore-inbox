Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbTAUGno>; Tue, 21 Jan 2003 01:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbTAUGno>; Tue, 21 Jan 2003 01:43:44 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:51959 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265222AbTAUGnn>;
	Tue, 21 Jan 2003 01:43:43 -0500
Message-ID: <3E2CEE1B.EEC9F6B6@mvista.com>
Date: Mon, 20 Jan 2003 22:52:11 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-14smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net
Subject: [PATCH NOTICE] POSIX clocks & timers take 21 (NOT HIGH RES)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5.59 version of this patch is now available on
sourceforge (see signature).

Changes since last time:

---------------
Fixed a spin lock hand off problem in locking timers (thanks
to Randy).
Fixed nanosleep to test for out of bound nanoseconds
(thanks to Julie).
Fixed a couple of id deallocation bugs that left old ids
laying around (hay I get this one).
-----------
This version has a new timer id manager.  Andrew Morton
suggested elimination of recursion (done) and I added code
to allow it to release unused nodes.  The prior version only
released the leaf nodes.  (The id manager uses radix tree
type nodes.)  Also added is a reuse count so ids will not
repeat for at least 256 alloc/ free cycles.
-----------

The changes for the new sys_call restart now allow one
restart function to handle both nanosleep and
clock_nanosleep.  Saves a bit of code, nice.

All the requested changes and Lindent too :).

I also broke clock_nanosleep() apart much the same way
nanosleep() was with the 2.5.50-bk5 changes.  

This is still this way.  Should be easy to do the compat
stuff.

TIMER STORMS

The POSIX clocks and timers code prevents "timer storms" by
not putting repeating timers back in the timer list until
the signal is delivered for the prior expiry.  Timer events
missed by this delay are accounted for in the timer overrun
count.  The net result is MUCH lower system overhead while
presenting the same info to the user as would be the case if
an interrupt and timer processing were required for each
increment in the overrun count.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
