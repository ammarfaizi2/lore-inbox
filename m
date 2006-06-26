Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933115AbWFZXoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933115AbWFZXoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933139AbWFZXoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:44:11 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:24991 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933128AbWFZWd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:58 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/16] [Suspend2] Core load routine.
Date: Tue, 27 Jun 2006 08:33:56 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223354.3832.516.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routine called when the Suspend2 core is loaded.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 429d2eb..f7138c1 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -895,4 +895,18 @@ static struct suspend_proc_data proc_par
 	},
 #endif
 };
-       
+ 
+static __init int core_load(void)
+{
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	printk("Suspend2 Core.\n");
+
+	suspend_initialise_module_lists();
+
+	for (i=0; i< numfiles; i++)
+		suspend_register_procfile(&proc_params[i]);
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
