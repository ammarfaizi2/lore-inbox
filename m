Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbUKUV6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbUKUV6z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 16:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbUKUV6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 16:58:55 -0500
Received: from mail.dif.dk ([193.138.115.101]:14803 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261818AbUKUV6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 16:58:53 -0500
Date: Sun, 21 Nov 2004 23:08:21 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Hans Reiser <reiser@namesys.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] silence sparse warning in fs/reiserfs/namei.c about using
 plain integer as NULL pointer
Message-ID: <Pine.LNX.4.61.0411212304180.3423@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

sparse complains about passing 0 to functions execting a pointer argument:

  CHECK   fs/reiserfs/namei.c
fs/reiserfs/namei.c:617:50: warning: Using plain integer as NULL pointer

Trivial patch to change it to pass NULL instead below.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk6-orig/fs/reiserfs/namei.c linux-2.6.10-rc2-bk6/fs/reiserfs/namei.c
--- linux-2.6.10-rc2-bk6-orig/fs/reiserfs/namei.c	2004-11-17 01:20:16.000000000 +0100
+++ linux-2.6.10-rc2-bk6/fs/reiserfs/namei.c	2004-11-21 22:52:41.000000000 +0100
@@ -614,7 +614,7 @@ static int reiserfs_create (struct inode
         goto out_failed;
     }
 
-    retval = reiserfs_new_inode (&th, dir, mode, 0, 0/*i_size*/, dentry, inode);
+    retval = reiserfs_new_inode (&th, dir, mode, NULL, 0/*i_size*/, dentry, inode);
     if (retval)
         goto out_failed;
 	


