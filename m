Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265794AbUFVWWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUFVWWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUFVWWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 18:22:01 -0400
Received: from aun.it.uu.se ([130.238.12.36]:23031 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265794AbUFVWTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 18:19:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16600.45126.425726.174463@alkaid.it.uu.se>
Date: Wed, 23 Jun 2004 00:18:46 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6.7-mm1] perfctr ppc32 update
In-Reply-To: <1087939194.1839.13.camel@gaston>
References: <200406212014.i5LKElHD019224@alkaid.it.uu.se>
	<1087928274.1881.4.camel@gaston>
	<16600.37372.473221.988885@alkaid.it.uu.se>
	<1087935661.1855.10.camel@gaston>
	<16600.39256.669322.177553@alkaid.it.uu.se>
	<1087939194.1839.13.camel@gaston>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:
 > 
 > > So what you're saying is that PLL_CFG may not reflect the true
 > > relationship between the TB frequency and the core frequency?
 > 
 > Right.
 > 
 > > That shouldn't be a problem as long as there's _some_ in-kernel
 > > interface for finding that out. If querying OF isn't the correct
 > > approach, then what is?
 > 
 > What do you need exactly ? The TB one or the core one ? the core
 > I suppose ? Well, we should probably define an ppc_get_cpu_core_frequency
 > or something like that that uses the cpufreq callback like the pmac code
 > when cpufreq is enabled or default to the old parsing when not. Look at
 > the pmac code. You may also want to install a cpufreq notifier callback
 > to be informed of core frequency changes.

I want both TB and core speeds, but TB is more important.

Originally, I used and sampled the x86 time-stamp counter to
provide an additional clock-like register for measurements.
On x86, observable TSC freq == core freq, so the CPU speed
I report to users coincides with TSC speed. This is then
used to derive high-resolution actual time from TSC counts.

When adding PPC32 support, I used TB for the clock-like
entity, but had to introduce a TB-to-core multiplier to
maintain the notion that clock*multiplier == core speed.

If TB speed is constant but core speed is not, then this
was a mistake and I should instead report TB speed only,
and let user-space convert TB counts to time directly
without conversion via core speed.

So can I assume constant TB speed? In that case I don't
really care about core speed changes.

/Mikael
