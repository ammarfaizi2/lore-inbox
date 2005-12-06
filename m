Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbVLFAM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbVLFAM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbVLFAM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:12:57 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:26443 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1751493AbVLFAM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:12:57 -0500
Date: Mon, 5 Dec 2005 16:12:56 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206001256.GM22168@hexapodia.org>
References: <20051205081935.GI22168@hexapodia.org> <200512060005.04556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512060005.04556.rjw@sisk.pl>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 12:05:04AM +0100, Rafael J. Wysocki wrote:
> On Monday, 5 December 2005 09:19, Andy Isaacson wrote:
> > On recent kernels such as 2.6.14-rc2-mm1, a swsusp of my laptop (1.25
> > GB, P4M 1.4 GHz) was a pretty fast process; freeing memory took about 3
> > seconds or less,
> 
> It took much more time on my box, but I won't discuss with your
> experience. ;-)

I may be misremembering, it didn't seem important at the time.  Less
than 10 seconds, anyways.

> > Certainly there's a tradeoff to be made, and I'm glad to lose the slow
> > re-paging after resume, but I'm hoping that some kind of improvement can
> > be made in the suspend/resume time.
> 
> Yes, there is a tradeoff.  Till now, we have used the simplistic approach
> based on freeing as much memory as possible before suspend.  Now, we
> are freeing only as much memory as necessary, which is on the other
> end of the scale, so to speak.  There are a whole lot of possibilities in
> between, and there's a question which one is the best.  Frankly, I'm afraid
> the answer is very system-dependent.

If you wanted to compute "What's the absolute perfect 99.9999th
percentile amount to free", yes, that would be impossibly
system-dependent.

But some kind of rule of thumb should get good results in most cases,
and it should be easy enough to add a knob for people who have
particular requirements.

> If you want a quick solution, you can get back to the previous behavior by
> commenting out the definition of FAST_FREE in kernel/power/power.h.

That's boring. :)  The current behavior isn't bad enough to force me
back.

> Alternatively, you can increase the value of PAGES_FOR_IO, defined
> in include/linux/suspend.h.  To see any effect, you'll probably have to
> increase it by tens of thousands, but please note the box may be unable
> to suspend if it's too great (if you try this anyway, please let me know what
> number seems to be the best to you).
> 
> Also, I can create a patch to improve this a bit, if you promise to help
> test/debug it. ;-)

I'll play with this a bit tonight but I'd love to see a patch that makes
it a tunable.  Rebooting my laptop is sloooow and annoying (due to slow
startup scripts and losing all my state), but trying various suspend
settings sounds like a fun experiment.

-andy
