Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWFZQzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWFZQzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWFZQyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:54:44 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:49798 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750909AbWFZQyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:54:07 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 2/9] [Suspend2] Extent allocation routines.
Date: Tue, 27 Jun 2006 02:54:11 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165410.11065.34890.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add routines to get and put extents.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/extent.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/kernel/power/extent.c b/kernel/power/extent.c
index 4027bb1..2fb6a23 100644
--- a/kernel/power/extent.c
+++ b/kernel/power/extent.c
@@ -17,3 +17,33 @@
 
 int suspend_extents_allocated = 0;
 
+/* suspend_get_extent
+ *
+ * Returns a free extent. May fail, returning NULL instead.
+ */
+static struct extent *suspend_get_extent(void)
+{
+	struct extent *result;
+	
+	if (!(result = kmalloc(sizeof(struct extent), GFP_ATOMIC)))
+		return NULL;
+
+	suspend_extents_allocated++;
+	result->minimum = result->maximum = 0;
+	result->next = NULL;
+
+	return result;
+}
+
+/* suspend_put_extent.
+ *
+ * Frees an extent. Assumes unlinking is done by the caller.
+ */
+void suspend_put_extent(struct extent *extent)
+{
+	BUG_ON(!extent);
+
+	kfree(extent);
+	suspend_extents_allocated--;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
