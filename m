Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUJHSru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUJHSru (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUJHSpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:45:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:48085 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S263540AbUJHSfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:35:52 -0400
Date: Fri, 8 Oct 2004 11:36:11 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: akpm@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] register_chrdev_region, alloc_chrdev_region const
 char
Message-Id: <20041008113611.5aaf0693@zqx3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple chrdev routines take a constant string and should be declared
with const char *

diff -Nru a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	2004-10-08 10:44:52 -07:00
+++ b/fs/char_dev.c	2004-10-08 10:44:52 -07:00
@@ -153,7 +153,7 @@
 	return cd;
 }
 
-int register_chrdev_region(dev_t from, unsigned count, char *name)
+int register_chrdev_region(dev_t from, unsigned count, const char *name)
 {
 	struct char_device_struct *cd;
 	dev_t to = from + count;
@@ -178,7 +178,8 @@
 	return PTR_ERR(cd);
 }
 
-int alloc_chrdev_region(dev_t *dev, unsigned baseminor, unsigned count, char *name)
+int alloc_chrdev_region(dev_t *dev, unsigned baseminor, unsigned count, 
+			const char *name)
 {
 	struct char_device_struct *cd;
 	cd = __register_chrdev_region(0, baseminor, count, name);
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2004-10-08 10:44:52 -07:00
+++ b/include/linux/fs.h	2004-10-08 10:44:52 -07:00
@@ -1269,8 +1269,8 @@
 extern void bd_release(struct block_device *);
 
 /* fs/char_dev.c */
-extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, char *);
-extern int register_chrdev_region(dev_t, unsigned, char *);
+extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
+extern int register_chrdev_region(dev_t, unsigned, const char *);
 extern int register_chrdev(unsigned int, const char *,
 			   struct file_operations *);
 extern int unregister_chrdev(unsigned int, const char *);
