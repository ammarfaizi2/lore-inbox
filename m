Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbUCOXbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbUCOXbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:31:40 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:30990
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263413AbUCOXbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:31:21 -0500
Date: Tue, 16 Mar 2004 00:32:05 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
Message-ID: <20040315233205.GO30940@dualathlon.random>
References: <20040315222419.GM30940@dualathlon.random> <Pine.LNX.4.44.0403151737380.12895-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403151737380.12895-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 05:41:54PM -0500, Rik van Riel wrote:
> On Mon, 15 Mar 2004, Andrea Arcangeli wrote:
> 
> > As I told Andrew, you've also to make sure not to start always from the
> > highmemzone, and from the code this seems not the case, so my 2G
> > scenario still applies.
> 
> Agreed, the scenario applies.  However, I don't see how a
> global LRU would fix it in eg. the case of an AMD64 NUMA
> system...

I think I mentioned the per-node lru would be enough for numa, I'm only
talking here about per-zone lru, per-node numa needs are another matter.
For 64bit per-node or per-zone is basically the same in practice.

however after 2.6.4 will be fixed even the per-zone should not generate
loss of caching info, so with that part fixed I'm not against per-zone
even if it's more difficult to be fair.

> And once we fix it right for those NUMA systems, we can
> use the same code to take care of balancing between zones
> on normal PCs, giving us the scalability benefits of the
> per-zone lists and locks.

I argue those scalability benefits of the locks, on a 32G machine or on
a 1G machine those locks benefits are near zero. The only significant
benefit is in terms of computational complexity of the normal-zone
allocations, where we'll only walk on the zone-normal and zone-dma
pages.

> How about AMD64 NUMA systems ?
> What evens out the LRU pressure there in 2.4 ?

by the time you say 64bit you can forget the per-zone per-node
differences.  sure there will be still a difference but it's cosmetical
so I don't care about those per-zone lru issues for 64bit hardware,
infact on 64bit hardware per-zone (even if totally unfair) is the most
optimal just in case somebody asks for ZONE_DMA more than once per day.
But the difference is so small in practice that even global would be ok.

the per-node on numa (not necessairly on amd64, infact in amd64 the
penality is so small that I doubt things like that will payoff big)
still remains but that's not the thing I was discussing here.
