Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271147AbUJVBNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271147AbUJVBNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271105AbUJVBJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:09:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:47818 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271052AbUJVBH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:07:26 -0400
Date: Thu, 21 Oct 2004 18:07:24 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3][LSM] Lindent security/security.c
Message-ID: <20041021180723.J2357@build.pdx.osdl.net>
References: <20041021180345.H2357@build.pdx.osdl.net> <20041021180451.I2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041021180451.I2357@build.pdx.osdl.net>; from chrisw@osdl.org on Thu, Oct 21, 2004 at 06:04:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lindent security/security.c.

Signed-off-by: Chris Wright <chrisw@osdl.org>

 security.c |   58 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

--- linus-2.6/security/security.c~Lindent	2004-10-21 17:16:31.167148568 -0700
+++ linus-2.6/security/security.c	2004-10-21 17:16:46.739781168 -0700
@@ -22,16 +22,16 @@
 
 /* things that live in dummy.c */
 extern struct security_operations dummy_security_ops;
-extern void security_fixup_ops (struct security_operations *ops);
+extern void security_fixup_ops(struct security_operations *ops);
 
 struct security_operations *security_ops;	/* Initialized to NULL */
 
-static inline int verify (struct security_operations *ops)
+static inline int verify(struct security_operations *ops)
 {
 	/* verify the security_operations structure exists */
 	if (!ops)
 		return -EINVAL;
-	security_fixup_ops (ops);
+	security_fixup_ops(ops);
 	return 0;
 }
 
@@ -40,7 +40,7 @@
 	initcall_t *call;
 	call = &__security_initcall_start;
 	while (call < &__security_initcall_end) {
-		(*call)();
+		(*call) ();
 		call++;
 	}
 }
@@ -52,12 +52,12 @@
  */
 int __init security_init(void)
 {
-	printk (KERN_INFO "Security Framework v" SECURITY_FRAMEWORK_VERSION
-		" initialized\n");
+	printk(KERN_INFO "Security Framework v" SECURITY_FRAMEWORK_VERSION
+	       " initialized\n");
 
-	if (verify (&dummy_security_ops)) {
-		printk (KERN_ERR "%s could not verify "
-			"dummy_security_ops structure.\n", __FUNCTION__);
+	if (verify(&dummy_security_ops)) {
+		printk(KERN_ERR "%s could not verify "
+		       "dummy_security_ops structure.\n", __FUNCTION__);
 		return -EIO;
 	}
 
@@ -79,11 +79,11 @@
  * If there is already a security module registered with the kernel,
  * an error will be returned.  Otherwise 0 is returned on success.
  */
-int register_security (struct security_operations *ops)
+int register_security(struct security_operations *ops)
 {
-	if (verify (ops)) {
+	if (verify(ops)) {
 		printk(KERN_DEBUG "%s could not verify "
-			"security_operations structure.\n", __FUNCTION__);
+		       "security_operations structure.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
@@ -106,12 +106,12 @@
  * an error is returned.  Otherwise the default security options is set to the
  * the dummy_security_ops structure, and 0 is returned.
  */
-int unregister_security (struct security_operations *ops)
+int unregister_security(struct security_operations *ops)
 {
 	if (ops != security_ops) {
-		printk (KERN_INFO "%s: trying to unregister "
-			"a security_opts structure that is not "
-			"registered, failing.\n", __FUNCTION__);
+		printk(KERN_INFO "%s: trying to unregister "
+		       "a security_opts structure that is not "
+		       "registered, failing.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
@@ -132,21 +132,21 @@
  * The return value depends on the currently loaded security module, with 0 as
  * success.
  */
-int mod_reg_security (const char *name, struct security_operations *ops)
+int mod_reg_security(const char *name, struct security_operations *ops)
 {
-	if (verify (ops)) {
-		printk (KERN_INFO "%s could not verify "
-			"security operations.\n", __FUNCTION__);
+	if (verify(ops)) {
+		printk(KERN_INFO "%s could not verify "
+		       "security operations.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
 	if (ops == security_ops) {
-		printk (KERN_INFO "%s security operations "
-			"already registered.\n", __FUNCTION__);
+		printk(KERN_INFO "%s security operations "
+		       "already registered.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
-	return security_ops->register_security (name, ops);
+	return security_ops->register_security(name, ops);
 }
 
 /**
@@ -162,15 +162,15 @@
  * The return value depends on the currently loaded security module, with 0 as
  * success.
  */
-int mod_unreg_security (const char *name, struct security_operations *ops)
+int mod_unreg_security(const char *name, struct security_operations *ops)
 {
 	if (ops == security_ops) {
-		printk (KERN_INFO "%s invalid attempt to unregister "
-			" primary security ops.\n", __FUNCTION__);
+		printk(KERN_INFO "%s invalid attempt to unregister "
+		       " primary security ops.\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
-	return security_ops->unregister_security (name, ops);
+	return security_ops->unregister_security(name, ops);
 }
 
 /**
@@ -183,9 +183,9 @@
  * This allows the security module to implement the capable function call
  * however it chooses to.
  */
-int capable (int cap)
+int capable(int cap)
 {
-	if (security_ops->capable (current, cap)) {
+	if (security_ops->capable(current, cap)) {
 		/* capability denied */
 		return 0;
 	}
