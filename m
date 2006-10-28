Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWJ1Ugu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWJ1Ugu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 16:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWJ1Ugu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 16:36:50 -0400
Received: from 1wt.eu ([62.212.114.60]:19972 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750831AbWJ1Ugu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 16:36:50 -0400
Date: Sat, 28 Oct 2006 22:36:59 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andi Kleen <ak@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, thockin@hockin.org,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028203659.GD1603@1wt.eu>
References: <1161969308.27225.120.camel@mindpipe> <200610281233.27588.ak@suse.de> <20061028200439.GB1603@1wt.eu> <200610281311.14665.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610281311.14665.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 01:11:14PM -0700, Andi Kleen wrote:
> On Saturday 28 October 2006 13:04, Willy Tarreau wrote:
> 
> > I really think that the hardware was doing tricks far beyond my knowledge,
> > because on another Sun (a V40Z), there were 4 dual cores which I never saw
> > out of sync even after hours of testing. But the HPET was available in it,
> > I don't remember if it's used by default when detected.
> 
> I think some system occasionally ramp the clock for thermal management,
> but that should be rare.

I should say that at one moment, I've been wondering whether they were
or not performing sort of an automatic overclocking under load, because
those machines were really faster even in single-core than other opterons
I had tested. Since such boxes are often compared on workloads such as
SSL, doing so might have favored them in comparative benchmarks.

> > No I did not "force" anything at first. You take the RHEL3 CD, you install
> > it, reboot and watch your logs report negative times, then scratch your
> > head, first call red hat dumb ass, and after a few tests, apologize to the
> > poor innocent red hat 
> 
> Well they should have fixed the kernel to fall back to another clock
> by backporting the appropiate fixes from mainline. I assume they
> did actually.

But upon what trigger should they apply the fallback ? I don't see
what can be detected. I see no such thing in 2.4 mainline (except
TSC resync at boot), and do not seem to find any such fallback either
in 2.6 (though I might not have looked deep enough as the code is more
complex there).

> > and call the box a total crap. To put it shortly 
> > (might be useful for people who Google for it) : Dual-core Sun x2100 is
> > unreliable out of the box under Linux.
> 
> No that shouldn't be true with any modern kernel. It will just fallback
> to HPET or more likely PMtimer.

same comment as above :-)

> >
> > > In the default configuration there shouldn't be any problems
> > > like this, it will just run slower because the kernel falls back to a
> > > slower time source.
> >
> > You have to specify "notsc" for this.
> 
> No, the kernel should work out of the box. Some older kernels didn't
> at various points of time though.

Anyway, if they started providing kernels which used TSC by default,
I don't think they will change this afterwards, in order to avoid
causing regressions.

Could you please check if the fallbacks you're talking about are
hard to backport in 2.4 ? Depending on their complexity and risk,
I would not be against a small backport. I think for instance that
automatically disabling TSC on SMP when HPET is present would not
be a terrible regression and might help in a number of occasions.
The user would then have to force the use of TSC if needed.

Regards,
Willy

