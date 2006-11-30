Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936254AbWK3MLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936254AbWK3MLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936256AbWK3MLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:11:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34181 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936254AbWK3MLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:11:52 -0500
Subject: [GFS2] gfs2_dinode_host fields are host-endian [2/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:12:34 +0000
Message-Id: <1164888754.3752.305.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 5c6edb576f3800723bb65dbfaff82517089e32d0 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 20:33:01 -0400
Subject: [PATCH] [GFS2] gfs2_dinode_host fields are host-endian

Annotated scalar fields, dropped unused ones.  Note that
it's not at all obvious that we want to convert all of them
to host-endian...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/incore.h            |    2 +-
 include/linux/gfs2_ondisk.h |   47 ++++++++++++++++++-------------------------
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 118dc69..1c876e0 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -229,7 +229,7 @@ struct gfs2_inode {
 	unsigned long i_flags;		/* GIF_... */
 
 	u64 i_vn;
-	struct gfs2_dinode i_di; /* To be replaced by ref to block */
+	struct gfs2_dinode_host i_di; /* To be replaced by ref to block */
 
 	struct gfs2_glock *i_gl; /* Move into i_gh? */
 	struct gfs2_holder i_iopen_gh;
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index f334b4b..0e67a89 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -275,41 +275,34 @@ struct gfs2_dinode_host {
 
 	struct gfs2_inum di_num;
 
-	__be32 di_mode;	/* mode of file */
-	__be32 di_uid;	/* owner's user id */
-	__be32 di_gid;	/* owner's group id */
-	__be32 di_nlink;	/* number of links to this file */
-	__be64 di_size;	/* number of bytes in file */
-	__be64 di_blocks;	/* number of blocks in file */
-	__be64 di_atime;	/* time last accessed */
-	__be64 di_mtime;	/* time last modified */
-	__be64 di_ctime;	/* time last changed */
-	__be32 di_major;	/* device major number */
-	__be32 di_minor;	/* device minor number */
+	__u32 di_mode;	/* mode of file */
+	__u32 di_uid;	/* owner's user id */
+	__u32 di_gid;	/* owner's group id */
+	__u32 di_nlink;	/* number of links to this file */
+	__u64 di_size;	/* number of bytes in file */
+	__u64 di_blocks;	/* number of blocks in file */
+	__u64 di_atime;	/* time last accessed */
+	__u64 di_mtime;	/* time last modified */
+	__u64 di_ctime;	/* time last changed */
+	__u32 di_major;	/* device major number */
+	__u32 di_minor;	/* device minor number */
 
 	/* This section varies from gfs1. Padding added to align with
          * remainder of dinode
 	 */
-	__be64 di_goal_meta;	/* rgrp to alloc from next */
-	__be64 di_goal_data;	/* data block goal */
-	__be64 di_generation;	/* generation number for NFS */
+	__u64 di_goal_meta;	/* rgrp to alloc from next */
+	__u64 di_goal_data;	/* data block goal */
+	__u64 di_generation;	/* generation number for NFS */
 
-	__be32 di_flags;	/* GFS2_DIF_... */
-	__be32 di_payload_format;  /* GFS2_FORMAT_... */
-	__u16 __pad1;	/* Was ditype in gfs1 */
-	__be16 di_height;	/* height of metadata */
-	__u32 __pad2;	/* Unused incarnation number from gfs1 */
+	__u32 di_flags;	/* GFS2_DIF_... */
+	__u32 di_payload_format;  /* GFS2_FORMAT_... */
+	__u16 di_height;	/* height of metadata */
 
 	/* These only apply to directories  */
-	__u16 __pad3;	/* Padding */
-	__be16 di_depth;	/* Number of bits in the table */
-	__be32 di_entries;	/* The number of entries in the directory */
-
-	struct gfs2_inum __pad4; /* Unused even in current gfs1 */
+	__u16 di_depth;	/* Number of bits in the table */
+	__u32 di_entries;	/* The number of entries in the directory */
 
-	__be64 di_eattr;	/* extended attribute block number */
-
-	__u8 di_reserved[56];
+	__u64 di_eattr;	/* extended attribute block number */
 };
 
 /*
-- 
1.4.1



