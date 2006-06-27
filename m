Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWF0Ex1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWF0Ex1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933408AbWF0ElV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:21 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:39899 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933416AbWF0ElB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:01 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/13] [Suspend2] Storage manager proc entries.
Date: Tue, 27 Jun 2006 14:41:00 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044058.14778.1717.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define the proc entries for the storage manager - there are entries for
disabling the manager, setting the program, manually activating and
simulating an atomic copy.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index aa140ea..c8f85db 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -236,3 +236,51 @@ static void storage_manager_activate(voi
 	storage_manager_last_action = storage_manager_action;
 }
 
+/*
+ * User interface specific /proc/suspend entries.
+ */
+
+static struct suspend_proc_data proc_params[] = {
+	{ .filename			= "disable_storage_manager",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &usm_ops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	  }
+	},
+	{ .filename			= "storage_manager",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .data = {
+		.string = {
+			.variable	= usm_helper_data.program,
+			.max_length	= 254,
+		}
+	  }
+	},
+	{ .filename			= "activate_storage",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &storage_manager_action,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	  },
+	  .write_proc 			= storage_manager_activate,
+	},
+
+#ifdef CONFIG_PM_DEBUG
+	{ .filename			= "simulate_atomic_copy",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_NONE,
+	  .write_proc 			= storage_manager_simulate,
+	}
+#endif
+};
+

--
Nigel Cunningham		nigel at suspend2 dot net
