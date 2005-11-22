Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVKVLfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVKVLfu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVKVLfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:35:50 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:65210 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751281AbVKVLft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:35:49 -0500
Date: Tue, 22 Nov 2005 11:35:35 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andi Kleen <ak@suse.de>, linux-mm@kvack.org, mingo@elte.hu,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
In-Reply-To: <4382EF48.1050107@shadowen.org>
Message-ID: <Pine.LNX.4.58.0511221133390.2476@skynet>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
 <200511160036.54461.ak@suse.de> <Pine.LNX.4.58.0511160137540.8470@skynet>
 <200511160252.05494.ak@suse.de> <Pine.LNX.4.58.0511160200530.8470@skynet>
 <4382EF48.1050107@shadowen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Andy Whitcroft wrote:

> Mel Gorman wrote:
>
> > That's iterating through, potentially, 1024 pages which I considered too
> > expensive. In terms of code complexity, the page-flags patch adds 237
> > which is not much of a saving in comparison to 275 that the usemap
> > approach uses.
>
> Surley you would just use a single bit in the first page of a MAX_ORDER
> block.   We guarentee that the mem_map is contigious out to MAX_ORDER
> pages so you can simply calculate the offset.  The page free path does
> the same thing to find the buddy pages when coallescing.
>
> > Again, I can revisit the page-flag approach if I thought that something
> > like this would get merged and people would not choke on another page flag
> > being consumed.
>
> All of that said, I am not even sure we have a bit left in the page
> flags on smaller architectures :/.
>

Based on the 2.6.15-rc1-mm2, there is a macro FLAGS_RESERVED defined in
include/linux/mmzone.h which says how many bits are served for teh
node+zone bits in the page flags with the remainder for normal page flags.
It's currently 9, leaving 21 bits for page flags of which 19 are used. I
don't think using another bit will cause breakage but I imagine it will
make eyebrows furrow.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
