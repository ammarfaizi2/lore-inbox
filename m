Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbVKZQvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbVKZQvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 11:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422665AbVKZQvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 11:51:16 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:30203 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1422663AbVKZQvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 11:51:15 -0500
Date: Sat, 26 Nov 2005 11:50:45 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] v9fs: fix memory leak in v9fs dentry code
Message-ID: <20051126165045.GA27111@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assign the appropriate dentry operations to the dentry. Fixes memory leak.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit 1a6e02daf77d610278380537ff3f5687a205dac8
tree 3b53740d44c07d4c8db4e0a0df11794697ab9549
parent 2d0ebb36038c0626cde662a3b06da9787cfb68c3
author Latchesar Ionkov <lucho@ionkov.net> Sat, 26 Nov 2005 10:39:47 -0500
committer Latchesar Ionkov <lucho@ionkov.net> Sat, 26 Nov 2005 10:39:47 -0500

 fs/9p/vfs_inode.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -427,6 +427,8 @@ v9fs_create(struct inode *dir,
 
 	v9fs_mistat2inode(fcall->params.rstat.stat, file_inode, sb);
 	kfree(fcall);
+	fcall = NULL;
+	file_dentry->d_op = &v9fs_dentry_operations;
 	d_instantiate(file_dentry, file_inode);
 
 	if (perm & V9FS_DMDIR) {
