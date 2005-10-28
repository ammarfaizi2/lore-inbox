Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVJ1Gc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVJ1Gc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVJ1GcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:32:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:41706 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965140AbVJ1GbX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:23 -0400
Cc: rdunlap@xenotime.net
Subject: [PATCH] kobject: fix gfp flags type
In-Reply-To: <11304810221164@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:22 -0700
Message-Id: <11304810221338@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] kobject: fix gfp flags type

Fix implicit nocast warnings in kobject_uevent code, including __nocast:
lib/kobject_uevent.c:78:37: warning: implicit cast to nocast type
lib/kobject_uevent.c:97:51: warning: implicit cast to nocast type
lib/kobject_uevent.c:120:27: warning: implicit cast to nocast type

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 409d93787e8cfec603d512c2925f8580c32a9d0a
tree 7ee455a735b293d329e1921f5dd6e565644817c7
parent 3da2cf413a832ae4f7691d299f2d7dab30654ce5
author Randy Dunlap <rdunlap@xenotime.net> Tue, 04 Oct 2005 00:45:34 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:47:59 -0700

 include/linux/kobject.h |    2 +-
 lib/kobject.c           |    2 +-
 lib/kobject_uevent.c    |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 3b22304..9c52805 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -65,7 +65,7 @@ extern void kobject_unregister(struct ko
 extern struct kobject * kobject_get(struct kobject *);
 extern void kobject_put(struct kobject *);
 
-extern char * kobject_get_path(struct kobject *, int);
+extern char * kobject_get_path(struct kobject *, unsigned int __nocast);
 
 struct kobj_type {
 	void (*release)(struct kobject *);
diff --git a/lib/kobject.c b/lib/kobject.c
index dd0917d..97ad4c6 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -100,7 +100,7 @@ static void fill_kobj_path(struct kobjec
  * @kobj:	kobject in question, with which to build the path
  * @gfp_mask:	the allocation type used to allocate the path
  */
-char *kobject_get_path(struct kobject *kobj, int gfp_mask)
+char *kobject_get_path(struct kobject *kobj, unsigned int __nocast gfp_mask)
 {
 	char *path;
 	int len;
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index a318330..7be1769 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -62,7 +62,7 @@ static struct sock *uevent_sock;
  * @gfp_mask:
  */
 static int send_uevent(const char *signal, const char *obj,
-		       char **envp, int gfp_mask)
+		       char **envp, unsigned int __nocast gfp_mask)
 {
 	struct sk_buff *skb;
 	char *pos;
@@ -98,7 +98,7 @@ static int send_uevent(const char *signa
 }
 
 static int do_kobject_uevent(struct kobject *kobj, enum kobject_action action, 
-			     struct attribute *attr, int gfp_mask)
+			struct attribute *attr, unsigned int __nocast gfp_mask)
 {
 	char *path;
 	char *attrpath;
@@ -170,7 +170,7 @@ postcore_initcall(kobject_uevent_init);
 
 #else
 static inline int send_uevent(const char *signal, const char *obj,
-			      char **envp, int gfp_mask)
+			      char **envp, unsigned int __nocast gfp_mask)
 {
 	return 0;
 }

