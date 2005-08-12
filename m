Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVHLOtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVHLOtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVHLOr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:47:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28927 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751099AbVHLOre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:34 -0400
Subject: [RFC][PATCH 10/12] memory hotplug: call setup_per_zone_pages_min after hotplug
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:31 -0700
References: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
In-Reply-To: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Message-Id: <20050812144731.900DCD08@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
> I found the tests does not work well with Dave's patchset.
> I've found the followings:
> 
> 	- setup_per_zone_pages_min() calls should be added in
> 	   capture_page_range() and online_pages()
> 	- lru_add_drain() should be called before try_to_migrate_pages()

The following patch deals with the first item.

Signed-off-by: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/memory_hotplug.c |    2 ++
 mm/page_alloc.c                     |    0 
 2 files changed, 2 insertions(+)

diff -puN include/linux/mmzone.h~D0.7-call_setup_per_zone_pages_min_after_memory_size_change include/linux/mmzone.h
diff -puN mm/memory_hotplug.c~D0.7-call_setup_per_zone_pages_min_after_memory_size_change mm/memory_hotplug.c
--- memhotplug/mm/memory_hotplug.c~D0.7-call_setup_per_zone_pages_min_after_memory_size_change	2005-08-12 07:43:50.000000000 -0700
+++ memhotplug-dave/mm/memory_hotplug.c	2005-08-12 07:43:50.000000000 -0700
@@ -133,5 +133,7 @@ int online_pages(unsigned long pfn, unsi
 	}
 	zone->present_pages += onlined_pages;
 
+	setup_per_zone_pages_min();
+
 	return 0;
 }
diff -puN mm/page_alloc.c~D0.7-call_setup_per_zone_pages_min_after_memory_size_change mm/page_alloc.c
_
