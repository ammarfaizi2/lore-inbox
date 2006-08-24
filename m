Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWHXVR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWHXVR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWHXVR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:17:27 -0400
Received: from pat.uio.no ([129.240.10.4]:32418 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030392AbWHXVR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:17:26 -0400
Subject: [GIT] Fixes for the NFS client...
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:17:11 -0400
Message-Id: <1156454232.5629.75.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.923, required 12,
	autolearn=disabled, AWL 0.57, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the repository at

   git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git fixes

This will update the following files through the appended changesets.

  Cheers,
    Trond

----
 fs/exec.c                          |    8 -----
 fs/lockd/svcsubs.c                 |   15 ++++++----
 fs/namei.c                         |   11 +++++++
 fs/nfs/file.c                      |    8 +++++
 fs/nfs/idmap.c                     |    4 +--
 fs/nfs/nfs4proc.c                  |   29 ++++++++++++++++++-
 fs/nfs/nfs4xdr.c                   |   21 +++++++-------
 fs/nfs/read.c                      |   23 ++++++++++-----
 include/linux/nfs_xdr.h            |    2 +
 include/linux/sunrpc/rpc_pipe_fs.h |    4 +--
 include/linux/sunrpc/xprt.h        |    2 +
 net/sunrpc/auth_gss/auth_gss.c     |    3 +-
 net/sunrpc/clnt.c                  |   30 ++++++++++++--------
 net/sunrpc/rpc_pipe.c              |   55 ++++++++++++++----------------------
 14 files changed, 125 insertions(+), 90 deletions(-)

commit a969fd5a4e162c4485ae8f3e49d674656a18fa36
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    VFS: Remove redundant open-coded mode bit checks in open_exec().

commit 9167b0b9a0ab7907191523f5a0528e3b9c288e21
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    VFS: Remove redundant open-coded mode bit check in prepare_binfmt().

commit a343bb7750e6a098909c34f5c5dfddbc4fa40053
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    VFS: Fix access("file", X_OK) in the presence of ACLs

commit 16b4289c7460ba9c04af40c574949dcca9029658
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    NFSv4: Add v4 exception handling for the ACL functions.

commit e8896495bca8490a427409e0886d63d05419ec65
Author: David Howells <dhowells@redhat.com>

    NFS: Check lengths more thoroughly in NFS4 readdir XDR decode

commit 3cedf13af9f7e61aca0dbbd11b601ac93bf93a9f
Author: J. Bruce Fields <bfields@fieldses.org>

    NFSv4: increase client-provided nfs4 clientid size

commit 8e037094c414172481c5ce903efdab50ce932343
Author: Chuck Lever <chuck.lever@oracle.com>

    SUNRPC: avoid choosing an IPMI port for RPC traffic

commit 79558f3610efd7928e8882b2eaca3093b283630e
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    NFS: Fix issue with EIO on NFS read

commit 01df9c5e918ae5559f2d96da0143f8bfbb9e6171
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    LOCKD: Fix a deadlock in nlm_traverse_files()

commit 8f8e7a50f450fcb86a5b2ffb94543c57a14f8260
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    SUNRPC: Fix dentry refcounting issues with users of rpc_pipefs

commit 68adb0af51ebccb72ffb14d49cb8121b1afc4259
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    SUNRPC: rpc_unlink() must check for unhashed dentries

commit dff02cc1a34fcb60904a2c57cb351857cc11219e
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    NFS: clean up rpc_rmdir

commit 5d67476fff2df6ff12f60b540fd0e74cf2a668f9
Author: Trond Myklebust <Trond.Myklebust@netapp.com>

    SUNRPC: make rpc_unlink() take a dentry argument instead of a path

commit a634904a7de0d3a0bc606f608007a34e8c05bfee
Author: ASANO Masahiro <masano@tnes.nec.co.jp>

    VFS: add lookup hint for network file systems

commit ddeff520f02b92128132c282c350fa72afffb84a
Author: Nikita Danilov <nikita@clusterfs.com>

    NFS: Fix a potential deadlock in nfs_release_page

diff --git a/fs/exec.c b/fs/exec.c
index 8344ba7..f7aabfe 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -486,8 +486,6 @@ struct file *open_exec(const char *name)
 		if (!(nd.mnt->mnt_flags & MNT_NOEXEC) &&
 		    S_ISREG(inode->i_mode)) {
 			int err = vfs_permission(&nd, MAY_EXEC);
-			if (!err && !(inode->i_mode & 0111))
-				err = -EACCES;
 			file = ERR_PTR(err);
 			if (!err) {
 				file = nameidata_to_filp(&nd, O_RDONLY);
@@ -922,12 +920,6 @@ int prepare_binprm(struct linux_binprm *
 	int retval;
 
 	mode = inode->i_mode;
-	/*
-	 * Check execute perms again - if the caller has CAP_DAC_OVERRIDE,
-	 * generic_permission lets a non-executable through
-	 */
-	if (!(mode & 0111))	/* with at least _one_ execute bit set */
-		return -EACCES;
 	if (bprm->file->f_op == NULL)
 		return -EACCES;
 
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 2a4df9b..01b4db9 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -237,19 +237,22 @@ static int
 nlm_traverse_files(struct nlm_host *host, int action)
 {
 	struct nlm_file	*file, **fp;
-	int		i;
+	int i, ret = 0;
 
 	mutex_lock(&nlm_file_mutex);
 	for (i = 0; i < FILE_NRHASH; i++) {
 		fp = nlm_files + i;
 		while ((file = *fp) != NULL) {
+			file->f_count++;
+			mutex_unlock(&nlm_file_mutex);
+
 			/* Traverse locks, blocks and shares of this file
 			 * and update file->f_locks count */
-			if (nlm_inspect_file(host, file, action)) {
-				mutex_unlock(&nlm_file_mutex);
-				return 1;
-			}
+			if (nlm_inspect_file(host, file, action))
+				ret = 1;
 
+			mutex_lock(&nlm_file_mutex);
+			file->f_count--;
 			/* No more references to this file. Let go of it. */
 			if (!file->f_blocks && !file->f_locks
 			 && !file->f_shares && !file->f_count) {
@@ -262,7 +265,7 @@ nlm_traverse_files(struct nlm_host *host
 		}
 	}
 	mutex_unlock(&nlm_file_mutex);
-	return 0;
+	return ret;
 }
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index 55a1312..432d6bc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -227,10 +227,10 @@ int generic_permission(struct inode *ino
 
 int permission(struct inode *inode, int mask, struct nameidata *nd)
 {
+	umode_t mode = inode->i_mode;
 	int retval, submask;
 
 	if (mask & MAY_WRITE) {
-		umode_t mode = inode->i_mode;
 
 		/*
 		 * Nobody gets write access to a read-only fs.
@@ -247,6 +247,13 @@ int permission(struct inode *inode, int 
 	}
 
 
+	/*
+	 * MAY_EXEC on regular files requires special handling: We override
+	 * filesystem execute permissions if the mode bits aren't set.
+	 */
+	if ((mask & MAY_EXEC) && S_ISREG(mode) && !(mode & S_IXUGO))
+		return -EACCES;
+
 	/* Ordinary permission routines do not understand MAY_APPEND. */
 	submask = mask & ~MAY_APPEND;
 	if (inode->i_op && inode->i_op->permission)
@@ -1767,6 +1774,8 @@ struct dentry *lookup_create(struct name
 	if (nd->last_type != LAST_NORM)
 		goto fail;
 	nd->flags &= ~LOOKUP_PARENT;
+	nd->flags |= LOOKUP_CREATE;
+	nd->intent.open.flags = O_EXCL;
 
 	/*
 	 * Do the final lookup.
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index cc2b874..48e8928 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -312,7 +312,13 @@ static void nfs_invalidate_page(struct p
 
 static int nfs_release_page(struct page *page, gfp_t gfp)
 {
-	return !nfs_wb_page(page->mapping->host, page);
+	if (gfp & __GFP_FS)
+		return !nfs_wb_page(page->mapping->host, page);
+	else
+		/*
+		 * Avoid deadlock on nfs_wait_on_request().
+		 */
+		return 0;
 }
 
 const struct address_space_operations nfs_file_aops = {
diff --git a/fs/nfs/idmap.c b/fs/nfs/idmap.c
index b81e7ed..07a5dd5 100644
--- a/fs/nfs/idmap.c
+++ b/fs/nfs/idmap.c
@@ -130,9 +130,7 @@ nfs_idmap_delete(struct nfs4_client *clp
 
 	if (!idmap)
 		return;
-	dput(idmap->idmap_dentry);
-	idmap->idmap_dentry = NULL;
-	rpc_unlink(idmap->idmap_path);
+	rpc_unlink(idmap->idmap_dentry);
 	clp->cl_idmap = NULL;
 	kfree(idmap);
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e6ee97f..153898e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2668,7 +2668,7 @@ out:
 	nfs4_set_cached_acl(inode, acl);
 }
 
-static inline ssize_t nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t buflen)
+static ssize_t __nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t buflen)
 {
 	struct page *pages[NFS4ACL_MAXPAGES];
 	struct nfs_getaclargs args = {
@@ -2721,6 +2721,19 @@ out_free:
 	return ret;
 }
 
+static ssize_t nfs4_get_acl_uncached(struct inode *inode, void *buf, size_t buflen)
+{
+	struct nfs4_exception exception = { };
+	ssize_t ret;
+	do {
+		ret = __nfs4_get_acl_uncached(inode, buf, buflen);
+		if (ret >= 0)
+			break;
+		ret = nfs4_handle_exception(NFS_SERVER(inode), ret, &exception);
+	} while (exception.retry);
+	return ret;
+}
+
 static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
@@ -2737,7 +2750,7 @@ static ssize_t nfs4_proc_get_acl(struct 
 	return nfs4_get_acl_uncached(inode, buf, buflen);
 }
 
-static int nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t buflen)
+static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t buflen)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 	struct page *pages[NFS4ACL_MAXPAGES];
@@ -2763,6 +2776,18 @@ static int nfs4_proc_set_acl(struct inod
 	return ret;
 }
 
+static int nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t buflen)
+{
+	struct nfs4_exception exception = { };
+	int err;
+	do {
+		err = nfs4_handle_exception(NFS_SERVER(inode),
+				__nfs4_proc_set_acl(inode, buf, buflen),
+				&exception);
+	} while (exception.retry);
+	return err;
+}
+
 static int
 nfs4_async_handle_error(struct rpc_task *task, const struct nfs_server *server)
 {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 1750d99..730ec8f 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3355,7 +3355,7 @@ static int decode_readdir(struct xdr_str
 	struct kvec	*iov = rcvbuf->head;
 	unsigned int	nr, pglen = rcvbuf->page_len;
 	uint32_t	*end, *entry, *p, *kaddr;
-	uint32_t	len, attrlen;
+	uint32_t	len, attrlen, xlen;
 	int 		hdrlen, recvd, status;
 
 	status = decode_op_hdr(xdr, OP_READDIR);
@@ -3377,10 +3377,10 @@ static int decode_readdir(struct xdr_str
 
 	BUG_ON(pglen + readdir->pgbase > PAGE_CACHE_SIZE);
 	kaddr = p = (uint32_t *) kmap_atomic(page, KM_USER0);
-	end = (uint32_t *) ((char *)p + pglen + readdir->pgbase);
+	end = p + ((pglen + readdir->pgbase) >> 2);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
-		if (p + 3 > end)
+		if (end - p < 3)
 			goto short_pkt;
 		dprintk("cookie = %Lu, ", *((unsigned long long *)p));
 		p += 2;			/* cookie */
@@ -3389,18 +3389,19 @@ static int decode_readdir(struct xdr_str
 			printk(KERN_WARNING "NFS: giant filename in readdir (len 0x%x)\n", len);
 			goto err_unmap;
 		}
-		dprintk("filename = %*s\n", len, (char *)p);
-		p += XDR_QUADLEN(len);
-		if (p + 1 > end)
+		xlen = XDR_QUADLEN(len);
+		if (end - p < xlen + 1)
 			goto short_pkt;
+		dprintk("filename = %*s\n", len, (char *)p);
+		p += xlen;
 		len = ntohl(*p++);	/* bitmap length */
-		p += len;
-		if (p + 1 > end)
+		if (end - p < len + 1)
 			goto short_pkt;
+		p += len;
 		attrlen = XDR_QUADLEN(ntohl(*p++));
-		p += attrlen;		/* attributes */
-		if (p + 2 > end)
+		if (end - p < attrlen + 2)
 			goto short_pkt;
+		p += attrlen;		/* attributes */
 		entry = p;
 	}
 	if (!nr && (entry[0] != 0 || entry[1] == 0))
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 65c0c5b..da9cf11 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -116,10 +116,17 @@ static void nfs_readpage_truncate_uninit
 	pages = &data->args.pages[base >> PAGE_CACHE_SHIFT];
 	base &= ~PAGE_CACHE_MASK;
 	pglen = PAGE_CACHE_SIZE - base;
-	if (pglen < remainder)
+	for (;;) {
+		if (remainder <= pglen) {
+			memclear_highpage_flush(*pages, base, remainder);
+			break;
+		}
 		memclear_highpage_flush(*pages, base, pglen);
-	else
-		memclear_highpage_flush(*pages, base, remainder);
+		pages++;
+		remainder -= pglen;
+		pglen = PAGE_CACHE_SIZE;
+		base = 0;
+	}
 }
 
 /*
@@ -476,6 +483,8 @@ static void nfs_readpage_set_pages_uptod
 	unsigned int base = data->args.pgbase;
 	struct page **pages;
 
+	if (data->res.eof)
+		count = data->args.count;
 	if (unlikely(count == 0))
 		return;
 	pages = &data->args.pages[base >> PAGE_CACHE_SHIFT];
@@ -483,11 +492,7 @@ static void nfs_readpage_set_pages_uptod
 	count += base;
 	for (;count >= PAGE_CACHE_SIZE; count -= PAGE_CACHE_SIZE, pages++)
 		SetPageUptodate(*pages);
-	/*
-	 * Was this an eof or a short read? If the latter, don't mark the page
-	 * as uptodate yet.
-	 */
-	if (count > 0 && (data->res.eof || data->args.count == data->res.count))
+	if (count != 0)
 		SetPageUptodate(*pages);
 }
 
@@ -502,6 +507,8 @@ static void nfs_readpage_set_pages_error
 	count += base;
 	for (;count >= PAGE_CACHE_SIZE; count -= PAGE_CACHE_SIZE, pages++)
 		SetPageError(*pages);
+	if (count != 0)
+		SetPageError(*pages);
 }
 
 /*
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 2d3fb64..db9cbf6 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -659,7 +659,7 @@ struct nfs4_rename_res {
 struct nfs4_setclientid {
 	const nfs4_verifier *		sc_verifier;      /* request */
 	unsigned int			sc_name_len;
-	char				sc_name[32];	  /* request */
+	char				sc_name[48];	  /* request */
 	u32				sc_prog;          /* request */
 	unsigned int			sc_netid_len;
 	char				sc_netid[4];	  /* request */
diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index 2c2189c..a481472 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -42,9 +42,9 @@ RPC_I(struct inode *inode)
 extern int rpc_queue_upcall(struct inode *, struct rpc_pipe_msg *);
 
 extern struct dentry *rpc_mkdir(char *, struct rpc_clnt *);
-extern int rpc_rmdir(char *);
+extern int rpc_rmdir(struct dentry *);
 extern struct dentry *rpc_mkpipe(char *, void *, struct rpc_pipe_ops *, int flags);
-extern int rpc_unlink(char *);
+extern int rpc_unlink(struct dentry *);
 extern struct vfsmount *rpc_get_mount(void);
 extern void rpc_put_mount(void);
 
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 840e47a..3a0cca2 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -37,7 +37,7 @@ extern unsigned int xprt_max_resvport;
 
 #define RPC_MIN_RESVPORT	(1U)
 #define RPC_MAX_RESVPORT	(65535U)
-#define RPC_DEF_MIN_RESVPORT	(650U)
+#define RPC_DEF_MIN_RESVPORT	(665U)
 #define RPC_DEF_MAX_RESVPORT	(1023U)
 
 /*
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 4a9aa93..ef1cf5b 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -718,8 +718,7 @@ gss_destroy(struct rpc_auth *auth)
 		auth, auth->au_flavor);
 
 	gss_auth = container_of(auth, struct gss_auth, rpc_auth);
-	rpc_unlink(gss_auth->path);
-	dput(gss_auth->dentry);
+	rpc_unlink(gss_auth->dentry);
 	gss_auth->dentry = NULL;
 	gss_mech_put(gss_auth->mech);
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d6409e7..3e19d32 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -183,8 +183,7 @@ rpc_new_client(struct rpc_xprt *xprt, ch
 
 out_no_auth:
 	if (!IS_ERR(clnt->cl_dentry)) {
-		rpc_rmdir(clnt->cl_pathname);
-		dput(clnt->cl_dentry);
+		rpc_rmdir(clnt->cl_dentry);
 		rpc_put_mount();
 	}
 out_no_path:
@@ -251,10 +250,8 @@ rpc_clone_client(struct rpc_clnt *clnt)
 	new->cl_autobind = 0;
 	new->cl_oneshot = 0;
 	new->cl_dead = 0;
-	if (!IS_ERR(new->cl_dentry)) {
+	if (!IS_ERR(new->cl_dentry))
 		dget(new->cl_dentry);
-		rpc_get_mount();
-	}
 	rpc_init_rtt(&new->cl_rtt_default, clnt->cl_xprt->timeout.to_initval);
 	if (new->cl_auth)
 		atomic_inc(&new->cl_auth->au_count);
@@ -317,11 +314,15 @@ rpc_destroy_client(struct rpc_clnt *clnt
 		clnt->cl_auth = NULL;
 	}
 	if (clnt->cl_parent != clnt) {
+		if (!IS_ERR(clnt->cl_dentry))
+			dput(clnt->cl_dentry);
 		rpc_destroy_client(clnt->cl_parent);
 		goto out_free;
 	}
-	if (clnt->cl_pathname[0])
-		rpc_rmdir(clnt->cl_pathname);
+	if (!IS_ERR(clnt->cl_dentry)) {
+		rpc_rmdir(clnt->cl_dentry);
+		rpc_put_mount();
+	}
 	if (clnt->cl_xprt) {
 		xprt_destroy(clnt->cl_xprt);
 		clnt->cl_xprt = NULL;
@@ -331,10 +332,6 @@ rpc_destroy_client(struct rpc_clnt *clnt
 out_free:
 	rpc_free_iostats(clnt->cl_metrics);
 	clnt->cl_metrics = NULL;
-	if (!IS_ERR(clnt->cl_dentry)) {
-		dput(clnt->cl_dentry);
-		rpc_put_mount();
-	}
 	kfree(clnt);
 	return 0;
 }
@@ -1184,6 +1181,17 @@ call_verify(struct rpc_task *task)
 	u32	*p = iov->iov_base, n;
 	int error = -EACCES;
 
+	if ((task->tk_rqstp->rq_rcv_buf.len & 3) != 0) {
+		/* RFC-1014 says that the representation of XDR data must be a
+		 * multiple of four bytes
+		 * - if it isn't pointer subtraction in the NFS client may give
+		 *   undefined results
+		 */
+		printk(KERN_WARNING
+		       "call_verify: XDR representation not a multiple of"
+		       " 4 bytes: 0x%x\n", task->tk_rqstp->rq_rcv_buf.len);
+		goto out_eio;
+	}
 	if ((len -= 3) < 0)
 		goto out_overflow;
 	p += 1;	/* skip XID */
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index a3bd2db..0b1a1ac 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -539,6 +539,7 @@ repeat:
 				rpc_close_pipes(dentry->d_inode);
 				simple_unlink(dir, dentry);
 			}
+			inode_dir_notify(dir, DN_DELETE);
 			dput(dentry);
 		} while (n);
 		goto repeat;
@@ -610,8 +611,8 @@ __rpc_rmdir(struct inode *dir, struct de
 	int error;
 
 	shrink_dcache_parent(dentry);
-	if (dentry->d_inode)
-		rpc_close_pipes(dentry->d_inode);
+	if (d_unhashed(dentry))
+		return 0;
 	if ((error = simple_rmdir(dir, dentry)) != 0)
 		return error;
 	if (!error) {
@@ -684,28 +685,20 @@ err_dput:
 }
 
 int
-rpc_rmdir(char *path)
+rpc_rmdir(struct dentry *dentry)
 {
-	struct nameidata nd;
-	struct dentry *dentry;
+	struct dentry *parent;
 	struct inode *dir;
 	int error;
 
-	if ((error = rpc_lookup_parent(path, &nd)) != 0)
-		return error;
-	dir = nd.dentry->d_inode;
+	parent = dget_parent(dentry);
+	dir = parent->d_inode;
 	mutex_lock_nested(&dir->i_mutex, I_MUTEX_PARENT);
-	dentry = lookup_one_len(nd.last.name, nd.dentry, nd.last.len);
-	if (IS_ERR(dentry)) {
-		error = PTR_ERR(dentry);
-		goto out_release;
-	}
 	rpc_depopulate(dentry);
 	error = __rpc_rmdir(dir, dentry);
 	dput(dentry);
-out_release:
 	mutex_unlock(&dir->i_mutex);
-	rpc_release_path(&nd);
+	dput(parent);
 	return error;
 }
 
@@ -746,32 +739,26 @@ err_dput:
 }
 
 int
-rpc_unlink(char *path)
+rpc_unlink(struct dentry *dentry)
 {
-	struct nameidata nd;
-	struct dentry *dentry;
+	struct dentry *parent;
 	struct inode *dir;
-	int error;
+	int error = 0;
 
-	if ((error = rpc_lookup_parent(path, &nd)) != 0)
-		return error;
-	dir = nd.dentry->d_inode;
+	parent = dget_parent(dentry);
+	dir = parent->d_inode;
 	mutex_lock_nested(&dir->i_mutex, I_MUTEX_PARENT);
-	dentry = lookup_one_len(nd.last.name, nd.dentry, nd.last.len);
-	if (IS_ERR(dentry)) {
-		error = PTR_ERR(dentry);
-		goto out_release;
-	}
-	d_drop(dentry);
-	if (dentry->d_inode) {
-		rpc_close_pipes(dentry->d_inode);
-		error = simple_unlink(dir, dentry);
+	if (!d_unhashed(dentry)) {
+		d_drop(dentry);
+		if (dentry->d_inode) {
+			rpc_close_pipes(dentry->d_inode);
+			error = simple_unlink(dir, dentry);
+		}
+		inode_dir_notify(dir, DN_DELETE);
 	}
 	dput(dentry);
-	inode_dir_notify(dir, DN_DELETE);
-out_release:
 	mutex_unlock(&dir->i_mutex);
-	rpc_release_path(&nd);
+	dput(parent);
 	return error;
 }
 


