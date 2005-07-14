Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVGNUrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVGNUrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbVGNUpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:45:08 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:22966 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261689AbVGNUn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:43:57 -0400
Date: Thu, 14 Jul 2005 13:26:29 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/4] new human-time soft-timer subsystem
Message-ID: <20050714202629.GD28100@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.2005 [12:18:41 -0700], john stultz wrote:

<snip>

> Nish has some code, which I hope he'll be sending out shortly that
> does just this, converting the soft-timer subsystem to use absolute
> time instead of ticks for expiration. I feel it both simplifies the
> code and makes it easier to changing the timer interrupt frequency
> while the system is running.

Here's the set of patches John promised :)

1/4: add jiffies conversion helper functions

2/4: core human-time modifications to soft-timer subsystem

3/4: add new human-time schedule_timeout() functions

4/4: rework sys_nanosleep() to use schedule_timeout_nsecs()

The individual patches have more details, but the gist is this:

We no longer use jiffies (the variable) as the basis for determining
what "time" a timer should expire or when it should be added. Instead,
we use a new function, do_monotonic_clock(), which is simply a wrapper
for getnstimeofday(). That is to say, we use uptime in nanoseconds. But,
to avoid modifying the existing soft-timer algorithm, we convert the
64-bit nanosecond value to "timerinterval" units. These units are simply
2^TIMEINTERVAL_BITS nanoseconds in length (thus determined at compile
time).

To sum up, soft-timers now use time (as defined by the
timeofday-subsystem) not ticks. Hopefully, the individual
e-mails/patches make this change clear.

Thanks,
Nish
