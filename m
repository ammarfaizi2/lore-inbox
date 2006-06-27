Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933443AbWF0Eo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933443AbWF0Eo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933446AbWF0En6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:43:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:59355 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030706AbWF0EnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:43:08 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/13] [Suspend2] Suspend2 common header.
Date: Tue, 27 Jun 2006 14:43:07 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044305.15066.1229.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Declarations used by virtually all of the Suspend2 files, but which are not
needed externally. That is, debugging and result set/clear macros and the
enum for the result codes.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend2_common.h |   45 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend2_common.h b/kernel/power/suspend2_common.h
new file mode 100644
index 0000000..455250e
--- /dev/null
+++ b/kernel/power/suspend2_common.h
@@ -0,0 +1,45 @@
+/*
+ * kernel/power/suspend2_common.h
+ *
+ * Copyright (C) 2005-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Routines for talking to a userspace program that manages storage.
+ *
+ * The kernel side:
+ * - starts the userspace program;
+ * - sends messages telling it when to open and close the connection;
+ * - tells it when to quit;
+ *
+ * The user space side:
+ * - passes messages regarding status;
+ *
+ */
+
+#ifdef CONFIG_PM_DEBUG
+#define set_debug_state(bit) (test_and_set_bit(bit, &suspend_debug_state))
+#define clear_debug_state(bit) (test_and_clear_bit(bit, &suspend_debug_state))
+#else
+#define set_debug_state(bit) (0)
+#define clear_debug_state(bit) (0)
+#endif
+
+#define set_result_state(bit) (test_and_set_bit(bit, &suspend_result))
+#define clear_result_state(bit) (test_and_clear_bit(bit, &suspend_result))
+
+enum {
+	SUSPEND_ABORT_REQUESTED = 1,
+	SUSPEND_NOSTORAGE_AVAILABLE,
+	SUSPEND_INSUFFICIENT_STORAGE,
+	SUSPEND_FREEZING_FAILED,
+	SUSPEND_UNEXPECTED_ALLOC,
+	SUSPEND_KEPT_IMAGE,
+	SUSPEND_WOULD_EAT_MEMORY,
+	SUSPEND_UNABLE_TO_FREE_ENOUGH_MEMORY,
+	SUSPEND_ENCRYPTION_SETUP_FAILED,
+	SUSPEND_PM_SEM,
+};
+
+extern unsigned int nr_suspends;
+extern char resume2_file[256];

--
Nigel Cunningham		nigel at suspend2 dot net
