Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbVBCO3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbVBCO3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVBCO3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:29:30 -0500
Received: from gprs214-99.eurotel.cz ([160.218.214.99]:22241 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263146AbVBCOWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:22:31 -0500
Date: Thu, 3 Feb 2005 15:22:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Message-ID: <20050203142203.GB1402@elf.ucw.cz>
References: <200502021428.12134.rjw@sisk.pl> <200502031230.20302.rjw@sisk.pl> <20050203124006.GA18142@isilmar.linta.de> <200502031420.37560.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502031420.37560.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > So, would it be acceptable to check in _suspend() if the state is S4
> > > and drop the frequency in that case or do nothing otherwise?
> > 
> > No. The point is that this is _very_ system-specific. Some systems resume
> > always at full speed, some always at low speed; for S4 the behaviour may be
> > completely unpredictable. And in fact I wouldn't want my desktop P4 drop th
> > 12.5 % frequency if I ask it to suspend to disk, too. "Ignoring" the warning
> > seems to be the best thing to me. The good thing is, after all, that cpufreq
> > detected this situation and tries to correct for it.
> 
> Well, the warning is not a big problem, as far as I'm concerned.  The problem is
> that the box often reboots when it's woken up on batteries and this certainly
> is related to cpufreq (ie it does not happen if cpufreq is not compiled in).
> 
> Pavel has suggested that it may happen when the frequency of
> the CPU is too high on resume, so I'm trying to verify if this is the case.  If so,
> which I'm not entirely convinced about yet, I'll be going to provide a fix
> for it, but I wouldn't like to do anything that's not acceptable from the
> start.

Well, try to force your machine to 2GHz while it is on battery. If it
crashes, you have verified it is indeed the problem. [Insert standard
disclaimer about exploding batteries here.]

> I'm currently thinking that the proper approach may be to add a ->suspend()
> routine to struct cpufreq_driver and call the driver-specific ->suspend()
> (if one is defined) from cpufreq_suspend().  Then, it'll be possible to do
> whatever-is-necessary on a per-driver basis.  Just a thought. :-)

Yes, that seems like right solution.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
