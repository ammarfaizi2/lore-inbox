Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSIIOdQ>; Mon, 9 Sep 2002 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSIIOdQ>; Mon, 9 Sep 2002 10:33:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41743 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317022AbSIIOdP>;
	Mon, 9 Sep 2002 10:33:15 -0400
Date: Mon, 9 Sep 2002 15:37:58 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Trivial Kernel Patches <trivial@rustcorp.com.au>, vandrove@vc.cvut.cz
Subject: [PATCH] remove GFP_NFS
Message-ID: <20020909153758.I10583@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


GFP_NFS has been obsolete for a while now.  Kill its only remaining user,
its definition and the SLAB_NFS define too.

diff -urpNX dontdiff linux-2.5.33/fs/ncpfs/symlink.c linux-2.5.33-willy/fs/ncpfs/symlink.c
--- linux-2.5.33/fs/ncpfs/symlink.c	2002-09-04 07:20:56.000000000 -0600
+++ linux-2.5.33-willy/fs/ncpfs/symlink.c	2002-09-09 06:29:03.000000000 -0600
@@ -49,7 +49,7 @@ static int ncp_symlink_readpage(struct f
 	char *buf = kmap(page);
 
 	error = -ENOMEM;
-	rawlink=(char *)kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_NFS);
+	rawlink=(char *)kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_KERNEL);
 	if (!rawlink)
 		goto fail;
 
@@ -126,7 +126,7 @@ int ncp_symlink(struct inode *dir, struc
 	/* EPERM is returned by VFS if symlink procedure does not exist */
 		return -EPERM;
   
-	rawlink=(char *)kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_NFS);
+	rawlink=(char *)kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_KERNEL);
 	if (!rawlink)
 		return -ENOMEM;
 
diff -urpNX dontdiff linux-2.5.33/include/linux/gfp.h linux-2.5.33-willy/include/linux/gfp.h
--- linux-2.5.33/include/linux/gfp.h	2002-09-04 07:21:06.000000000 -0600
+++ linux-2.5.33-willy/include/linux/gfp.h	2002-09-09 06:27:59.000000000 -0600
@@ -25,7 +25,6 @@
 #define GFP_USER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
 #define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS | __GFP_HIGHMEM)
 #define GFP_KERNEL	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
-#define GFP_NFS		(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
 #define GFP_KSWAPD	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
diff -urpNX dontdiff linux-2.5.33/include/linux/slab.h linux-2.5.33-willy/include/linux/slab.h
--- linux-2.5.33/include/linux/slab.h	2002-08-02 05:44:53.000000000 -0600
+++ linux-2.5.33-willy/include/linux/slab.h	2002-09-09 06:28:31.000000000 -0600
@@ -21,7 +21,6 @@ typedef struct kmem_cache_s kmem_cache_t
 #define	SLAB_ATOMIC		GFP_ATOMIC
 #define	SLAB_USER		GFP_USER
 #define	SLAB_KERNEL		GFP_KERNEL
-#define	SLAB_NFS		GFP_NFS
 #define	SLAB_DMA		GFP_DMA
 
 #define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_HIGHIO|__GFP_FS)

-- 
Revolutions do not require corporate support.
