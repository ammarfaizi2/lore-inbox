Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933109AbWFZWed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933109AbWFZWed (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933111AbWFZWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:12 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:63466 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933109AbWFZWbz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:31:55 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 7/7] [Suspend2] Pageflags.h
Date: Tue, 27 Jun 2006 08:31:53 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223152.3725.83186.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
References: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add header for pageflags variables and macros.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pageflags.h |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pageflags.h b/kernel/power/pageflags.h
new file mode 100644
index 0000000..c1d1b88
--- /dev/null
+++ b/kernel/power/pageflags.h
@@ -0,0 +1,51 @@
+/*
+ * kernel/power/pageflags.h
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Suspend2 needs a few pageflags while working that aren't otherwise
+ * used. To save the struct page pageflags, we dynamically allocate
+ * a bitmap and use that. These are the only non order-0 allocations
+ * we do.
+ *
+ * NOTE!!!
+ * We assume that PAGE_SIZE - sizeof(void *) is a multiple of
+ * sizeof(unsigned long). Is this ever false?
+ */
+
+#include <linux/dyn_pageflags.h>
+#include <linux/suspend.h>
+
+extern dyn_pageflags_t in_use_map;
+extern dyn_pageflags_t pageset2_map;
+
+/* 
+ * inusemap is used in two ways: 
+ * - During suspend, to tag pages which are not used (to speed up 
+ *   count_data_pages);
+ * - During resume, to tag pages which are in pagedir1. This does not tag 
+ *   pagedir2 pages, so !== first use.
+ */
+
+#define PageInUse(page) (test_dynpageflag(&in_use_map, page))
+#define SetPageInUse(page) (set_dynpageflag(&in_use_map, page))
+#define ClearPageInUse(page) (clear_dynpageflag(&in_use_map, page))
+
+#define PagePageset1(page) (test_dynpageflag(&pageset1_map, page))
+#define SetPagePageset1(page) (set_dynpageflag(&pageset1_map, page))
+#define ClearPagePageset1(page) (clear_dynpageflag(&pageset1_map, page))
+
+#define PagePageset1Copy(page) (test_dynpageflag(&pageset1_copy_map, page))
+#define SetPagePageset1Copy(page) (set_dynpageflag(&pageset1_copy_map, page))
+#define ClearPagePageset1Copy(page) (clear_dynpageflag(&pageset1_copy_map, page))
+
+#define PagePageset2(page) (test_dynpageflag(&pageset2_map, page))
+#define SetPagePageset2(page) (set_dynpageflag(&pageset2_map, page))
+#define ClearPagePageset2(page) (clear_dynpageflag(&pageset2_map, page))
+
+extern void save_dyn_pageflags(dyn_pageflags_t pagemap);
+extern void load_dyn_pageflags(dyn_pageflags_t pagemap);
+extern void relocate_dyn_pageflags(dyn_pageflags_t *pagemap);
+extern int suspend_pageflags_space_needed(void);

--
Nigel Cunningham		nigel at suspend2 dot net
