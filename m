Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030688AbWF0Es5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030688AbWF0Es5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030692AbWF0Esj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:48:39 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:48603 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030693AbWF0El6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:58 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 13/21] [Suspend2] Main message output.
Date: Tue, 27 Jun 2006 14:41:57 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044155.14883.41039.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Output one of the main messages describing our progress, possibly also
clearing the progress bar. These messages are printk'd if there is no
active userui.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 6542f3f..b11edb8 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -439,3 +439,30 @@ void abort_suspend(const char *fmt, ...)
 	}
 }
 
+/* suspend_prepare_status
+ * Description:	Prepare the 'nice display', drawing the header and version,
+ * 		along with the current action and perhaps also resetting the
+ * 		progress bar.
+ * Arguments:	
+ * 		int clearbar: Whether to reset the progress bar.
+ * 		const char *fmt, ...: The action to be displayed.
+ */
+void suspend_prepare_status(int clearbar, const char *fmt, ...)
+{
+	va_list args;
+
+	if (fmt) {
+		va_start(args, fmt);
+		lastheader_message_len = vsnprintf(lastheader, 512, fmt, args);
+		va_end(args);
+	}
+
+	if (clearbar)
+		suspend_update_status(0, 1, NULL);
+
+	__suspend_message(0, SUSPEND_STATUS, 1, lastheader, NULL);
+
+	if (ui_helper_data.pid == -1)
+		printk(KERN_EMERG "%s\n", lastheader);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
