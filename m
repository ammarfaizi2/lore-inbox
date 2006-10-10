Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWJJDOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWJJDOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWJJDO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:14:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33453 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964916AbWJJDOC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:14:02 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] nfsd: NFSv{2,3} trivial endianness annotations for error values
Cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Message-Id: <E1GX849-0004HH-Aw@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 04:14:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfs2acl.c  |    6 +++---
 fs/nfsd/nfs3acl.c  |    4 ++--
 fs/nfsd/nfs3proc.c |   46 +++++++++++++++++++++++++---------------------
 fs/nfsd/nfsproc.c  |   40 +++++++++++++++++++++-------------------
 4 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index fd5397d..e3eca08 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -35,7 +35,7 @@ static __be32 nfsacld_proc_getacl(struct
 {
 	svc_fh *fh;
 	struct posix_acl *acl;
-	int nfserr = 0;
+	__be32 nfserr = 0;
 
 	dprintk("nfsd: GETACL(2acl)   %s\n", SVCFH_fmt(&argp->fh));
 
@@ -102,7 +102,7 @@ static __be32 nfsacld_proc_setacl(struct
 		struct nfsd_attrstat *resp)
 {
 	svc_fh *fh;
-	int nfserr = 0;
+	__be32 nfserr = 0;
 
 	dprintk("nfsd: SETACL(2acl)   %s\n", SVCFH_fmt(&argp->fh));
 
@@ -143,7 +143,7 @@ static __be32 nfsacld_proc_getattr(struc
 static __be32 nfsacld_proc_access(struct svc_rqst *rqstp, struct nfsd3_accessargs *argp,
 		struct nfsd3_accessres *resp)
 {
-	int nfserr;
+	__be32 nfserr;
 
 	dprintk("nfsd: ACCESS(2acl)   %s 0x%x\n",
 			SVCFH_fmt(&argp->fh),
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 78b2c83..fcad289 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -33,7 +33,7 @@ static __be32 nfsd3_proc_getacl(struct s
 {
 	svc_fh *fh;
 	struct posix_acl *acl;
-	int nfserr = 0;
+	__be32 nfserr = 0;
 
 	fh = fh_copy(&resp->fh, &argp->fh);
 	if ((nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_NOP)))
@@ -98,7 +98,7 @@ static __be32 nfsd3_proc_setacl(struct s
 		struct nfsd3_attrstat *resp)
 {
 	svc_fh *fh;
-	int nfserr = 0;
+	__be32 nfserr = 0;
 
 	fh = fh_copy(&resp->fh, &argp->fh);
 	nfserr = fh_verify(rqstp, &resp->fh, 0, MAY_SATTR);
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index a12663f..64db601 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -56,7 +56,8 @@ static __be32
 nfsd3_proc_getattr(struct svc_rqst *rqstp, struct nfsd_fhandle  *argp,
 					   struct nfsd3_attrstat *resp)
 {
-	int	err, nfserr;
+	int	err;
+	__be32	nfserr;
 
 	dprintk("nfsd: GETATTR(3)  %s\n",
 		SVCFH_fmt(&argp->fh));
@@ -80,7 +81,7 @@ static __be32
 nfsd3_proc_setattr(struct svc_rqst *rqstp, struct nfsd3_sattrargs *argp,
 					   struct nfsd3_attrstat  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: SETATTR(3)  %s\n",
 				SVCFH_fmt(&argp->fh));
@@ -98,7 +99,7 @@ static __be32
 nfsd3_proc_lookup(struct svc_rqst *rqstp, struct nfsd3_diropargs *argp,
 					  struct nfsd3_diropres  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: LOOKUP(3)   %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -122,7 +123,7 @@ static __be32
 nfsd3_proc_access(struct svc_rqst *rqstp, struct nfsd3_accessargs *argp,
 					  struct nfsd3_accessres *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: ACCESS(3)   %s 0x%x\n",
 				SVCFH_fmt(&argp->fh),
@@ -141,7 +142,7 @@ static __be32
 nfsd3_proc_readlink(struct svc_rqst *rqstp, struct nfsd3_readlinkargs *argp,
 					   struct nfsd3_readlinkres *resp)
 {
-	int nfserr;
+	__be32 nfserr;
 
 	dprintk("nfsd: READLINK(3) %s\n", SVCFH_fmt(&argp->fh));
 
@@ -159,7 +160,7 @@ static __be32
 nfsd3_proc_read(struct svc_rqst *rqstp, struct nfsd3_readargs *argp,
 				        struct nfsd3_readres  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 	u32	max_blocksize = svc_max_payload(rqstp);
 
 	dprintk("nfsd: READ(3) %s %lu bytes at %lu\n",
@@ -199,7 +200,7 @@ static __be32
 nfsd3_proc_write(struct svc_rqst *rqstp, struct nfsd3_writeargs *argp,
 					 struct nfsd3_writeres  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: WRITE(3)    %s %d bytes at %ld%s\n",
 				SVCFH_fmt(&argp->fh),
@@ -229,7 +230,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp
 {
 	svc_fh		*dirfhp, *newfhp = NULL;
 	struct iattr	*attr;
-	u32		nfserr;
+	__be32		nfserr;
 
 	dprintk("nfsd: CREATE(3)   %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -269,7 +270,7 @@ static __be32
 nfsd3_proc_mkdir(struct svc_rqst *rqstp, struct nfsd3_createargs *argp,
 					 struct nfsd3_diropres   *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -289,7 +290,7 @@ static __be32
 nfsd3_proc_symlink(struct svc_rqst *rqstp, struct nfsd3_symlinkargs *argp,
 					   struct nfsd3_diropres    *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: SYMLINK(3)  %s %.*s -> %.*s\n",
 				SVCFH_fmt(&argp->ffh),
@@ -311,7 +312,8 @@ static __be32
 nfsd3_proc_mknod(struct svc_rqst *rqstp, struct nfsd3_mknodargs *argp,
 					 struct nfsd3_diropres  *resp)
 {
-	int	nfserr, type;
+	__be32	nfserr;
+	int type;
 	dev_t	rdev = 0;
 
 	dprintk("nfsd: MKNOD(3)    %s %.*s\n",
@@ -347,7 +349,7 @@ static __be32
 nfsd3_proc_remove(struct svc_rqst *rqstp, struct nfsd3_diropargs *argp,
 					  struct nfsd3_attrstat  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: REMOVE(3)   %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -367,7 +369,7 @@ static __be32
 nfsd3_proc_rmdir(struct svc_rqst *rqstp, struct nfsd3_diropargs *argp,
 					 struct nfsd3_attrstat  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: RMDIR(3)    %s %.*s\n",
 				SVCFH_fmt(&argp->fh),
@@ -383,7 +385,7 @@ static __be32
 nfsd3_proc_rename(struct svc_rqst *rqstp, struct nfsd3_renameargs *argp,
 					  struct nfsd3_renameres  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: RENAME(3)   %s %.*s ->\n",
 				SVCFH_fmt(&argp->ffh),
@@ -405,7 +407,7 @@ static __be32
 nfsd3_proc_link(struct svc_rqst *rqstp, struct nfsd3_linkargs *argp,
 					struct nfsd3_linkres  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: LINK(3)     %s ->\n",
 				SVCFH_fmt(&argp->ffh));
@@ -428,7 +430,8 @@ static __be32
 nfsd3_proc_readdir(struct svc_rqst *rqstp, struct nfsd3_readdirargs *argp,
 					   struct nfsd3_readdirres  *resp)
 {
-	int		nfserr, count;
+	__be32		nfserr;
+	int		count;
 
 	dprintk("nfsd: READDIR(3)  %s %d bytes at %d\n",
 				SVCFH_fmt(&argp->fh),
@@ -463,7 +466,8 @@ static __be32
 nfsd3_proc_readdirplus(struct svc_rqst *rqstp, struct nfsd3_readdirargs *argp,
 					       struct nfsd3_readdirres  *resp)
 {
-	int	nfserr, count = 0;
+	__be32	nfserr;
+	int	count = 0;
 	loff_t	offset;
 	int	i;
 	caddr_t	page_addr = NULL;
@@ -521,7 +525,7 @@ static __be32
 nfsd3_proc_fsstat(struct svc_rqst * rqstp, struct nfsd_fhandle    *argp,
 					   struct nfsd3_fsstatres *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: FSSTAT(3)   %s\n",
 				SVCFH_fmt(&argp->fh));
@@ -538,7 +542,7 @@ static __be32
 nfsd3_proc_fsinfo(struct svc_rqst * rqstp, struct nfsd_fhandle    *argp,
 					   struct nfsd3_fsinfores *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 	u32	max_blocksize = svc_max_payload(rqstp);
 
 	dprintk("nfsd: FSINFO(3)   %s\n",
@@ -580,7 +584,7 @@ static __be32
 nfsd3_proc_pathconf(struct svc_rqst * rqstp, struct nfsd_fhandle      *argp,
 					     struct nfsd3_pathconfres *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: PATHCONF(3) %s\n",
 				SVCFH_fmt(&argp->fh));
@@ -623,7 +627,7 @@ static __be32
 nfsd3_proc_commit(struct svc_rqst * rqstp, struct nfsd3_commitargs *argp,
 					   struct nfsd3_commitres  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: COMMIT(3)   %s %u@%Lu\n",
 				SVCFH_fmt(&argp->fh),
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 03ab682..ec983b7 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -36,16 +36,16 @@ nfsd_proc_null(struct svc_rqst *rqstp, v
 	return nfs_ok;
 }
 
-static int
-nfsd_return_attrs(int err, struct nfsd_attrstat *resp)
+static __be32
+nfsd_return_attrs(__be32 err, struct nfsd_attrstat *resp)
 {
 	if (err) return err;
 	return nfserrno(vfs_getattr(resp->fh.fh_export->ex_mnt,
 				    resp->fh.fh_dentry,
 				    &resp->stat));
 }
-static int
-nfsd_return_dirop(int err, struct nfsd_diropres *resp)
+static __be32
+nfsd_return_dirop(__be32 err, struct nfsd_diropres *resp)
 {
 	if (err) return err;
 	return nfserrno(vfs_getattr(resp->fh.fh_export->ex_mnt,
@@ -60,7 +60,7 @@ static __be32
 nfsd_proc_getattr(struct svc_rqst *rqstp, struct nfsd_fhandle  *argp,
 					  struct nfsd_attrstat *resp)
 {
-	int nfserr;
+	__be32 nfserr;
 	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
@@ -76,7 +76,7 @@ static __be32
 nfsd_proc_setattr(struct svc_rqst *rqstp, struct nfsd_sattrargs *argp,
 					  struct nfsd_attrstat  *resp)
 {
-	int nfserr;
+	__be32 nfserr;
 	dprintk("nfsd: SETATTR  %s, valid=%x, size=%ld\n",
 		SVCFH_fmt(&argp->fh),
 		argp->attrs.ia_valid, (long) argp->attrs.ia_size);
@@ -96,7 +96,7 @@ static __be32
 nfsd_proc_lookup(struct svc_rqst *rqstp, struct nfsd_diropargs *argp,
 					 struct nfsd_diropres  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: LOOKUP   %s %.*s\n",
 		SVCFH_fmt(&argp->fh), argp->len, argp->name);
@@ -116,7 +116,7 @@ static __be32
 nfsd_proc_readlink(struct svc_rqst *rqstp, struct nfsd_readlinkargs *argp,
 					   struct nfsd_readlinkres *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: READLINK %s\n", SVCFH_fmt(&argp->fh));
 
@@ -136,7 +136,7 @@ static __be32
 nfsd_proc_read(struct svc_rqst *rqstp, struct nfsd_readargs *argp,
 				       struct nfsd_readres  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: READ    %s %d bytes at %d\n",
 		SVCFH_fmt(&argp->fh),
@@ -176,7 +176,7 @@ static __be32
 nfsd_proc_write(struct svc_rqst *rqstp, struct nfsd_writeargs *argp,
 					struct nfsd_attrstat  *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 	int	stable = 1;
 
 	dprintk("nfsd: WRITE    %s %d bytes at %d\n",
@@ -206,7 +206,8 @@ nfsd_proc_create(struct svc_rqst *rqstp,
 	struct iattr	*attr = &argp->attrs;
 	struct inode	*inode;
 	struct dentry	*dchild;
-	int		nfserr, type, mode;
+	int		type, mode;
+	__be32		nfserr;
 	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
 
 	dprintk("nfsd: CREATE   %s %.*s\n",
@@ -352,7 +353,7 @@ static __be32
 nfsd_proc_remove(struct svc_rqst *rqstp, struct nfsd_diropargs *argp,
 					 void		       *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: REMOVE   %s %.*s\n", SVCFH_fmt(&argp->fh),
 		argp->len, argp->name);
@@ -367,7 +368,7 @@ static __be32
 nfsd_proc_rename(struct svc_rqst *rqstp, struct nfsd_renameargs *argp,
 				  	 void		        *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: RENAME   %s %.*s -> \n",
 		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname);
@@ -385,7 +386,7 @@ static __be32
 nfsd_proc_link(struct svc_rqst *rqstp, struct nfsd_linkargs *argp,
 				void			    *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: LINK     %s ->\n",
 		SVCFH_fmt(&argp->ffh));
@@ -406,7 +407,7 @@ nfsd_proc_symlink(struct svc_rqst *rqstp
 				          void			  *resp)
 {
 	struct svc_fh	newfh;
-	int		nfserr;
+	__be32		nfserr;
 
 	dprintk("nfsd: SYMLINK  %s %.*s -> %.*s\n",
 		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname,
@@ -434,7 +435,7 @@ static __be32
 nfsd_proc_mkdir(struct svc_rqst *rqstp, struct nfsd_createargs *argp,
 					struct nfsd_diropres   *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
 
@@ -458,7 +459,7 @@ static __be32
 nfsd_proc_rmdir(struct svc_rqst *rqstp, struct nfsd_diropargs *argp,
 				 	void		      *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: RMDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
 
@@ -474,7 +475,8 @@ static __be32
 nfsd_proc_readdir(struct svc_rqst *rqstp, struct nfsd_readdirargs *argp,
 					  struct nfsd_readdirres  *resp)
 {
-	int		nfserr, count;
+	int		count;
+	__be32		nfserr;
 	loff_t		offset;
 
 	dprintk("nfsd: READDIR  %s %d bytes at %d\n",
@@ -513,7 +515,7 @@ static __be32
 nfsd_proc_statfs(struct svc_rqst * rqstp, struct nfsd_fhandle   *argp,
 					  struct nfsd_statfsres *resp)
 {
-	int	nfserr;
+	__be32	nfserr;
 
 	dprintk("nfsd: STATFS   %s\n", SVCFH_fmt(&argp->fh));
 
-- 
1.4.2.GIT


