Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSHFPms>; Tue, 6 Aug 2002 11:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSHFPms>; Tue, 6 Aug 2002 11:42:48 -0400
Received: from angband.namesys.com ([212.16.7.85]:43245 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S310190AbSHFPmq>; Tue, 6 Aug 2002 11:42:46 -0400
Date: Tue, 6 Aug 2002 19:46:18 +0400
From: Oleg Drokin <green@namesys.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-ac4
Message-ID: <20020806194618.A19899@namesys.com>
References: <200208051147.g75Blh720012@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <200208051147.g75Blh720012@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hello!

On Mon, Aug 05, 2002 at 07:47:43AM -0400, Alan Cox wrote:

> o	Fix __FUNCTION__ warnings in reiserfs		(me)

I see people reporting this change is not working correctly,
so I think I might as well submit my own implementation that works
and that we plan to push to Marcelo.

Bye,
    Oleg

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename=683

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.682   -> 1.683  
#	 fs/reiserfs/namei.c	1.20    -> 1.21   
#	include/linux/reiserfs_fs.h	1.18    -> 1.19   
#	fs/reiserfs/bitmap.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/06	green@angband.namesys.com	1.683
# reiserfs_fs.h, namei.c, bitmap.c:
#   fix __FUNCTION__ usage to prevent gcc 3.1+ warnings
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
--- a/fs/reiserfs/bitmap.c	Tue Aug  6 10:38:10 2002
+++ b/fs/reiserfs/bitmap.c	Tue Aug  6 10:38:10 2002
@@ -683,7 +683,7 @@
 {
 #ifdef CONFIG_REISERFS_CHECK
   if (inode->u.reiserfs_i.i_prealloc_count < 0)
-     reiserfs_warning("zam-4001:" __FUNCTION__ ": inode has negative prealloc blocks count.\n");
+     reiserfs_warning("zam-4001:%s: inode has negative prealloc blocks count.\n", __FUNCTION__);
 #endif  
     if (inode->u.reiserfs_i.i_prealloc_count > 0) {
     __discard_prealloc(th, inode);
@@ -699,7 +699,7 @@
     inode = list_entry(plist->next, struct inode, u.reiserfs_i.i_prealloc_list);
 #ifdef CONFIG_REISERFS_CHECK
     if (!inode->u.reiserfs_i.i_prealloc_count) {
-      reiserfs_warning("zam-4001:" __FUNCTION__ ": inode is in prealloc list but has no preallocated blocks.\n");
+      reiserfs_warning("zam-4001:%s: inode is in prealloc list but has no preallocated blocks.\n", __FUNCTION__);
     }
 #endif    
     __discard_prealloc(th, inode);
diff -Nru a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
--- a/fs/reiserfs/namei.c	Tue Aug  6 10:38:10 2002
+++ b/fs/reiserfs/namei.c	Tue Aug  6 10:38:10 2002
@@ -287,7 +287,7 @@
     while (1) {
 	retval = search_by_entry_key (dir->i_sb, &key_to_search, path_to_entry, de);
 	if (retval == IO_ERROR) {
-	    reiserfs_warning ("zam-7001: io error in " __FUNCTION__ "\n");
+	    reiserfs_warning ("zam-7001: io error in %s\n", __FUNCTION__);
 	    return IO_ERROR;
 	}
 
@@ -413,8 +413,8 @@
 	}
 
         if (retval != NAME_FOUND) {
-	    reiserfs_warning ("zam-7002:" __FUNCTION__ ": \"reiserfs_find_entry\" has returned"
-                              " unexpected value (%d)\n", retval);
+	    reiserfs_warning ("zam-7002:%s: \"reiserfs_find_entry\" has returned"
+                              " unexpected value (%d)\n", __FUNCTION__, retval);
        }
 
 	return -EEXIST;
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Tue Aug  6 10:38:10 2002
+++ b/include/linux/reiserfs_fs.h	Tue Aug  6 10:38:10 2002
@@ -75,9 +75,9 @@
 /** always check a condition and panic if it's false. */
 #define RASSERT( cond, format, args... )					\
 if( !( cond ) ) 								\
-  reiserfs_panic( 0, "reiserfs[%i]: assertion " #cond " failed at "		\
-		  __FILE__ ":%i:" __FUNCTION__ ": " format "\n",		\
-		  in_interrupt() ? -1 : current -> pid, __LINE__ , ##args )
+  reiserfs_panic( 0, "reiserfs[%i]: assertion " #cond " failed at "	\
+		  __FILE__ ":%i:%s: " format "\n",		\
+		  in_interrupt() ? -1 : current -> pid, __LINE__ , __FUNCTION__ , ##args )
 
 #if defined( CONFIG_REISERFS_CHECK )
 #define RFALSE( cond, format, args... ) RASSERT( !( cond ), format, ##args )

--k+w/mQv8wyuph6w0--
