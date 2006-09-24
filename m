Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752064AbWIXCgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbWIXCgz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 22:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbWIXCgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 22:36:55 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:55945 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1752064AbWIXCgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 22:36:54 -0400
Date: Sun, 24 Sep 2006 04:36:29 +0200
From: Voluspa <lista1@comhem.se>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, brugolsky@telemetry-investments.com,
       pavel@suse.cz, akpm@osdl.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: hires timer patchset [was Re: 2.6.19 -mm merge plans]
Message-ID: <20060924043629.5bebc404@loke.fish.not>
In-Reply-To: <20060923202027.GA8350@elte.hu>
References: <20060923041746.2b9b7e1f@loke.fish.not>
	<1159034967.21405.22.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<20060923215832.03b1dac5@loke.fish.not>
	<20060923202027.GA8350@elte.hu>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 22:20:27 +0200 Ingo Molnar wrote:
> 
> * Voluspa wrote:
> 
> > WARNING: "monotonic_clock" [drivers/char/hangcheck-timer.ko]
> > undefined!
> 
> turn off the CONFIG_HANGCHECK_TIMER option.
> 
> > WARNING: "hrtimer_stop_sched_tick" [drivers/acpi/processor.ko]
> > undefined! WARNING:
> > "hrtimer_restart_sched_tick" [drivers/acpi/processor.ko] undefined!
> 
> add these two lins to the end of kernel/hrtimer.c:
> 
> EXPORT_SYMBOL_GPL(hrtimer_stop_sched_tick);
> EXPORT_SYMBOL_GPL(hrtimer_restart_sched_tick);

My mind was clouded close to bedtime. I now remember the fix that
was published already at 2.6.17 time, from Steven Rostedt:

http://marc.theaimsgroup.com/?l=linux-kernel&m=115124086410874&w=2

Well, result is that NO_HZ indeed is the culprit for this CPU
issue. /proc/interrupts showed the timer to be stuck on an initial 3044
triggers after boot, while NMI: counted up almost as fast as LOC: (if
that tells any tale). Observing "top -d 1" for awhile revealed SYS
bursting (almost regularly alternating) between 50% and 100% CPU each 2
to 3 seconds. In between it was 0. USER also had the same pattern, but
with much longer duration. Perhaps 10 seconds from one show to the next.

I've gotten the broken out hrt-dyntick1 patches so will be able to
experiment on my own - slowly, on spare time.

I am of course available for any thoughts or trials you can come up
with in the meantime.

Mvh
Mats Johannesson
