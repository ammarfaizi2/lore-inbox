Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVEQPfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVEQPfM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVEQPfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:35:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57017 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261644AbVEQPbL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:31:11 -0400
Date: Tue, 17 May 2005 10:31:06 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [patch 6/7] BSD Secure Levels: trivial code and comment changes
Message-ID: <20050517153106.GE2944@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517152303.GA2814@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the sixth in a series of seven patches to the BSD Secure
Levels LSM.  It makes several trivial changes to make the code and
comments consistent.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-16 16:29:19.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-16 16:31:36.000000000 -0500
@@ -2,12 +2,12 @@
  * BSD Secure Levels LSM
  *
  * Maintainers:
- *	Michael A. Halcrow <mike@halcrow.us>
- *	Serge Hallyn <hallyn@cs.wm.edu>
+ *	Michael A. Halcrow <mhalcrow@us.ibm.com>
+ *	Serge Hallyn <serue@us.ibm.com>
  *
  * Copyright (c) 2001 WireX Communications, Inc <chris@wirex.com>
  * Copyright (c) 2001 Greg Kroah-Hartman <greg@kroah.com>
- * Copyright (c) 2002 International Business Machines <robb@austin.ibm.com>
+ * Copyright (c) 2002 International Business Machines <mhalcrow@us.ibm.com>
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License as published by
@@ -30,9 +30,9 @@
 #include <linux/proc_fs.h>
 #include <linux/kobject.h>
 #include <linux/crypto.h>
-#include <asm/scatterlist.h>
 #include <linux/gfp.h>
 #include <linux/sysfs.h>
+#include <asm/scatterlist.h>
 
 #define SHA1_DIGEST_SIZE 20
 
@@ -52,7 +52,9 @@
 module_param(initlvl, int, 0);
 MODULE_PARM_DESC(initlvl, "Initial secure level (defaults to 1)");
 
-/* Module parameter that defines the verbosity level */
+/**
+ * Module parameter that defines the verbosity level.
+ */
 static int verbosity;
 module_param(verbosity, int, 0);
 MODULE_PARM_DESC(verbosity, "Initial verbosity level (0 or 1; defaults to "
@@ -67,7 +69,6 @@
  * not a good idea to use this parameter when loading seclvl from a
  * script; use sha1_passwd instead.
  */
-
 #define MAX_PASSWD_SIZE	32
 static char passwd[MAX_PASSWD_SIZE];
 module_param_string(passwd, passwd, sizeof(passwd), 0);
@@ -93,9 +94,9 @@
 		 "sets seclvl=0 when plaintext password is written to "
 		 "(sysfs mount point)/seclvl/passwd\n");
 
-static int hideHash = 1;
-module_param(hideHash, int, 0);
-MODULE_PARM_DESC(hideHash, "When set to 0, reading seclvl/passwd from sysfs "
+static int hide_hash = 1;
+module_param(hide_hash, int, 0);
+MODULE_PARM_DESC(hide_hash, "When set to 0, reading seclvl/passwd from sysfs "
 		 "will return the SHA1-hashed value of the password that "
 		 "lowers the secure level to 0.\n");
 
@@ -166,7 +167,7 @@
 }
 
 /**
- * Callback function pointers for show and store
+ * Callback function pointers for show and store.
  */
 static struct sysfs_ops seclvlfs_sysfs_ops = {
 	.show = seclvl_attr_show,
@@ -185,7 +186,7 @@
 static int seclvl;
 
 /**
- * flag to keep track of how we were registered
+ * Flag to keep track of how we were registered.
  */
 static int secondary;
 
@@ -212,7 +213,7 @@
 
 /**
  * Called whenever the user reads the sysfs handle to this kernel
- * object
+ * object.
  */
 static ssize_t seclvl_read_file(struct seclvl_obj *obj, char *buff)
 {
@@ -220,7 +221,7 @@
 }
 
 /**
- * security level advancement rules:
+ * Security level advancement rules:
  *   Valid levels are -1 through 2, inclusive.
  *   From -1, stuck.  [ in case compiled into kernel ]
  *   From 0 or above, can only increment.
@@ -272,28 +273,28 @@
 	return count;
 }
 
-/* Generate sysfs_attr_seclvl */
+/**
+ * Generate sysfs_attr_seclvl.
+ */
 static struct seclvl_attribute sysfs_attr_seclvl =
 __ATTR(seclvl, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_file,
        seclvl_write_file);
 
-static unsigned char hashedPassword[SHA1_DIGEST_SIZE];
+static unsigned char hashed_password[SHA1_DIGEST_SIZE];
 
 /**
  * Called whenever the user reads the sysfs passwd handle.
  */
 static ssize_t seclvl_read_passwd(struct seclvl_obj *obj, char *buff)
 {
-	/* So just how good *is* your password? :-) */
 	char tmp[3];
 	int i = 0;
 	buff[0] = '\0';
-	if (hideHash) {
-		/* Security through obscurity */
+	if (hide_hash) {
 		return 0;
 	}
 	while (i < SHA1_DIGEST_SIZE) {
-		snprintf(tmp, 3, "%02x", hashedPassword[i]);
+		snprintf(tmp, 3, "%02x", hashed_password[i]);
 		strncat(buff, tmp, 2);
 		i++;
 	}
@@ -325,8 +326,8 @@
 			      "SHA1\n", __FUNCTION__);
 		return -ENOSYS;
 	}
-	// Just get a new page; don't play around with page boundaries
-	// and scatterlists.
+	/* Just get a new page; don't play around with page boundaries
+	 * and scatterlists. */
 	pg_virt_addr = (char *)__get_free_page(GFP_KERNEL);
 	if (!pg_virt_addr) {
 		seclvl_printk(0, KERN_ERR "%s: Out of memory\n", __FUNCTION__);
@@ -377,7 +378,7 @@
 		return rc;
 	}
 	for (i = 0; i < SHA1_DIGEST_SIZE; i++) {
-		if (hashedPassword[i] != tmp[i]) {
+		if (hashed_password[i] != tmp[i]) {
 			return -EPERM;
 		}
 	}
@@ -387,7 +388,9 @@
 	return count;
 }
 
-/* Generate sysfs_attr_passwd */
+/**
+ * Generate sysfs_attr_passwd.
+ */
 static struct seclvl_attribute sysfs_attr_passwd =
 __ATTR(passwd, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_passwd,
        seclvl_write_passwd);
@@ -431,7 +434,7 @@
 				      "denied in seclvl [%d]\n", __FUNCTION__,
 				      seclvl);
 			return -EPERM;
