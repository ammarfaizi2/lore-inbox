Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWESUra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWESUra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWESUr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:47:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16816 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964833AbWESUr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:47:29 -0400
Date: Fri, 19 May 2006 13:49:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: mel@csn.ul.ie, nickpiggin@yahoo.com.au, haveblue@us.ibm.com, ak@suse.de,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       apw@shadowen.org, mingo@elte.hu, mbligh@mbligh.org
Subject: Re: [PATCH 1/2] Align the node_mem_map endpoints to a MAX_ORDER
 boundary
Message-Id: <20060519134948.10992ba1.akpm@osdl.org>
In-Reply-To: <20060519134301.29021.71137.sendpatchset@skynet>
References: <20060519134241.29021.84756.sendpatchset@skynet>
	<20060519134301.29021.71137.sendpatchset@skynet>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mel@csn.ul.ie> wrote:
>
> Andy added code to buddy allocator which does not require the zone's
> endpoints to be aligned to MAX_ORDER. An issue is that the buddy
> allocator requires the node_mem_map's endpoints to be MAX_ORDER aligned.
> Otherwise __page_find_buddy could compute a buddy not in node_mem_map for
> partial MAX_ORDER regions at zone's endpoints. page_is_buddy will detect
> that these pages at endpoints are not PG_buddy (they were zeroed out by
> bootmem allocator and not part of zone). Of course the negative here is
> we could waste a little memory but the positive is eliminating all the
> old checks for zone boundary conditions.
> 
> SPARSEMEM won't encounter this issue because of MAX_ORDER size constraint
> when SPARSEMEM is configured. ia64 VIRTUAL_MEM_MAP doesn't need the
> logic either because the holes and endpoints are handled differently.
> This leaves checking alloc_remap and other arches which privately allocate
> for node_mem_map.

Do we think we need this in 2.6.17?
