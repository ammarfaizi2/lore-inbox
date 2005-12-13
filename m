Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVLMNWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVLMNWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVLMNWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:22:17 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43699 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932113AbVLMNWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:22:16 -0500
Date: Tue, 13 Dec 2005 22:20:35 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: [Patch] Fix calculation of grow_pgdat_span() in mm/memory_hotplug.c
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.054
Message-Id: <20051213220842.9C02.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave-san.
CC: Andrew-san.

I realized 2.6.15-rc5 still has a bug for memory hotplug.
The calculation for node_spanned_pages at grow_pgdat_span() is
clearly wrong. This is patch for it.

(Please see grow_zone_span() to compare. It is correct.)

Thanks.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: zone_reclaim/mm/memory_hotplug.c
===================================================================
--- zone_reclaim.orig/mm/memory_hotplug.c	2005-12-13 21:38:16.000000000 +0900
+++ zone_reclaim/mm/memory_hotplug.c	2005-12-13 21:39:14.000000000 +0900
@@ -104,7 +104,7 @@ static void grow_pgdat_span(struct pglis
 		pgdat->node_start_pfn = start_pfn;
 
 	if (end_pfn > old_pgdat_end_pfn)
-		pgdat->node_spanned_pages = end_pfn - pgdat->node_spanned_pages;
+		pgdat->node_spanned_pages = end_pfn - pgdat->node_start_pfn;
 }
 
 int online_pages(unsigned long pfn, unsigned long nr_pages)

-- 
Yasunori Goto 


