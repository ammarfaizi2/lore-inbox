Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVFUDQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVFUDQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVFUDPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:15:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:6116 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261651AbVFTW7e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:34 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] sysfs_{create|remove}_link should take const char *
In-Reply-To: <20050620225538.GA16888@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:20 -0700
Message-Id: <11193083602227@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sysfs_{create|remove}_link should take const char *

sysfs: make sysfs_{create|remove}_link to take const char * name.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e3a15db2415579d5136b9ba9b52fe27c66da8780
tree 55a431608174bc96f34233d9ef3e699b1f982183
parent eb11d8ffceead1eb3d84366f1687daf2217e883e
author Dmitry Torokhov <dtor_core@ameritech.net> Tue, 26 Apr 2005 02:31:08 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:00 -0700

 fs/sysfs/symlink.c    |    8 ++++----
 include/linux/sysfs.h |   10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
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
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
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

