Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbUCOWn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbUCOWnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:43:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39813 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262843AbUCOWmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:42:17 -0500
Date: Mon, 15 Mar 2004 17:41:54 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       <marcelo.tosatti@cyclades.com>, <j-nomura@ce.jp.nec.com>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <20040315222419.GM30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403151737380.12895-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004, Andrea Arcangeli wrote:

> As I told Andrew, you've also to make sure not to start always from the
> highmemzone, and from the code this seems not the case, so my 2G
> scenario still applies.

Agreed, the scenario applies.  However, I don't see how a
global LRU would fix it in eg. the case of an AMD64 NUMA
system...

And once we fix it right for those NUMA systems, we can
use the same code to take care of balancing between zones
on normal PCs, giving us the scalability benefits of the
per-zone lists and locks.

> 	for (i = 0; zones[i] != NULL; i++) {
> 		int to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX);

> Either that or you can choose to do some overwork and to shrink from all
> the zones removing this break:
> 
> 		if (ret >= nr_pages)
> 			break;

That's probably the nicest solution.  Though you will want
to cap it at a certain high water mark (2 * pages_high?) so
you don't end up freeing all of highmem on a burst of lowmem
pressure.

> but as far as I can tell, the 50% waste of cache in a 2G box can happen
> in 2.6.4 and it won't happen in 2.4.x.

How about AMD64 NUMA systems ?
What evens out the LRU pressure there in 2.4 ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

