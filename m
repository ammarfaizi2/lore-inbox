Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVAaHp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVAaHp1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVAaHoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:44:37 -0500
Received: from waste.org ([216.27.176.166]:59372 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261952AbVAaHfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:35:01 -0500
Date: Mon, 31 Jan 2005 01:34:59 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.416337461@selenic.com>
Message-Id: <3.416337461@selenic.com>
Subject: [PATCH 2/8] lib/sort: Replace qsort in XFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Point XFS qsort at lib/sort in a way that makes it happy.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm2/fs/xfs/linux-2.6/xfs_linux.h
===================================================================
--- mm2.orig/fs/xfs/linux-2.6/xfs_linux.h	2005-01-30 14:22:38.000000000 -0800
+++ mm2/fs/xfs/linux-2.6/xfs_linux.h	2005-01-30 20:15:45.000000000 -0800
@@ -87,6 +87,7 @@
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/version.h>
+#include <linux/sort.h>
 
 #include <asm/page.h>
 #include <asm/div64.h>
@@ -367,4 +368,12 @@
 	return(x * y);
 }
 
+
+#define qsort xfs_sort
+static inline void xfs_sort(void *a, size_t n, size_t s,
+			int (*cmp)(const void *,const void *))
+{
+	sort(a, n, s, cmp, 0);
+}
+
 #endif /* __XFS_LINUX__ */
Index: mm2/fs/xfs/Kconfig
===================================================================
--- mm2.orig/fs/xfs/Kconfig	2005-01-30 14:22:38.000000000 -0800
+++ mm2/fs/xfs/Kconfig	2005-01-30 20:34:54.000000000 -0800
@@ -2,7 +2,6 @@
 
 config XFS_FS
 	tristate "XFS filesystem support"
-	select QSORT
 	help
 	  XFS is a high performance journaling filesystem which originated
 	  on the SGI IRIX platform.  It is completely multi-threaded, can
