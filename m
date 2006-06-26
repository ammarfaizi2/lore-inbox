Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933177AbWFZWgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933177AbWFZWgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933181AbWFZWgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:36:00 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:42911 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933175AbWFZWf5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:57 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 20/20] [Suspend2] Prepare image header file
Date: Tue, 27 Jun 2006 08:35:55 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223553.4050.55187.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header file for image preparation routines and exported functions.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.h |   92 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.h b/kernel/power/prepare_image.h
new file mode 100644
index 0000000..912f570
--- /dev/null
+++ b/kernel/power/prepare_image.h
@@ -0,0 +1,92 @@
+/*
+ * kernel/power/prepare_image.h
+ *
+ * Copyright (C) 2003-2006 Nigel Cunningham <nigel@suspend.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ */
+
+extern int suspend_prepare_image(void);
+extern void suspend_recalculate_image_contents(int storage_available);
+extern long real_nr_free_pages(void);
+extern long image_size_limit;
+extern long pageset1_sizelow, pageset2_sizelow;
+
+struct pageset_sizes_result {
+	long size1; /* Can't be unsigned - breaks MAX function */
+	long size1low;
+	long size2;
+	long size2low;
+};
+
+#ifdef CONFIG_CRYPTO
+extern int suspend_expected_compression_ratio(void);
+#else
+static inline int suspend_expected_compression_ratio(void)
+{
+	return 0;
+};
+#endif
+
+#define MIN_FREE_RAM 2000
+#define MIN_EXTRA_PAGES_ALLOWANCE 500
+
+extern long extra_pd1_pages_allowance;
+extern long storage_needed(int use_ecr, int ignore_extra_p1_allowance);
+extern long ram_to_suspend(void);
+
+#ifdef CONFIG_DEBUG_RODATA
+extern char __start_rodata, __end_rodata;
+
+static inline struct page* rodata_start_page(void)
+{
+	return virt_to_page(&__start_rodata);
+}
+
+static inline struct page* rodata_end_page(void)
+{
+	return virt_to_page(&__end_rodata);
+}
+
+#else
+static inline struct page* rodata_start_page(void)
+{
+	return NULL;
+}
+
+static inline struct page* rodata_end_page(void)
+{
+	return NULL;
+}
+#endif
+
+#ifdef CONFIG_PPC
+extern char _etext[];
+
+static inline struct page* rotext_start_page(void)
+{
+	return virt_to_page(PAGE_OFFSET);
+}
+#else
+extern char _text[], _etext[];
+static inline struct page* rotext_start_page(void)
+{
+	return virt_to_page(_text);
+}
+#endif
+
+static inline struct page* rotext_end_page(void)
+{
+	return virt_to_page(_etext);
+}
+
+static inline struct page* nosave_start_page(void)
+{
+	return virt_to_page(&__nosave_begin);
+}
+
+static inline struct page* nosave_end_page(void)
+{
+	return virt_to_page(&__nosave_end);
+}

--
Nigel Cunningham		nigel at suspend2 dot net
