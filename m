Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWF0Ex7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWF0Ex7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933401AbWF0ElQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:16 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:35291 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933407AbWF0Eka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:30 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/13] [Suspend2] Storage.c header.
Date: Tue, 27 Jun 2006 14:40:29 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044027.14778.14573.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header for the storage.c file. This file provides the interface to a
userspace helper that manages access to storage (possibly network storage,
eg).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
new file mode 100644
index 0000000..91b24a6
--- /dev/null
+++ b/kernel/power/storage.c
@@ -0,0 +1,36 @@
+/*
+ * kernel/power/storage.c
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
+#include <linux/suspend.h>
+#include <linux/freezer.h>
+ 
+#include "proc.h"
+#include "modules.h"
+#include "netlink.h"
+#include "storage.h"
+#include "ui.h"
+
+static struct user_helper_data usm_helper_data;
+static struct suspend_module_ops usm_ops;
+static int message_received = 0;
+static int activations = 0;
+static int usm_prepare_count = 0;
+static int storage_manager_last_action = 0;
+static int storage_manager_action = 0;
+       

--
Nigel Cunningham		nigel at suspend2 dot net
