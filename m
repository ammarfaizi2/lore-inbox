Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268224AbTBYRs7>; Tue, 25 Feb 2003 12:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268226AbTBYRs7>; Tue, 25 Feb 2003 12:48:59 -0500
Received: from [195.223.140.107] ([195.223.140.107]:53638 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268224AbTBYRs4>;
	Tue, 25 Feb 2003 12:48:56 -0500
Date: Tue, 25 Feb 2003 18:59:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225175928.GP29467@dualathlon.random>
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random> <20030225174359.GA10411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225174359.GA10411@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 09:43:59AM -0800, William Lee Irwin III wrote:
> On Sat, Feb 22, 2003 at 07:24:24PM -0800, Andrew Morton wrote:
> >> So whole stole the remaining 1.85 seconds?   Looks like pte_highmem.
> 
> On Tue, Feb 25, 2003 at 06:17:27PM +0100, Andrea Arcangeli wrote:
> > would you mind to add the line for 2.4.21-pre4aa3? it has pte-highmem so
> > you can easily find it out for sure if it is pte_highmem that stole >10%
> > of your fast cpu. A line for the 2.4-rmap patch would be also
> > interesting.
> 
> On Sat, Feb 22, 2003 at 07:24:24PM -0800, Andrew Morton wrote:
> >> Note one second spent in pte_alloc_one().
> 
> On Tue, Feb 25, 2003 at 06:17:27PM +0100, Andrea Arcangeli wrote:
> > note the seconds spent in the rmap affected paths too.
> 
> The pagetable cache is gone in 2.5, so pte_alloc_one() takes the
> bitblitting hit for pagetables.

I'm talking about do_anonymous_page, do_wp_page, do_no_page fork and all
the other places that introduces spinlocks (per-page) and allocations of
2 pieces of ram rather than just 1 (and in turn potentially global
spinlocks too if the cpu-caches are empty). Just grep for
pte_chain_alloc or page_add_rmap in mm/memory.c, that's what I mean, I'm
not talking about pagetables.

Andrea
