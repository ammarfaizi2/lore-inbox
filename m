Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbSI1Rwc>; Sat, 28 Sep 2002 13:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262300AbSI1Rwc>; Sat, 28 Sep 2002 13:52:32 -0400
Received: from mxall.mxgrp.airmail.net ([209.196.77.108]:49925 "EHLO
	mx11.airmail.net") by vger.kernel.org with ESMTP id <S262298AbSI1Rwa>;
	Sat, 28 Sep 2002 13:52:30 -0400
Date: Sat, 28 Sep 2002 12:57:50 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: C99 desiginated initializer patch for fs/devpts
Message-ID: <20020928175750.GD22783@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a small patch for fs/devpts/inode.c to switch it to use
C99 designated initializers. The patch is against 2.5.39.

Art Haas

--- linux-2.5.39/fs/devpts/inode.c.old	2002-07-05 18:42:18.000000000 -0500
+++ linux-2.5.39/fs/devpts/inode.c	2002-09-28 10:36:22.000000000 -0500
@@ -27,7 +27,7 @@
 	uid_t   uid;
 	gid_t   gid;
 	umode_t mode;
-} config = {mode: 0600};
+} config = {.mode = 0600};
 
 static int devpts_remount(struct super_block *sb, int *flags, char *data)
 {
@@ -67,8 +67,8 @@
 }
 
 static struct super_operations devpts_sops = {
-	statfs:		simple_statfs,
-	remount_fs:	devpts_remount,
+	.statfs		= simple_statfs,
+	.remount_fs	= devpts_remount,
 };
 
 static int devpts_fill_super(struct super_block *s, void *data, int silent)
@@ -110,10 +110,10 @@
 }
 
 static struct file_system_type devpts_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"devpts",
-	get_sb:		devpts_get_sb,
-	kill_sb:	kill_anon_super,
+	.owner		= THIS_MODULE,
+	.name		= "devpts",
+	.get_sb		= devpts_get_sb,
+	.kill_sb	= kill_anon_super,
 };
 
 /*
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
