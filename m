Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269245AbUHaX00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269245AbUHaX00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269312AbUHaXRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:17:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:29855 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269284AbUHaXMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:12:44 -0400
Subject: Re: [Lhms-devel] Re: [RFC] buddy allocator without bitmap(2) [1/3]
From: Dave Hansen <haveblue@us.ibm.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <413501DC.2050409@jp.fujitsu.com>
References: <413455BE.6010302@jp.fujitsu.com>
	 <1093969857.26660.4816.camel@nighthawk>  <413501DC.2050409@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1093993935.28787.416.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 16:12:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 15:55, Hiroyuki KAMEZAWA wrote:
> Dave Hansen wrote:
> 
> > On Tue, 2004-08-31 at 03:41, Hiroyuki KAMEZAWA wrote:
> > 
> >>+static void __init calculate_aligned_end(struct zone *zone,
> >>+					 unsigned long start_pfn,
> >>+					 int nr_pages)
> > 
> > ...
> > 
> >>+		end_address = (zone->zone_start_pfn + end_idx) << PAGE_SHIFT;
> >>+#ifndef CONFIG_DISCONTIGMEM
> >>+		reserve_bootmem(end_address,PAGE_SIZE);
> >>+#else
> >>+		reserve_bootmem_node(zone->zone_pgdat,end_address,PAGE_SIZE);
> >>+#endif
> >>+	}
> >>+	return;
> >>+}
> > 
> > 
> > What if someone has already reserved that address?  You might not be
> > able to grow the zone, right?
> > 
> 1) If someone has already reserved that address,  it (the page) will not join to
>    buddy allocator and it's no problem.
> 
> 2) No, I can grow the zone.
>    A reserved page is the last page of "not aligned contiguous mem_map", not zone.
> 
> I answer your question ?

If the end of the zone isn't aligned, you simply waste memory until it becomes aligned, right?

> I know this patch contains some BUG, if a page is allocateed when calculate_alinged_end()
> is called, and is freed after calling this, it is never reserved and join to buddy system.

If you adjust the zone_spanned pages properly, this shouldn't happen.

-- Dave

