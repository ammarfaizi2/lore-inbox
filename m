Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933243AbWFZWiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933243AbWFZWiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933234AbWFZWiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:38:23 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:59807 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933214AbWFZWhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:37:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/32] [Suspend2] Prepare & cleanup readahead pages.
Date: Tue, 27 Jun 2006 08:37:49 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223747.4376.10216.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
References: <20060626223706.4376.96042.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate and cleanup pages used for readahead.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_block_io.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_block_io.c b/kernel/power/suspend_block_io.c
index f14939e..a1fcacb 100644
--- a/kernel/power/suspend_block_io.c
+++ b/kernel/power/suspend_block_io.c
@@ -414,3 +414,25 @@ static int suspend_readahead_ready(int r
 	return test_bit(bit, &suspend_readahead_flags[index]);
 }
 
+/* suspend_readahead_prepare
+ * Set up for doing readahead on an image */
+static int suspend_prepare_readahead(int index)
+{
+	unsigned long new_page = get_zeroed_page(GFP_ATOMIC);
+
+	if(!new_page)
+		return -ENOMEM;
+
+	suspend_readahead_pages[index] = virt_to_page(new_page);
+	return 0;
+}
+
+/* suspend_readahead_cleanup
+ * Clean up structures used for readahead */
+static void suspend_cleanup_readahead(int page)
+{
+	__free_page(suspend_readahead_pages[page]);
+	suspend_readahead_pages[page] = 0;
+	return;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
