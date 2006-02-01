Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWBALmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWBALmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWBALlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:41:19 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:19163 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964835AbWBALkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:40:51 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 07/10] [Suspend2] Header storage for modules.
Date: Wed, 01 Feb 2006 21:37:24 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060201113723.6320.19646.stgit@localhost.localdomain>
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Calculate the space in an image header required for storing module
configuration data.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index dd53b27..7d56ce0 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -16,6 +16,27 @@ static int num_filters = 0, num_ui = 0;
 int num_writers = 0, num_modules = 0;
 
 /*
+ * header_storage_for_modules
+ *
+ * Returns the amount of space needed to store configuration
+ * data needed by the modules prior to copying back the original
+ * kernel. We can exclude data for pageset2 because it will be
+ * available anyway once the kernel is copied back.
+ */
+unsigned long header_storage_for_modules(void)
+{
+	struct suspend_module_ops *this_module;
+	unsigned long bytes = 0;
+	
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (this_module->disabled)
+			continue;
+		if (this_module->storage_needed)
+			bytes += this_module->storage_needed();
+	}
+
+	return bytes;
+}
  * suspend_register_module
  *
  * Register a module.

--
Nigel Cunningham		nigel at suspend2 dot net
