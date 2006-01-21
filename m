Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWAUVmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWAUVmY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWAUVmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:42:24 -0500
Received: from admingilde.org ([213.95.32.146]:18150 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932393AbWAUVmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:42:23 -0500
Date: Sat, 21 Jan 2006 22:42:21 +0100
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DocBook: fix some kernel-doc comments in fs and block
Message-ID: <20060121214221.GF30777@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update some parameter descriptions to actually match the code.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 block/ll_rw_blk.c |    2 ++
 fs/bio.c          |    1 +
 fs/inode.c        |    2 +-
 fs/namei.c        |    2 ++
 4 files changed, 6 insertions(+), 1 deletions(-)

b356c4996e5a8df0f841d0f8bc08e80a26aa68d8
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 8e27d0a..d6b9640 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -304,6 +304,7 @@ static inline void rq_init(request_queue
  * blk_queue_ordered - does this queue support ordered writes
  * @q:        the request queue
  * @ordered:  one of QUEUE_ORDERED_*
+ * @prepare_flush_fn: the flush prepare function
  *
  * Description:
  *   For journalled file systems, doing ordered writes on a commit
@@ -2632,6 +2633,7 @@ EXPORT_SYMBOL(blk_put_request);
 /**
  * blk_end_sync_rq - executes a completion event on a request
  * @rq: request to complete
+ * @error: not used
  */
 void blk_end_sync_rq(struct request *rq, int error)
 {
diff --git a/fs/bio.c b/fs/bio.c
index bbc442b..c7b13b9 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -411,6 +411,7 @@ static int __bio_add_page(request_queue_
 
 /**
  *	bio_add_pc_page	-	attempt to add page to bio
+ *	@q: the request queue to use
  *	@bio: destination bio
  *	@page: page to add
  *	@len: vec entry length
diff --git a/fs/inode.c b/fs/inode.c
index 108138d..d0be615 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1179,7 +1179,7 @@ EXPORT_SYMBOL(bmap);
 /**
  *	touch_atime	-	update the access time
  *	@mnt: mount the inode is accessed on
- *	@inode: inode accessed
+ *	@dentry: dentry accessed
  *
  *	Update the accessed time on an inode and mark it for writeback.
  *	This function automatically handles read only file systems and media,
diff --git a/fs/namei.c b/fs/namei.c
index 4acdac0..7ac9fb4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1161,6 +1161,7 @@ static int __path_lookup_intent_open(int
 
 /**
  * path_lookup_open - lookup a file path with open intent
+ * @dfd: the directory to use as base, or AT_FDCWD
  * @name: pointer to file name
  * @lookup_flags: lookup intent flags
  * @nd: pointer to nameidata
@@ -1175,6 +1176,7 @@ int path_lookup_open(int dfd, const char
 
 /**
  * path_lookup_create - lookup a file path with open + create intent
+ * @dfd: the directory to use as base, or AT_FDCWD
  * @name: pointer to file name
  * @lookup_flags: lookup intent flags
  * @nd: pointer to nameidata
-- 
0.99.9.GIT

-- 
Martin Waitz
