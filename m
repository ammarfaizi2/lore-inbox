Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVBGTuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVBGTuZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVBGTs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:48:59 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:28651 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261271AbVBGTfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:35:39 -0500
Date: Mon, 7 Feb 2005 13:35:19 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [PATCH] BSD Secure Levels: nits, 2.6.11-rc2-mm1 (6/8)
Message-ID: <20050207193518.GE834@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050207192108.GA776@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20050207192108.GA776@halcrow.us>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the sixth in a series of eight patches to the BSD Secure
Levels LSM.  It makes several trivial changes to make the code
consistent.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="seclvl_nits.patch"

Index: linux-2.6.11-rc2-mm1-modules/security/seclvl.c
===================================================================
--- linux-2.6.11-rc2-mm1-modules.orig/security/seclvl.c	2005-02-03 15:41:46.043754544 -0600
+++ linux-2.6.11-rc2-mm1-modules/security/seclvl.c	2005-02-03 15:47:52.249082872 -0600
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
 
@@ -93,9 +93,9 @@
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
 
@@ -123,7 +123,7 @@
 struct subsystem seclvl_subsys;
 
 struct seclvl_obj {
-	char *name;
+	char * name;
 	struct list_head slot_list;
 	struct kobject kobj;
 };
@@ -147,20 +147,20 @@
  * unique for "passwd" and "seclvl".
  */
 static ssize_t
-seclvl_attr_store(struct kobject *kobj,
-		  struct attribute *attr, const char *buf, size_t len)
+seclvl_attr_store(struct kobject * kobj,
+		  struct attribute * attr, const char * buf, size_t len)
 {
-	struct seclvl_obj *obj = container_of(kobj, struct seclvl_obj, kobj);
-	struct seclvl_attribute *attribute =
+	struct seclvl_obj * obj = container_of(kobj, struct seclvl_obj, kobj);
+	struct seclvl_attribute * attribute =
 	    container_of(attr, struct seclvl_attribute, attr);
 	return (attribute->store ? attribute->store(obj, buf, len) : 0);
 }
 
 static ssize_t
-seclvl_attr_show(struct kobject *kobj, struct attribute *attr, char *buf)
+seclvl_attr_show(struct kobject * kobj, struct attribute * attr, char * buf)
 {
-	struct seclvl_obj *obj = container_of(kobj, struct seclvl_obj, kobj);
-	struct seclvl_attribute *attribute =
+	struct seclvl_obj * obj = container_of(kobj, struct seclvl_obj, kobj);
+	struct seclvl_attribute * attribute =
 	    container_of(attr, struct seclvl_attribute, attr);
 	return (attribute->show ? attribute->show(obj, buf) : 0);
 }
@@ -214,7 +214,7 @@
  * Called whenever the user reads the sysfs handle to this kernel
  * object
  */
-static ssize_t seclvl_read_file(struct seclvl_obj *obj, char *buff)
+static ssize_t seclvl_read_file(struct seclvl_obj * obj, char * buff)
 {
 	return snprintf(buff, PAGE_SIZE, "%d\n", seclvl);
 }
@@ -251,7 +251,7 @@
  * object (seclvl/seclvl).  It expects a single-digit number.
  */
 static ssize_t
