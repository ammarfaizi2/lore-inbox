Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933356AbWFZWmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933356AbWFZWmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933346AbWFZWm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:26 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:51383 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933348AbWFZWmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:19 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 21/28] [Suspend2] Get swapwriter image storage needed.
Date: Tue, 27 Jun 2006 08:42:17 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224216.4975.17794.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the amount of space in the image header needed for swapwriter
configuration info.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 3589b63..ba6ed75 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -847,3 +847,28 @@ static int swapwriter_print_debug_stats(
 	return len;
 }
 
+/*
+ * Storage needed
+ *
+ * Returns amount of space in the swap header required
+ * for the swapwriter's data. This ignores the links between
+ * pages, which we factor in when allocating the space.
+ *
+ * We ensure the space is allocated, but actually save the
+ * data from write_header_init and therefore don't also define a
+ * save_config_info routine.
+ */
+static unsigned long swapwriter_storage_needed(void)
+{
+	int i, result;
+	result = sizeof(suspend_writer_posn_save) + sizeof(devinfo);
+
+	for (i = 0; i < MAX_SWAPFILES; i++) {
+		result += 3 * sizeof(int);
+		result += (2 * sizeof(unsigned long) * 
+			(block_chain[i].allocs - block_chain[i].frees));
+	}
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
