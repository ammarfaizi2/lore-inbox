Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVFUDK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVFUDK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVFUDHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:07:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:7652 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261656AbVFTW7f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:35 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] sysfs: if show/store is missing return -EIO
In-Reply-To: <11193083611546@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:21 -0700
Message-Id: <11193083612648@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sysfs: if show/store is missing return -EIO

sysfs: if attribute does not implement show or store method
       read/write should return -EIO instead of 0 or -EINVAL.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c76d0abd07a9c9cf72bbb5b641e1e97f92ea8f3e
tree c5f3c752031dfb8b7c5a624d06b129661eec5665
parent d48593bf208e0d046c35fb0707ae5b23fef8c4ff
author Dmitry Torokhov <dtor_core@ameritech.net> Fri, 29 Apr 2005 01:22:00 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:02 -0700

 fs/sysfs/bin.c  |    4 ++--
 fs/sysfs/file.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/sysfs/bin.c b/fs/sysfs/bin.c
--- a/fs/sysfs/bin.c
+++ b/fs/sysfs/bin.c
@@ -25,7 +25,7 @@ fill_read(struct dentry *dentry, char *b
 	struct kobject * kobj = to_kobj(dentry->d_parent);
 
 	if (!attr->read)
-		return -EINVAL;
+		return -EIO;
 
 	return attr->read(kobj, buffer, off, count);
 }
@@ -71,7 +71,7 @@ flush_write(struct dentry *dentry, char 
 	struct kobject *kobj = to_kobj(dentry->d_parent);
 
 	if (!attr->write)
-		return -EINVAL;
+		return -EIO;
 
 	return attr->write(kobj, buffer, offset, count);
 }
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -23,7 +23,7 @@ subsys_attr_show(struct kobject * kobj, 
 {
 	struct subsystem * s = to_subsys(kobj);
 	struct subsys_attribute * sattr = to_sattr(attr);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (sattr->show)
 		ret = sattr->show(s,page);
@@ -36,7 +36,7 @@ subsys_attr_store(struct kobject * kobj,
 {
 	struct subsystem * s = to_subsys(kobj);
 	struct subsys_attribute * sattr = to_sattr(attr);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (sattr->store)
 		ret = sattr->store(s,page,count);

