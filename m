Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbTAUGpa>; Tue, 21 Jan 2003 01:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbTAUGpa>; Tue, 21 Jan 2003 01:45:30 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:10744 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265589AbTAUGp2>;
	Tue, 21 Jan 2003 01:45:28 -0500
Message-ID: <3E2CEE91.7F2DFC83@mvista.com>
Date: Mon, 20 Jan 2003 22:54:09 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-14smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net
Subject: [PATCH NOTICE 2/3] High-res-timers part 2 (x86 platform code) take 25
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the platform part of the high-res timers for the
x86.

The 2.5.59 version of this patch is now available on
sourceforge (see signature).

Changes since last time:
Kconfig comment clean up by Randy Dunlap.  
Changes to the CPU frequency code in the hrtimer_tsc area.
John Stultz's  changes to make fast_gettimeoffset_quotient a
static are included.
Make file changes in arch/i386/kernel/time/Makefile
------------
Changes to the .../arch/i386/kernel/time/Makefile
Moved the disable_tsc var to time.c so it can be shared.
Picked up the do_timer.h changes in two addional sub archs.

CONFIG dependency added to not turn on stuff only needed
when CONFIG_HIGH_RES = y.
----------

This patch, in conjunction with the "core" high-res-timers
patch implements high resolution timers on the i386
platforms.  The high-res-timers use the periodic interrupt
to "remind" the system to look at the clock.  The clock
should be relatively high resolution (1 micro second or
better).  This patch allows configuring of three possible
clocks, the TSC, the ACPI pm timer, or the Programmable
interrupt timer (PIT).  Most of the changes in this patch
are in the arch/i386/kernel/timer/* code.

This patch uses (if available) the APIC timer(s) to generate
1/HZ ticks and sub 1/HZ ticks as needed.  The PIT still
interrupts, but if the APIC timer is available, just causes
the wall clock update.  No attempt is made to make this
interrupt happen on jiffie boundaries, however, the APIC
timers are disciplined to expire on 1/HZ boundaries to give
consistent timer latencies WRT to the system time.

With this patch applied and enabled (at config time in the
processor feature section), the system clock will be the
specified clock.  The PIT is not used to keep track of time,
but only to remind the system to look at the clock.  Sub
jiffies are kept and available for code that knows how to
use them.

Depends on the core high res timers patch.

This patch as well as the POSIX clocks & timers patch is
available on the project site:
http://sourceforge.net/projects/high-res-timers/

The 3 parts to the high res timers are:
 core           The core kernel (i.e. platform independent)
changes
*i386           The high-res changes for the i386 (x86)
platform
 hrposix        The changes to the POSIX clocks & timers
patch to
use high-res timers

Please apply.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
