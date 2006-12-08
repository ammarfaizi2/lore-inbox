Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425294AbWLHJpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425294AbWLHJpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 04:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425296AbWLHJpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 04:45:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45983 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425294AbWLHJpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 04:45:32 -0500
Date: Fri, 8 Dec 2006 09:45:30 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: [PATCH] uml problems with linux/io.h
Message-ID: <20061208094530.GP4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless includes of linux/io.h, don't even try to build iomap_copy
on uml (it doesn't have readb() et.al., so...)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 crypto/blkcipher.c |    1 -
 lib/Kconfig        |    5 +++++
 lib/Makefile       |    3 ++-
 lib/ioremap.c      |    1 -
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
index 034c939..6e93004 100644
--- a/crypto/blkcipher.c
+++ b/crypto/blkcipher.c
@@ -17,7 +17,6 @@
 #include <linux/crypto.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/scatterlist.h>
 #include <linux/seq_file.h>
diff --git a/lib/Kconfig b/lib/Kconfig
index 734ce95..77eb379 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -97,4 +97,9 @@ #
 config PLIST
 	boolean
 
+config IOMAP_COPY
+	boolean
+	depends on !UML
+	default y
+
 endmenu
diff --git a/lib/Makefile b/lib/Makefile
index fea8f90..92ca7fe 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -12,13 +12,14 @@ lib-$(CONFIG_SMP) += cpumask.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
-obj-y += sort.o parser.o halfmd4.o iomap_copy.o debug_locks.o random32.o
+obj-y += sort.o parser.o halfmd4.o debug_locks.o random32.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
 CFLAGS_kobject_uevent.o += -DDEBUG
 endif
 
+obj-$(CONFIG_IOMAP_COPY) += iomap_copy.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 99fa277..a9e4415 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -5,7 +5,6 @@
  *
  * (C) Copyright 1995 1996 Linus Torvalds
  */
-#include <linux/io.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 
-- 
1.4.2.GIT
