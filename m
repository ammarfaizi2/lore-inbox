Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933401AbWF0EyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933401AbWF0EyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933412AbWF0ElK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:10 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:36827 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933411AbWF0Ekk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:40 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/13] [Suspend2] Utility function for testing storage managers.
Date: Tue, 27 Jun 2006 14:40:39 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044037.14778.61097.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
References: <20060627044025.14778.17719.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a means whereby a developer (via a proc entry) can test a storage
manager. Invoke the prepare, activate, deactivate and cleanup routines in
that order.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/storage.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/kernel/power/storage.c b/kernel/power/storage.c
index 71b8c02..c007a8e 100644
--- a/kernel/power/storage.c
+++ b/kernel/power/storage.c
@@ -130,3 +130,21 @@ int suspend_deactivate_storage(int force
 	return 0;
 }
 
+#ifdef CONFIG_PM_DEBUG
+static void storage_manager_simulate(void)
+{
+	printk("--- Storage manager simulate ---\n");
+	suspend_prepare_usm();
+	schedule();
+	printk("--- Activate storage 1 ---\n");
+	suspend_activate_storage(1);
+	schedule();
+	printk("--- Deactivate storage 1 ---\n");
+	suspend_deactivate_storage(1);
+	schedule();
+	printk("--- Cleanup usm ---\n");
+	suspend_cleanup_usm();
+	schedule();
+	printk("--- Storage manager simulate ends ---\n");
+}
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
