Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVCYVQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVCYVQv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVCYVQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:16:51 -0500
Received: from mail.dif.dk ([193.138.115.101]:65202 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261788AbVCYVQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:16:48 -0500
Date: Fri, 25 Mar 2005 22:18:44 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove redundant NULL checks before kfree for fs/affs/
Message-ID: <Pine.LNX.4.62.0503252216140.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kfree() handles NULL pointers just fine, no need to check first.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm3-orig/fs/affs/super.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.12-rc1-mm3/fs/affs/super.c	2005-03-25 21:35:12.000000000 +0100
@@ -35,8 +35,7 @@ affs_put_super(struct super_block *sb)
 		mark_buffer_dirty(sbi->s_root_bh);
 	}
 
-	if (sbi->s_prefix)
-		kfree(sbi->s_prefix);
+	kfree(sbi->s_prefix);
 	affs_free_bitmap(sb);
 	affs_brelse(sbi->s_root_bh);
 	kfree(sbi);
@@ -198,10 +197,7 @@ parse_options(char *options, uid_t *uid,
 			*mount_opts |= SF_MUFS;
 			break;
 		case Opt_prefix:
-			if (*prefix) {		/* Free any previous prefix */
-				kfree(*prefix);
-				*prefix = NULL;
-			}
+			kfree(*prefix);
 			*prefix = match_strdup(&args[0]);
 			if (!*prefix)
 				return 0;
@@ -462,11 +458,9 @@ got_root:
 out_error:
 	if (root_inode)
 		iput(root_inode);
-	if (sbi->s_bitmap)
-		kfree(sbi->s_bitmap);
+	kfree(sbi->s_bitmap);
 	affs_brelse(root_bh);
-	if (sbi->s_prefix)
-		kfree(sbi->s_prefix);
+	kfree(sbi->s_prefix);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 	return -EINVAL;


