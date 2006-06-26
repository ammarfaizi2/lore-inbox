Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWFZQsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWFZQsL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWFZQro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:47:44 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:35301 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750793AbWFZQrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:47:39 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 4/7] [Suspend2] Basic (do_suspend/do_resume) entries.
Date: Tue, 27 Jun 2006 02:47:43 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164742.10724.35295.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
References: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define the two basic proc entries for Suspend2. Without these, nothing
useful will be done ;).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/proc.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/kernel/power/proc.c b/kernel/power/proc.c
index cdbf9cf..85301a9 100644
--- a/kernel/power/proc.c
+++ b/kernel/power/proc.c
@@ -231,3 +231,28 @@ static int suspend_write_proc(struct fil
 	return result;
 }
 
+/* Non-module proc entries.
+ *
+ * This array contains entries that are automatically registered at
+ * boot. Modules and the console code register their own entries separately.
+ *
+ * NB: If you move do_suspend, change suspend_write_proc's test so that
+ * suspend_start_anything still gets a 1 when the user echos > do_suspend!
+ */
+
+static struct suspend_proc_data proc_params[] = {
+	{ .filename			= "do_suspend",
+	  .permissions			= PROC_WRITEONLY,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .write_proc			= suspend_main,
+	  .needs_storage_manager	= 2,
+	},
+
+	{ .filename			= "do_resume",
+	  .permissions			= PROC_WRITEONLY,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .write_proc			= __suspend_try_resume,
+	  .needs_storage_manager	= 2,
+	},
+};
+       

--
Nigel Cunningham		nigel at suspend2 dot net
