Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267194AbUHMTCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267194AbUHMTCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUHMTAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:00:49 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:58844 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S266820AbUHMS5F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:57:05 -0400
Message-ID: <411D0ECA.70201@ttnet.net.tr>
Date: Fri, 13 Aug 2004 21:56:10 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] befs fixes
Content-Type: multipart/mixed;
	boundary="------------050403090901090609040808"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050403090901090609040808
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: quoted-printable

various befs fixes. one is unused xattr code.
the other is unreached code fixed the same way in 2.6.

=D6zkan Sezer


--------------050403090901090609040808
Content-Type: text/plain;
	name="befs-unreached.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="befs-unreached.diff"

--- 27rc5~/fs/befs/linuxvfs.c	2003-06-13 17:51:37.000000000 +0300
+++ 27rc5/fs/befs/linuxvfs.c	2004-08-07 14:09:39.000000000 +0300
@@ -584,11 +577,11 @@
 		}
 	}
 	result[o] = '\0';
+	*out_len = o;
 
 	befs_debug(sb, "<--- utf2nls()");
 
 	return o;
-	*out_len = o;
 
       conv_err:
 	befs_error(sb, "Name using charecter set %s contains a charecter that "


--------------050403090901090609040808
Content-Type: text/plain;
	name="befs-unused-xattr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="befs-unused-xattr.diff"

--- 27rc5~/fs/befs/linuxvfs.c	2003-06-13 17:51:37.000000000 +0300
+++ 27rc5/fs/befs/linuxvfs.c	2004-08-07 14:09:39.000000000 +0300
@@ -55,13 +55,6 @@
 static int befs_statfs(struct super_block *, struct statfs *);
 static int parse_options(char *, befs_mount_options *);
 
-static ssize_t befs_listxattr(struct dentry *dentry, char *buffer, size_t size);
-static ssize_t befs_getxattr(struct dentry *dentry, const char *name,
-			     void *buffer, size_t size);
-static int befs_setxattr(struct dentry *dentry, const char *name, void *value,
-			 size_t size, int flags);
-static int befs_removexattr(struct dentry *dentry, const char *name);
-
 /* slab cache for befs_inode_info objects */
 static kmem_cache_t *befs_inode_cachep;
 
@@ -675,35 +668,6 @@
 	return -EILSEQ;
 }
 
-/****Xattr****/
-
-static ssize_t
-befs_listxattr(struct dentry *dentry, char *buffer, size_t size)
-{
-	printk(KERN_ERR "befs_listxattr called\n");
-	return 0;
-}
-
-static ssize_t
-befs_getxattr(struct dentry *dentry, const char *name,
-	      void *buffer, size_t size)
-{
-	return 0;
-}
-
-static int
-befs_setxattr(struct dentry *dentry, const char *name,
-	      void *value, size_t size, int flags)
-{
-	return 0;
-}
-
-static int
-befs_removexattr(struct dentry *dentry, const char *name)
-{
-	return 0;
-}
-
 /****Superblock****/
 
 static int


--------------050403090901090609040808--
