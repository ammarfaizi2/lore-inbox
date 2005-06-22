Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVFVB2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVFVB2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbVFVB2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:28:00 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:29088 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262480AbVFVBZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:25:43 -0400
Message-Id: <200506220125.j5M1PYe1007343@ms-smtp-02-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Tue, 21 Jun 2005 20:24:21 -0500
To: linux-kernel@vger.kernel.org
Subject: [-mm PATCH] v9fs: Fix support for special files (devices, named pipes, etc.)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix v9fs special files (block, char devices) support.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit 215b1ec24f03d17163f43753eafc15bb7d5ca9cd
tree af5931d9ea737636c61147e18c815d7cc11be8a6
parent 90d763e77646e85c987fc550d19ff931554aba60
author Eric Van Hensbergen <ericvh@gmail.com> Tue, 21 Jun 2005 20:14:38 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Tue, 21 Jun 2005 20:14:38 -0500

 fs/9p/vfs_inode.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -250,6 +250,9 @@ struct inode *v9fs_get_inode(struct supe
 		case S_IFBLK:
 		case S_IFCHR:
 		case S_IFSOCK:
+			init_special_inode(inode, inode->i_mode,
+					   inode->i_rdev);
+			break;
 		case S_IFREG:
 			inode->i_op = &v9fs_file_inode_operations;
 			inode->i_fop = &v9fs_file_operations;
