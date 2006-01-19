Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWASVcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWASVcx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWASVcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:32:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21953 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422648AbWASVbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:31:22 -0500
Date: Thu, 19 Jan 2006 15:31:01 -0600
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dlm: use kzalloc
Message-ID: <20060119213100.GF31387@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/device.c
===================================================================
--- linux.orig/drivers/dlm/device.c	2006-01-19 13:38:38.978178974 -0600
+++ linux/drivers/dlm/device.c	2006-01-19 13:38:54.847754011 -0600
@@ -236,12 +236,11 @@
 
 	namelen = strlen(name)+strlen(name_prefix)+2;
 
-	newls = kmalloc(sizeof(struct user_ls), GFP_KERNEL);
+	newls = kzalloc(sizeof(struct user_ls), GFP_KERNEL);
 	if (!newls)
 		return -ENOMEM;
-	memset(newls, 0, sizeof(struct user_ls));
 
-	newls->ls_miscinfo.name = kmalloc(namelen, GFP_KERNEL);
+	newls->ls_miscinfo.name = kzalloc(namelen, GFP_KERNEL);
 	if (!newls->ls_miscinfo.name) {
 		kfree(newls);
 		return -ENOMEM;
@@ -306,11 +305,10 @@
 static void add_to_astqueue(struct lock_info *li, void *astaddr, void *astparam,
 			    int lvb_updated)
 {
-	struct ast_info *ast = kmalloc(sizeof(struct ast_info), GFP_KERNEL);
+	struct ast_info *ast = kzalloc(sizeof(struct ast_info), GFP_KERNEL);
 	if (!ast)
 		return;
 
-	memset(ast, 0, sizeof(*ast));
 	ast->result.user_astparam = astparam;
 	ast->result.user_astaddr  = astaddr;
 	ast->result.user_lksb     = li->li_user_lksb;
@@ -439,7 +437,7 @@
 	if (!lsinfo)
 		return -ENOENT;
 
-	f = kmalloc(sizeof(struct file_info), GFP_KERNEL);
+	f = kzalloc(sizeof(struct file_info), GFP_KERNEL);
 	if (!f)
 		return -ENOMEM;
 
@@ -754,7 +752,7 @@
 	if (!try_module_get(THIS_MODULE))
 		return NULL;
 
-	li = kmalloc(sizeof(struct lock_info), GFP_KERNEL);
+	li = kzalloc(sizeof(struct lock_info), GFP_KERNEL);
 	if (li) {
 		li->li_magic     = LOCKINFO_MAGIC;
 		li->li_file      = fi;
Index: linux/drivers/dlm/lockspace.c
===================================================================
--- linux.orig/drivers/dlm/lockspace.c	2006-01-19 10:06:23.000000000 -0600
+++ linux/drivers/dlm/lockspace.c	2006-01-19 13:38:54.848753858 -0600
@@ -351,10 +351,9 @@
 		return -EEXIST;
 	}
 
-	ls = kmalloc(sizeof(struct dlm_ls) + namelen, GFP_KERNEL);
+	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_KERNEL);
 	if (!ls)
 		goto out;
-	memset(ls, 0, sizeof(struct dlm_ls) + namelen);
 	memcpy(ls->ls_name, name, namelen);
 	ls->ls_namelen = namelen;
 	ls->ls_exflags = flags;
Index: linux/drivers/dlm/member.c
===================================================================
--- linux.orig/drivers/dlm/member.c	2006-01-19 13:38:44.615317587 -0600
+++ linux/drivers/dlm/member.c	2006-01-19 13:38:54.848753858 -0600
@@ -52,7 +52,7 @@
 	struct dlm_member *memb;
 	int w;
 
-	memb = kmalloc(sizeof(struct dlm_member), GFP_KERNEL);
+	memb = kzalloc(sizeof(struct dlm_member), GFP_KERNEL);
 	if (!memb)
 		return -ENOMEM;
 
@@ -271,10 +271,9 @@
 	int *ids = NULL;
 	int error, count;
 
-	rv = kmalloc(sizeof(struct dlm_recover), GFP_KERNEL);
+	rv = kzalloc(sizeof(struct dlm_recover), GFP_KERNEL);
 	if (!rv)
 		return -ENOMEM;
-	memset(rv, 0, sizeof(struct dlm_recover));
 
 	error = count = dlm_nodeid_list(ls->ls_name, &ids);
 	if (error <= 0)