-seclvl_write_file(struct seclvl_obj *obj, const char *buff, size_t count)
+seclvl_write_file(struct seclvl_obj * obj, const char * buff, size_t count)
 {
 	unsigned long val;
 	if (count > 2 || (count == 2 && buff[1] != '\n')) {
@@ -277,23 +277,23 @@
 __ATTR(seclvl, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_file,
        seclvl_write_file);
 
-static unsigned char hashedPassword[SHA1_DIGEST_SIZE];
+static unsigned char hashed_password[SHA1_DIGEST_SIZE];
 
 /**
  * Called whenever the user reads the sysfs passwd handle.
  */
-static ssize_t seclvl_read_passwd(struct seclvl_obj *obj, char *buff)
+static ssize_t seclvl_read_passwd(struct seclvl_obj * obj, char * buff)
 {
 	/* So just how good *is* your password? :-) */
 	char tmp[3];
 	int i = 0;
 	buff[0] = '\0';
-	if (hideHash) {
+	if (hide_hash) {
 		/* Security through obscurity */
 		return 0;
 	}
 	while (i < SHA1_DIGEST_SIZE) {
-		snprintf(tmp, 3, "%02x", hashedPassword[i]);
+		snprintf(tmp, 3, "%02x", hashed_password[i]);
 		strncat(buff, tmp, 2);
 		i++;
 	}
@@ -308,10 +308,10 @@
  * people...
  */
 static int
-plaintext_to_sha1(unsigned char *hash, const char *plaintext, int len)
+plaintext_to_sha1(unsigned char * hash, const char * plaintext, int len)
 {
-	char *pg_virt_addr;
-	struct crypto_tfm *tfm;
+	char * pg_virt_addr;
+	struct crypto_tfm * tfm;
 	struct scatterlist sg[1];
 	if (len > PAGE_SIZE) {
 		seclvl_printk(0, KERN_ERR "%s: Plaintext password too large "
@@ -349,7 +349,7 @@
  * object.  It hashes the password and compares the hashed results.
  */
 static ssize_t
-seclvl_write_passwd(struct seclvl_obj *obj, const char *buff, size_t count)
+seclvl_write_passwd(struct seclvl_obj * obj, const char * buff, size_t count)
 {
 	int i;
 	unsigned char tmp[SHA1_DIGEST_SIZE];
@@ -377,7 +377,7 @@
 		return rc;
 	}
 	for (i = 0; i < SHA1_DIGEST_SIZE; i++) {
-		if (hashedPassword[i] != tmp[i]) {
+		if (hashed_password[i] != tmp[i]) {
 			return -EPERM;
 		}
 	}
@@ -395,7 +395,8 @@
 /**
  * Explicitely disallow ptrace'ing the init process.
  */
-static int seclvl_ptrace(struct task_struct *parent, struct task_struct *child)
+static int
+seclvl_ptrace(struct task_struct * parent, struct task_struct * child)
 {
 	if (seclvl >= 0) {
 		if (child->pid == 1) {
@@ -413,7 +414,7 @@
  * Capability checks for seclvl.  The majority of the policy
  * enforcement for seclvl takes place here.
  */
-static int seclvl_capable(struct task_struct *tsk, int cap)
+static int seclvl_capable(struct task_struct * tsk, int cap)
 {
 	/* init can do anything it wants */
 	if (tsk->pid == 1)
@@ -472,7 +473,7 @@
 /**
  * Disallow reversing the clock in seclvl > 1
  */
-static int seclvl_settime(struct timespec *tv, struct timezone *tz)
+static int seclvl_settime(struct timespec * tv, struct timezone * tz)
 {
 	struct timespec now;
 	if (seclvl > 1) {
@@ -497,7 +498,7 @@
 static int seclvl_bd_claim(struct file * filp)
 {
 	int holder;
-	struct block_device *bdev = NULL;
+	struct block_device * bdev = NULL;
 	dev_t dev = filp->f_dentry->d_inode->i_rdev;
 	bdev = open_by_devnum(dev, FMODE_WRITE);
 	if (bdev) {
@@ -615,7 +616,7 @@
 /**
  * Cannot unmount in secure level 2
  */
-static int seclvl_umount(struct vfsmount *mnt, int flags)
+static int seclvl_umount(struct vfsmount * mnt, int flags)
 {
 	if (current->pid == 1) {
 		return 0;
@@ -643,10 +644,10 @@
 /**
  * Process the password-related module parameters
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
@@ -655,7 +656,7 @@
 				      "exclusive.\n", __FUNCTION__);
 			return -EINVAL;
 		}
-		if ((rc = plaintext_to_sha1(hashedPassword, passwd,
+		if ((rc = plaintext_to_sha1(hashed_password, passwd,
 					    strlen(passwd)))) {
 			seclvl_printk(0, KERN_ERR "%s: Error: SHA1 support "
 				      "not in kernel\n", __FUNCTION__);
@@ -678,7 +679,7 @@
 			unsigned char tmp;
 			tmp = sha1_passwd[i + 2];
 			sha1_passwd[i + 2] = '\0';
-			hashedPassword[i / 2] = (unsigned char)
+			hashed_password[i / 2] = (unsigned char)
 			    simple_strtol(&sha1_passwd[i], NULL, 16);
 			sha1_passwd[i + 2] = tmp;
 		}
@@ -689,7 +690,7 @@
 /**
  * Sysfs registrations
  */
-static int doSysfsRegistrations(void)
+static int do_sysfs_registrations(void)
 {
 	int rc = 0;
 	if ((rc = subsystem_register(&seclvl_subsys))) {
@@ -726,7 +727,7 @@
 		goto exit;
 	}
 	seclvl = initlvl;
-	if ((rc = processPassword())) {
+	if ((rc = process_password())) {
 		seclvl_printk(0, KERN_ERR "%s: Error processing the password "
 			      "module parameter(s): rc = [%d]\n", __FUNCTION__,
 			      rc);
@@ -746,7 +747,7 @@
 		}		/* if primary module registered */
 		secondary = 1;
 	}			/* if we registered ourselves with the security framework */
-	if ((rc = doSysfsRegistrations())) {
+	if ((rc = do_sysfs_registrations())) {
 		seclvl_printk(0, KERN_ERR "%s: Error registering with sysfs\n",
 			      __FUNCTION__);
 		goto exit;
@@ -783,6 +784,6 @@
 module_init(seclvl_init);
 module_exit(seclvl_exit);
 
-MODULE_AUTHOR("Michael A. Halcrow <mike@halcrow.us>");
+MODULE_AUTHOR("Michael A. Halcrow <mhalcrow@us.ibm.com>");
 MODULE_DESCRIPTION("LSM implementation of the BSD Secure Levels");
 MODULE_LICENSE("GPL");

--9l24NVCWtSuIVIod--
