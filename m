Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbVIBVAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbVIBVAu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVIBU47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:56:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:57325 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751258AbVIBU4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:56:53 -0400
Subject: [PATCH 09/11] memory hotplug: call setup_per_zone_pages_min after hotplug
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 02 Sep 2005 13:56:50 -0700
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
In-Reply-To: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
Message-Id: <20050902205650.C36ECCC6@kernel.beaverton.ibm.com>
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
 1 files changed, 2 insertions(+)

diff -puN mm/memory_hotplug.c~D0.7-call_setup_per_zone_pages_min_after_memory_size_change mm/memory_hotplug.c
--- memhotplug/mm/memory_hotplug.c~D0.7-call_setup_per_zone_pages_min_after_memory_size_change	2005-08-18 14:59:49.000000000 -0700
+++ memhotplug-dave/mm/memory_hotplug.c	2005-08-18 14:59:49.000000000 -0700
@@ -133,5 +133,7 @@ int online_pages(unsigned long pfn, unsi
 	}
 	zone->present_pages += onlined_pages;
 
+	setup_per_zone_pages_min();
+
 	return 0;
 }
_
