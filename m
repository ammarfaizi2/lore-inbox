Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWIILWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWIILWo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWIILWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:22:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48016 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751310AbWIILWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:22:43 -0400
Subject: [PATCH] [1/6] Reduce user-visible noise in <linux/nfs_fs.h>
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
In-Reply-To: <1157800733.2977.40.camel@pmac.infradead.org>
References: <1157800733.2977.40.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 12:21:59 +0100
Message-Id: <1157800919.2977.44.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need any of this crap included from the user-visible part of
nfs_fs.h -- remove it all.

In fact, we probably don't need anything but NFS_SUPER_MAGIC to be
defined; is there any need for anything else? And magic numbers should
probably move to <linux/magic.h> rather than being strewn across various
fs-specific include files which exist in userspace for solely that
purpose.

With this patch, 'make header_check' works again at least on PowerPC.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 530b1e6..6c2066c 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -9,27 +9,6 @@
 #ifndef _LINUX_NFS_FS_H
 #define _LINUX_NFS_FS_H
 
-#include <linux/in.h>
-#include <linux/mm.h>
-#include <linux/pagemap.h>
-#include <linux/rwsem.h>
-#include <linux/wait.h>
-
-#include <linux/sunrpc/debug.h>
-#include <linux/sunrpc/auth.h>
-#include <linux/sunrpc/clnt.h>
-
-#include <linux/nfs.h>
-#include <linux/nfs2.h>
-#include <linux/nfs3.h>
-#include <linux/nfs4.h>
-#include <linux/nfs_xdr.h>
-
-#include <linux/nfs_fs_sb.h>
-
-#include <linux/rwsem.h>
-#include <linux/mempool.h>
-
 /*
  * Enable debugging support for nfs client.
  * Requires RPC_DEBUG.
@@ -48,11 +27,6 @@ #define NFS_MAX_TCP_TIMEOUT	(600*HZ)
 #define NFS_SUPER_MAGIC			0x6969
 
 /*
- * These are the default flags for swap requests
- */
-#define NFS_RPC_SWAPFLAGS		(RPC_TASK_SWAPPER|RPC_TASK_ROOTCREDS)
-
-/*
  * When flushing a cluster of dirty pages, there can be different
  * strategies:
  */
@@ -65,6 +39,32 @@ #define FLUSH_INVALIDATE	64	/* Invalidat
 
 #ifdef __KERNEL__
 
+#include <linux/in.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/rwsem.h>
+#include <linux/wait.h>
+
+#include <linux/sunrpc/debug.h>
+#include <linux/sunrpc/auth.h>
+#include <linux/sunrpc/clnt.h>
+
+#include <linux/nfs.h>
+#include <linux/nfs2.h>
+#include <linux/nfs3.h>
+#include <linux/nfs4.h>
+#include <linux/nfs_xdr.h>
+
+#include <linux/nfs_fs_sb.h>
+
+#include <linux/rwsem.h>
+#include <linux/mempool.h>
+
+/*
+ * These are the default flags for swap requests
+ */
+#define NFS_RPC_SWAPFLAGS		(RPC_TASK_SWAPPER|RPC_TASK_ROOTCREDS)
+
 /*
  * NFSv3/v4 Access mode cache entry
  */


-- 
dwmw2

