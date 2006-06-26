Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933148AbWFZXmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148AbWFZXmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933154AbWFZXlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:41:00 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:26527 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933115AbWFZWeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:08 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 15/16] [Suspend2] __init routines
Date: Tue, 27 Jun 2006 08:34:06 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223405.3832.27744.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for resume2=, noresume2 and retry_resume command line options.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 85307c6..78c77d6 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -1024,3 +1024,43 @@ void suspend2_try_suspend(void)
 	suspend_finish_anything(0);
 }
 
+/* --  Commandline Parameter Handling ---
+ *
+ * Resume setup: obtain the storage device.
+ */
+static int __init resume2_setup(char *str)
+{
+	if (!*str)
+		return 0;
+	
+	strncpy(resume2_file, str, 255);
+	return 0;
+}
+
+/*
+ * Allow the user to set the debug parameter from lilo, prior to resuming.
+ */
+/*
+ * Allow the user to specify that we should ignore any image found and
+ * invalidate the image if necesssary. This is equivalent to running
+ * the task queue and a sync and then turning off the power. The same
+ * precautions should be taken: fsck if you're not journalled.
+ */
+static int __init noresume2_setup(char *str)
+{
+	set_suspend_state(SUSPEND_NORESUME_SPECIFIED);
+	return 0;
+}
+
+static int __init suspend_retry_resume_setup(char *str)
+{
+	set_suspend_state(SUSPEND_RETRY_RESUME);
+	return 0;
+}
+
+__setup("noresume2", noresume2_setup);
+__setup("resume2=", resume2_setup);
+__setup("suspend_retry_resume", suspend_retry_resume_setup);
+
+late_initcall(core_load);
+EXPORT_SYMBOL(suspend_state);

--
Nigel Cunningham		nigel at suspend2 dot net
