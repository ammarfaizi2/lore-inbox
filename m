Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSFRAx2>; Mon, 17 Jun 2002 20:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317219AbSFRAx1>; Mon, 17 Jun 2002 20:53:27 -0400
Received: from hera.cwi.nl ([192.16.191.8]:16323 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317217AbSFRAx0>;
	Mon, 17 Jun 2002 20:53:26 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 18 Jun 2002 02:53:27 +0200 (MEST)
Message-Id: <UTC200206180053.g5I0rRX09038.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove path_init
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like there are no in-tree users of path_init.
Maybe it can be removed.

Andries

diff -u -r linux-2.5.22/linux/fs/namei.c linux-2.5.22pi/linux/fs/namei.c
--- linux-2.5.22/linux/fs/namei.c	Sun Jun  9 07:28:50 2002
+++ linux-2.5.22pi/linux/fs/namei.c	Tue Jun 18 02:49:39 2002
@@ -837,22 +837,6 @@
 	return 1;
 }
 
-/* SMP-safe */
-int path_init(const char *name, unsigned int flags, struct nameidata *nd)
-{
-	nd->last_type = LAST_ROOT; /* if there are only slashes... */
-	nd->old_mnt = NULL;
-	nd->old_dentry = NULL;
-	nd->flags = flags;
-	if (*name=='/')
-		return walk_init_root(name,nd);
-	read_lock(&current->fs->lock);
-	nd->mnt = mntget(current->fs->pwdmnt);
-	nd->dentry = dget(current->fs->pwd);
-	read_unlock(&current->fs->lock);
-	return 1;
-}
-
 int path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
 {
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
diff -u -r linux-2.5.22/linux/include/linux/namei.h linux-2.5.22pi/linux/include/linux/namei.h
--- linux-2.5.22/linux/include/linux/namei.h	Sun Jun  9 07:28:48 2002
+++ linux-2.5.22pi/linux/include/linux/namei.h	Tue Jun 18 02:49:18 2002
@@ -40,7 +40,6 @@
 	__user_walk(name, LOOKUP_FOLLOW, nd)
 #define user_path_walk_link(name,nd) \
 	__user_walk(name, 0, nd)
-extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
diff -u -r linux-2.5.22/linux/kernel/ksyms.c linux-2.5.22pi/linux/kernel/ksyms.c
--- linux-2.5.22/linux/kernel/ksyms.c	Mon Jun 17 19:35:40 2002
+++ linux-2.5.22pi/linux/kernel/ksyms.c	Tue Jun 18 02:49:49 2002
@@ -148,7 +148,6 @@
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(lookup_mnt);
 EXPORT_SYMBOL(path_lookup);
-EXPORT_SYMBOL(path_init);
 EXPORT_SYMBOL(path_walk);
 EXPORT_SYMBOL(path_release);
 EXPORT_SYMBOL(__user_walk);

