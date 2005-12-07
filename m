Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVLGEYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVLGEYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 23:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVLGEYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 23:24:12 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:49867 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S932576AbVLGEYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 23:24:12 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200512070425.jB74Pkhq009503@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.14-rt21: slow-running clock
To: johnstul@us.ibm.com (john stultz)
Date: Wed, 7 Dec 2005 14:55:46 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <1133928070.10613.19.camel@cog.beaverton.ibm.com> from "john stultz" at Dec 06, 2005 08:01:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > When running Ingo's 2.6.14-rt21 (and in fact rt kernels back to at least
> > > > 2.6.13-rc days), the clock on my i915-based laptop runs slow.  The degree
> > > > of slowness appears directly related to how busy the machine is.  If
> > > > it is just sitting around doing very little the time is kept rather
> > > > well.  However, as soon as the load increases the RTC and system time
> > > > diverge significantly.  For example, running jackd for 2 minutes results
> > > > in the system time loosing as much as 20 seconds compared to the CMOS RTC.
> > > > Processes doing HDD I/O also seem to affect the system time similarly.
> > > > 
> > > > Selectively disabling different timer-related kernel options does not make
> > > > any difference.  However, the clock seems fine under vanilla 2.6.14,
> > > > suggesting an issue somewhere in the rt patches.
> > > 
> > > Could you please send me your dmesg and the output of:
> > > 
> > > 	cat  /sys/devices/system/clocksource/clocksource0/*
> > 
> > First the contents of the above /sys/ files:
> > 
> >   /sys/devices/system/clocksource/clocksource0/current_clocksource:
> >     c3tsc
> > 
> >   /sys/devices/system/clocksource/clocksource0/available_clocksource
> >     acpi_pm jiffies c3tsc pit
> 
> Odd. I'm not sure why the acpi_pm wasn't chosen by default if it was
> available and the TSC fell back to the c3tsc. It might be something in
> the -RT tree that's changed that bit. Could you try the following and
> see if it doesn't resolve the timekeeping problems you're seeing?
> 
> echo "acpi_pm" >  /sys/devices/system/clocksource/clocksource0/current_clocksource

Will test it tonight.

> Still it sounds like something isn't right w/ either the c3tsc code or
> the cpufreq notification code. Would you be willing to test further
> patches?

Yes, no problem.

> Also could you try booting w/ idle=poll and see if that changes the
> behavior?

Again, it will be done tonight and I'll advise tomorrow.

Regards
  jonathan
