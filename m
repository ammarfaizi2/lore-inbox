Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318105AbSFTCyW>; Wed, 19 Jun 2002 22:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318106AbSFTCyV>; Wed, 19 Jun 2002 22:54:21 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:19660 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S318105AbSFTCyU>;
	Wed, 19 Jun 2002 22:54:20 -0400
Date: Thu, 20 Jun 2002 12:53:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] ext2 statics
Message-Id: <20020620125338.64cbe90d.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch just changes some things in ext2 to be static.

I am not sure who the ext2 maintainer is, but I am pretty sure it
is not Remy Card who is listed in the MAINTAINERS file.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.23/fs/ext2/balloc.c 2.5.23-sfr.3/fs/ext2/balloc.c
--- 2.5.23/fs/ext2/balloc.c	Sat May 25 21:20:13 2002
+++ 2.5.23-sfr.3/fs/ext2/balloc.c	Thu Jun 20 12:34:56 2002
@@ -602,7 +602,7 @@
 	}
 }
 
-int ext2_group_sparse(int group)
+static int ext2_group_sparse(int group)
 {
 	return (test_root(group, 3) || test_root(group, 5) ||
 		test_root(group, 7));
diff -ruN 2.5.23/fs/ext2/ext2.h 2.5.23-sfr.3/fs/ext2/ext2.h
--- 2.5.23/fs/ext2/ext2.h	Mon Apr 15 06:13:17 2002
+++ 2.5.23-sfr.3/fs/ext2/ext2.h	Thu Jun 20 12:42:35 2002
@@ -92,10 +92,7 @@
 extern void ext2_warning (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
 extern void ext2_update_dynamic_rev (struct super_block *sb);
-extern void ext2_put_super (struct super_block *);
 extern void ext2_write_super (struct super_block *);
-extern int ext2_remount (struct super_block *, int *, char *);
-extern int ext2_statfs (struct super_block *, struct statfs *);
 
 /*
  * Inodes and files operations
diff -ruN 2.5.23/fs/ext2/super.c 2.5.23-sfr.3/fs/ext2/super.c
--- 2.5.23/fs/ext2/super.c	Sat May 25 21:20:13 2002
+++ 2.5.23-sfr.3/fs/ext2/super.c	Thu Jun 20 12:42:54 2002
@@ -31,6 +31,8 @@
 
 static void ext2_sync_super(struct super_block *sb,
 			    struct ext2_super_block *es);
+static int ext2_remount (struct super_block * sb, int * flags, char * data);
+static int ext2_statfs (struct super_block * sb, struct statfs * buf);
 
 static char error_buf[1024];
 
@@ -123,7 +125,7 @@
 	 */
 }
 
-void ext2_put_super (struct super_block * sb)
+static void ext2_put_super (struct super_block * sb)
 {
 	int db_count;
 	int i;
@@ -772,7 +774,7 @@
 	unlock_kernel();
 }
 
-int ext2_remount (struct super_block * sb, int * flags, char * data)
+static int ext2_remount (struct super_block * sb, int * flags, char * data)
 {
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_super_block * es;
@@ -827,7 +829,7 @@
 	return 0;
 }
 
-int ext2_statfs (struct super_block * sb, struct statfs * buf)
+static int ext2_statfs (struct super_block * sb, struct statfs * buf)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	unsigned long overhead;
