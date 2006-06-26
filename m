Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933170AbWFZXUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933170AbWFZXUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933240AbWFZXT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:19:59 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:52639 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933208AbWFZWhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:01 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 18/19] [Suspend2] Read pageset2.
Date: Tue, 27 Jun 2006 08:36:59 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223658.4219.46399.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
References: <20060626223557.4219.53030.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Re)read pageset2 data when cancelling a suspend after the atomic copy,
or when resuming.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/io.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/kernel/power/io.c b/kernel/power/io.c
index cd99bd8..6a8badf 100644
--- a/kernel/power/io.c
+++ b/kernel/power/io.c
@@ -971,3 +971,27 @@ out:
 	return output_buffer;
 }
 
+/* read_pageset2()
+ *
+ * Description:	Read in part or all of pageset2 of an image, depending upon
+ * 		whether we are suspending and have only overwritten a portion
+ * 		with pageset1 pages, or are resuming and need to read them 
+ * 		all.
+ * Arguments:	Int. Boolean. Read only pages which would have been
+ * 		overwritten by pageset1?
+ * Returns:	Int. Zero if no error, otherwise the error value.
+ */
+int read_pageset2(int overwrittenpagesonly)
+{
+	int result = 0;
+
+	if (!pagedir2.pageset_size)
+		return 0;
+
+	result = read_pageset(&pagedir2, 2, overwrittenpagesonly);
+
+	suspend_update_status(100, 100, NULL);
+	suspend_cond_pause(1, "Pagedir 2 read.");
+
+	return result;
+}

--
Nigel Cunningham		nigel at suspend2 dot net
