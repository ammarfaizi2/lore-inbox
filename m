Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWFZQsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWFZQsw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWFZQsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:48:13 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:36837 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750809AbWFZQru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:47:50 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 7/7] [Suspend2] Suspend2 proc.h
Date: Tue, 27 Jun 2006 02:47:54 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164752.10724.22617.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
References: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header file for Suspend2 proc entries - define the data structure used to
define our proc entries, flags and the register/unregister routines.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/proc.h |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/kernel/power/proc.h b/kernel/power/proc.h
new file mode 100644
index 0000000..688f8d2
--- /dev/null
+++ b/kernel/power/proc.h
@@ -0,0 +1,76 @@
+/*
+ * kernel/power/proc.h
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It provides declarations for suspend to use in managing
+ * /proc/suspend2. When we switch to kobjects,
+ * this will become redundant.
+ *
+ */
+
+#include <linux/proc_fs.h>
+
+struct suspend_proc_data {
+	char *filename;
+	int permissions;
+	int type;
+	int needs_storage_manager;
+	union {
+		struct {
+			unsigned long *bit_vector;
+			int bit;
+		} bit;
+		struct {
+			int *variable;
+			int minimum;
+			int maximum;
+		} integer;
+		struct {
+			long *variable;
+			long minimum;
+			long maximum;
+		} a_long;
+		struct {
+			unsigned long *variable;
+			unsigned long minimum;
+			unsigned long maximum;
+		} ul;
+		struct {
+			char *variable;
+			int max_length;
+		} string;
+		struct {
+			read_proc_t *read_proc;
+			write_proc_t *write_proc;
+			void *data;
+		} special;
+	} data;
+	
+	/* Side effects routines. Used, eg, for reparsing the
+	 * resume2 entry when it changes */
+	void (*read_proc) (void);
+	void (*write_proc) (void); 
+	struct list_head proc_data_list;
+};
+
+enum {
+	SUSPEND_PROC_DATA_NONE,
+	SUSPEND_PROC_DATA_CUSTOM,
+	SUSPEND_PROC_DATA_BIT,
+	SUSPEND_PROC_DATA_INTEGER,
+	SUSPEND_PROC_DATA_UL,
+	SUSPEND_PROC_DATA_LONG,
+	SUSPEND_PROC_DATA_STRING
+};
+
+#define PROC_WRITEONLY 0200
+#define PROC_READONLY 0400
+#define PROC_RW 0600
+
+struct proc_dir_entry *suspend_register_procfile(
+		struct suspend_proc_data *suspend_proc_data);
+void suspend_unregister_procfile(struct suspend_proc_data *suspend_proc_data);
+

--
Nigel Cunningham		nigel at suspend2 dot net
