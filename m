Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVAaTcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVAaTcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVAaTb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:31:26 -0500
Received: from lists.us.dell.com ([143.166.224.162]:32934 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261328AbVAaT3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:29:12 -0500
Date: Mon, 31 Jan 2005 13:28:59 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 2.6.11-rc2] dm-ioctl.c: use new kstrdup() from library
Message-ID: <20050131192859.GB24164@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes private kstrdup() function, uses new implementation in lib/string.c.

Required to build.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== drivers/md/dm-ioctl.c 1.42 vs edited =====
--- 1.42/drivers/md/dm-ioctl.c	2004-11-15 21:29:26 -06:00
+++ edited/drivers/md/dm-ioctl.c	2005-01-27 19:27:26 -06:00
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/dm-ioctl.h>
 
@@ -122,14 +123,6 @@
 /*-----------------------------------------------------------------
  * Inserting, removing and renaming a device.
  *---------------------------------------------------------------*/
-static inline char *kstrdup(const char *str)
-{
-	char *r = kmalloc(strlen(str) + 1, GFP_KERNEL);
-	if (r)
-		strcpy(r, str);
-	return r;
-}
-
 static struct hash_cell *alloc_cell(const char *name, const char *uuid,
 				    struct mapped_device *md)
 {
@@ -139,7 +132,7 @@
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name);
+	hc->name = kstrdup(name, GFP_KERNEL);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -149,7 +142,7 @@
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid);
+		hc->uuid = kstrdup(uuid, GFP_KERNEL);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -273,7 +266,7 @@
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new);
+	new_name = kstrdup(new, GFP_KERNEL);
 	if (!new_name)
 		return -ENOMEM;
 
