Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVC2WMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVC2WMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVC2WMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:12:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:49360 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261172AbVC2WLz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:11:55 -0500
Subject: Re: Clock 3x too fast on AMD64 laptop [WAS Re: Various issues
	after rebooting]
From: john stultz <johnstul@us.ibm.com>
To: Olivier Fourdan <fourdan@xfce.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1112133731.14248.14.camel@shuttle>
References: <1112039799.6106.16.camel@shuttle>
	 <20050328192054.GV30052@alpha.home.local> <1112038226.6626.3.camel@shuttle>
	 <20050328193921.GW30052@alpha.home.local>
	 <1112131714.14248.8.camel@shuttle>  <1112133731.14248.14.camel@shuttle>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 14:11:52 -0800
Message-Id: <1112134312.17854.55.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 00:02 +0200, Olivier Fourdan wrote:
> A quick look at the source shows that the error is triggered in
> arch/i386/kernel/timers/timer_pm.c by the verify_pmtr_rate() function.
> 
> My guess is that the pmtmr timer is right and the pit is wrong in my
> case. That would explain why the clock is wrong when being based on pit
> (like when forced with "clock=pit")

Yea. From your description this is most likely the cause of the issue.
Currently the time of day is still tick-based, using the tsc/pmtmr/hpet
only for interpolating between ticks. 

> Maybe, if I can prove my guesses, a fix could be to "trust" the pmtmr
> clock when the user has passed a "clock=pmtmr" argument ? Does that make
> any sense ?

Well, if you tried the time of day re-work I've been working on it would
mask the issue somewhat, but you'd still have the problem that you are
taking too many timer interrupts.

One thing you could try is playing with the CLOCK_TICK_RATE value to see
if you just have very unique hardware. 

A similar sounding issue has also been reported here:
http://bugme.osdl.org/show_bug.cgi?id=3927

thanks
-john




