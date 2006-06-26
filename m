Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWFZQxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWFZQxv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWFZQxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:53:40 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:47238 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750893AbWFZQx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:53:28 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 09/11] [Suspend2] Get next suspend2 module in the pipeline.
Date: Tue, 27 Jun 2006 02:53:32 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165330.10957.67513.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
References: <20060626165301.10957.62592.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend2 modules are strung together in a pipeline. This function enables
one module in the pipeline to find out what the next module is, so that it
can pass its output to that module when writing, and request data from it
when reading.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index cd171a8..d7c2076 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -268,6 +268,26 @@ void suspend_cleanup_modules(int finishi
 	}
 }
 
+/*
+ * suspend_get_next_filter
+ *
+ * Get the next filter in the pipeline.
+ */
+struct suspend_module_ops *suspend_get_next_filter(struct suspend_module_ops *filter_sought)
+{
+	struct suspend_module_ops *last_filter = NULL, *this_filter = NULL;
+
+	list_for_each_entry(this_filter, &suspend_filters, type_list) {
+		if (this_filter->disabled)
+			continue;
+		if ((last_filter == filter_sought) || (!filter_sought))
+			return this_filter;
+		last_filter = this_filter;
+	}
+
+	return suspend_active_writer;
+}
+
 	return len;
 }
 

--
Nigel Cunningham		nigel at suspend2 dot net
