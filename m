Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268695AbUIQL0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268695AbUIQL0c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUIQL0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:26:32 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:48353 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268695AbUIQL02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:26:28 -0400
Date: Fri, 17 Sep 2004 04:25:39 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20040917112539.32393.65844.29676@sam.engr.sgi.com>
In-Reply-To: <20040917112527.32393.49322.23478@sam.engr.sgi.com>
References: <20040917112527.32393.49322.23478@sam.engr.sgi.com>
Subject: cpusets: remove more casts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some more casts of (void *) d_fsdata.

In gcc, unlike C++, these serve no good purpose, and can
hide valid errors if the type changes in the future.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc2-mm1/kernel/cpuset.c
===================================================================
--- 2.6.9-rc2-mm1.orig/kernel/cpuset.c	2004-09-17 02:45:54.000000000 -0700
+++ 2.6.9-rc2-mm1/kernel/cpuset.c	2004-09-17 02:50:18.000000000 -0700
@@ -215,7 +215,7 @@ static void cpuset_diput(struct dentry *
 {
 	/* is dentry a directory ? if so, kfree() associated cpuset */
 	if (S_ISDIR(inode->i_mode)) {
-		struct cpuset *cs = (struct cpuset *)dentry->d_fsdata;
+		struct cpuset *cs = dentry->d_fsdata;
 		BUG_ON(!(is_removed(cs)));
 		kfree(cs);
 	}
@@ -351,12 +351,12 @@ struct cftype {
 
 static inline struct cpuset *__d_cs(struct dentry *dentry)
 {
-	return (struct cpuset *)dentry->d_fsdata;
+	return dentry->d_fsdata;
 }
 
 static inline struct cftype *__d_cft(struct dentry *dentry)
 {
-	return (struct cftype *)dentry->d_fsdata;
+	return dentry->d_fsdata;
 }
 
 /*
@@ -1273,8 +1273,7 @@ err:
 
 static int cpuset_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
-	struct dentry *d_parent = dentry->d_parent;
-	struct cpuset *c_parent = (struct cpuset *)d_parent->d_fsdata;
+	struct cpuset *c_parent = dentry->d_parent->d_fsdata;
 
 	/* the vfs holds inode->i_sem already */
 	return cpuset_create(c_parent, dentry->d_name.name, mode | S_IFDIR);
@@ -1282,7 +1281,7 @@ static int cpuset_mkdir(struct inode *di
 
 static int cpuset_rmdir(struct inode *unused_dir, struct dentry *dentry)
 {
-	struct cpuset *cs = (struct cpuset *)dentry->d_fsdata;
+	struct cpuset *cs = dentry->d_fsdata;
 	struct dentry *d;
 	struct cpuset *parent;
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
