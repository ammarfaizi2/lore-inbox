Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWJJDMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWJJDMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWJJDLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:11:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:8109 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964824AbWJJDLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:11:41 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/25] xdr annotations: NFS readdir entries
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX81t-0004Bl-1Q@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:11:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on-the-wire data is big-endian

[in large part pulled from Alexey's patch]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c            |    6 +++---
 fs/nfs/internal.h       |    6 +++---
 fs/nfs/nfs2xdr.c        |    4 ++--
 fs/nfs/nfs3xdr.c        |    4 ++--
 fs/nfs/nfs4_fs.h        |    2 +-
 fs/nfs/nfs4proc.c       |    4 ++--
 fs/nfs/nfs4xdr.c        |    2 +-
 include/linux/nfs_xdr.h |    2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 481f889..916088f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -142,12 +142,12 @@ nfs_opendir(struct inode *inode, struct 
 	return res;
 }
 
-typedef u32 * (*decode_dirent_t)(u32 *, struct nfs_entry *, int);
+typedef __be32 * (*decode_dirent_t)(__be32 *, struct nfs_entry *, int);
 typedef struct {
 	struct file	*file;
 	struct page	*page;
 	unsigned long	page_index;
-	u32		*ptr;
+	__be32		*ptr;
 	u64		*dir_cookie;
 	loff_t		current_index;
 	struct nfs_entry *entry;
@@ -218,7 +218,7 @@ int nfs_readdir_filler(nfs_readdir_descr
 static inline
 int dir_decode(nfs_readdir_descriptor_t *desc)
 {
-	u32	*p = desc->ptr;
+	__be32	*p = desc->ptr;
 	p = desc->decode(p, desc->entry, desc->plus);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index bea0b01..d205466 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -93,15 +93,15 @@ #endif
 /* nfs2xdr.c */
 extern int nfs_stat_to_errno(int);
 extern struct rpc_procinfo nfs_procedures[];
-extern u32 * nfs_decode_dirent(u32 *, struct nfs_entry *, int);
+extern __be32 * nfs_decode_dirent(__be32 *, struct nfs_entry *, int);
 
 /* nfs3xdr.c */
 extern struct rpc_procinfo nfs3_procedures[];
-extern u32 *nfs3_decode_dirent(u32 *, struct nfs_entry *, int);
+extern __be32 *nfs3_decode_dirent(__be32 *, struct nfs_entry *, int);
 
 /* nfs4xdr.c */
 #ifdef CONFIG_NFS_V4
-extern u32 *nfs4_decode_dirent(u32 *p, struct nfs_entry *entry, int plus);
+extern __be32 *nfs4_decode_dirent(__be32 *p, struct nfs_entry *entry, int plus);
 #endif
 
 /* nfs4proc.c */
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 1d801e3..3be4e72 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -468,8 +468,8 @@ err_unmap:
 	goto out;
 }
 
-u32 *
-nfs_decode_dirent(u32 *p, struct nfs_entry *entry, int plus)
+__be32 *
+nfs_decode_dirent(__be32 *p, struct nfs_entry *entry, int plus)
 {
 	if (!*p++) {
 		if (!*p)
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index b4e740e..0ace092 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -583,8 +583,8 @@ err_unmap:
 	goto out;
 }
 
-u32 *
-nfs3_decode_dirent(u32 *p, struct nfs_entry *entry, int plus)
+__be32 *
+nfs3_decode_dirent(__be32 *p, struct nfs_entry *entry, int plus)
 {
 	struct nfs_entry old = *entry;
 
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 61095fe..6f34667 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -212,7 +212,7 @@ extern void nfs_free_seqid(struct nfs_se
 extern const nfs4_stateid zero_stateid;
 
 /* nfs4xdr.c */
-extern uint32_t *nfs4_decode_dirent(uint32_t *p, struct nfs_entry *entry, int plus);
+extern __be32 *nfs4_decode_dirent(__be32 *p, struct nfs_entry *entry, int plus);
 extern struct rpc_procinfo nfs4_procedures[];
 
 struct nfs4_mount_data;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 47c7e6e..cbf640e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -141,7 +141,7 @@ const u32 nfs4_fs_locations_bitmap[2] = 
 static void nfs4_setup_readdir(u64 cookie, u32 *verifier, struct dentry *dentry,
 		struct nfs4_readdir_arg *readdir)
 {
-	u32 *start, *p;
+	__be32 *start, *p;
 
 	BUG_ON(readdir->count < 80);
 	if (cookie > 2) {
@@ -162,7 +162,7 @@ static void nfs4_setup_readdir(u64 cooki
 	 * when talking to the server, we always send cookie 0
 	 * instead of 1 or 2.
 	 */
-	start = p = (u32 *)kmap_atomic(*readdir->pages, KM_USER0);
+	start = p = kmap_atomic(*readdir->pages, KM_USER0);
 	
 	if (cookie == 0) {
 		*p++ = xdr_one;                                  /* next */
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index e284123..0cf3fa3 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4421,7 +4421,7 @@ out:
 	return status;
 }
 
-uint32_t *nfs4_decode_dirent(uint32_t *p, struct nfs_entry *entry, int plus)
+__be32 *nfs4_decode_dirent(__be32 *p, struct nfs_entry *entry, int plus)
 {
 	uint32_t bitmap[2] = {0};
 	uint32_t len;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index dc5397d..ac8058b 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -811,7 +811,7 @@ struct nfs_rpc_ops {
 	int	(*pathconf) (struct nfs_server *, struct nfs_fh *,
 			     struct nfs_pathconf *);
 	int	(*set_capabilities)(struct nfs_server *, struct nfs_fh *);
-	u32 *	(*decode_dirent)(u32 *, struct nfs_entry *, int plus);
+	__be32 *(*decode_dirent)(__be32 *, struct nfs_entry *, int plus);
 	void	(*read_setup)   (struct nfs_read_data *);
 	int	(*read_done)  (struct rpc_task *, struct nfs_read_data *);
 	void	(*write_setup)  (struct nfs_write_data *, int how);
-- 
1.4.2.GIT


