Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030615AbWJJWhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030615AbWJJWhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030613AbWJJWhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:37:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59266 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030612AbWJJWhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:37:36 -0400
To: torvalds@osdl.org
Subject: [PATCH 5/16] befs: prepare to sanitizing headers
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQEB-0008V3-Pm@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:37:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 24 Dec 2005 01:13:13 -0500

pulled includes of endian.h from fs/befs/*.c to befs.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/befs/befs.h       |    2 ++
 fs/befs/btree.c      |    1 -
 fs/befs/datastream.c |    1 -
 fs/befs/debug.c      |    1 -
 fs/befs/endian.h     |    1 -
 fs/befs/inode.c      |    1 -
 fs/befs/linuxvfs.c   |    1 -
 fs/befs/super.c      |    1 -
 8 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/befs/befs.h b/fs/befs/befs.h
index 057a2c3..c400bb6 100644
--- a/fs/befs/befs.h
+++ b/fs/befs/befs.h
@@ -151,4 +151,6 @@ befs_brun_size(struct super_block *sb, b
 	return BEFS_SB(sb)->block_size * run.len;
 }
 
+#include "endian.h"
+
 #endif				/* _LINUX_BEFS_H */
diff --git a/fs/befs/btree.c b/fs/befs/btree.c
index 76e2197..12e0fd6 100644
--- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -30,7 +30,6 @@ #include <linux/buffer_head.h>
 #include "befs.h"
 #include "btree.h"
 #include "datastream.h"
-#include "endian.h"
 
 /*
  * The btree functions in this file are built on top of the
diff --git a/fs/befs/datastream.c b/fs/befs/datastream.c
index b7d6b92..67335e2 100644
--- a/fs/befs/datastream.c
+++ b/fs/befs/datastream.c
@@ -18,7 +18,6 @@ #include <linux/string.h>
 #include "befs.h"
 #include "datastream.h"
 #include "io.h"
-#include "endian.h"
 
 const befs_inode_addr BAD_IADDR = { 0, 0, 0 };
 
diff --git a/fs/befs/debug.c b/fs/befs/debug.c
index 875cc0a..3afd088 100644
--- a/fs/befs/debug.c
+++ b/fs/befs/debug.c
@@ -21,7 +21,6 @@ #include <linux/fs.h>
 #endif				/* __KERNEL__ */
 
 #include "befs.h"
-#include "endian.h"
 
 #define ERRBUFSIZE 1024
 
diff --git a/fs/befs/endian.h b/fs/befs/endian.h
index 9ecaea4..d77a26e 100644
--- a/fs/befs/endian.h
+++ b/fs/befs/endian.h
@@ -10,7 +10,6 @@ #ifndef LINUX_BEFS_ENDIAN
 #define LINUX_BEFS_ENDIAN
 
 #include <linux/byteorder/generic.h>
-#include "befs.h"
 
 static inline u64
 fs64_to_cpu(const struct super_block *sb, u64 n)
diff --git a/fs/befs/inode.c b/fs/befs/inode.c
index d41c924..94c17f9 100644
--- a/fs/befs/inode.c
+++ b/fs/befs/inode.c
@@ -8,7 +8,6 @@ #include <linux/fs.h>
 
 #include "befs.h"
 #include "inode.h"
-#include "endian.h"
 
 /*
 	Validates the correctness of the befs inode
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 57020c7..07f7144 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -22,7 +22,6 @@ #include "inode.h"
 #include "datastream.h"
 #include "super.h"
 #include "io.h"
-#include "endian.h"
 
 MODULE_DESCRIPTION("BeOS File System (BeFS) driver");
 MODULE_AUTHOR("Will Dyson");
diff --git a/fs/befs/super.c b/fs/befs/super.c
index 4557acb..8c3401f 100644
--- a/fs/befs/super.c
+++ b/fs/befs/super.c
@@ -11,7 +11,6 @@ #include <linux/fs.h>
 
 #include "befs.h"
 #include "super.h"
-#include "endian.h"
 
 /**
  * load_befs_sb -- Read from disk and properly byteswap all the fields
-- 
1.4.2.GIT


