Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbUKPUdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbUKPUdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUKPUbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:31:05 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:48636 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261809AbUKPU36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:29:58 -0500
Date: Tue, 16 Nov 2004 21:29:45 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: john stultz <johnstul@us.ibm.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] prefer TSC over PM Timer
Message-ID: <20041116202944.GA8982@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	john stultz <johnstul@us.ibm.com>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org> <1100569104.21267.58.camel@cog.beaverton.ibm.com> <Pine.LNX.4.61.0411151843190.22091@twinlark.arctic.org> <1100598645.13732.22.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100598645.13732.22.camel@leatherman>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 01:50:44AM -0800, john stultz wrote:
> > 
> > right -- except i think the default is the opposite of what it should be 
> > for a generic kernel.  i think more systems are served better by using tsc 
> > than those that need clock=pm...  NUMA systems are rare (with custom 
> > kernels/etc), and if my experience with the centrino is valid then newer 
> > laptops aren't having this tsc/cpufreq problem.

Oh yes, they do -- as Venkatesh pointed out, the TSC stops if the CPU is in
the "deep sleep" power state. And better support for deeper sleep states is
in the working...

Also, the cpufreq code currently can only update the timing code with an
inaccuracy of up to one jiffy. If transitions happen in between two timer
ticks, timing becomes inaccurate by -0.5<x<0.5 jiffy. So, if you're
transitioning back and forth a lot, it becomes quite inaccurate over time.
It's the best we can do, and with john's new timer core, we'll be able to
reduce this issue to zero.

In addition, notebooks won't be changing their CPU's frequency behind their 
kernel's back in future as often -- a call to disable this BIOS interference
was added into 2.6.10-rc2.

> Yea, no, I definitely don't like that. I know how these tricks work,
> send out a worse patch to make the first look better ;) But alas, you've
> worn me down! Add the comments I mentioned above and I'd go along with
> it. 
> 
> Dominik: are you cool with this?

I agree with handling TMTA specially, as it uses such a different approach
to CPU frequency scaling _and_ gets TSC right. Therefore, ACK.

Thanks,
	Dominik
