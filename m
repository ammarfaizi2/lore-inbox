Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967800AbWK3BcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967800AbWK3BcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967801AbWK3BcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:32:12 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:32995 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S967800AbWK3BcL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:32:11 -0500
Subject: Re: PM-Timer clock source is slow. Try something else: How slow?
	What other source(s)?
From: john stultz <johnstul@us.ibm.com>
To: Linda Walsh <lkml@tlinx.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <456E2C2C.40303@tlinx.org>
References: <456E2C2C.40303@tlinx.org>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 17:32:09 -0800
Message-Id: <1164850329.5426.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 16:56 -0800, Linda Walsh wrote:
> I recently noticed this message in my bootup that I don't remember
> from before:
> 
> PCI: Probing PCI hardware (bus 00)
> * Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
> * this clock source is slow. Consider trying other clock sources

This basically means that your chipset has a bug which requires the ACPI
PM timer to be read three times in order to get a valid reading.

This will cause gettimeofday/clock_gettime to take longer to execute,
which is what is meant by "slow" (rather then the counter's frequency
being incorrect).

>     How would this affect my clock?  It says to try another
> clock source, what type of clock source would it be suggesting I
> use? Another chip already in the computer? It is an Intel 440BX
> chipset; on an Dell motherboard. Would that be likely to have
> another chip source that is compensating?
> 
> I don't notice a significant clock slowdown, but I'm running NTP,
> so that could be masking the problem.

Unless you're running performance critical programs that utilize
gettimeofday/clock_gettime, you probably won't notice anything. Time
should still function properly.  If you are having performance issues,
you can try using a different clocksource (the TSC is probably safe, but
not necessarily).

thanks
-john



