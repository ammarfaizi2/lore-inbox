Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945903AbWANAl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945903AbWANAl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423251AbWANAl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:41:29 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:15790 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1423243AbWANAlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:41:22 -0500
Message-Id: <20060114004044.951312000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:39:53 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] fuse: uninline some functions
Content-Disposition: inline; filename=fuse_uninline.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inline keyword is unnecessary in most cases.  Clean them up.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/fuse/dev.c
===================================================================
--- linux.orig/fs/fuse/dev.c	2006-01-13 23:40:08.000000000 +0100
+++ linux/fs/fuse/dev.c	2006-01-13 23:40:09.000000000 +0100
@@ -21,7 +21,7 @@ MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 
 static kmem_cache_t *fuse_req_cachep;
 
-static inline struct fuse_conn *fuse_get_conn(struct file *file)
+static struct fuse_conn *fuse_get_conn(struct file *file)
 {
 	struct fuse_conn *fc;
 	spin_lock(&fuse_lock);
@@ -32,7 +32,7 @@ static inline struct fuse_conn *fuse_get
 	return fc;
 }
 
-static inline void fuse_request_init(struct fuse_req *req)
+static void fuse_request_init(struct fuse_req *req)
 {
 	memset(req, 0, sizeof(*req));
 	INIT_LIST_HEAD(&req->list);
@@ -53,7 +53,7 @@ void fuse_request_free(struct fuse_req *
 	kmem_cache_free(fuse_req_cachep, req);
 }
 
-static inline void block_sigs(sigset_t *oldset)
+static void block_sigs(sigset_t *oldset)
 {
 	sigset_t mask;
 
@@ -61,7 +61,7 @@ static inline void block_sigs(sigset_t *
 	sigprocmask(SIG_BLOCK, &mask, oldset);
 }
 
-static inline void restore_sigs(sigset_t *oldset)
+static void restore_sigs(sigset_t *oldset)
 {
 	sigprocmask(SIG_SETMASK, oldset, NULL);
 }
@@ -385,7 +385,7 @@ void fuse_send_init(struct fuse_conn *fc
  * anything that could cause a page-fault.  If the request was already
  * interrupted bail out.
  */
-static inline int lock_request(struct fuse_req *req)
+static int lock_request(struct fuse_req *req)
 {
 	int err = 0;
 	if (req) {
@@ -404,7 +404,7 @@ static inline int lock_request(struct fu
  * requester thread is currently waiting for it to be unlocked, so
  * wake it up.
  */
-static inline void unlock_request(struct fuse_req *req)
+static void unlock_request(struct fuse_req *req)
 {
 	if (req) {
 		spin_lock(&fuse_lock);
@@ -440,7 +440,7 @@ static void fuse_copy_init(struct fuse_c
 }
 
 /* Unmap and put previous page of userspace buffer */
-static inline void fuse_copy_finish(struct fuse_copy_state *cs)
+static void fuse_copy_finish(struct fuse_copy_state *cs)
 {
 	if (cs->mapaddr) {
 		kunmap_atomic(cs->mapaddr, KM_USER0);
@@ -489,8 +489,7 @@ static int fuse_copy_fill(struct fuse_co
 }
 
 /* Do as much copy to/from userspace buffer as we can */
-static inline int fuse_copy_do(struct fuse_copy_state *cs, void **val,
-			       unsigned *size)
+static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 {
 	unsigned ncpy = min(*size, cs->len);
 	if (val) {
@@ -510,8 +509,8 @@ static inline int fuse_copy_do(struct fu
  * Copy a page in the request to/from the userspace buffer.  Must be
  * done atomically
  */
-static inline int fuse_copy_page(struct fuse_copy_state *cs, struct page *page,
-				 unsigned offset, unsigned count, int zeroing)
+static int fuse_copy_page(struct fuse_copy_state *cs, struct page *page,
+			  unsigned offset, unsigned count, int zeroing)
 {
 	if (page && zeroing && count < PAGE_SIZE) {
 		void *mapaddr = kmap_atomic(page, KM_USER1);
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-01-13 23:40:08.000000000 +0100
+++ linux/fs/fuse/dir.c	2006-01-13 23:40:09.000000000 +0100
@@ -23,8 +23,7 @@
 /*
  * Calculate the time in jiffies until a dentry/attributes are valid
  */
-static inline unsigned long time_to_jiffies(unsigned long sec,
-					    unsigned long nsec)
+static unsigned long time_to_jiffies(unsigned long sec, unsigned long nsec)
 {
 	struct timespec ts = {sec, nsec};
 	return jiffies + timespec_to_jiffies(&ts);
@@ -157,7 +156,7 @@ static int dir_alias(struct inode *inode
 	return 0;
 }
 
-static inline int invalid_nodeid(u64 nodeid)
+static int invalid_nodeid(u64 nodeid)
 {
 	return !nodeid || nodeid == FUSE_ROOT_ID;
 }
@@ -166,7 +165,7 @@ static struct dentry_operations fuse_den
 	.d_revalidate	= fuse_dentry_revalidate,
 };
 
-static inline int valid_mode(int m)
+static int valid_mode(int m)
 {
 	return S_ISREG(m) || S_ISDIR(m) || S_ISLNK(m) || S_ISCHR(m) ||
 		S_ISBLK(m) || S_ISFIFO(m) || S_ISSOCK(m);
@@ -763,9 +762,8 @@ static int parse_dirfile(char *buf, size
 	return 0;
 }
 
-static inline size_t fuse_send_readdir(struct fuse_req *req, struct file *file,
-				       struct inode *inode, loff_t pos,
-				       size_t count)
+static size_t fuse_send_readdir(struct fuse_req *req, struct file *file,
+				struct inode *inode, loff_t pos, size_t count)
 {
 	return fuse_send_read_common(req, file, inode, pos, count, 1);
 }
Index: linux/fs/fuse/file.c
===================================================================
--- linux.orig/fs/fuse/file.c	2006-01-13 23:40:08.000000000 +0100
+++ linux/fs/fuse/file.c	2006-01-13 23:40:09.000000000 +0100
@@ -267,9 +267,8 @@ size_t fuse_send_read_common(struct fuse
 	return req->out.args[0].size;
 }
 
-static inline size_t fuse_send_read(struct fuse_req *req, struct file *file,
-				    struct inode *inode, loff_t pos,
-				    size_t count)
+static size_t fuse_send_read(struct fuse_req *req, struct file *file,
+			     struct inode *inode, loff_t pos, size_t count)
 {
 	return fuse_send_read_common(req, file, inode, pos, count, 0);
 }

--
