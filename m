Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVBAFOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVBAFOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 00:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVBAFOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 00:14:33 -0500
Received: from waste.org ([216.27.176.166]:23957 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261543AbVBAFO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 00:14:27 -0500
Date: Mon, 31 Jan 2005 21:14:24 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFS ACL build fix, POSIX ACL config tidy
Message-ID: <20050201051424.GB2955@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if I've sent this twice:

Build fix for NFS ACLs and cleanup of POSIX ACL config.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm2/fs/Kconfig
===================================================================
--- mm2.orig/fs/Kconfig	2005-01-30 21:26:27.000000000 -0800
+++ mm2/fs/Kconfig	2005-01-30 21:32:26.000000000 -0800
@@ -29,6 +29,7 @@
 config EXT2_FS_POSIX_ACL
 	bool "Ext2 POSIX Access Control Lists"
 	depends on EXT2_FS_XATTR
+	select FS_POSIX_ACL
 	help
 	  Posix Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
@@ -97,6 +98,7 @@
 config EXT3_FS_POSIX_ACL
 	bool "Ext3 POSIX Access Control Lists"
 	depends on EXT3_FS_XATTR
+	select FS_POSIX_ACL
 	help
 	  Posix Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
@@ -226,6 +228,7 @@
 config REISERFS_FS_POSIX_ACL
 	bool "ReiserFS POSIX Access Control Lists"
 	depends on REISERFS_FS_XATTR
+	select FS_POSIX_ACL
 	help
 	  Posix Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
@@ -259,6 +262,7 @@
 config JFS_POSIX_ACL
 	bool "JFS POSIX Access Control Lists"
 	depends on JFS_FS
+	select FS_POSIX_ACL
 	help
 	  Posix Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
@@ -303,8 +307,7 @@
 # 	Never use this symbol for ifdefs.
 #
 	bool
-	depends on EXT2_FS_POSIX_ACL || EXT3_FS_POSIX_ACL || JFS_POSIX_ACL || REISERFS_FS_POSIX_ACL || NFSD_V4
-	default y
+	default n
 
 source "fs/xfs/Kconfig"
 
@@ -1426,6 +1429,7 @@
 	bool "NFS_ACL protocol extension"
 	depends on NFS_V3
 	select QSORT
+	select FS_POSIX_ACL
 	help
 	  Implement the NFS_ACL protocol extension for manipulating POSIX
 	  Access Control Lists.  The server must also implement the NFS_ACL


-- 
Mathematics is the supreme nostalgia of our time.
