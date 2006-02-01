Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWBALnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWBALnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBALlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:41:18 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:18651 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964855AbWBALkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:40:52 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 09/10] [Suspend2] Append module debug info to a buffer.
Date: Wed, 01 Feb 2006 21:37:28 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060201113727.6320.22089.stgit@localhost.localdomain>
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Append the (textual) debugging output of each non-disabled module to a
buffer. This output should be short, so we don't get carried away
supporting multiple pages of output.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index 63f9dbb..9c27957 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -57,6 +57,30 @@ struct suspend_module_ops *find_module_g
 	return found_module;
 }
 
+/*
+ * print_module_debug_info
+ * Functionality   : Get debugging info from modules into a buffer.
+ */
+int print_module_debug_info(char *buffer, int buffer_size)
+{
+	struct suspend_module_ops *this_module;
+	int len = 0;
+
+	list_for_each_entry(this_module, &suspend_modules, module_list) {
+		if (this_module->disabled)
+			continue;
+		if (this_module->print_debug_info) {
+			int result;
+			result = this_module->print_debug_info(buffer + len, 
+					buffer_size - len);
+			len += result;
+		}
+	}
+
+	return len;
+}
+
+/*
  * suspend_register_module
  *
  * Register a module.

--
Nigel Cunningham		nigel at suspend2 dot net
