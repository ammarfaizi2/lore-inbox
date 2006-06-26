Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933339AbWFZWpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933339AbWFZWpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933350AbWFZWmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:20 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:50871 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933340AbWFZWmQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:42:16 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 20/28] [Suspend2] Get swapwriter debug info.
Date: Tue, 27 Jun 2006 08:42:14 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224212.4975.81926.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fill a buffer with debug info for the swapwriter.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index f2940ea..3589b63 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -819,3 +819,31 @@ static unsigned long swapwriter_memory_n
 	return 1;
 }
 
+/* Print debug info
+ *
+ * Description:
+ */
+
+static int swapwriter_print_debug_stats(char *buffer, int size)
+{
+	int len = 0;
+	struct sysinfo sysinfo;
+	
+	if (suspend_active_writer != &swapwriterops) {
+		len = snprintf_used(buffer, size, "- Swapwriter inactive.\n");
+		return len;
+	}
+
+	len = snprintf_used(buffer, size, "- Swapwriter active.\n");
+	if (swapfilename[0])
+		len+= snprintf_used(buffer+len, size-len,
+			"  Attempting to automatically swapon: %s.\n", swapfilename);
+
+	si_swapinfo(&sysinfo);
+	
+	len+= snprintf_used(buffer+len, size-len, "  Swap available for image: %ld pages.\n",
+			sysinfo.freeswap + swapwriter_storage_allocated());
+
+	return len;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
