Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVFWH07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVFWH07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVFWHZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:25:37 -0400
Received: from [24.22.56.4] ([24.22.56.4]:14566 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262272AbVFWGSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:42 -0400
Message-Id: <20050623061801.618872000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:29 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 37/38] CKRM e18: Use sizeof instead of define for the array size in RBCE
Content-Disposition: inline; filename=use_sizeof_instead_of_define_for_the_array_size_in_rbce
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While creating the config files for rbce, instead of using #define
use sizeof so that when the array size changes, things still work as
expected.

Signed-off-by:  Chandra Seetharaman <sekharan@us.ibm.com>
Signed-off-by:  Gerrit Huizenga <gh@us.ibm.com>

Index: linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_fs.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/rbce/rbce_fs.c	2005-06-20 15:02:49.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/rbce/rbce_fs.c	2005-06-20 16:01:57.000000000 -0700
@@ -273,8 +273,7 @@ rbce_symlink(struct inode *dir, struct d
 
 /******************************* Config files  ********************/
 
-#define RBCE_NR_CONFIG 5
-struct rcfs_magf rbce_config_files[RBCE_NR_CONFIG] = {
+struct rcfs_magf rbce_config_files[] = {
 	{
 	 .name = CONFIG_CE_DIR,
 	 .mode = RCFS_DEFAULT_DIR_MODE,
@@ -302,16 +301,17 @@ static struct dentry *ce_root_dentry;
 
 int rbce_create_config(void)
 {
-	int rc;
+	int rc, nr;
 
+	nr = sizeof(rbce_config_files) / sizeof(struct rcfs_magf);
 	/* Make root dentry */
-	rc = rcfs_mkroot(rbce_config_files, RBCE_NR_CONFIG, &ce_root_dentry);
+	rc = rcfs_mkroot(rbce_config_files, nr, &ce_root_dentry);
 	if ((!ce_root_dentry) || rc)
 		return rc;
 
 	/* Create config files */
 	if ((rc = rcfs_create_magic(ce_root_dentry, &rbce_config_files[1],
-				    RBCE_NR_CONFIG - 1))) {
+				    nr - 1))) {
 		printk(KERN_ERR "Failed to create c/rbce config files."
 		       " Deleting c/rbce root\n");
 		rcfs_rmroot(ce_root_dentry);

--
