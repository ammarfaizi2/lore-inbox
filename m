Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWBALlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWBALlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBALlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:41:21 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:18651 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964833AbWBALkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:40:49 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 05/10] [Suspend2] Get next module.
Date: Wed, 01 Feb 2006 21:37:21 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060201113720.6320.16737.stgit@localhost.localdomain>
In-Reply-To: <20060201113710.6320.68289.stgit@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Given a current (possibly NULL) pointer to a module, find the next module
in the pipeline.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/modules.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/kernel/power/modules.c b/kernel/power/modules.c
index eee5678..a7c3c38 100644
--- a/kernel/power/modules.c
+++ b/kernel/power/modules.c
@@ -165,3 +165,23 @@ void suspend2_cleanup_modules(int finish
 		}
 	}
 }
+
+/*
+ * get_next_filter
+ *
+ * Get the next filter in the pipeline.
+ */
+struct suspend_module_ops *get_next_filter(struct suspend_module_ops *filter_sought)
+{
+	struct suspend_module_ops *last_filter = NULL, *this_filter = NULL;
+
+	list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
+		if (this_filter->disabled)
+			continue;
+		if ((last_filter == filter_sought) || (!filter_sought))
+			return this_filter;
+		last_filter = this_filter;
+	}
+
+	return active_writer;
+}

--
Nigel Cunningham		nigel at suspend2 dot net
