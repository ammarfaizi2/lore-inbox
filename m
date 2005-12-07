Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbVLGEBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVLGEBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 23:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVLGEBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 23:01:13 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:61591 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750994AbVLGEBN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 23:01:13 -0500
Subject: Re: 2.6.14-rt21: slow-running clock
From: john stultz <johnstul@us.ibm.com>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512070339.jB73dmDb006057@auster.physics.adelaide.edu.au>
References: <200512070339.jB73dmDb006057@auster.physics.adelaide.edu.au>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 20:01:10 -0800
Message-Id: <1133928070.10613.19.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 14:09 +1030, Jonathan Woithe wrote:
> > > When running Ingo's 2.6.14-rt21 (and in fact rt kernels back to at least
> > > 2.6.13-rc days), the clock on my i915-based laptop runs slow.  The degree
> > > of slowness appears directly related to how busy the machine is.  If
> > > it is just sitting around doing very little the time is kept rather
> > > well.  However, as soon as the load increases the RTC and system time
> > > diverge significantly.  For example, running jackd for 2 minutes results
> > > in the system time loosing as much as 20 seconds compared to the CMOS RTC.
> > > Processes doing HDD I/O also seem to affect the system time similarly.
> > > 
> > > Selectively disabling different timer-related kernel options does not make
> > > any difference.  However, the clock seems fine under vanilla 2.6.14,
> > > suggesting an issue somewhere in the rt patches.
> > 
> > Could you please send me your dmesg and the output of:
> > 
> > 	cat  /sys/devices/system/clocksource/clocksource0/*
> 
> First the contents of the above /sys/ files:
> 
>   /sys/devices/system/clocksource/clocksource0/current_clocksource:
>     c3tsc
> 
>   /sys/devices/system/clocksource/clocksource0/available_clocksource
>     acpi_pm jiffies c3tsc pit

Odd. I'm not sure why the acpi_pm wasn't chosen by default if it was
available and the TSC fell back to the c3tsc. It might be something in
the -RT tree that's changed that bit. Could you try the following and
see if it doesn't resolve the timekeeping problems you're seeing?

echo "acpi_pm" >  /sys/devices/system/clocksource/clocksource0/current_clocksource


Still it sounds like something isn't right w/ either the c3tsc code or
the cpufreq notification code. Would you be willing to test further
patches?

Also could you try booting w/ idle=poll and see if that changes the
behavior?

Thanks for the testing and feedback!
-john

