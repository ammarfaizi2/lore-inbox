Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWFZQrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWFZQrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWFZQrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:47:32 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:33765 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750811AbWFZQr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:47:29 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 1/7] [Suspend2] Proc.c header.
Date: Tue, 27 Jun 2006 02:47:33 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164731.10724.49191.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
References: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend2 uses shared routines to handle reading and writing proc entries,
and a simple data structure to define the properties of entries, including
data type, constraints on values and specific routines to be called as side
effects.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/proc.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/kernel/power/proc.c b/kernel/power/proc.c
new file mode 100644
index 0000000..16ad90e
--- /dev/null
+++ b/kernel/power/proc.c
@@ -0,0 +1,30 @@
+/*
+ * kernel/power/proc.c
+ *
+ * Copyright (C) 2002-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains support for proc entries for tuning Suspend2.
+ *
+ * We have a generic handler that deals with the most common cases, and
+ * hooks for special handlers to use.
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+#include "proc.h"
+#include "suspend2.h"
+#include "storage.h"
+
+static int suspend_proc_initialised = 0;
+
+static struct list_head suspend_proc_entries;
+static struct proc_dir_entry *suspend_dir;
+static struct suspend_proc_data proc_params[];
+
+extern void __suspend_try_resume(void);
+extern void suspend_main(void);
+

--
Nigel Cunningham		nigel at suspend2 dot net
