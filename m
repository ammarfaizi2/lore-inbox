Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbUJ0Axr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbUJ0Axr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbUJ0Axq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:53:46 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:54251 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261555AbUJ0Axd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:53:33 -0400
Date: Wed, 27 Oct 2004 02:54:25 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Rik van Riel <riel@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041027005425.GO14325@dualathlon.random>
References: <417DCFDD.50606@yahoo.com.au> <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410262029210.21548-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 08:31:32PM -0400, Rik van Riel wrote:
> On Tue, 26 Oct 2004, Nick Piggin wrote:
> 
> > OK that makes sense... it isn't the length of the name, but the fact
> > that that naming convention hasn't proliferated thoughout the 2.6 tree;
> 
> Speaking about not proliferating...
> 
> One thing we need to make sure of is that the lower zone
> protection stuff doesn't put the allocation threshold
> higher than kswapd's freeing threshold.

I agree. I didn't introduce that bug, the very same problem would happen
with the previous protection code. So this is not a regression, I'm far
from finished... I'm just trying to post orthogonal patches, since Hugh
had a much better merging success rate with small patches (though I find
very hard to produce small patches myself when there's more than one
thing to fix in the same file).

the per-classzone kswapd treshold was very well taken care of in 2.4,
thanks the watermarks embedding the low/min/high and the classzone being
passed up to the kswapd wakeup function.

> Otherwise on a 1GB system, we'll end up cycling most of
> userspace allocations through the 128MB highmem zone,
> instead of falling back to the other zones.

that's the side effect of the per-zone lru too (though I'm not going to
change the lru).
