Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWEVI0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWEVI0d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 04:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWEVI0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 04:26:33 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:15878 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750703AbWEVI0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 04:26:32 -0400
Message-ID: <44717564.50607@shadowen.org>
Date: Mon, 22 May 2006 09:25:08 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mel Gorman <mel@csn.ul.ie>, nickpiggin@yahoo.com.au, haveblue@us.ibm.com,
       ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mingo@elte.hu, mbligh@mbligh.org
Subject: Re: [PATCH 1/2] Align the node_mem_map endpoints to a MAX_ORDER boundary
References: <20060519134241.29021.84756.sendpatchset@skynet>	<20060519134301.29021.71137.sendpatchset@skynet> <20060519134948.10992ba1.akpm@osdl.org>
In-Reply-To: <20060519134948.10992ba1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Mel Gorman <mel@csn.ul.ie> wrote:
> 
>>Andy added code to buddy allocator which does not require the zone's
>>endpoints to be aligned to MAX_ORDER. An issue is that the buddy
>>allocator requires the node_mem_map's endpoints to be MAX_ORDER aligned.
>>Otherwise __page_find_buddy could compute a buddy not in node_mem_map for
>>partial MAX_ORDER regions at zone's endpoints. page_is_buddy will detect
>>that these pages at endpoints are not PG_buddy (they were zeroed out by
>>bootmem allocator and not part of zone). Of course the negative here is
>>we could waste a little memory but the positive is eliminating all the
>>old checks for zone boundary conditions.
>>
>>SPARSEMEM won't encounter this issue because of MAX_ORDER size constraint
>>when SPARSEMEM is configured. ia64 VIRTUAL_MEM_MAP doesn't need the
>>logic either because the holes and endpoints are handled differently.
>>This leaves checking alloc_remap and other arches which privately allocate
>>for node_mem_map.
> 
> 
> Do we think we need this in 2.6.17?

I would say yes, it is a very low risk patch in my view and provides a
very large part of the protections we require.  i386 as our largest
userbase should be safe from zone/node alignment issues with just this
change.  Others need slightly more (the page_zone_idx check) which is
being discussed in another thread.

-apw
