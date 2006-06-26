Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933142AbWFZXli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933142AbWFZXli (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933115AbWFZXlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:41:06 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:26015 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933142AbWFZWeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:04 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 14/16] [Suspend2] Try to suspend.
Date: Tue, 27 Jun 2006 08:34:03 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223402.3832.75140.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Called when /proc/suspend2/do_suspend is written to. It is essentially a
wrapper around suspend_main(), invoking the start_anything and
finish_anything routines first.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0f751d1..85307c6 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -1008,3 +1008,19 @@ void suspend2_try_resume(void)
 	suspend_finish_anything(0);
 }
 
+/*
+ * suspend2_try_suspend
+ * Functionality   : Wrapper around suspend_main.
+ * Called From     : drivers/acpi/sleep/main.c
+ *                   kernel/reboot.c
+ */
+void suspend2_try_suspend(void)
+{
+	if (suspend_start_anything(0))
+		return;
+
+	suspend_main();
+
+	suspend_finish_anything(0);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
