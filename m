Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbTAUGu0>; Tue, 21 Jan 2003 01:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265800AbTAUGu0>; Tue, 21 Jan 2003 01:50:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:3066 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265633AbTAUGuS>;
	Tue, 21 Jan 2003 01:50:18 -0500
Message-ID: <3E2CEFA4.45F997D8@mvista.com>
Date: Mon, 20 Jan 2003 22:58:44 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-14smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net
Subject: [PATCH NOTICE 1/3] High-res-timers part 1 (core) take 25
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now available for 2.5.59 on sourceforge (see signature).

Changes since last time:
-----------
Fixed patch rejection on kernel make file.
-----------
Update the kernel base.
--------
Added stub macros to include/linux/hrtime.h to handle the no
high res case.  This was causing undefines when building a
kernel with CONFIG_HIGH_RES = n.

Removed the SMP optimization in timer.c (folks objected to
eliminating unneeded spin locks in favor of letting the
compiler do it).
-------
This patch supplies the core changes to implement high
resolution timers.  Mostly it changes the timer list from
the multi stage hash (or cascade) list to a single stage
hash list.  This change makes it easy to configure the list
size for those who are concerned with performance.  It also
eliminates the "time out" for the cascade operation every
512 jiffies, thus eliminating possibly long preemption
times.  On input from Stephen Hemminger<shemminger@osdl.org>
the configuration of the timer list size is no longer
presented as a configure option.  The code can still be
change (one line) to use larger or smaller lists.

It also adds a sub jiffie word to the timer structure to
allow timers to exist between jiffies.  However, to support
the sub jiffie timers, work needs to be done in the platform
code for each arch.  The platform work for the i386 arch
follows in part 2.  To prevent requests from
nonexistent code for sub jiffies stuff, these parts of this
patch are disabled with the IF_HIGH_RES() macro which
depends on CONFIG_HIGH_RES_TIMERS which will be defined for
each platform as they supply the needed code.

With this patch applied, the system should boot and run much
as it does prior to the patch.  This patch depends on the
POSIX clocks & timers patch in that it assumes the changes
that patch made to timer.c to remove timer_t.  This
dependency can be removed if needed.

This patch as well as the POSIX clocks & timers patch is
available on the project site:
http://sourceforge.net/projects/high-res-timers/

For those who want a change log, this version is changed
only to follow the changes in the posix patch, which, was
changed to use the new syscall restart stuff.

The 3 parts to the high res timers are:
*core           The core kernel (i.e. platform independent)
changes
 i386           The high-res changes for the i386 (x86)
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
