Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030619AbWJJWiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030619AbWJJWiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030617AbWJJWin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:38:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61570 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932137AbWJJWi0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:38:26 -0400
To: torvalds@osdl.org
Subject: [PATCH 10/16] hpfs endianness annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQEz-0008WQ-TB@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:38:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 24 Dec 2005 14:31:53 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hpfs/inode.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index bcf6ee3..7faef85 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -60,14 +60,14 @@ void hpfs_read_inode(struct inode *i)
 	if (hpfs_sb(i->i_sb)->sb_eas) {
 		if ((ea = hpfs_get_ea(i->i_sb, fnode, "UID", &ea_size))) {
 			if (ea_size == 2) {
-				i->i_uid = le16_to_cpu(*(u16*)ea);
+				i->i_uid = le16_to_cpu(*(__le16*)ea);
 				hpfs_inode->i_ea_uid = 1;
 			}
 			kfree(ea);
 		}
 		if ((ea = hpfs_get_ea(i->i_sb, fnode, "GID", &ea_size))) {
 			if (ea_size == 2) {
-				i->i_gid = le16_to_cpu(*(u16*)ea);
+				i->i_gid = le16_to_cpu(*(__le16*)ea);
 				hpfs_inode->i_ea_gid = 1;
 			}
 			kfree(ea);
@@ -87,7 +87,7 @@ void hpfs_read_inode(struct inode *i)
 			int rdev = 0;
 			umode_t mode = hpfs_sb(sb)->sb_mode;
 			if (ea_size == 2) {
-				mode = le16_to_cpu(*(u16*)ea);
+				mode = le16_to_cpu(*(__le16*)ea);
 				hpfs_inode->i_ea_mode = 1;
 			}
 			kfree(ea);
@@ -95,7 +95,7 @@ void hpfs_read_inode(struct inode *i)
 			if (S_ISBLK(mode) || S_ISCHR(mode)) {
 				if ((ea = hpfs_get_ea(i->i_sb, fnode, "DEV", &ea_size))) {
 					if (ea_size == 4)
-						rdev = le32_to_cpu(*(u32*)ea);
+						rdev = le32_to_cpu(*(__le32*)ea);
 					kfree(ea);
 				}
 			}
@@ -148,7 +148,7 @@ static void hpfs_write_inode_ea(struct i
 		   we'd better not overwrite them
 		hpfs_error(i->i_sb, "fnode %08x has some unknown HPFS386 stuctures", i->i_ino);
 	} else*/ if (hpfs_sb(i->i_sb)->sb_eas >= 2) {
-		u32 ea;
+		__le32 ea;
 		if ((i->i_uid != hpfs_sb(i->i_sb)->sb_uid) || hpfs_inode->i_ea_uid) {
 			ea = cpu_to_le32(i->i_uid);
 			hpfs_set_ea(i, fnode, "UID", (char*)&ea, 2);
@@ -165,6 +165,7 @@ static void hpfs_write_inode_ea(struct i
 			  && i->i_mode != ((hpfs_sb(i->i_sb)->sb_mode & ~(S_ISDIR(i->i_mode) ? 0222 : 0333))
 			  | (S_ISDIR(i->i_mode) ? S_IFDIR : S_IFREG))) || hpfs_inode->i_ea_mode) {
 				ea = cpu_to_le32(i->i_mode);
+				/* sick, but legal */
 				hpfs_set_ea(i, fnode, "MODE", (char *)&ea, 2);
 				hpfs_inode->i_ea_mode = 1;
 			}
-- 
1.4.2.GIT


