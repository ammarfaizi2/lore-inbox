Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVBFTEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVBFTEX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVBFTEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:04:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261280AbVBFSou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:44:50 -0500
Date: Sun, 6 Feb 2005 19:44:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/nfs/: make some code static
Message-ID: <20050206184438.GU3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Jan 2005

 fs/nfs/inode.c          |    8 +++++---
 fs/nfs/mount_clnt.c     |    4 ++--
 fs/nfs/nfs4proc.c       |    9 +++++----
 fs/nfs/nfsroot.c        |    4 ++--
 fs/nfs/read.c           |    2 +-
 fs/nfs/write.c          |   29 +++++++++++++++++++++++------
 include/linux/nfs_fs.h  |   24 ------------------------
 include/linux/nfs_xdr.h |    2 --
 8 files changed, 38 insertions(+), 44 deletions(-)

--- linux-2.6.10-mm2-full/include/linux/nfs_xdr.h.old	2005-01-08 16:36:56.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/nfs_xdr.h	2005-01-08 16:37:13.000000000 +0100
@@ -731,7 +731,5 @@
 extern struct rpc_version	nfs_version2;
 extern struct rpc_version	nfs_version3;
 extern struct rpc_version	nfs_version4;
-extern struct rpc_program	nfs_program;
-extern struct rpc_stat		nfs_rpcstat;
 
 #endif
--- linux-2.6.10-mm2-full/fs/nfs/inode.c.old	2005-01-08 16:35:25.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfs/inode.c	2005-01-08 16:38:33.000000000 +0100
@@ -64,6 +64,8 @@
 static int  nfs_statfs(struct super_block *, struct kstatfs *);
 static int  nfs_show_options(struct seq_file *, struct vfsmount *);
 
