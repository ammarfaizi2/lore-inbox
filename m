Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSJYP57>; Fri, 25 Oct 2002 11:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJYP56>; Fri, 25 Oct 2002 11:57:58 -0400
Received: from ns.suse.de ([213.95.15.193]:34064 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261456AbSJYP55>;
	Fri, 25 Oct 2002 11:57:57 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@digeo.com>
Subject: [2.5.44-mm5] Missing exports in ext23-acl-xattr-07.patch
Date: Fri, 25 Oct 2002 18:03:12 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200210251759.26991.agruen@suse.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_CLOJZXS5PA2AGVJ1HZYE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_CLOJZXS5PA2AGVJ1HZYE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Ted and Andrew,

The ext23-acl-xattr-07.patch is missing some exports in fs/posix_acl.c th=
at=20
are necessary if modules use the functions in that file. Please include/m=
erge=20
in the attached patch.

--Andreas.


--------------Boundary-00=_CLOJZXS5PA2AGVJ1HZYE
Content-Type: text/x-diff;
  charset="us-ascii";
  name="missing-exports.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="missing-exports.patch"

--- linux-2.5.44.patch0/fs/posix_acl.c	2002-10-25 16:39:32.000000000 +0200
+++ linux-2.5.44.patch/fs/posix_acl.c	2002-10-25 16:35:13.000000000 +0200
@@ -18,9 +18,20 @@
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/posix_acl.h>
+#include <linux/module.h>
 
 #include <linux/errno.h>
 
+EXPORT_SYMBOL(posix_acl_alloc);
+EXPORT_SYMBOL(posix_acl_clone);
+EXPORT_SYMBOL(posix_acl_valid);
+EXPORT_SYMBOL(posix_acl_equiv_mode);
+EXPORT_SYMBOL(posix_acl_from_mode);
+EXPORT_SYMBOL(posix_acl_create_masq);
+EXPORT_SYMBOL(posix_acl_chmod_masq);
+EXPORT_SYMBOL(posix_acl_masq_nfs_mode);
+EXPORT_SYMBOL(posix_acl_permission);
+
 /*
  * Allocate a new ACL with the specified number of entries.
  */
--- linux-2.5.44.patch0/fs/Makefile	2002-10-25 16:39:32.000000000 +0200
+++ linux-2.5.44.patch/fs/Makefile	2002-10-25 16:33:03.000000000 +0200
@@ -6,7 +6,8 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o dcookies.o mbcache.o xattr_acl.o
+                fcntl.o read_write.o dcookies.o mbcache.o xattr_acl.o \
+                posix_acl.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \

--------------Boundary-00=_CLOJZXS5PA2AGVJ1HZYE--

