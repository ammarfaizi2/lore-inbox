Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWFZRBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWFZRBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWFZRAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:00:51 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:44678 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750811AbWFZQxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:12 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 04/11] [Suspend2] Find a suspend2 module given its name
Date: Tue, 27 Jun 2006 02:53:15 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165314.10957.4181.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the name of a Suspend2 module, return a pointer to it's struct
suspend_module_ops.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index ff9b9d7..c18b5fb 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -71,3 +71,22 @@ unsigned long suspend_memory_for_modules
 	return ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT);
 }
 
+/* suspend_find_module_given_name
+ * Functionality :	Return a module (if found), given a pointer
+ * 			to its name
+ */
+
+struct suspend_module_ops *suspend_find_module_given_name(char *name)
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

--
Nigel Cunningham		nigel at suspend2 dot net
