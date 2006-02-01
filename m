Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWBALnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWBALnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWBALlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:41:16 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:18651 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964869AbWBALky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:40:54 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 10/10] [Suspend2] Memory needed for modules.
Date: Wed, 01 Feb 2006 21:37:30 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060201113729.6320.96126.stgit@localhost.localdomain>
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Calculate the amount of memory required for the modules that will be used.
Utilised when preparing to suspend, to ensure that we have sufficient
memory available for doing our work.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index 9c27957..e7e7e93 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -38,6 +38,28 @@ unsigned long header_storage_for_modules
 	return bytes;
 }
 
+/*
+ * memory_for_modules
+ *
+ * Returns the amount of memory requested by modules for
+ * doing their work during the cycle.
+ */
+
+unsigned long memory_for_modules(void)
+{
+	unsigned long bytes = 0;
+	struct suspend_module_ops *this_module;
+
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (this_module->disabled)
+			continue;
+		if (this_module->memory_needed)
+			bytes += this_module->memory_needed();
+	}
+
+	return ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT);
+}
+
 /* find_module_given_name
  * Functionality :	Return a module (if found), given a pointer
  * 			to its name

--
Nigel Cunningham		nigel at suspend2 dot net
