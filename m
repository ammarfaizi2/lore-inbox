Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbUKPJxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbUKPJxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUKPJw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:52:59 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:16329 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261587AbUKPJuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:50:52 -0500
Subject: Re: [patch] prefer TSC over PM Timer
From: john stultz <johnstul@us.ibm.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>, linux@brodo.de
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411151843190.22091@twinlark.arctic.org>
References: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
	 <1100569104.21267.58.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0411151843190.22091@twinlark.arctic.org>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 01:50:44 -0800
Message-Id: <1100598645.13732.22.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-15 at 19:21 -0800, dean gaudet wrote:
> On Mon, 15 Nov 2004, john stultz wrote:
> > With your patch, ACPI PM would never be selected (as TSC always wins
> > when available, and it will be available on all ACPI enabled i386
> > systems). So its just the same as disabling CONFIG_X86_PM_TIMER, so why
> > not just do that?
> 
> my patch lets you use "clock=pmtmr" if you want it.

Yea, but at that point you have to enable it in the config and then pass
a boot parameter to use it.  I dunno. If you want to go with that you
should def include a comment in the pmtmr code as well as in the config
help. 

> > Do note, using the "clock=tsc" boot option, you can easily force the
> > system to use the TSC.
> 
> right -- except i think the default is the opposite of what it should be 
> for a generic kernel.  i think more systems are served better by using tsc 
> than those that need clock=pm...  NUMA systems are rare (with custom 
> kernels/etc), and if my experience with the centrino is valid then newer 
> laptops aren't having this tsc/cpufreq problem.
>
> > I would however, support a patch that selected the TSC over the ACPI PM
> > time source when CONFIG_CPUFREQ and CONFIG_SMP were N. That's fairly
> > safe. 
> 
> i'm looking for a solution that generic distribution kernels can use...
> 
> honestly my selfish motivation is to get efficeon/crusoe treated properly 
> -- they support a fixed TSC rate which does not vary with frequency (which 
> many people fault us for, but the reality is that fixed TSC is the only 
> viable solution for a processor which can vary power consumption without 
> the involvement of the kernel).  

Yea, I just wish we could get away from the TSC and have a well defined
and hardware guaranteed timebase register like PPC. 

> i'd advocate a patch like the one 
> below... but it feels wrong.

Yea, no, I definitely don't like that. I know how these tricks work,
send out a worse patch to make the first look better ;) But alas, you've
worn me down! Add the comments I mentioned above and I'd go along with
it. 

Dominik: are you cool with this?

thanks
-john

