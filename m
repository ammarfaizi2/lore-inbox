Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266369AbSKUHFU>; Thu, 21 Nov 2002 02:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbSKUHFU>; Thu, 21 Nov 2002 02:05:20 -0500
Received: from miranda.axis.se ([193.13.178.2]:39110 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S266369AbSKUHFT>;
	Thu, 21 Nov 2002 02:05:19 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE3ED@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'jffs-dev@axis.com'" <jffs-dev@axis.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH]  d_delete in jffs causes oops (2.5.48)
Date: Thu, 21 Nov 2002 08:12:19 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jffs_remove calls d_delete(dentry). vfs_unlink then tries to access dentry->d_inode->i_sem
and calls d_delete(dentry). 

Suggested patch:

--- inode-v23.c	20 Nov 2002 11:57:45 -0000	1.4
+++ inode-v23.c	20 Nov 2002 19:45:07 -0000
@@ -1063,8 +1063,6 @@
 	inode->i_ctime = dir->i_ctime;
 	mark_inode_dirty(inode);
 
-	d_delete(dentry);	/* This also frees the inode */
-
 	result = 0;
 jffs_remove_end:
 	return result;

Can the JFFS guys verify that this doesn't cause a memory leak?

/Mikael
