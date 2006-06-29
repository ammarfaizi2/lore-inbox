Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWF2TWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWF2TWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWF2TVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:21:44 -0400
Received: from [141.84.69.5] ([141.84.69.5]:32016 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932270AbWF2TVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:21:33 -0400
Date: Thu, 29 Jun 2006 21:20:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/nfs/: make code static
Message-ID: <20060629192051.GW19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Jun 2006

 fs/nfs/namespace.c      |   12 +++++++++---
 fs/nfs/super.c          |    4 +++-
 include/linux/nfs_fs.h  |    4 ----
 include/linux/nfs_xdr.h |    1 -
 4 files changed, 12 insertions(+), 9 deletions(-)

--- linux-2.6.17-rc4-mm1-full/include/linux/nfs_fs.h.old	2006-05-16 13:13:54.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/include/linux/nfs_fs.h	2006-05-16 13:14:01.000000000 +0200
@@ -312,10 +312,6 @@
 extern struct nfs_open_context *get_nfs_open_context(struct nfs_open_context *ctx);
 extern void put_nfs_open_context(struct nfs_open_context *ctx);
 extern struct nfs_open_context *nfs_find_open_context(struct inode *inode, struct rpc_cred *cred, int mode);
-extern struct vfsmount *nfs_do_submount(const struct vfsmount *mnt_parent,
-					const struct dentry *dentry,
-					struct nfs_fh *fh,
-					struct nfs_fattr *fattr);
 
 /* linux/net/ipv4/ipconfig.c: trims ip addr off front of name, too. */
 extern u32 root_nfs_parse_addr(char *name); /*__init*/
--- linux-2.6.17-rc4-mm1-full/fs/nfs/namespace.c.old	2006-05-16 13:14:52.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/fs/nfs/namespace.c	2006-05-16 13:14:33.000000000 +0200
@@ -26,6 +26,11 @@
 static DECLARE_WORK(nfs_automount_task, nfs_expire_automounts, &nfs_automount_list);
 int nfs_mountpoint_expiry_timeout = 500 * HZ;
 
+static struct vfsmount *nfs_do_submount(const struct vfsmount *mnt_parent,
+					const struct dentry *dentry,
+					struct nfs_fh *fh,
+					struct nfs_fattr *fattr);
+
 /*
  * nfs_path - reconstruct the path given an arbitrary dentry
  * @base - arbitrary string to prepend to the path
@@ -206,9 +211,10 @@
  * @fattr - attributes for new root inode
  *
  */
-struct vfsmount *nfs_do_submount(const struct vfsmount *mnt_parent,
-		const struct dentry *dentry, struct nfs_fh *fh,
-		struct nfs_fattr *fattr)
+static struct vfsmount *nfs_do_submount(const struct vfsmount *mnt_parent,
+					const struct dentry *dentry,
+					struct nfs_fh *fh,
+					struct nfs_fattr *fattr)
 {
 	struct nfs_clone_mount mountdata = {
 		.sb = mnt_parent->mnt_sb,

--- linux-2.6.17-mm1-full/include/linux/nfs_xdr.h.old	2006-06-22 02:00:39.000000000 +0200
+++ linux-2.6.17-mm1-full/include/linux/nfs_xdr.h	2006-06-22 02:00:47.000000000 +0200
@@ -835,6 +835,5 @@
 extern struct rpc_version	nfs_version4;
 
 extern struct rpc_version	nfsacl_version3;
-extern struct rpc_program	nfsacl_program;
 
 #endif
--- linux-2.6.17-mm1-full/fs/nfs/super.c.old	2006-06-22 02:00:57.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/nfs/super.c	2006-06-22 02:13:26.000000000 +0200
@@ -92,12 +92,14 @@
 
 
 #ifdef CONFIG_NFS_V3_ACL
+static struct rpc_program	nfsacl_program;
+
 static struct rpc_stat		nfsacl_rpcstat = { &nfsacl_program };
 static struct rpc_version *	nfsacl_version[] = {
 	[3]			= &nfsacl_version3,
 };
 
-struct rpc_program		nfsacl_program = {
+static struct rpc_program	nfsacl_program = {
 	.name =			"nfsacl",
 	.number =		NFS_ACL_PROGRAM,
 	.nrvers =		ARRAY_SIZE(nfsacl_version),

