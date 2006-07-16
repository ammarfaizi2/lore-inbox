Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946078AbWGPByj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946078AbWGPByj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 21:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946080AbWGPByj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 21:54:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62130 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1946078AbWGPByi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 21:54:38 -0400
Date: Sun, 16 Jul 2006 03:54:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: andrea@cpushare.com
Cc: Valdis.Kletnieks@vt.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060716015426.GB21162@atrey.karlin.mff.cuni.cz>
References: <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712210545.GB24367@opteron.random> <1152741776.22943.103.camel@localhost.localdomain> <20060712234441.GA9102@opteron.random> <20060713212940.GB4101@ucw.cz> <20060713231118.GA1913@opteron.random> <200607150255.k6F2tS2R008742@turing-police.cc.vt.edu> <20060716005108.GK18774@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060716005108.GK18774@opteron.random>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jul 14, 2006 at 10:55:28PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > In fact, the best you can do here is to reduce the effective bandwidth
> > the signal can have, as Shannon showed quite clearly.
> 
> Yes.
> 
> > And even 20 years ago, the guys who did the original DoD Orange Book
> > requirements understood this - they didn't make a requirement that covert
> > channels (both timing and other) be totally closed down, they only made
> > a requirement that for higher security configurations the bandwidth of
> > the channel be reduced below a specified level...
> 
> Why I think it's trivial to guarantee the closure of the seccomp side
> channel timing attack even on a very fast internet by simply
> introducing the random delay, is that below a certain sampling
> frequency you won't be able to extract data from the latencies of the
> cache. The max length of the random noise has to be >= of what it
> takes to refill the whole cache. Then you won't know if it was a
> cache

You won't know for sure... but. Let t be time takes to reload the
cache. Let your random noise be in <0, t> interval. According to you,
that would be okay. IT IS NOT.

If the original delay was long, and your generator returned t,
attacker sees 2*t. He can be _sure_ delay was long now.

If the delay was short, and your generator returns 0, attacker sees 0,
and _knows_ delay was short. (Chance that generator produces 0 or t is
small, but non zero).

Even if you do random noise in <0, 2*t) interval, I'll be able to
gather some statistics.

							Pavel
Thanks, Sharp!
