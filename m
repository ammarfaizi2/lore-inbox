Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422813AbWJRUZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbWJRUZM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422872AbWJRUZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:25:11 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:63942 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422813AbWJRUZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:25:09 -0400
Date: Wed, 18 Oct 2006 13:26:23 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs/Kconfig: move GENERIC_ACL, fix acl() call errors
Message-Id: <20061018132623.79c4b42f.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

GENERIC_ACL shouldn't be under Network File Systems (which made it
depend on NET) as far as I can tell.  Having it there and having
many (FS) config symbols disabled gives this (which the patch fixes):

mm/built-in.o: In function `shmem_check_acl':
shmem_acl.c:(.text.shmem_check_acl+0x33): undefined reference to `posix_acl_permission'
fs/built-in.o: In function `generic_acl_get':
(.text.generic_acl_get+0x30): undefined reference to `posix_acl_to_xattr'
fs/built-in.o: In function `generic_acl_set':
(.text.generic_acl_set+0x75): undefined reference to `posix_acl_from_xattr'
fs/built-in.o: In function `generic_acl_set':
(.text.generic_acl_set+0x94): undefined reference to `posix_acl_valid'
fs/built-in.o: In function `generic_acl_set':
(.text.generic_acl_set+0xc1): undefined reference to `posix_acl_equiv_mode'
fs/built-in.o: In function `generic_acl_init':
(.text.generic_acl_init+0x7a): undefined reference to `posix_acl_clone'
fs/built-in.o: In function `generic_acl_init':
(.text.generic_acl_init+0xb4): undefined reference to `posix_acl_clone'
fs/built-in.o: In function `generic_acl_init':
(.text.generic_acl_init+0xc8): undefined reference to `posix_acl_create_masq'
fs/built-in.o: In function `generic_acl_chmod':
(.text.generic_acl_chmod+0x49): undefined reference to `posix_acl_clone'
fs/built-in.o: In function `generic_acl_chmod':
(.text.generic_acl_chmod+0x76): undefined reference to `posix_acl_chmod_masq'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 fs/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2619-rc2g2.orig/fs/Kconfig
+++ linux-2619-rc2g2/fs/Kconfig
@@ -634,6 +634,10 @@ config FUSE_FS
 	  If you want to develop a userspace FS, or if you want to use
 	  a filesystem based on FUSE, answer Y or M.
 
+config GENERIC_ACL
+	bool
+	select FS_POSIX_ACL
+
 if BLOCK
 menu "CD-ROM/DVD Filesystems"
 
@@ -2080,10 +2084,6 @@ config 9P_FS
 
 	  If unsure, say N.
 
-config GENERIC_ACL
-	bool
-	select FS_POSIX_ACL
-
 endmenu
 
 if BLOCK


---
