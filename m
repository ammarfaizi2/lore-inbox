Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268576AbUHaWwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268576AbUHaWwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269120AbUHaWwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:52:11 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:47586 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268576AbUHaWuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:50:13 -0400
Date: Wed, 01 Sep 2004 07:55:24 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] Re: [RFC] buddy allocator without bitmap(2) [1/3]
In-reply-to: <1093969857.26660.4816.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
Message-id: <413501DC.2050409@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <413455BE.6010302@jp.fujitsu.com>
 <1093969857.26660.4816.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> On Tue, 2004-08-31 at 03:41, Hiroyuki KAMEZAWA wrote:
> 
>>+static void __init calculate_aligned_end(struct zone *zone,
>>+					 unsigned long start_pfn,
>>+					 int nr_pages)
> 
> ...
> 
>>+		end_address = (zone->zone_start_pfn + end_idx) << PAGE_SHIFT;
>>+#ifndef CONFIG_DISCONTIGMEM
>>+		reserve_bootmem(end_address,PAGE_SIZE);
>>+#else
>>+		reserve_bootmem_node(zone->zone_pgdat,end_address,PAGE_SIZE);
>>+#endif
>>+	}
>>+	return;
>>+}
> 
> 
> What if someone has already reserved that address?  You might not be
> able to grow the zone, right?
> 
1) If someone has already reserved that address,  it (the page) will not join to
   buddy allocator and it's no problem.

2) No, I can grow the zone.
   A reserved page is the last page of "not aligned contiguous mem_map", not zone.

I answer your question ?

I know this patch contains some BUG, if a page is allocateed when calculate_alinged_end()
is called, and is freed after calling this, it is never reserved and join to buddy system.

> 
>>+	/* Because memmap_init_zone() is called in suitable way
>>+	 * even if zone has memory holes,
>>+	 * calling calculate_aligned_end(zone) here is reasonable
>>+	 */
>>+	calculate_aligned_end(zonep, saved_start_pfn, size);
> 
> 
> Could you please elaborate on "suitable way".  That comment really
> doesn't say anything. 
I'll rewrite this.
/*
 *  calculate_aligned_end() has to be called by each contiguous mem_map.
 */




-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

