Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262398AbSJEQOF>; Sat, 5 Oct 2002 12:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262401AbSJEQOE>; Sat, 5 Oct 2002 12:14:04 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:3583 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S262398AbSJEQOC>; Sat, 5 Oct 2002 12:14:02 -0400
Message-ID: <3D9F114E.30709@quark.didntduck.org>
Date: Sat, 05 Oct 2002 12:20:30 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] struct super_block cleanup - ext3
Content-Type: multipart/mixed;
 boundary="------------050704060305000107010604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050704060305000107010604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Removes the last member of the union, ext3.

--
				Brian Gerst

--------------050704060305000107010604
Content-Type: text/plain;
 name="sb-ext3-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-ext3-1"

diff -urN linux/include/linux/ext3_fs.h linux2/include/linux/ext3_fs.h
--- linux/include/linux/ext3_fs.h	Wed Sep 18 00:06:55 2002
+++ linux2/include/linux/ext3_fs.h	Sat Oct  5 11:46:42 2002
@@ -17,6 +17,7 @@
 #define _LINUX_EXT3_FS_H
 
 #include <linux/types.h>
+#include <linux/ext3_fs_sb.h>
 
 /*
  * The second extended filesystem constants/structures
diff -urN linux/include/linux/fs.h linux2/include/linux/fs.h
--- linux/include/linux/fs.h	Sat Oct  5 01:30:14 2002
+++ linux2/include/linux/fs.h	Sat Oct  5 11:45:06 2002
@@ -627,8 +627,6 @@
 #define MNT_FORCE	0x00000001	/* Attempt to forcibily umount */
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
 
-#include <linux/ext3_fs_sb.h>
-
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
 
@@ -669,7 +667,6 @@
 	char s_id[32];				/* Informational name */
 
 	union {
-		struct ext3_sb_info	ext3_sb;
 		void			*generic_sbp;
 	} u;
 	/*

--------------050704060305000107010604--

