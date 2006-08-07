Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWHGPUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWHGPUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWHGPUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:20:18 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:49359 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932144AbWHGPT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:19:59 -0400
Date: Mon, 7 Aug 2006 17:19:57 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andi Kleen <ak@muc.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Dmitry Torokhov <dtor@insightbb.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060807151957.GA9911@rhlx01.fht-esslingen.de>
References: <1154771262.28257.38.camel@localhost.localdomain> <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de> <200608062243.45129.dtor@insightbb.com> <20060807084850.GA67713@muc.de> <20060807110931.GM27757@suse.cz> <20060807122845.GA85602@muc.de> <20060807124855.GB21003@suse.cz> <20060807125639.GA88155@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807125639.GA88155@muc.de>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 02:56:39PM +0200, Andi Kleen wrote:
> On Mon, Aug 07, 2006 at 02:48:55PM +0200, Vojtech Pavlik wrote:
> > But I need, in the driver, in the no-TSC case use i/o counting, not a
> > slow but reliable method. And I can't say, from outside the timing
> > subsystem, whether gettimeofday() is fast or slow.
> 
> Hmm if that is the only obstacle I can export a "slow gettimeofday" flag.

Wouldn't it be much more useful to normalize this versus (e.g.) CPU cycles
for much more information than a plain "this is fast/this is slow" flag,
to be measured on bootup?
That way a driver could use

	if (gtod_cpu_cycles_needed <= 500)
		gettimeofday();
	else
		funky_fast_workaround();

OK, in total we have at least four ways of doing this:

a) gtod_is_slow flag
b) number of CPU cycles needed
c) number of nanoseconds needed (but this is less useful since it doesn't
   properly take into account the fast vs. slow CPUs behaviour, I think)
d) providing all three items above together, for optimal flexibility??

This is somewhat related to an idea of mine which would be to benchmark all
clock sources on bootup and print a timing summary, optionally warning
users if grave performance issues have been found with a specific source
(and especially if that one is active!).
Additionally, print timing summary of gettimeofday() itself on bootup?

Andreas Mohr
