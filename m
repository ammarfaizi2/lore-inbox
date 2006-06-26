Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWFZXAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWFZXAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933280AbWFZWkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:40:23 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:28855 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933297AbWFZWkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:19 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 22/35] [Suspend2] Filewriter debug info routine.
Date: Tue, 27 Jun 2006 08:40:18 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224017.4685.58102.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fill a buffer with the debugging information that the filewriter provides.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 4df05c8..a4871c7 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -714,3 +714,26 @@ out:
 	return result;
 }
 
+/* Print debug info
+ *
+ * Description:
+ */
+
+static int filewriter_print_debug_stats(char *buffer, int size)
+{
+	int len = 0;
+	
+	if (suspend_active_writer != &filewriterops) {
+		len = snprintf_used(buffer, size, "- Filewriter inactive.\n");
+		return len;
+	}
+
+	len = snprintf_used(buffer, size, "- Filewriter active.\n");
+
+	len+= snprintf_used(buffer+len, size-len, "  Storage available for image: "
+			"%ld pages.\n",
+			filewriter_storage_allocated());
+
+	return len;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
