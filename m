Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933127AbWFZXlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933127AbWFZXlB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933144AbWFZXk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:40:59 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:30623 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933111AbWFZWef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:35 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 6/9] [Suspend2] Get nonconflicting page.
Date: Tue, 27 Jun 2006 08:34:33 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223431.3963.46405.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
References: <20060626223412.3963.1484.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the atomic restore, get a page that can safely be used
during the restore - ie, that isn't a location of a page that will be
restored.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pagedir.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pagedir.c b/kernel/power/pagedir.c
index c23ca58..4cdc0ef 100644
--- a/kernel/power/pagedir.c
+++ b/kernel/power/pagedir.c
@@ -270,3 +270,21 @@ void suspend_mark_pages_for_pageset2(voi
 
 }
 
+/* suspend_get_nonconflicting_page
+ *
+ * Description: Gets order zero pages that won't be overwritten
+ *		while copying the original pages.
+ */
+
+unsigned long suspend_get_nonconflicting_page(void)
+{
+	struct page *page;
+
+	do {
+		page = alloc_pages(GFP_ATOMIC | __GFP_NOWARN | __GFP_ZERO, 0);
+		BUG_ON(!page);
+	} while(PagePageset1(page));
+
+	return (unsigned long) page_address(page);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
