Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271137AbUJVBIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271137AbUJVBIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271146AbUJVBHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:07:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:60358 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271137AbUJVBDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:03:54 -0400
Date: Thu, 21 Oct 2004 18:03:45 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3][LSM] rename security_scaffolding_startup to security_init
Message-ID: <20041021180345.H2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename security_scaffolding_startup() to security_init().  It always
bothered me.

Signed-off-by: Chris Wright <chrisw@osdl.org>

 include/linux/security.h |    2 +-
 init/main.c              |    2 +-
 security/security.c      |    8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

===== include/linux/security.h 1.42 vs edited =====
--- 1.42/include/linux/security.h	2004-10-20 01:37:07 -07:00
+++ edited/include/linux/security.h	2004-10-21 16:36:30 -07:00
@@ -1903,7 +1903,7 @@
 }
 
 /* prototypes */
-extern int security_scaffolding_startup	(void);
+extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
 extern int unregister_security	(struct security_operations *ops);
 extern int mod_reg_security	(const char *name, struct security_operations *ops);
===== init/main.c 1.159 vs edited =====
--- 1.159/init/main.c	2004-10-08 21:09:14 -07:00
+++ edited/init/main.c	2004-10-21 16:35:35 -07:00
@@ -555,7 +555,7 @@
 	proc_caches_init();
 	buffer_init();
 	unnamed_dev_init();
-	security_scaffolding_startup();
+	security_init();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
===== security/security.c 1.10 vs edited =====
--- 1.10/security/security.c	2004-08-24 02:08:51 -07:00
+++ edited/security/security.c	2004-10-21 16:44:06 -07:00
@@ -18,7 +18,7 @@
 #include <linux/sched.h>
 #include <linux/security.h>
 
-#define SECURITY_SCAFFOLD_VERSION	"1.0.0"
+#define SECURITY_FRAMEWORK_VERSION	"1.0.0"
 
 /* things that live in dummy.c */
 extern struct security_operations dummy_security_ops;
@@ -49,13 +49,13 @@
 }
 
 /**
- * security_scaffolding_startup - initializes the security scaffolding framework
+ * security_init - initializes the security framework
  *
  * This should be called early in the kernel initialization sequence.
  */
-int __init security_scaffolding_startup (void)
+int __init security_init(void)
 {
-	printk (KERN_INFO "Security Scaffold v" SECURITY_SCAFFOLD_VERSION
+	printk (KERN_INFO "Security Framework v" SECURITY_FRAMEWORK_VERSION
 		" initialized\n");
 
 	if (verify (&dummy_security_ops)) {

