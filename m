Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUCaR3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbUCaR3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:29:00 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4068
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262134AbUCaR2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:28:52 -0500
Date: Wed, 31 Mar 2004 19:28:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040331172851.GJ2143@dualathlon.random>
References: <20040331150718.GC2143@dualathlon.random> <Pine.LNX.4.44.0403311735560.27163-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403311735560.27163-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 05:45:31PM +0100, Hugh Dickins wrote:
> On Wed, 31 Mar 2004, Andrea Arcangeli wrote:
> > 
> > So I rewritten the fix this way:
> > 
> > +	ret = add_to_swap_cache(page, entry);
> 
> I think you'll find that gets into trouble on the header page,
> entry 0, which pmdisk/swsusp does access through this interface,
> but swapping does not: I'd expect its swap_duplicate to fail.

I didn't know they have to modify the header page.

> I've put off dealing with this, wasn't a priority for me to
> decide what to do with it.  You might experiment with setting
> p->swap_map[0] = 1 instead of SWAP_MAP_BAD in sys_swapon, but
> offhand I'm unsure whether that's enough e.g. would the totals
> come out right, would swapoff complete?
> 
> Just an idea, not something to finalize.

if they run into trouble I'll return to the pagecache API adding the
GFP_KERNEL and check for oom failure.
