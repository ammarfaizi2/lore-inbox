Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVD2G1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVD2G1q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 02:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVD2G1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 02:27:46 -0400
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:12127 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262434AbVD2G1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 02:27:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5 (take 2)] sysfs: if show/store is missing return -EIO
Date: Fri, 29 Apr 2005 01:22:00 -0500
User-Agent: KMail/1.8
Cc: Robert Love <rml@novell.com>, Greg KH <gregkh@suse.de>,
       Jean Delvare <khali@linux-fr.org>
References: <200504280030.10214.dtor_core@ameritech.net> <20050428172659.GA18859@kroah.com> <1114710135.6682.60.camel@betsy>
In-Reply-To: <1114710135.6682.60.camel@betsy>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504290122.00679.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs: if attribute does not implement show or store method
       read/write should return -EIO instead of 0 or -EINVAL.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 bin.c  |    4 ++--
 file.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: dtor/fs/sysfs/file.c
===================================================================
--- dtor.orig/fs/sysfs/file.c
+++ dtor/fs/sysfs/file.c
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
Index: dtor/fs/sysfs/bin.c
===================================================================
--- dtor.orig/fs/sysfs/bin.c
+++ dtor/fs/sysfs/bin.c
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
