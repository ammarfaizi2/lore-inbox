Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319100AbSHFMnl>; Tue, 6 Aug 2002 08:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319104AbSHFMnl>; Tue, 6 Aug 2002 08:43:41 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7177 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S319100AbSHFMnj>;
	Tue, 6 Aug 2002 08:43:39 -0400
Message-ID: <3D4FC52E.7020006@namesys.com>
Date: Tue, 06 Aug 2002 16:46:38 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] [BK] correct __FUNCTION__ usage as string literal in reiserfs.
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

     You can pull this changeset from bk://thebsh.namesys.com/bk/reiser3-linux-2.5
     It fixes usage of __FUNCTION__ preprocessor defines as string literals in
     reiserfs code, since such usage is deprecated now.

     Diffstat:
  fs/reiserfs/bitmap.c        |    4 ++--
  fs/reiserfs/namei.c         |    6 +++---
  include/linux/reiserfs_fs.h |    6 +++---
  3 files changed, 8 insertions(+), 8 deletions(-)

    Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
# 
            ChangeSet	1.469   -> 1.470
# 
  fs/reiserfs/namei.c	1.40    -> 1.41
# 
fs/reiserfs/bitmap.c 
1.20    -> 1.21
# 
include/linux/reiserfs_fs.h 
1.39    -> 1.40
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/06	green@angband.namesys.com	1.470
# reiserfs_fs.h, namei.c, bitmap.c:
#   fix __FUNCTION__ usage, since its use in string literals is deprecated now.
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Tue Aug  6 10:58:15 2002
+++ b/fs/reiserfs/bitmap.c	Tue Aug  6 10:58:15 2002
@@ -689,7 +689,7 @@
    struct reiserfs_inode_info *ei = REISERFS_I(inode);
  #ifdef CONFIG_REISERFS_CHECK
    if (ei->i_prealloc_count < 0)
-     reiserfs_warning("zam-4001:" __FUNCTION__ ": inode has negative prealloc 
blocks count.\n");
+     reiserfs_warning("zam-4001:%s inode has negative prealloc blocks 
count.\n", __FUNCTION__);
  #endif
      if (ei->i_prealloc_count > 0) {
      __discard_prealloc(th, ei);
@@ -705,7 +705,7 @@
  	ei = list_entry(plist->next, struct reiserfs_inode_info, i_prealloc_list);
  #ifdef CONFIG_REISERFS_CHECK
  	if (!ei->i_prealloc_count) {
- 
	reiserfs_warning("zam-4001:" __FUNCTION__ ": inode is in prealloc list but has no 
preallocated blocks.\n");
+ 
	reiserfs_warning("zam-4001:%s: inode is in prealloc list but has no preallocated 
blocks.\n", __FUNCTION__);
  	}
  #endif
  	__discard_prealloc(th, ei);
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Tue Aug  6 10:58:15 2002
+++ b/fs/reiserfs/namei.c	Tue Aug  6 10:58:15 2002
@@ -296,7 +296,7 @@
      while (1) {
  	retval = search_by_entry_key (dir->i_sb, &key_to_search, path_to_entry, de);
  	if (retval == IO_ERROR) {
- 
     reiserfs_warning ("zam-7001: io error in " __FUNCTION__ "\n");
+ 
     reiserfs_warning ("zam-7001: io error in %s\n", __FUNCTION__);
  	    return IO_ERROR;
  	}

@@ -468,8 +468,8 @@
  	}

          if (retval != NAME_FOUND) {
- 
     reiserfs_warning ("zam-7002:" __FUNCTION__ ": \"reiserfs_find_entry\" has 
returned"
-                              " unexpected value (%d)\n", retval);
+ 
     reiserfs_warning ("zam-7002:%s: \"reiserfs_find_entry\" has returned"
+                              " unexpected value (%d)\n", __FUNCTION__, retval);
         }

  	return -EEXIST;
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Tue Aug  6 10:58:15 2002
+++ b/include/linux/reiserfs_fs.h	Tue Aug  6 10:58:15 2002
@@ -79,9 +79,9 @@
  /** always check a condition and panic if it's false. */
  #define RASSERT( cond, format, args... )					\
  if( !( cond ) ) 								\
-  reiserfs_panic( 0, "reiserfs[%i]: assertion " #cond " failed at "		\
- 
	  __FILE__ ":%i:" __FUNCTION__ ": " format "\n",		\
- 
	  in_interrupt() ? -1 : current -> pid, __LINE__ , ##args )
+  reiserfs_panic( 0, "reiserfs[%i]: assertion " #cond " failed at "	\
+ 
	  __FILE__ ":%i:%s: " format "\n",		\
+ 
	  in_interrupt() ? -1 : current -> pid, __LINE__ , __FUNCTION__ , ##args )

  #if defined( CONFIG_REISERFS_CHECK )
  #define RFALSE( cond, format, args... ) RASSERT( !( cond ), format, ##args )

Bye,
     Oleg



