Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266179AbUFXQwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266179AbUFXQwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUFXQwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:52:00 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49372
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266179AbUFXQv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:51:58 -0400
Date: Thu, 24 Jun 2004 18:52:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Takashi Iwai <tiwai@suse.de>, Andi Kleen <ak@suse.de>, ak@muc.de,
       tripperda@nvidia.com, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624165200.GM30687@dualathlon.random>
References: <m3acyu6pwd.fsf@averell.firstfloor.org> <20040623213643.GB32456@hygelac> <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DAF7DF.9020501@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 01:48:47AM +1000, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >
> >why does it fail? note that with the lower_zone_reserve_ratio algorithm I
> >added to 2.4 all dma zone will be reserved for __GFP_DMA allocations so
> >you should have troubles only with 2.6, 2.4 should work fine.
> >
> >So with latest 2.4 it has to fail only if you already allocated 16M with
> >pci_alloc_consistent which sounds unlikely.
> >
> >the fact 2.6 lacks the lower_zone_reserve_ratio algorithm is a different
> >issue, but I'm confortable there's no other possible algorithm to solve
> >this memory balancing problem completely so there's no way around a
> >forward port.
> >
> >well 2.6 has a tiny hack like some older 2.4 that attempts to do what
> >lower_zone_reserve_ratio does, but it's not nearly enough, there's no
> >per-zone-point-of-view watermark in 2.6 etc.. 2.6 actually has a more
> >hardcoded hack for highmem, but the lower_zone_reserve_ratio has
> >absolutely nothing to do with highmem vs lowmem. it's by pure
> >coincidence that it avoids highmem machine to lockup without swap, but
> >the very same problem happens on x86-64 with lowmem vs dma.
> 
> 2.6 has the "incremental min" thing. What is wrong with that?
> Though I think it is turned off by default.

sysctl_lower_zone_protection is an inferior implementation of the
lower_zone_reserve_ratio, inferior because it has no way to give a
different balance to each zone. As you said it's turned off by default
so it had no tuning. The lower_zone_reserve_ratio has already been
tuned in 2.4. Somebody can attempt a conversion but it'll never be equal
since lower_zone_reserve_ratio is a superset of what
sysctl_lower_zone_protection can do.
