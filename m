Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWEVIo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWEVIo4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 04:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWEVIo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 04:44:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750706AbWEVIoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 04:44:55 -0400
Date: Mon, 22 May 2006 01:44:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: mel@csn.ul.ie, nickpiggin@yahoo.com.au, haveblue@us.ibm.com, ak@suse.de,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       mingo@elte.hu, mbligh@mbligh.org
Subject: Re: [PATCH 1/2] Align the node_mem_map endpoints to a MAX_ORDER
 boundary
Message-Id: <20060522014404.48e57958.akpm@osdl.org>
In-Reply-To: <44717564.50607@shadowen.org>
References: <20060519134241.29021.84756.sendpatchset@skynet>
	<20060519134301.29021.71137.sendpatchset@skynet>
	<20060519134948.10992ba1.akpm@osdl.org>
	<44717564.50607@shadowen.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> Andrew Morton wrote:
> > Mel Gorman <mel@csn.ul.ie> wrote:
> > 
> >>Andy added code to buddy allocator which does not require the zone's
> >>endpoints to be aligned to MAX_ORDER. An issue is that the buddy
> >>allocator requires the node_mem_map's endpoints to be MAX_ORDER aligned.
> >>Otherwise __page_find_buddy could compute a buddy not in node_mem_map for
> >>partial MAX_ORDER regions at zone's endpoints. page_is_buddy will detect
> >>that these pages at endpoints are not PG_buddy (they were zeroed out by
> >>bootmem allocator and not part of zone). Of course the negative here is
> >>we could waste a little memory but the positive is eliminating all the
> >>old checks for zone boundary conditions.
> >>
> >>SPARSEMEM won't encounter this issue because of MAX_ORDER size constraint
> >>when SPARSEMEM is configured. ia64 VIRTUAL_MEM_MAP doesn't need the
> >>logic either because the holes and endpoints are handled differently.
> >>This leaves checking alloc_remap and other arches which privately allocate
> >>for node_mem_map.
> > 
> > 
> > Do we think we need this in 2.6.17?
> 
> I would say yes, it is a very low risk patch in my view and provides a
> very large part of the protections we require.  i386 as our largest
> userbase should be safe from zone/node alignment issues with just this
> change.  Others need slightly more (the page_zone_idx check) which is
> being discussed in another thread.
> 

Well I've largely lost the plot here (which happens often), and it appears
that Nick has concerns with this approach (which also is not uncommon).

So could you guys please come to some sort of (rapid) consensus and tell me
which patches from -mm3 (hopefully but an hour away) need to go into
2.6.17?

Thanks.
