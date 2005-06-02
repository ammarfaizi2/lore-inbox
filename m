Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVFBINe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVFBINe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVFBIAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:00:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17607 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261198AbVFBH6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:58:54 -0400
Date: Thu, 2 Jun 2005 16:03:20 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 8/9] dlm: consistent ifdefs
Message-ID: <20050602080320.GH21570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="debug-ifdefs.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consistently handle the declarations of ifdef'ed debug functions in the
two places they occur.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/dlm_internal.h
===================================================================
--- linux.orig/drivers/dlm/dlm_internal.h	2005-06-02 13:04:51.696074128 +0800
+++ linux/drivers/dlm/dlm_internal.h	2005-06-02 13:11:20.554958592 +0800
@@ -80,14 +80,6 @@
 #define log_error(ls, fmt, args...) \
 	printk(KERN_ERR "dlm: %s: " fmt "\n", (ls)->ls_name , ##args)
 
-#ifdef CONFIG_DLM_DEBUG
-int dlm_create_debug_file(struct dlm_ls *ls);
-void dlm_delete_debug_file(struct dlm_ls *ls);
-#else
-static inline int dlm_create_debug_file(struct dlm_ls *ls) { return 0; }
-static inline void dlm_delete_debug_file(struct dlm_ls *ls) { }
-#endif
-
 #ifdef DLM_LOG_DEBUG
 #define log_debug(ls, fmt, args...) log_error(ls, fmt, ##args)
 #else
Index: linux/drivers/dlm/lockspace.c
===================================================================
--- linux.orig/drivers/dlm/lockspace.c	2005-06-02 12:55:58.290164152 +0800
+++ linux/drivers/dlm/lockspace.c	2005-06-02 13:12:01.091796056 +0800
@@ -23,6 +23,14 @@
 #include "memory.h"
 #include "lock.h"
 
+#ifdef CONFIG_DLM_DEBUG
+int dlm_create_debug_file(struct dlm_ls *ls);
+void dlm_delete_debug_file(struct dlm_ls *ls);
+#else
+static inline int dlm_create_debug_file(struct dlm_ls *ls) { return 0; }
+static inline void dlm_delete_debug_file(struct dlm_ls *ls) { }
+#endif
+
 static int			ls_count;
 static struct semaphore		ls_lock;
 static struct list_head		lslist;
Index: linux/drivers/dlm/main.c
===================================================================
--- linux.orig/drivers/dlm/main.c	2005-06-02 12:43:52.480503992 +0800
+++ linux/drivers/dlm/main.c	2005-06-02 13:12:43.582336512 +0800
@@ -23,14 +23,8 @@
 int dlm_register_debugfs(void);
 void dlm_unregister_debugfs(void);
 #else
-int dlm_register_debugfs(void)
-{
-	return 0;
-}
-
-void dlm_unregister_debugfs(void)
-{
-}
+static inline int dlm_register_debugfs(void) { return 0; }
+static inline void dlm_unregister_debugfs(void) { }
 #endif
 
 int dlm_node_ioctl_init(void);

--

