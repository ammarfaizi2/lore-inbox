Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbTGDB4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265638AbTGDBzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:55:02 -0400
Received: from granite.he.net ([216.218.226.66]:23566 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265649AbTGDByu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:50 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845541853@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845543452@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1375, 2003/07/03 17:43:34-07:00, greg@kroah.com

[PATCH] kobject: add kobject_rename()
Based on a patch written by Dan Aloni <da-x@gmx.net>


 include/linux/kobject.h |    2 ++
 lib/kobject.c           |   15 +++++++++++++++
 2 files changed, 17 insertions(+)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Thu Jul  3 18:15:44 2003
+++ b/include/linux/kobject.h	Thu Jul  3 18:15:44 2003
@@ -39,6 +39,8 @@
 extern int kobject_add(struct kobject *);
 extern void kobject_del(struct kobject *);
 
+extern void kobject_rename(struct kobject *, char *new_name);
+
 extern int kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
 
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Thu Jul  3 18:15:44 2003
+++ b/lib/kobject.c	Thu Jul  3 18:15:44 2003
@@ -314,6 +314,21 @@
 }
 
 /**
+ *	kobject_rename - change the name of an object
+ *	@kobj:	object in question.
+ *	@new_name: object's new name
+ */
+
+void kobject_rename(struct kobject * kobj, char *new_name)
+{
+	kobj = kobject_get(kobj);
+	if (!kobj)
+		return;
+	sysfs_rename_dir(kobj, new_name);
+	kobject_put(kobj);
+}
+
+/**
  *	kobject_del - unlink kobject from hierarchy.
  * 	@kobj:	object.
  */

