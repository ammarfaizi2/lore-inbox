Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTHZODS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTHZOBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:01:06 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:40111 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263782AbTHZOAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:00:00 -0400
Subject: [PATCH] Fix typo in #ifdef for ext2 xattr support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       ext2-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1061906380.23880.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Aug 2003 09:59:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects a typo in an ifdef that enables xattr operations for
special files in the ext2 code; otherwise, extended attributes cannot be
obtained or set on such inodes.

 fs/ext2/namei.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.5/fs/ext2/namei.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.5/fs/ext2/namei.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 namei.c
--- linux-2.5/fs/ext2/namei.c	11 Jul 2003 14:20:17 -0000	1.1.1.2
+++ linux-2.5/fs/ext2/namei.c	25 Aug 2003 16:57:27 -0000
@@ -143,7 +143,7 @@
 	int err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
 		init_special_inode(inode, inode->i_mode, rdev);
-#ifdef CONFIG_EXT2_FS_EXT_ATTR
+#ifdef CONFIG_EXT2_FS_XATTR
 		inode->i_op = &ext2_special_inode_operations;
 #endif
 		mark_inode_dirty(inode);


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

