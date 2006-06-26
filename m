Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933304AbWFZW5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933304AbWFZW5A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933302AbWFZW4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:56:37 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:29879 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933297AbWFZWk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:27 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 24/35] [Suspend2] Invalidate filewriter image.
Date: Tue, 27 Jun 2006 08:40:25 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224024.4685.2086.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Invalidate an image stored by the filewriter.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 4f9d6f5..04f9cd0 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -757,3 +757,21 @@ static unsigned long filewriter_storage_
 		 (block_chain.allocs - block_chain.frees));
 }
 
+/* 
+ * filewriter_invalidate_image
+ * 
+ */
+static int filewriter_invalidate_image(void)
+{
+	int result;
+
+	if (nr_suspends > 0)
+		filewriter_release_storage();
+
+	result = filewriter_signature_op(INVALIDATE);
+	if (result == 1 && !nr_suspends)
+		printk(KERN_WARNING name_suspend "Image invalidated.\n");
+
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
