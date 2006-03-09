Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751782AbWCIKUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbWCIKUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 05:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWCIKUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 05:20:38 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:31675 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751782AbWCIKUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 05:20:38 -0500
Date: Thu, 09 Mar 2006 19:20:33 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch]Tiny bug fix of memory hotadd (pgdat->node_present_pages are not correct).
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060309191244.E607.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This patch is tiny bug fix for memory hotplug.

When pages are onlined, not only zone->present_pages 
but also pgdat->node_present_pages should be refreshed.

This parameter is used to show information at
/sys/device/system/node/nodeX/meminfo 
via si_meminfo_node().

So, it shows strange value for MemUsed which is calculated
(node_present_pages - all zones free pages).

This patch is for 2.6.16-rc5-mm3.
And I tested this on my hotplug emulation environment.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat7/mm/memory_hotplug.c
===================================================================
--- pgdat7.orig/mm/memory_hotplug.c	2006-03-09 18:32:11.000000000 +0900
+++ pgdat7/mm/memory_hotplug.c	2006-03-09 18:34:34.000000000 +0900
@@ -130,6 +130,7 @@ int online_pages(unsigned long pfn, unsi
 		onlined_pages++;
 	}
 	zone->present_pages += onlined_pages;
+	zone->zone_pgdat->node_present_pages += onlined_pages;
 
 	setup_per_zone_pages_min();
 

-- 
Yasunori Goto 


