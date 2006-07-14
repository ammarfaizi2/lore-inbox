Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbWGNGw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbWGNGw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 02:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWGNGw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 02:52:56 -0400
Received: from www.osadl.org ([213.239.205.134]:5283 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030341AbWGNGwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 02:52:55 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Pavel Machek <pavel@ucw.cz>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1152828344.6845.96.camel@localhost>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
	 <1152554328.5320.6.camel@localhost.localdomain>
	 <20060710180839.GA16503@elf.ucw.cz>
	 <Pine.LNX.4.64.0607110035300.17704@scrub.home>
	 <1152571816.9062.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607110054180.12900@scrub.home>
	 <1152605229.32107.88.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607111120310.12900@scrub.home>
	 <1152616025.32107.151.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607120039380.12900@scrub.home>
	 <1152664944.760.70.camel@cog.beaverton.ibm.com>
	 <1152822433.24345.19.camel@localhost.localdomain>
	 <1152828344.6845.96.camel@localhost>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 08:56:09 +0200
Message-Id: <1152860169.7809.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 15:05 -0700, john stultz wrote:
> Also note: Assuming no NTP changes during a period, the maximum error in
> nanosecond accumulated over a period is the number of clocksource cycles
> in that period shifted down by the clocksource shift value. (This is
> since the smallest adjustment is 1 mult unit, and mult/2^shift is
> 1/freq)
> 
> So for a counter w/ a 4Ghz frequency and a shift value of 22 (similar to
> a TSC). Over 1 second, if there was no high-precision adjustment, you
> could get a *maximum* of error of ~1us (4b/2^22 = ~1024ns), which is a
> 1ppm drift, if left uncorrected.
> 
> Now, if we have high-precision adjustments, the question is "how fast
> should we fix that 1us error?". If the code assumes we're going to have
> a tick every 1 ms, it can make a stronger adjustment (of 10 mult units)
> which it will remove after the next tick. This however could cause
> problems if we lost ticks and that interrupt was delayed as we would
> overshoot.
> 
> Thus, if we assume that ticks will show up worse case, about once a
> second or two, we can make an adjustment of a single mult unit and
> assume that we'll correct it over the next second. This is what Roman
> was saying would be "slow adjustments", but I don't see it as too
> unacceptable. 

There is really no need to worry about sub micro second accuracy, when
you look at the latencies in todays machines. We need a robust design
and no ivory tower experiments with precisions which are not useful for
anything.

	tglx


