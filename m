Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVI1Xhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVI1Xhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVI1Xhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:37:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:6080 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751244AbVI1Xhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:37:35 -0400
Date: Thu, 29 Sep 2005 00:37:34 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] saa6588 __user annotations
Message-ID: <20050928233734.GM7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-cyblafb/drivers/media/video/rds.h RC14-rc2-git6-saa6588/drivers/media/video/rds.h
--- RC14-rc2-git6-cyblafb/drivers/media/video/rds.h	2005-09-10 15:41:34.000000000 -0400
+++ RC14-rc2-git6-saa6588/drivers/media/video/rds.h	2005-09-28 13:02:19.000000000 -0400
@@ -31,7 +31,7 @@
 struct rds_command {
 	unsigned int  block_count;
 	int           result;
-	unsigned char *buffer;
+	unsigned char __user *buffer;
 	struct file   *instance;
 	poll_table    *event_list;
 };
diff -urN RC14-rc2-git6-cyblafb/drivers/media/video/saa6588.c RC14-rc2-git6-saa6588/drivers/media/video/saa6588.c
--- RC14-rc2-git6-cyblafb/drivers/media/video/saa6588.c	2005-09-10 15:41:34.000000000 -0400
+++ RC14-rc2-git6-saa6588/drivers/media/video/saa6588.c	2005-09-28 13:02:19.000000000 -0400
@@ -157,7 +157,7 @@
 
 /* ---------------------------------------------------------------------- */
 
-static int block_to_user_buf(struct saa6588 *s, unsigned char *user_buf)
+static int block_to_user_buf(struct saa6588 *s, unsigned char __user *user_buf)
 {
 	int i;
 
@@ -191,7 +191,7 @@
 {
 	unsigned long flags;
 
-	unsigned char *buf_ptr = a->buffer;	/* This is a user space buffer! */
+	unsigned char __user *buf_ptr = a->buffer;
 	unsigned int i;
 	unsigned int rd_blocks;
 
