Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264616AbTIDDce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbTIDDa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:30:58 -0400
Received: from dp.samba.org ([66.70.73.150]:22208 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264619AbTIDDaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:30:19 -0400
From: Rusty Trivial Russell <trivial@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] eliminate warnings in mtrr_if.c when !CONFIG_PROC_FS
Date: Thu, 04 Sep 2003 13:26:13 +1000
Message-Id: <20030904033019.3E4342C225@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Stephen Hemminger <shemminger@osdl.org>

  Patch against 2.6.0-test1 latest (post-bk2).  Get's rid of unused variable and function
  warnings if /proc is not configured on.

--- trivial-2.6.0-test4-bk5/arch/i386/kernel/cpu/mtrr/if.c.orig	2003-09-04 13:02:00.000000000 +1000
+++ trivial-2.6.0-test4-bk5/arch/i386/kernel/cpu/mtrr/if.c	2003-09-04 13:02:00.000000000 +1000
@@ -13,6 +13,7 @@
 /* RED-PEN: this is accessed without any locking */
 extern unsigned int *usage_table;
 
+#ifdef CONFIG_PROC_FS
 static int mtrr_seq_show(struct seq_file *seq, void *offset);
 
 #define FILE_FCOUNT(f) (((struct seq_file *)((f)->private_data))->private)
@@ -310,11 +311,9 @@
 	.release = mtrr_close,
 };
 
-#  ifdef CONFIG_PROC_FS
 
 static struct proc_dir_entry *proc_root_mtrr;
 
-#  endif			/*  CONFIG_PROC_FS  */
 
 static int mtrr_seq_show(struct seq_file *seq, void *offset)
 {
@@ -349,6 +348,8 @@
 	return 0;
 }
 
+#  endif			/*  CONFIG_PROC_FS  */
+
 static int __init mtrr_if_init(void)
 {
 #ifdef CONFIG_PROC_FS
-- 
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Stephen Hemminger <shemminger@osdl.org>: [PATCH] eliminate warnings in mtrr_if.c when !CONFIG_PROC_FS
