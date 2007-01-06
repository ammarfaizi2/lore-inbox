Return-Path: <linux-kernel-owner+w=401wt.eu-S1751202AbXAFH1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbXAFH1f (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXAFH1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:27:35 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:59142 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751202AbXAFH1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:27:16 -0500
Message-ID: <368068420.92201@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20070106072729.598977589@mail.ustc.edu.cn>
References: <20070106072626.911640026@mail.ustc.edu.cn>
User-Agent: quilt/0.45-1
Date: Sat, 06 Jan 2007 15:26:28 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] readahead: min/max sizes: remove get_readahead_bounds()
Content-Disposition: inline; filename=readahead-min-max-sizes-remove-get_readahead_bounds.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove get_readahead_bounds():
- ra_max: we already have get_max_readahead() for it
- ra_min: is only used by context based readahead, and will be moved there
          and set to a more reasonable value

Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>

---
 mm/readahead.c |   24 ------------------------
 1 file changed, 24 deletions(-)

--- linux-2.6.20-rc3-mm1.orig/mm/readahead.c
+++ linux-2.6.20-rc3-mm1/mm/readahead.c
@@ -780,30 +780,6 @@ out:
 	return nr_pages;
 }
 
-/*
- * ra_min is mainly determined by the size of cache memory. Reasonable?
- *
- * Table of concrete numbers for 4KB page size:
- *   inactive + free (MB):    4   8   16   32   64  128  256  512 1024
- *            ra_min (KB):   16  16   16   16   20   24   32   48   64
- */
-static inline void get_readahead_bounds(struct file_ra_state *ra,
-					unsigned long *ra_min,
-					unsigned long *ra_max)
-{
-	unsigned long active;
-	unsigned long inactive;
-	unsigned long free;
-
-	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
-
-	free += inactive;
-	*ra_max = min(min(ra->ra_pages, 0xFFFFUL), free / 2);
-	*ra_min = min(min(MIN_RA_PAGES + (free >> 14),
-			  DIV_ROUND_UP(64*1024, PAGE_CACHE_SIZE)),
-			  *ra_max / 8);
-}
-
 #endif /* CONFIG_ADAPTIVE_READAHEAD */
 
 /*

--
