Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268331AbUIQEQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268331AbUIQEQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268345AbUIQENg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:13:36 -0400
Received: from [12.177.129.25] ([12.177.129.25]:5828 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268351AbUIQEND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:13:03 -0400
Message-Id: <200409170517.i8H5HY2J005402@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Remove useless ioctls
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:17:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The UML block driver had some useless ioctls in it somehow.  This gets rid of
them.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/drivers/ubd_kern.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/drivers/ubd_kern.c	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/drivers/ubd_kern.c	2004-09-16 23:39:25.000000000 -0400
@@ -1064,7 +1064,6 @@
 {
 	struct hd_geometry *loc = (struct hd_geometry *) arg;
 	struct ubd *dev = inode->i_bdev->bd_disk->private_data;
-	int err;
 	struct hd_driveid ubd_id = {
 		.cyls		= 0,
 		.heads		= 128,
@@ -1082,32 +1081,6 @@
 		g.start = get_start_sect(inode->i_bdev);
 		return(copy_to_user(loc, &g, sizeof(g)) ? -EFAULT : 0);
 
-	case HDIO_SET_UNMASKINTR:
-		if(!capable(CAP_SYS_ADMIN)) return(-EACCES);
-		if((arg > 1) || (inode->i_bdev->bd_contains != inode->i_bdev))
-			return(-EINVAL);
-		return(0);
-
-	case HDIO_GET_UNMASKINTR:
-		if(!arg)  return(-EINVAL);
-		err = verify_area(VERIFY_WRITE, (long *) arg, sizeof(long));
-		if(err)
-			return(err);
-		return(0);
-
-	case HDIO_GET_MULTCOUNT:
-		if(!arg)  return(-EINVAL);
-		err = verify_area(VERIFY_WRITE, (long *) arg, sizeof(long));
-		if(err)
-			return(err);
-		return(0);
-
-	case HDIO_SET_MULTCOUNT:
-		if(!capable(CAP_SYS_ADMIN)) return(-EACCES);
-		if(inode->i_bdev->bd_contains != inode->i_bdev)
-			return(-EINVAL);
-		return(0);
-
 	case HDIO_GET_IDENTITY:
 		ubd_id.cyls = dev->size / (128 * 32 * 512);
 		if(copy_to_user((char *) arg, (char *) &ubd_id, 

