Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWEPMj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWEPMj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWEPMj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:39:57 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8964 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751813AbWEPMj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:39:56 -0400
Date: Tue, 16 May 2006 14:39:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/nfs/: make code static
Message-ID: <20060516123954.GT6931@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/nfs/client.c         |    6 ++++--
 fs/nfs/internal.h       |    2 --
 fs/nfs/namespace.c      |   12 +++++++++---
 include/linux/nfs_fs.h  |    4 ----
 include/linux/nfs_xdr.h |    1 -
 5 files changed, 13 insertions(+), 12 deletions(-)

--- linux-2.6.17-rc4-mm1-full/fs/nfs/internal.h.old	2006-05-16 13:11:54.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/fs/nfs/internal.h	2006-05-16 13:12:00.000000000 +0200
@@ -38,8 +38,6 @@
 };
 
 /* client.c */
-extern struct rpc_program nfs_program;
-
 extern void nfs_put_client(struct nfs_client *);
 extern struct nfs_client *nfs_find_client(struct sockaddr_in *, int);
 extern struct nfs_server *nfs_create_server(struct nfs_mount_data *,
--- linux-2.6.17-rc4-mm1-full/include/linux/nfs_xdr.h.old	2006-05-16 13:12:07.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/include/linux/nfs_xdr.h	2006-05-16 13:12:20.000000000 +0200
@@ -838,6 +838,5 @@
 extern struct rpc_version	nfs_version4;
 
 extern struct rpc_version	nfsacl_version3;
-extern struct rpc_program	nfsacl_program;
 
 #endif
--- linux-2.6.17-rc4-mm1-full/fs/nfs/client.c.old	2006-05-16 13:12:32.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/fs/nfs/client.c	2006-05-16 13:25:59.000000000 +0200
@@ -75,7 +75,7 @@
 #endif
 };
 
-struct rpc_program nfs_program = {
+static struct rpc_program nfs_program = {
 	.name			= "nfs",
 	.number			= NFS_PROGRAM,
 	.nrvers			= ARRAY_SIZE(nfs_version),
@@ -90,12 +90,14 @@
 
 
 #ifdef CONFIG_NFS_V3_ACL
+static struct rpc_program	nfsacl_program;
+
 static struct rpc_stat		nfsacl_rpcstat = { &nfsacl_program };
 static struct rpc_version *	nfsacl_version[] = {
 	[3]			= &nfsacl_version3,
 };
 
-struct rpc_program		nfsacl_program = {
+static struct rpc_program	nfsacl_program = {
 	.name			= "nfsacl",
 	.number			= NFS_ACL_PROGRAM,
 	.nrvers			= ARRAY_SIZE(nfsacl_version),
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

