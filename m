Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWBXQIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWBXQIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWBXQIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:08:20 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:19918 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751025AbWBXQIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:08:20 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 24 Feb 2006 16:08:10 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 2/5] NTFS: We have struct kmem_cache now so use it instead
 of the typedef.
In-Reply-To: <Pine.LNX.4.64.0602241605210.2136@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0602241607280.2136@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0602241559150.2136@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0602241605210.2136@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: We have struct kmem_cache now so use it instead of the typedef.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ntfs.h  |   10 +++++-----
 fs/ntfs/super.c |   12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

64419d93a5906600af5817ad0cae3c6ecf7fb389
diff --git a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
index 446b501..653d2a5 100644
--- a/fs/ntfs/ntfs.h
+++ b/fs/ntfs/ntfs.h
@@ -50,11 +50,11 @@ typedef enum {
 /* Global variables. */
 
 /* Slab caches (from super.c). */
-extern kmem_cache_t *ntfs_name_cache;
-extern kmem_cache_t *ntfs_inode_cache;
-extern kmem_cache_t *ntfs_big_inode_cache;
-extern kmem_cache_t *ntfs_attr_ctx_cache;
-extern kmem_cache_t *ntfs_index_ctx_cache;
+extern struct kmem_cache *ntfs_name_cache;
+extern struct kmem_cache *ntfs_inode_cache;
+extern struct kmem_cache *ntfs_big_inode_cache;
+extern struct kmem_cache *ntfs_attr_ctx_cache;
+extern struct kmem_cache *ntfs_index_ctx_cache;
 
 /* The various operations structs defined throughout the driver files. */
 extern struct address_space_operations ntfs_aops;
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index c3a3f1a..e9c0d80 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2987,14 +2987,14 @@ err_out_now:
  * strings of the maximum length allowed by NTFS, which is NTFS_MAX_NAME_LEN
  * (255) Unicode characters + a terminating NULL Unicode character.
  */
-kmem_cache_t *ntfs_name_cache;
+struct kmem_cache *ntfs_name_cache;
 
 /* Slab caches for efficient allocation/deallocation of inodes. */
-kmem_cache_t *ntfs_inode_cache;
-kmem_cache_t *ntfs_big_inode_cache;
+struct kmem_cache *ntfs_inode_cache;
+struct kmem_cache *ntfs_big_inode_cache;
 
 /* Init once constructor for the inode slab cache. */
-static void ntfs_big_inode_init_once(void *foo, kmem_cache_t *cachep,
+static void ntfs_big_inode_init_once(void *foo, struct kmem_cache *cachep,
 		unsigned long flags)
 {
 	ntfs_inode *ni = (ntfs_inode *)foo;
@@ -3008,8 +3008,8 @@ static void ntfs_big_inode_init_once(voi
  * Slab caches to optimize allocations and deallocations of attribute search
  * contexts and index contexts, respectively.
  */
-kmem_cache_t *ntfs_attr_ctx_cache;
-kmem_cache_t *ntfs_index_ctx_cache;
+struct kmem_cache *ntfs_attr_ctx_cache;
+struct kmem_cache *ntfs_index_ctx_cache;
 
 /* Driver wide semaphore. */
 DECLARE_MUTEX(ntfs_lock);
-- 
1.2.3.g9821

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
