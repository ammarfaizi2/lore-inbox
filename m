Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263354AbREXGtq>; Thu, 24 May 2001 02:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263361AbREXGth>; Thu, 24 May 2001 02:49:37 -0400
Received: from [195.211.46.202] ([195.211.46.202]:53573 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S263354AbREXGt2>;
	Thu, 24 May 2001 02:49:28 -0400
Date: Thu, 24 May 2001 08:46:29 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG][PATCH] linux-2.4.5-pre5/drivers/isdn/avmb1/capifs.c
Message-ID: <Pine.LNX.4.33.0105240844030.941-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml!

capifs.c is broken in 2.4.5-pre5:
- A forward declaration of capifs_new_inode() is needed
- The semicolon at the end of line musrt be deleted
- struct inode * was not declared

--- linux-2.4.5/drivers/isdn/avmb1/capifs.c.orig	Thu May 24 08:42:43 2001
+++ linux-2.4.5/drivers/isdn/avmb1/capifs.c	Thu May 24 08:43:15 2001
@@ -142,6 +142,7 @@
 static int capifs_root_readdir(struct file *,void *,filldir_t);
 static struct dentry *capifs_root_lookup(struct inode *,struct dentry *);
 static int capifs_revalidate(struct dentry *, int);
+static struct inode *capifs_new_inode(struct super_block *sb);

 static struct file_operations capifs_root_operations = {
 	read:		generic_read_dir,
@@ -491,9 +492,9 @@
 }
 #endif

-static struct inode *capifs_new_inode(struct super_block *sb);
+static struct inode *capifs_new_inode(struct super_block *sb)
 {
-	inode = new_inode(sb);
+	struct inode *inode = new_inode(sb);
 	if (inode) {
 		inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 		inode->i_blocks = 0;

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

