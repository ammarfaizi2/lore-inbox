Return-Path: <linux-kernel-owner+w=401wt.eu-S964875AbXABMjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbXABMjt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbXABMjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:39:49 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:4260 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964875AbXABMjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:39:48 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: gregkh@suse.de
Subject: [patch] fs: sysfs kobject_put cleanup
Date: Tue, 2 Jan 2007 13:41:10 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021341.11109.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes redundant argument checks for kobject_put().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 fs/sysfs/bin.c  |    5 ++---
 fs/sysfs/file.c |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/fs/sysfs/bin.c linux-2.6.20-rc2-mm1-b/fs/sysfs/bin.c
--- linux-2.6.20-rc2-mm1-a/fs/sysfs/bin.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/fs/sysfs/bin.c	2007-01-02 02:34:32.000000000 +0100
@@ -146,7 +146,7 @@ static int open(struct inode * inode, st
  Error:
 	module_put(attr->attr.owner);
  Done:
-	if (error && kobj)
+	if (error)
 		kobject_put(kobj);
 	return error;
 }
@@ -157,8 +157,7 @@ static int release(struct inode * inode,
 	struct bin_attribute * attr = to_bin_attr(file->f_path.dentry);
 	u8 * buffer = file->private_data;
 
-	if (kobj) 
-		kobject_put(kobj);
+	kobject_put(kobj);
 	module_put(attr->attr.owner);
 	kfree(buffer);
 	return 0;
diff -upr linux-2.6.20-rc2-mm1-a/fs/sysfs/file.c linux-2.6.20-rc2-mm1-b/fs/sysfs/file.c
--- linux-2.6.20-rc2-mm1-a/fs/sysfs/file.c	2006-12-28 12:57:48.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/fs/sysfs/file.c	2007-01-02 02:34:03.000000000 +0100
@@ -375,7 +375,7 @@ static int sysfs_open_file(struct inode 
 	error = -EACCES;
 	module_put(attr->owner);
  Done:
-	if (error && kobj)
+	if (error)
 		kobject_put(kobj);
 	return error;
 }
@@ -389,8 +389,7 @@ static int sysfs_release(struct inode * 
 
 	if (buffer)
 		remove_from_collection(buffer, inode);
-	if (kobj) 
-		kobject_put(kobj);
+	kobject_put(kobj);
 	/* After this point, attr should not be accessed. */
 	module_put(owner);
 


-- 
Regards,

	Mariusz Kozlowski
