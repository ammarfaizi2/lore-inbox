Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTEEQuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTEEQus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:50:48 -0400
Received: from verein.lst.de ([212.34.181.86]:42503 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263760AbTEEQsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:48:18 -0400
Date: Mon, 5 May 2003 19:00:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove unused funcion proc_mknod
Message-ID: <20030505190045.A22238@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not used currently and a rather bad idea in general..



--- 1.21/fs/proc/generic.c	Fri Apr 25 17:46:19 2003
+++ edited/fs/proc/generic.c	Mon May  5 17:26:34 2003
@@ -566,22 +566,6 @@
 	return ent;
 }
 
-struct proc_dir_entry *proc_mknod(const char *name, mode_t mode,
-		struct proc_dir_entry *parent, kdev_t rdev)
-{
-	struct proc_dir_entry *ent;
-
-	ent = proc_create(&parent,name,mode,1);
-	if (ent) {
-		ent->rdev = rdev;
-		if (proc_register(parent, ent) < 0) {
-			kfree(ent);
-			ent = NULL;
-		}
-	}
-	return ent;
-}
-
 struct proc_dir_entry *proc_mkdir(const char *name, struct proc_dir_entry *parent)
 {
 	struct proc_dir_entry *ent;
===== fs/proc/root.c 1.11 vs edited =====
--- 1.11/fs/proc/root.c	Sat Sep 28 17:36:29 2002
+++ edited/fs/proc/root.c	Mon May  5 17:26:26 2003
@@ -151,7 +151,6 @@
 EXPORT_SYMBOL(proc_sys_root);
 #endif
 EXPORT_SYMBOL(proc_symlink);
-EXPORT_SYMBOL(proc_mknod);
 EXPORT_SYMBOL(proc_mkdir);
 EXPORT_SYMBOL(create_proc_entry);
 EXPORT_SYMBOL(remove_proc_entry);
===== include/linux/proc_fs.h 1.15 vs edited =====
--- 1.15/include/linux/proc_fs.h	Tue Aug 13 01:20:00 2002
+++ edited/include/linux/proc_fs.h	Mon May  5 17:26:44 2003
@@ -133,8 +133,6 @@
 
 extern struct proc_dir_entry *proc_symlink(const char *,
 		struct proc_dir_entry *, const char *);
-extern struct proc_dir_entry *proc_mknod(const char *,mode_t,
-		struct proc_dir_entry *,kdev_t);
 extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
 
 static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
@@ -182,8 +180,6 @@
 static inline void remove_proc_entry(const char *name, struct proc_dir_entry *parent) {};
 static inline struct proc_dir_entry *proc_symlink(const char *name,
 		struct proc_dir_entry *parent,char *dest) {return NULL;}
-static inline struct proc_dir_entry *proc_mknod(const char *name,mode_t mode,
-		struct proc_dir_entry *parent,kdev_t rdev) {return NULL;}
 static inline struct proc_dir_entry *proc_mkdir(const char *name,
 	struct proc_dir_entry *parent) {return NULL;}
 
