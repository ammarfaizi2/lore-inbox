Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWF0E4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWF0E4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933442AbWF0EyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:54:06 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:41435 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933411AbWF0ElL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:11 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/13] [Suspend2] Storage manager header file.
Date: Tue, 27 Jun 2006 14:41:09 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044108.14778.4079.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The header file for the storage manager, which defines the message numbers
used by it, and the functions accessible via proc entries.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.h |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.h b/kernel/power/storage.h
new file mode 100644
index 0000000..9039dcc
--- /dev/null
+++ b/kernel/power/storage.h
@@ -0,0 +1,37 @@
+/*
+ * kernel/power/storage.h
+ *
+ * Copyright (C) 2005-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ */
+
+int suspend_prepare_usm(void);
+void suspend_cleanup_usm(void);
+
+#ifdef CONFIG_NET
+int suspend_activate_storage(int force);
+int suspend_deactivate_storage(int force);
+#else
+static inline int suspend_activate_storage(int force)
+{
+	return 0;
+}
+
+static inline int suspend_deactivate_storage(int force)
+{
+	return 0;
+}
+#endif
+
+enum {
+	USM_MSG_BASE = 0x10,
+
+	/* Kernel -> Userspace */
+	USM_MSG_CONNECT = 0x30,
+	USM_MSG_DISCONNECT = 0x31,
+	USM_MSG_SUCCESS = 0x40,
+	USM_MSG_FAILED = 0x41,
+
+	USM_MSG_MAX,
+};

--
Nigel Cunningham		nigel at suspend2 dot net
