Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVFUAtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVFUAtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVFUAqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:46:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:42468 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261758AbVFTW7x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:53 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] Make kobject's name be const char *
In-Reply-To: <11193083603818@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:20 -0700
Message-Id: <11193083603640@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Make kobject's name be const char *

kobject: make kobject's name const char * since users should not
	 attempt to change it (except by calling kobject_rename).

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f3b4f3c6dec04c6c8261fe22645f07b39976595a
tree 9c4ad15f5d5fc7d3a8006396b185bb615386a61c
parent e3a15db2415579d5136b9ba9b52fe27c66da8780
author Dmitry Torokhov <dtor_core@ameritech.net> Tue, 26 Apr 2005 02:32:00 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:00 -0700

 include/linux/kobject.h |    6 +++---
 lib/kobject.c           |    2 +-
 lib/kobject_uevent.c    |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -33,7 +33,7 @@
 extern u64 hotplug_seqnum;
 
 struct kobject {
-	char			* k_name;
+	const char		* k_name;
 	char			name[KOBJ_NAME_LEN];
 	struct kref		kref;
 	struct list_head	entry;
@@ -46,7 +46,7 @@ struct kobject {
 extern int kobject_set_name(struct kobject *, const char *, ...)
 	__attribute__((format(printf,2,3)));
 
-static inline char * kobject_name(struct kobject * kobj)
+static inline const char * kobject_name(const struct kobject * kobj)
 {
 	return kobj->k_name;
 }
@@ -57,7 +57,7 @@ extern void kobject_cleanup(struct kobje
 extern int kobject_add(struct kobject *);
 extern void kobject_del(struct kobject *);
 
-extern int kobject_rename(struct kobject *, char *new_name);
+extern int kobject_rename(struct kobject *, const char *new_name);
 
 extern int kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
diff --git a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -279,7 +279,7 @@ EXPORT_SYMBOL(kobject_set_name);
  *	@new_name: object's new name
  */
 
-int kobject_rename(struct kobject * kobj, char *new_name)
+int kobject_rename(struct kobject * kobj, const char *new_name)
 {
 	int error = 0;
 
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -197,7 +197,7 @@ void kobject_hotplug(struct kobject *kob
 	int i = 0;
 	int retval;
 	char *kobj_path = NULL;
-	char *name = NULL;
+	const char *name = NULL;
 	char *action_string;
 	u64 seq;
 	struct kobject *top_kobj = kobj;
@@ -249,7 +249,7 @@ void kobject_hotplug(struct kobject *kob
 		name = kobject_name(&kset->kobj);
 
 	argv [0] = hotplug_path;
-	argv [1] = name;
+	argv [1] = (char *)name; /* won't be changed but 'const' has to go */
 	argv [2] = NULL;
 
 	/* minimal command environment */

