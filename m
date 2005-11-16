Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbVKPCHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbVKPCHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 21:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbVKPCHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 21:07:22 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:37324 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965176AbVKPCHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 21:07:21 -0500
Date: Wed, 16 Nov 2005 02:07:17 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Andi Kleen <ak@suse.de>
Cc: linux-mm@kvack.org, mingo@elte.hu, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
In-Reply-To: <200511160252.05494.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0511160200530.8470@skynet>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
 <200511160036.54461.ak@suse.de> <Pine.LNX.4.58.0511160137540.8470@skynet>
 <200511160252.05494.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005, Andi Kleen wrote:

> On Wednesday 16 November 2005 02:43, Mel Gorman wrote:
>
> > 1. I was using a page flag, valuable commodity, thought I would get kicked
> >    for it. Usemap uses 1 bit per 2^(MAX_ORDER-1) pages. Page flags uses
> >    2^(MAX_ORDER-1) bits at worse case.
>
> Why does it need multiple bits? A page can only be in one order at a
> time, can't it?
>

Yes, but 1024 pages in one block is one bit per page. Usemap uses 1 page
for all 1024.

> > 2. Fragmentation avoidance tended to break down, very fast.
>
> Why? The algorithm should the same, no?
>

That's what I thought when I wrote it first but it broke down fast
according to bench-stresshighalloc. I'll need to re-examine the patches
and see where I went wrong.

> > 3. When changing a block of pages from one type to another, there was no
> >    fast way to make sure all pages currently allocation would end up on
> >    the correct free list
>
> If you can change the bitmap you can change as well mem_map
>

That's iterating through, potentially, 1024 pages which I considered too
expensive. In terms of code complexity, the page-flags patch adds 237
which is not much of a saving in comparison to 275 that the usemap
approach uses.

Again, I can revisit the page-flag approach if I thought that something
like this would get merged and people would not choke on another page flag
being consumed.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
