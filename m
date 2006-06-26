Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWFZQss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWFZQss (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWFZQsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:48:17 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:35813 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750811AbWFZQrn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:47:43 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 5/7] [Suspend2] Initialise the proc directories & basic entries.
Date: Tue, 27 Jun 2006 02:47:47 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164745.10724.3069.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
References: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the Suspend2 proc entries - create the directory and register
the do_suspend and do_resume files.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/proc.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/kernel/power/proc.c b/kernel/power/proc.c
index 85301a9..dad818f 100644
--- a/kernel/power/proc.c
+++ b/kernel/power/proc.c
@@ -256,3 +256,28 @@ static struct suspend_proc_data proc_par
 	},
 };
        
+/* suspend_initialise_proc
+ *
+ * Initialise the /proc/suspend2 directory.
+ */
+
+static void suspend_initialise_proc(void)
+{
+	int i;
+	int numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+	
+	if (suspend_proc_initialised)
+		return;
+
+	suspend_dir = proc_mkdir("suspend2", NULL);
+	
+	BUG_ON(!suspend_dir);
+
+	INIT_LIST_HEAD(&suspend_proc_entries);
+
+	suspend_proc_initialised = 1;
+
+	for (i=0; i< numfiles; i++)
+		suspend_register_procfile(&proc_params[i]);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
