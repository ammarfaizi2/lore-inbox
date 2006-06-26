Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWFZXBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWFZXBC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWFZXAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:00:20 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:29367 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933300AbWFZWkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:23 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 23/35] [Suspend2] Filewriter storage needed.
Date: Tue, 27 Jun 2006 08:40:22 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224020.4685.63211.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the amount of space in the image header required by the filewriter.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index a4871c7..4f9d6f5 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -737,3 +737,23 @@ static int filewriter_print_debug_stats(
 	return len;
 }
 
+/*
+ * Storage needed
+ *
+ * Returns amount of space in the image header required
+ * for the filewriter's data.
+ *
+ * We ensure the space is allocated, but actually save the
+ * data from write_header_init and therefore don't also define a
+ * save_config_info routine.
+ */
+static unsigned long filewriter_storage_needed(void)
+{
+	return sig_size + strlen(filewriter_target) + 1 +
+		3 * sizeof(struct extent_iterate_saved_state) +
+		sizeof(devinfo) +
+		sizeof(struct extent_chain) - 2 * sizeof(void *) +
+		(2 * sizeof(unsigned long) *
+		 (block_chain.allocs - block_chain.frees));
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
