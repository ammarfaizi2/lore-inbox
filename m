Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVDZHgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVDZHgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVDZHer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:34:47 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:41889 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261392AbVDZHeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:34:16 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] sysfs_{create|remove}_link should take const char *
Date: Tue, 26 Apr 2005 02:31:08 -0500
User-Agent: KMail/1.8
Cc: Greg KH <gregkh@suse.de>
References: <200504260229.03866.dtor_core@ameritech.net>
In-Reply-To: <200504260229.03866.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504260231.09016.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs: make sysfs_{create|remove}_link to take const char * name.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 fs/sysfs/symlink.c    |    8 ++++----
 include/linux/sysfs.h |   10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

Index: dtor/include/linux/sysfs.h
===================================================================
--- dtor.orig/include/linux/sysfs.h
+++ dtor/include/linux/sysfs.h
@@ -105,11 +105,11 @@ sysfs_chmod_file(struct kobject *kobj, s
 extern void
 sysfs_remove_file(struct kobject *, const struct attribute *);
 
-extern int 
-sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name);
+extern int
+sysfs_create_link(struct kobject * kobj, struct kobject * target, const char * name);
 
 extern void
-sysfs_remove_link(struct kobject *, char * name);
+sysfs_remove_link(struct kobject *, const char * name);
 
 int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
 int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
@@ -153,12 +153,12 @@ static inline void sysfs_remove_file(str
 	;
 }
 
-static inline int sysfs_create_link(struct kobject * k, struct kobject * t, char * n)
+static inline int sysfs_create_link(struct kobject * k, struct kobject * t, const char * n)
 {
 	return 0;
 }
 
-static inline void sysfs_remove_link(struct kobject * k, char * name)
+static inline void sysfs_remove_link(struct kobject * k, const char * name)
 {
 	;
 }
Index: dtor/fs/sysfs/symlink.c
===================================================================
--- dtor.orig/fs/sysfs/symlink.c
+++ dtor/fs/sysfs/symlink.c
@@ -43,7 +43,7 @@ static void fill_object_path(struct kobj
 	}
 }
 
-static int sysfs_add_link(struct dentry * parent, char * name, struct kobject * target)
+static int sysfs_add_link(struct dentry * parent, const char * name, struct kobject * target)
 {
 	struct sysfs_dirent * parent_sd = parent->d_fsdata;
 	struct sysfs_symlink * sl;
@@ -79,7 +79,7 @@ exit1:
  *	@target:	object we're pointing to.
  *	@name:		name of the symlink.
  */
-int sysfs_create_link(struct kobject * kobj, struct kobject * target, char * name)
+int sysfs_create_link(struct kobject * kobj, struct kobject * target, const char * name)
 {
 	struct dentry * dentry = kobj->dentry;
 	int error = 0;
@@ -99,13 +99,13 @@ int sysfs_create_link(struct kobject * k
  *	@name:	name of the symlink to remove.
  */
 
-void sysfs_remove_link(struct kobject * kobj, char * name)
+void sysfs_remove_link(struct kobject * kobj, const char * name)
 {
 	sysfs_hash_and_remove(kobj->dentry,name);
 }
 
 static int sysfs_get_target_path(struct kobject * kobj, struct kobject * target,
-				   char *path)
+				 char *path)
 {
 	char * s;
 	int depth, size;
