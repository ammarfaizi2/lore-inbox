Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbTBQKtF>; Mon, 17 Feb 2003 05:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbTBQKtF>; Mon, 17 Feb 2003 05:49:05 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:19590 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266971AbTBQKtE>; Mon, 17 Feb 2003 05:49:04 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Make sysctl vm subdir dependent on CONFIG_MMU
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030217105900.5E2683728@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon, 17 Feb 2003 19:59:00 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.61-uc0.orig/kernel/sysctl.c linux-2.5.61-uc0/kernel/sysctl.c
--- linux-2.5.61-uc0.orig/kernel/sysctl.c	2002-12-16 12:53:59.000000000 +0900
+++ linux-2.5.61-uc0/kernel/sysctl.c	2003-02-17 19:24:58.000000000 +0900
@@ -111,7 +111,9 @@
 	{ root_table, LIST_HEAD_INIT(root_table_header.ctl_entry) };
 
 static ctl_table kern_table[];
+#ifdef CONFIG_MMU
 static ctl_table vm_table[];
+#endif
 #ifdef CONFIG_NET
 extern ctl_table net_table[];
 #endif
@@ -148,7 +150,9 @@
 
 static ctl_table root_table[] = {
 	{CTL_KERN, "kernel", NULL, 0, 0555, kern_table},
+#ifdef CONFIG_MMU
 	{CTL_VM, "vm", NULL, 0, 0555, vm_table},
+#endif
 #ifdef CONFIG_NET
 	{CTL_NET, "net", NULL, 0, 0555, net_table},
 #endif
@@ -271,6 +275,7 @@
 static int one_hundred = 100;
 
 
+#ifdef CONFIG_MMU
 static ctl_table vm_table[] = {
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
@@ -321,6 +326,7 @@
 	 NULL, },
 	{0}
 };
+#endif /* CONFIG_MMU */
 
 static ctl_table proc_table[] = {
 	{0}
