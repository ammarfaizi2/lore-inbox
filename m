Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWAZDzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWAZDzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWAZDte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:34 -0500
Received: from [202.53.187.9] ([202.53.187.9]:16363 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932208AbWAZDtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:11 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 02/23] [Suspend2] Add new include/linux/freezer.h header.
Date: Thu, 26 Jan 2006 13:45:31 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034530.3178.91517.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implements a new freezer header file, separated from
suspend.h and sched.h so that 95 percent of the kernel doesn't need
to be recompiled if/when we modify the freezer implementation.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 include/linux/freezer.h |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
new file mode 100644
index 0000000..5663f24
--- /dev/null
+++ b/include/linux/freezer.h
@@ -0,0 +1,28 @@
+/* Freezer declarations */
+
+#define FREEZER_ON 0
+#define ABORT_FREEZING 1
+
+#define FREEZER_KERNEL_THREADS 0
+#define FREEZER_ALL_THREADS 1
+
+#ifdef CONFIG_PM
+extern unsigned long freezer_state;
+
+#define test_freezer_state(bit) test_bit(bit, &freezer_state)
+#define set_freezer_state(bit) set_bit(bit, &freezer_state)
+#define clear_freezer_state(bit) clear_bit(bit, &freezer_state)
+
+#define freezer_is_on() (test_freezer_state(FREEZER_ON))
+
+extern void do_freeze_process(struct notifier_block *nl);
+
+#else
+
+#define test_freezer_state(bit) (0)
+#define set_freezer_state(bit) do { } while(0)
+#define clear_freezer_state(bit) do { } while(0)
+
+#define freezer_is_on() (0)
+
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
