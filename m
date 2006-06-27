Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWF0J34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWF0J34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWF0J34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:29:56 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:58021 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1161059AbWF0J3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:29:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Brownell <david-b@pacbell.net>
Subject: [patch] fix static linking of NFS 
From: Jes Sorensen <jes@sgi.com>
Date: 27 Jun 2006 05:29:54 -0400
Message-ID: <yq04py7j699.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch solved the problem where certain functions in the NFS code
goes missing due to the __exit section being discarded for static
links.

I saw one other version of this patch from David Brownell, but it had
clutter left on the lines where the __exit should simply be removed.

Cheers,
Jes

Remove __exit declarations from functions called from __init code to
avoid link errors when the __exit section is discarded, eg NFS is
linked statically into the kernel.

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 fs/nfs/direct.c   |    2 +-
 fs/nfs/inode.c    |    2 +-
 fs/nfs/pagelist.c |    2 +-
 fs/nfs/read.c     |    2 +-
 fs/nfs/write.c    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/fs/nfs/direct.c
===================================================================
--- linux-2.6.orig/fs/nfs/direct.c
+++ linux-2.6/fs/nfs/direct.c
@@ -909,7 +909,7 @@ int __init nfs_init_directcache(void)
  * nfs_destroy_directcache - destroy the slab cache for nfs_direct_req structures
  *
  */
-void __exit nfs_destroy_directcache(void)
+void nfs_destroy_directcache(void)
 {
 	if (kmem_cache_destroy(nfs_direct_cachep))
 		printk(KERN_INFO "nfs_direct_cache: not all structures were freed\n");
Index: linux-2.6/fs/nfs/inode.c
===================================================================
--- linux-2.6.orig/fs/nfs/inode.c
+++ linux-2.6/fs/nfs/inode.c
@@ -1132,7 +1132,7 @@ static int __init nfs_init_inodecache(vo
 	return 0;
 }
 
-static void __exit nfs_destroy_inodecache(void)
+static void nfs_destroy_inodecache(void)
 {
 	if (kmem_cache_destroy(nfs_inode_cachep))
 		printk(KERN_INFO "nfs_inode_cache: not all structures were freed\n");
Index: linux-2.6/fs/nfs/pagelist.c
===================================================================
--- linux-2.6.orig/fs/nfs/pagelist.c
+++ linux-2.6/fs/nfs/pagelist.c
@@ -390,7 +390,7 @@ int __init nfs_init_nfspagecache(void)
 	return 0;
 }
 
-void __exit nfs_destroy_nfspagecache(void)
+void nfs_destroy_nfspagecache(void)
 {
 	if (kmem_cache_destroy(nfs_page_cachep))
 		printk(KERN_INFO "nfs_page: not all structures were freed\n");
Index: linux-2.6/fs/nfs/read.c
===================================================================
--- linux-2.6.orig/fs/nfs/read.c
+++ linux-2.6/fs/nfs/read.c
@@ -711,7 +711,7 @@ int __init nfs_init_readpagecache(void)
 	return 0;
 }
 
-void __exit nfs_destroy_readpagecache(void)
+void nfs_destroy_readpagecache(void)
 {
 	mempool_destroy(nfs_rdata_mempool);
 	if (kmem_cache_destroy(nfs_rdata_cachep))
Index: linux-2.6/fs/nfs/write.c
===================================================================
--- linux-2.6.orig/fs/nfs/write.c
+++ linux-2.6/fs/nfs/write.c
@@ -1551,7 +1551,7 @@ int __init nfs_init_writepagecache(void)
 	return 0;
 }
 
-void __exit nfs_destroy_writepagecache(void)
+void nfs_destroy_writepagecache(void)
 {
 	mempool_destroy(nfs_commit_mempool);
 	mempool_destroy(nfs_wdata_mempool);
