Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWBALlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWBALlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWBALlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:41:14 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:19675 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964887AbWBALky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:40:54 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 08/10] [Suspend2] Find a module given its name
Date: Wed, 01 Feb 2006 21:37:26 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060201113725.6320.53709.stgit@localhost.localdomain>
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Given the name of a module, return a pointer to it, or NULL if not found.
This is used when reloading the configuration data at resume time.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index 7d56ce0..63f9dbb 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -37,6 +37,26 @@ unsigned long header_storage_for_modules
 
 	return bytes;
 }
+
+/* find_module_given_name
+ * Functionality :	Return a module (if found), given a pointer
+ * 			to its name
+ */
+
+struct suspend_module_ops *find_module_given_name(char *name)
+{
+	struct suspend_module_ops *this_module, *found_module = NULL;
+	
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (!strcmp(name, this_module->name)) {
+			found_module = this_module;
+			break;
+		}			
+	}
+
+	return found_module;
+}
+
  * suspend_register_module
  *
  * Register a module.

--
Nigel Cunningham		nigel at suspend2 dot net
