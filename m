Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966408AbWKTWsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966408AbWKTWsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966446AbWKTWsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:48:42 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:56336 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S966408AbWKTWsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:48:41 -0500
Date: Mon, 20 Nov 2006 22:48:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Brownell <david-b@pacbell.net>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, rpurdie@rpsys.net
Subject: Re: [patch 2.6.19-rc6 2/6] rtc-sa1100 tweaks
Message-ID: <20061120224832.GE26791@flint.arm.linux.org.uk>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	Linux Kernel list <linux-kernel@vger.kernel.org>, rpurdie@rpsys.net
References: <200611201014.41980.david-b@pacbell.net> <200611201019.53906.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611201019.53906.david-b@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 10:19:53AM -0800, David Brownell wrote:
> Minor updates to rtc-sa1100: report whether the alarm is enabled, remove
> duplicate procfs reporting of that factoid, and stick a FIXME at a place
> where alarms should be enabled (but aren't).

I think you're rather confused about alarms, but you're going to tell
me that it's me who is no doubt, so I'm not sure why I'm bothering to
write this mail.

The pre-rtc-lib user API was as follows:

- ALM_SET - sets the time of the alarm, does not enable or disable
            current alarm settings
- AIE_ON - enables alarm interrupts
- AIE_OFF - disables alarm interrupts
- WKALM_SET - sets the wake up alarm, enables wake up alarm, indicates
              whether wake up alarm is pending

So, alrm->enabled indicates _independently_ of the alarm interrupt whether
this should cause a wakeup, as per the SA1100 driver.  Whether a wakeup
can occur with or without AIE_ON is implementation defined.

Now, if the new RTC library treats this differently, then /it's/ changing
the userspace API and is therefore buggy.

Note also that _lots_ of drivers don't support these new weird
device_set_wakeup_enable() and device_may_wakeup() calls - it seems
that there's an exercise for someone to go through and add a load of
device_set_wakeup_enable() before we go trying to use device_may_wakeup()
on those devices.  I'm not presently sure what they're supposed to do
or achieve.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
