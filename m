Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUFXRdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUFXRdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266757AbUFXRds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:33:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6370
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266750AbUFXRcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:32:31 -0400
Date: Thu, 24 Jun 2004 19:32:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624173236.GP30687@dualathlon.random>
References: <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624165629.GG21066@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 09:56:29AM -0700, William Lee Irwin III wrote:
> On Fri, Jun 25, 2004 at 01:48:47AM +1000, Nick Piggin wrote:
> >> 2.6 has the "incremental min" thing. What is wrong with that?
> >> Though I think it is turned off by default.
> 
> On Thu, Jun 24, 2004 at 06:52:01PM +0200, Andrea Arcangeli wrote:
> > sysctl_lower_zone_protection is an inferior implementation of the
> > lower_zone_reserve_ratio, inferior because it has no way to give a
> > different balance to each zone. As you said it's turned off by default
> > so it had no tuning. The lower_zone_reserve_ratio has already been
> > tuned in 2.4. Somebody can attempt a conversion but it'll never be equal
> > since lower_zone_reserve_ratio is a superset of what
> > sysctl_lower_zone_protection can do.
> 
> Is there any chance you could send in thise improved implementation of
> zone fallback watermarks and describe the deficiencies in the current
> scheme that it corrects?

I did quite a few times and it was successfully merged in 2.4. Now I'd
need to forward port to 2.6.

I recall I recommended Andrew to merge the lower_zone_reserve_ratio
at some point during 2.5 or early 2.6 but apparently he implemented this
other thing called sysctl_lower_zone_protection. Note that now that I
look more into it, it seems sysctl_lower_zone_protection and
lower_zone_reserve_ratio have very little in common, I'm glad
sysctl_lower_zone_protection is disabled.  sysctl_lower_zone_protection
is just an improvement to the algorithm I dropped from 2.4 when
lowmem_zone_reserve_ratio was merged.  So in short enabling
sysctl_lower_zone_protection won't help, sysctl_lower_zone_protection
should be dropped enterely and replaced with lower_zone_reserve_ratio.
