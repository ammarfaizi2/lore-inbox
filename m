Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSEYSeH>; Sat, 25 May 2002 14:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSEYSeG>; Sat, 25 May 2002 14:34:06 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:21709 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315200AbSEYSeF>; Sat, 25 May 2002 14:34:05 -0400
Date: Sat, 25 May 2002 14:33:56 -0400
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [patch] remove space in /proc/slabinfo cache_name
Message-ID: <20020525143356.B323@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most /proc/slabinfo cache_names are in the format:
cache_name.  There are a couple with spaces in the
name, which is inconsistent and requires a special case
when scripting.

Changes "fasync cache" and "file lock cache" to have
the usual underscore.

Tested on 2.5.18.  Applies to 2.4.19-pre8 with offset.

diff -ruN linux-2.5.18/fs/fcntl.c linux-2.5.18.new/fs/fcntl.c
--- linux-2.5.18/fs/fcntl.c	2002-05-25 05:26:44.000000000 -0400
+++ linux-2.5.18.new/fs/fcntl.c	2002-05-25 06:12:52.000000000 -0400
@@ -551,7 +551,7 @@
 
 static int __init fasync_init(void)
 {
-	fasync_cache = kmem_cache_create("fasync cache",
+	fasync_cache = kmem_cache_create("fasync_cache",
 		sizeof(struct fasync_struct), 0, 0, NULL, NULL);
 	if (!fasync_cache)
 		panic("cannot create fasync slab cache");
diff -ruN linux-2.5.18/fs/locks.c linux-2.5.18.new/fs/locks.c
--- linux-2.5.18/fs/locks.c	2002-05-21 01:07:37.000000000 -0400
+++ linux-2.5.18.new/fs/locks.c	2002-05-25 06:13:34.000000000 -0400
@@ -1940,7 +1940,7 @@
 
 static int __init filelock_init(void)
 {
-	filelock_cache = kmem_cache_create("file lock cache",
+	filelock_cache = kmem_cache_create("file_lock_cache",
 			sizeof(struct file_lock), 0, 0, init_once, NULL);
 	if (!filelock_cache)
 		panic("cannot create file lock slab cache");

-- 
Randy Hron