+static struct rpc_program	nfs_program;
+
 static struct super_operations nfs_sops = { 
 	.alloc_inode	= nfs_alloc_inode,
 	.destroy_inode	= nfs_destroy_inode,
@@ -78,7 +80,7 @@
 /*
  * RPC cruft for NFS
  */
-struct rpc_stat			nfs_rpcstat = {
+static struct rpc_stat		nfs_rpcstat = {
 	.program		= &nfs_program
 };
 static struct rpc_version *	nfs_version[] = {
@@ -95,7 +97,7 @@
 #endif
 };
 
-struct rpc_program		nfs_program = {
+static struct rpc_program	nfs_program = {
 	.name			= "nfs",
 	.number			= NFS_PROGRAM,
 	.nrvers			= sizeof(nfs_version) / sizeof(nfs_version[0]),
@@ -792,7 +794,7 @@
  * Wait for the inode to get unlocked.
  * (Used for NFS_INO_LOCKED and NFS_INO_REVALIDATING).
  */
-int
+static int
 nfs_wait_on_inode(struct inode *inode, int flag)
 {
 	struct rpc_clnt	*clnt = NFS_CLIENT(inode);
--- linux-2.6.10-mm2-full/fs/nfs/mount_clnt.c.old	2005-01-08 16:38:47.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfs/mount_clnt.c	2005-01-08 16:39:04.000000000 +0100
@@ -31,7 +31,7 @@
 
 static struct rpc_clnt *	mnt_create(char *, struct sockaddr_in *,
 								int, int);
-struct rpc_program		mnt_program;
+static struct rpc_program	mnt_program;
 
 struct mnt_fhstatus {
 	unsigned int		status;
@@ -174,7 +174,7 @@
 
 static struct rpc_stat		mnt_stats;
 
-struct rpc_program	mnt_program = {
+static struct rpc_program	mnt_program = {
 	.name		= "mount",
 	.number		= NFS_MNT_PROGRAM,
 	.nrvers		= sizeof(mnt_version)/sizeof(mnt_version[0]),
--- linux-2.6.10-mm2-full/include/linux/nfs_fs.h.old	2005-01-08 16:41:00.000000000 +0100
+++ linux-2.6.10-mm2-full/include/linux/nfs_fs.h	2005-01-08 16:47:58.000000000 +0100
@@ -385,11 +385,8 @@
  * return value!)
  */
 extern int  nfs_sync_inode(struct inode *, unsigned long, unsigned int, int);
-extern int  nfs_flush_inode(struct inode *, unsigned long, unsigned int, int);
-extern int  nfs_flush_list(struct list_head *, int, int);
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 extern int  nfs_commit_inode(struct inode *, unsigned long, unsigned int, int);
-extern int  nfs_commit_list(struct list_head *, int);
 #else
 static inline int
 nfs_commit_inode(struct inode *inode, unsigned long idx_start, unsigned int npages, int how)
@@ -430,7 +427,6 @@
  * Allocate and free nfs_write_data structures
  */
 extern mempool_t *nfs_wdata_mempool;
-extern mempool_t *nfs_commit_mempool;
 
 static inline struct nfs_write_data *nfs_writedata_alloc(void)
 {
@@ -447,23 +443,6 @@
 	mempool_free(p, nfs_wdata_mempool);
 }
 
-extern void  nfs_writedata_release(struct rpc_task *task);
-
-static inline struct nfs_write_data *nfs_commit_alloc(void)
-{
-	struct nfs_write_data *p = mempool_alloc(nfs_commit_mempool, SLAB_NOFS);
-	if (p) {
-		memset(p, 0, sizeof(*p));
-		INIT_LIST_HEAD(&p->pages);
-	}
-	return p;
-}
-
-static inline void nfs_commit_free(struct nfs_write_data *p)
-{
-	mempool_free(p, nfs_commit_mempool);
-}
-
 /* Hack for future NFS swap support */
 #ifndef IS_SWAPFILE
 # define IS_SWAPFILE(inode)	(0)
@@ -475,7 +454,6 @@
 extern int  nfs_readpage(struct file *, struct page *);
 extern int  nfs_readpages(struct file *, struct address_space *,
 		struct list_head *, unsigned);
-extern int  nfs_pagein_list(struct list_head *, int);
 extern void nfs_readpage_result(struct rpc_task *);
 
 /*
@@ -712,10 +690,8 @@
 extern int nfs4_proc_async_renew(struct nfs4_client *);
 extern int nfs4_proc_renew(struct nfs4_client *);
 extern int nfs4_do_close(struct inode *inode, struct nfs4_state *state, mode_t mode);
-extern int nfs4_wait_clnt_recover(struct rpc_clnt *, struct nfs4_client *);
 extern struct inode *nfs4_atomic_open(struct inode *, struct dentry *, struct nameidata *);
 extern int nfs4_open_revalidate(struct inode *, struct dentry *, int);
-extern int nfs4_handle_exception(struct nfs_server *, int, struct nfs4_exception *);
 extern int nfs4_lock_reclaim(struct nfs4_state *state, struct file_lock *request);
 
 /* nfs4renewd.c */
--- linux-2.6.10-mm2-full/fs/nfs/nfs4proc.c.old	2005-01-08 16:39:18.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfs/nfs4proc.c	2005-01-08 16:41:23.000000000 +0100
@@ -57,6 +57,7 @@
 static int nfs4_do_fsinfo(struct nfs_server *, struct nfs_fh *, struct nfs_fsinfo *);
 static int nfs4_async_handle_error(struct rpc_task *, struct nfs_server *);
 static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry);
+static int nfs4_handle_exception(struct nfs_server *server, int errorcode, struct nfs4_exception *exception);
 extern u32 *nfs4_decode_dirent(u32 *p, struct nfs_entry *entry, int plus);
 extern struct rpc_procinfo nfs4_procedures[];
 
@@ -381,7 +382,7 @@
 /*
  * Returns an nfs4_state + an extra reference to the inode
  */
-int _nfs4_open_delegated(struct inode *inode, int flags, struct rpc_cred *cred, struct nfs4_state **res)
+static int _nfs4_open_delegated(struct inode *inode, int flags, struct rpc_cred *cred, struct nfs4_state **res)
 {
 	struct nfs_delegation *delegation;
 	struct nfs_server *server = NFS_SERVER(inode);
@@ -581,7 +582,7 @@
 }
 
 
-struct nfs4_state *nfs4_do_open(struct inode *dir, struct dentry *dentry, int flags, struct iattr *sattr, struct rpc_cred *cred)
+static struct nfs4_state *nfs4_do_open(struct inode *dir, struct dentry *dentry, int flags, struct iattr *sattr, struct rpc_cred *cred)
 {
 	struct nfs4_exception exception = { };
 	struct nfs4_state *res;
@@ -645,7 +646,7 @@
 	return rpc_call_sync(server->client, &msg, 0);
 }
 
-int nfs4_do_setattr(struct nfs_server *server, struct nfs_fattr *fattr,
+static int nfs4_do_setattr(struct nfs_server *server, struct nfs_fattr *fattr,
                 struct nfs_fh *fhandle, struct iattr *sattr,
                 struct nfs4_state *state)
 {
@@ -2067,7 +2068,7 @@
 	return 0;
 }
 
-int nfs4_wait_clnt_recover(struct rpc_clnt *clnt, struct nfs4_client *clp)
+static int nfs4_wait_clnt_recover(struct rpc_clnt *clnt, struct nfs4_client *clp)
 {
 	DEFINE_WAIT(wait);
 	sigset_t oldset;
--- linux-2.6.10-mm2-full/fs/nfs/nfsroot.c.old	2005-01-08 16:41:37.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfs/nfsroot.c	2005-01-08 16:41:59.000000000 +0100
@@ -351,7 +351,7 @@
 #endif
 
 
-int __init root_nfs_init(void)
+static int __init root_nfs_init(void)
 {
 #ifdef NFSROOT_DEBUG
 	nfs_debug |= NFSDBG_ROOT;
@@ -379,7 +379,7 @@
  *  Parse NFS server and directory information passed on the kernel
  *  command line.
  */
-int __init nfs_root_setup(char *line)
+static int __init nfs_root_setup(char *line)
 {
 	ROOT_DEV = Root_NFS;
 	if (line[0] == '/' || line[0] == ',' || (line[0] >= '0' && line[0] <= '9')) {
--- linux-2.6.10-mm2-full/fs/nfs/read.c.old	2005-01-08 16:42:34.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfs/read.c	2005-01-08 16:42:40.000000000 +0100
@@ -370,7 +370,7 @@
 	return -ENOMEM;
 }
 
-int
+static int
 nfs_pagein_list(struct list_head *head, int rpages)
 {
 	LIST_HEAD(one_request);
--- linux-2.6.10-mm2-full/fs/nfs/write.c.old	2005-01-08 16:43:33.000000000 +0100
+++ linux-2.6.10-mm2-full/fs/nfs/write.c	2005-01-08 16:48:03.000000000 +0100
@@ -80,14 +80,31 @@
 static void nfs_writeback_done_full(struct nfs_write_data *, int);
 static int nfs_wait_on_write_congestion(struct address_space *, int);
 static int nfs_wait_on_requests(struct inode *, unsigned long, unsigned int);
+static int nfs_flush_inode(struct inode *inode, unsigned long idx_start,
+			   unsigned int npages, int how);
 
 static kmem_cache_t *nfs_wdata_cachep;
 mempool_t *nfs_wdata_mempool;
-mempool_t *nfs_commit_mempool;
+static mempool_t *nfs_commit_mempool;
 
 static DECLARE_WAIT_QUEUE_HEAD(nfs_write_congestion);
 
-void nfs_writedata_release(struct rpc_task *task)
+static inline struct nfs_write_data *nfs_commit_alloc(void)
+{
+	struct nfs_write_data *p = mempool_alloc(nfs_commit_mempool, SLAB_NOFS);
+	if (p) {
+		memset(p, 0, sizeof(*p));
+		INIT_LIST_HEAD(&p->pages);
+	}
+	return p;
+}
+
+static inline void nfs_commit_free(struct nfs_write_data *p)
+{
+	mempool_free(p, nfs_commit_mempool);
+}
+
+static void nfs_writedata_release(struct rpc_task *task)
 {
 	struct nfs_write_data	*wdata = (struct nfs_write_data *)task->tk_calldata;
 	nfs_writedata_free(wdata);
@@ -990,7 +1007,7 @@
 	return -ENOMEM;
 }
 
-int
+static int
 nfs_flush_list(struct list_head *head, int wpages, int how)
 {
 	LIST_HEAD(one_request);
@@ -1240,7 +1257,7 @@
 /*
  * Commit dirty pages
  */
-int
+static int
 nfs_commit_list(struct list_head *head, int how)
 {
 	struct nfs_write_data	*data;
@@ -1314,8 +1331,8 @@
 }
 #endif
 
-int nfs_flush_inode(struct inode *inode, unsigned long idx_start,
-		   unsigned int npages, int how)
+static int nfs_flush_inode(struct inode *inode, unsigned long idx_start,
+			   unsigned int npages, int how)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	LIST_HEAD(head);

