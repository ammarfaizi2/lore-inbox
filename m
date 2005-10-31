Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVJaLgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVJaLgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVJaLgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:36:44 -0500
Received: from host-84-9-201-132.bulldogdsl.com ([84.9.201.132]:13698 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1751085AbVJaLgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:36:44 -0500
Date: Mon, 31 Oct 2005 11:36:39 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: fs/fat - fix sparse warning
Message-ID: <20051031113639.GA30667@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

move fat_cache_init/fat_cache_destroy to a common
header file in fs/fat so that inode.c and cache.c
see the same definition, and to stop warnings
from sparse about undeclared functions

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/fat/cache.c linux-2.6.14-git3-bjd1/fs/fat/cache.c
--- linux-2.6.14-git3/fs/fat/cache.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/fat/cache.c	2005-10-31 11:31:32.000000000 +0000
@@ -12,6 +12,8 @@
 #include <linux/msdos_fs.h>
 #include <linux/buffer_head.h>
 
+#include "cache.h"
+
 /* this must be > 0. */
 #define FAT_MAX_CACHE	8
 
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/fat/cache.h linux-2.6.14-git3-bjd1/fs/fat/cache.h
--- linux-2.6.14-git3/fs/fat/cache.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/fat/cache.h	2005-10-31 11:32:37.000000000 +0000
@@ -0,0 +1,8 @@
+/*  linux/fs/fat/cache.h
+ *
+ *  Written 1992,1993 by Werner Almesberger
+ *	header, 2005, Ben Dooks
+*/
+
+extern int __init fat_cache_init(void);
+extern void fat_cache_destroy(void);
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/fat/inode.c linux-2.6.14-git3-bjd1/fs/fat/inode.c
--- linux-2.6.14-git3/fs/fat/inode.c	2005-10-28 11:28:31.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/fat/inode.c	2005-10-31 11:32:29.000000000 +0000
@@ -24,6 +24,8 @@
 #include <linux/parser.h>
 #include <asm/unaligned.h>
 
+#include "cache.h"
+
 #ifndef CONFIG_FAT_DEFAULT_IOCHARSET
 /* if user don't select VFAT, this is undefined. */
 #define CONFIG_FAT_DEFAULT_IOCHARSET	""
@@ -1346,9 +1348,6 @@ out_fail:
 
 EXPORT_SYMBOL(fat_fill_super);
 
-int __init fat_cache_init(void);
-void fat_cache_destroy(void);
-
 static int __init init_fat_fs(void)
 {
 	int err;

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2614-fat-fix-cache-decl.patch"

diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/fat/cache.c linux-2.6.14-git3-bjd1/fs/fat/cache.c
--- linux-2.6.14-git3/fs/fat/cache.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/fat/cache.c	2005-10-31 11:31:32.000000000 +0000
@@ -12,6 +12,8 @@
 #include <linux/msdos_fs.h>
 #include <linux/buffer_head.h>
 
+#include "cache.h"
+
 /* this must be > 0. */
 #define FAT_MAX_CACHE	8
 
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/fat/cache.h linux-2.6.14-git3-bjd1/fs/fat/cache.h
--- linux-2.6.14-git3/fs/fat/cache.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/fat/cache.h	2005-10-31 11:32:37.000000000 +0000
@@ -0,0 +1,8 @@
+/*  linux/fs/fat/cache.h
+ *
+ *  Written 1992,1993 by Werner Almesberger
+ *	header, 2005, Ben Dooks
+*/
+
+extern int __init fat_cache_init(void);
+extern void fat_cache_destroy(void);
diff -urpN -X ../dontdiff linux-2.6.14-git3/fs/fat/inode.c linux-2.6.14-git3-bjd1/fs/fat/inode.c
--- linux-2.6.14-git3/fs/fat/inode.c	2005-10-28 11:28:31.000000000 +0100
+++ linux-2.6.14-git3-bjd1/fs/fat/inode.c	2005-10-31 11:32:29.000000000 +0000
@@ -24,6 +24,8 @@
 #include <linux/parser.h>
 #include <asm/unaligned.h>
 
+#include "cache.h"
+
 #ifndef CONFIG_FAT_DEFAULT_IOCHARSET
 /* if user don't select VFAT, this is undefined. */
 #define CONFIG_FAT_DEFAULT_IOCHARSET	""
@@ -1346,9 +1348,6 @@ out_fail:
 
 EXPORT_SYMBOL(fat_fill_super);
 
-int __init fat_cache_init(void);
-void fat_cache_destroy(void);
-
 static int __init init_fat_fs(void)
 {
 	int err;

--envbJBWh7q8WU6mo--
