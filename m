Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVCYVUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVCYVUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVCYVUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:20:03 -0500
Received: from mail.dif.dk ([193.138.115.101]:10419 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261807AbVCYVTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:19:55 -0500
Date: Fri, 25 Mar 2005 22:21:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove not needed checks for NULL before calling kfree()
 for fs/befs/
Message-ID: <Pine.LNX.4.62.0503252219200.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's no problem in passing kfree() a NULL pointer. Checking first is 
not needed.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/befs/linuxvfs.c	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/befs/linuxvfs.c	2005-03-25 21:36:53.000000000 +0100
@@ -731,20 +731,16 @@ parse_options(char *options, befs_mount_
 static void
 befs_put_super(struct super_block *sb)
 {
-	if (BEFS_SB(sb)->mount_opts.iocharset) {
-		kfree(BEFS_SB(sb)->mount_opts.iocharset);
-		BEFS_SB(sb)->mount_opts.iocharset = NULL;
-	}
+	kfree(BEFS_SB(sb)->mount_opts.iocharset);
+	BEFS_SB(sb)->mount_opts.iocharset = NULL;
 
 	if (BEFS_SB(sb)->nls) {
 		unload_nls(BEFS_SB(sb)->nls);
 		BEFS_SB(sb)->nls = NULL;
 	}
 
-	if (sb->s_fs_info) {
-		kfree(sb->s_fs_info);
-		sb->s_fs_info = NULL;
-	}
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
 	return;
 }
 


