Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTAUGsc>; Tue, 21 Jan 2003 01:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbTAUGsb>; Tue, 21 Jan 2003 01:48:31 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:64760 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265094AbTAUGsa>;
	Tue, 21 Jan 2003 01:48:30 -0500
Message-ID: <3E2CEF45.CB981617@mvista.com>
Date: Mon, 20 Jan 2003 22:57:09 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-14smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net
Subject: [PATCH NOTICE 3/3] High-res-timers part 3 (posix to hrposix) take 25
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And this finishes the high res timers code.

Now available for 2.5.59 on sourceforge (see signature).

Changes since last time:
-----------
-----------
I had to add arg3 to the restart_block to handle the two
word restart time...

This patch adds the two POSIX clocks CLOCK_REALTIME_HR and
CLOCK_MONOTONIC_HR to the posix clocks & timers package.  A
small change is made in sched.h and the rest of the patch is
against .../kernel/posix_timers.c and
.../include/linux/posix_timers.h


This patch takes advantage of the timer storm protection
features of the POSIX clock and timers patch.

This patch fixes the high resolution timer resolution at 1
micro second.  Should this number be a CONFIG option?

I think it would be a "good thing" to move the NTP stuff to
the jiffies clock.  This would allow the wall clock/ jiffies
clock difference to be a "fixed value" so that code that
needed this would not have to read two clocks.  Setting the
wall clock would then just be an adjustment to this "fixed
value".  It would also eliminate the problem of asking for a
wall clock offset and getting a jiffies clock offset.  This
issue is what causes the current 2.5.46 system to fail the
simple:

time sleep 60

test (any value less than 60 seconds violates the standard
in that it implies a timer expired early).

These patches as well as the POSIX clocks & timers patch are
available on the project site:
http://sourceforge.net/projects/high-res-timers/

The 3 parts to the high res timers are:
 core      The core kernel (i.e. platform independent)
 i386      The high-res changes for the i386 (x86) platform
*hrposix   The changes to the POSIX clocks & timers patch to
           use high-res timers

Please apply.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
