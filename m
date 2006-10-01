Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWJAUmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWJAUmH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWJAUmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:42:07 -0400
Received: from mail.gmx.de ([213.165.64.20]:17804 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932348AbWJAUmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:42:06 -0400
X-Authenticated: #704063
Subject: [Patch] Remove unnecessary check in fs/reiserfs/inode.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: reiserfs-dev@namesys.com
Content-Type: text/plain
Date: Sun, 01 Oct 2006 22:41:57 +0200
Message-Id: <1159735317.11887.10.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

since all callers dereference dir, we dont need this check.
Coverity id #337.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git16/fs/reiserfs/inode.c.orig	2006-10-01 22:40:24.000000000 +0200
+++ linux-2.6.18-git16/fs/reiserfs/inode.c	2006-10-01 22:40:35.000000000 +0200
@@ -1780,7 +1780,7 @@ int reiserfs_new_inode(struct reiserfs_t
 		err = -EDQUOT;
 		goto out_end_trans;
 	}
-	if (!dir || !dir->i_nlink) {
+	if (!dir->i_nlink) {
 		err = -EPERM;
 		goto out_bad_inode;
 	}


