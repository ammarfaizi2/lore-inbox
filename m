Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVIBGN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVIBGN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVIBGN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:13:57 -0400
Received: from mgate02.necel.com ([203.180.232.82]:54966 "EHLO
	mgate02.necel.com") by vger.kernel.org with ESMTP id S1030298AbVIBGN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:13:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Add show_mem
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
From: Miles Bader <miles@gnu.org>
Message-Id: <20050902061331.0197149B@dhapc248.dev.necel.com>
Date: Fri,  2 Sep 2005 15:13:31 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/setup.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff -ruN -X../cludes linux-2.6.13-uc0/arch/v850/kernel/setup.c linux-2.6.13-uc0-v850-20050902/arch/v850/kernel/setup.c
--- linux-2.6.13-uc0/arch/v850/kernel/setup.c	2005-06-21 16:07:27.095352000 +0900
+++ linux-2.6.13-uc0-v850-20050902/arch/v850/kernel/setup.c	2005-09-02 11:10:57.162581000 +0900
@@ -284,3 +294,33 @@
 	free_area_init_node (0, NODE_DATA(0), zones_size,
 			     ADDR_TO_PAGE (PAGE_OFFSET), 0);
 }
+
+
+
+/* Taken from m68knommu */
+void show_mem(void)
+{
+    unsigned long i;
+    int free = 0, total = 0, reserved = 0, shared = 0;
+    int cached = 0;
+
+    printk(KERN_INFO "\nMem-info:\n");
+    show_free_areas();
+    i = max_mapnr;
+    while (i-- > 0) {
+	total++;
+	if (PageReserved(mem_map+i))
+	    reserved++;
+	else if (PageSwapCache(mem_map+i))
+	    cached++;
+	else if (!page_count(mem_map+i))
+	    free++;
+	else
+	    shared += page_count(mem_map+i) - 1;
+    }
+    printk(KERN_INFO "%d pages of RAM\n",total);
+    printk(KERN_INFO "%d free pages\n",free);
+    printk(KERN_INFO "%d reserved pages\n",reserved);
+    printk(KERN_INFO "%d pages shared\n",shared);
+    printk(KERN_INFO "%d pages swap cached\n",cached);
+}
