Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUGGMvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUGGMvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbUGGMts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:49:48 -0400
Received: from linuxhacker.ru ([217.76.32.60]:62166 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265101AbUGGMtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:49:31 -0400
Date: Wed, 7 Jul 2004 15:47:32 +0300
From: Oleg Drokin <green@clusterfs.com>
To: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: [2/9] Lustre VFS patches for 2.6
Message-ID: <20040707124732.GA25904@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

%diffstat
 fs/dcache.c            |    7 +++++++
 include/linux/dcache.h |    1 +
 2 files changed, 8 insertions(+)

%patch
Index: linux-2.6.6/fs/dcache.c
===================================================================
--- linux-2.6.6.orig/fs/dcache.c	2004-05-22 02:11:17.000000000 +0800
+++ linux-2.6.6/fs/dcache.c	2004-05-22 02:14:46.000000000 +0800
@@ -217,6 +217,13 @@ int d_invalidate(struct dentry * dentry)
 		spin_unlock(&dcache_lock);
 		return 0;
 	}
+
+	/* network invalidation by Lustre */
+	if (dentry->d_flags & DCACHE_LUSTRE_INVALID) {
+		spin_unlock(&dcache_lock);
+		return 0;
+	}
+
 	/*
 	 * Check whether to do a partial shrink_dcache
 	 * to get rid of unused child entries.
Index: linux-2.6.6/include/linux/dcache.h
===================================================================
--- linux-2.6.6.orig/include/linux/dcache.h	2004-05-22 02:10:01.000000000 +0800
+++ linux-2.6.6/include/linux/dcache.h	2004-05-22 02:15:17.000000000 +0800
@@ -153,6 +153,7 @@ d_iput:		no		no		yes
 
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
 #define DCACHE_UNHASHED		0x0010	
+#define DCACHE_LUSTRE_INVALID	0x0020	/* invalidated by Lustre */
 
 extern spinlock_t dcache_lock;
 