-		} else if (cap == CAP_SYS_RAWIO) {	// Somewhat broad...
+		} else if (cap == CAP_SYS_RAWIO) { /* Somewhat broad */
 			seclvl_printk(1, KERN_WARNING "%s: Attempt to perform "
 				      "raw I/O while in secure level [%d] "
 				      "denied\n", __FUNCTION__, seclvl);
@@ -612,7 +615,7 @@
 }
 
 /**
- * Cannot unmount in secure level 2
+ * Cannot unmount in secure level 2.
  */
 static int seclvl_umount(struct vfsmount *mnt, int flags)
 {
@@ -640,12 +643,12 @@
 };
 
 /**
- * Process the password-related module parameters
+ * Process the password-related module parameters.
  */
-static int processPassword(void)
+static int process_password(void)
 {
 	int rc = 0;
-	hashedPassword[0] = '\0';
+	hashed_password[0] = '\0';
 	if (*passwd) {
 		if (*sha1_passwd) {
 			seclvl_printk(0, KERN_ERR "%s: Error: Both "
@@ -654,15 +657,15 @@
 				      "exclusive.\n", __FUNCTION__);
 			return -EINVAL;
 		}
-		if ((rc = plaintext_to_sha1(hashedPassword, passwd,
+		if ((rc = plaintext_to_sha1(hashed_password, passwd,
 					    strlen(passwd)))) {
 			seclvl_printk(0, KERN_ERR "%s: Error: SHA1 support "
 				      "not in kernel\n", __FUNCTION__);
 			return rc;
 		}
-		/* All static data goes to the BSS, which zero's the
+		/* All static data goes to the BSS, which wipes the
 		 * plaintext password out for us. */
-	} else if (*sha1_passwd) {	// Base 16
+	} else if (*sha1_passwd) { /* Base 16 */
 		int i;
 		i = strlen(sha1_passwd);
 		if (i != (SHA1_DIGEST_SIZE * 2)) {
@@ -677,7 +680,7 @@
 			unsigned char tmp;
 			tmp = sha1_passwd[i + 2];
 			sha1_passwd[i + 2] = '\0';
-			hashedPassword[i / 2] = (unsigned char)
+			hashed_password[i / 2] = (unsigned char)
 			    simple_strtol(&sha1_passwd[i], NULL, 16);
 			sha1_passwd[i + 2] = tmp;
 		}
@@ -686,9 +689,9 @@
 }
 
 /**
- * Sysfs registrations
+ * Sysfs registrations.
  */
-static int doSysfsRegistrations(void)
+static int do_sysfs_registrations(void)
 {
 	int rc = 0;
 	if ((rc = subsystem_register(&seclvl_subsys))) {
@@ -725,7 +728,7 @@
 		goto exit;
 	}
 	seclvl = initlvl;
-	if ((rc = processPassword())) {
+	if ((rc = process_password())) {
 		seclvl_printk(0, KERN_ERR "%s: Error processing the password "
 			      "module parameter(s): rc = [%d]\n", __FUNCTION__,
 			      rc);
@@ -745,7 +748,7 @@
 		}		/* if primary module registered */
 		secondary = 1;
 	}			/* if we registered ourselves with the security framework */
-	if ((rc = doSysfsRegistrations())) {
+	if ((rc = do_sysfs_registrations())) {
 		seclvl_printk(0, KERN_ERR "%s: Error registering with sysfs\n",
 			      __FUNCTION__);
 		goto exit;
@@ -782,6 +785,6 @@
 module_init(seclvl_init);
 module_exit(seclvl_exit);
 
-MODULE_AUTHOR("Michael A. Halcrow <mike@halcrow.us>");
+MODULE_AUTHOR("Michael A. Halcrow <mhalcrow@us.ibm.com>");
 MODULE_DESCRIPTION("LSM implementation of the BSD Secure Levels");
 MODULE_LICENSE("GPL");
