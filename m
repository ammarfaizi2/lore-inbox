Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933112AbWFZXgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112AbWFZXgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933173AbWFZXgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:36:47 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:32159 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933122AbWFZWep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:45 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 9/9] [Suspend2] Header file for pagedir functions.
Date: Tue, 27 Jun 2006 08:34:43 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223441.3963.89530.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
References: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/power/pagedir.h declares structures and functions related to
pagedirs. A pagedir is a set of pages that are being stored in part of the
image. It used to be a far more substantial structure, containing a list of
pages. Since the advent of bitmaps, it just has the size. Pagedir.c
contains the routines for allocating and freeing memory when pagedir1 is
larger than pageset2 (generally only init S), marking which pages belong to
which pageset, and for obtaining pages that can safely be used during the
atomic copy.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pagedir.h |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pagedir.h b/kernel/power/pagedir.h
new file mode 100644
index 0000000..608b29a
--- /dev/null
+++ b/kernel/power/pagedir.h
@@ -0,0 +1,37 @@
+/*
+ * kernel/power/pagedir.h
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Declarations for routines for handling pagesets.
+ */
+
+/* Pagedir
+ *
+ * Contains the metadata for a set of pages saved in the image.
+ */
+
+struct pagedir {
+	long pageset_size;
+	long lastpageset_size;
+};
+
+extern struct pagedir pagedir1, pagedir2;
+
+extern void suspend_copy_pageset1(void);
+
+extern void suspend_free_extra_pagedir_memory(void);
+
+extern int suspend_allocate_extra_pagedir_memory(struct pagedir *p, int pageset_size, int alloc_from);
+
+extern void suspend_mark_task_as_pageset1 (struct task_struct *t);
+extern void suspend_mark_pages_for_pageset2(void);
+
+extern void suspend_relocate_if_required(unsigned long *current_value, unsigned int size);
+extern int suspend_get_pageset1_load_addresses(void);
+
+extern int extra_pagedir_pages_allocated;
+
+extern unsigned long suspend_get_nonconflicting_page(void);

--
Nigel Cunningham		nigel at suspend2 dot net
