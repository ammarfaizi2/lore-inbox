Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWFZRAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWFZRAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWFZQxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:53:10 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:43910 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750812AbWFZQxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:08 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 03/11] [Suspend2] Get memory needed for Suspend2 modules.
Date: Tue, 27 Jun 2006 02:53:12 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165310.10957.73619.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Determine how much free memory should be available for Suspend2 modules to
do their work while reading and writing the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index 60c7c7b..ff9b9d7 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -49,3 +49,25 @@ unsigned long suspend_header_storage_for
 	return bytes + sizeof(struct suspend_module_header);
 }
 
+/*
+ * suspend_memory_for_modules
+ *
+ * Returns the amount of memory requested by modules for
+ * doing their work during the cycle.
+ */
+
+unsigned long suspend_memory_for_modules(void)
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

--
Nigel Cunningham		nigel at suspend2 dot net
