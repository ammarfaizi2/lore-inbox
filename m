Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWGUOGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWGUOGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 10:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWGUOGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 10:06:04 -0400
Received: from outmx007.isp.belgacom.be ([195.238.5.234]:56805 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750728AbWGUOGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 10:06:01 -0400
Date: Fri, 21 Jul 2006 16:06:37 +0200
To: linux-kernel@vger.kernel.org
Cc: jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu,
       ext2-devel@lists.sourceforge.net, sct@redhat.com, akpm@osdl.org,
       adilger@clusterfs.com, mikulas@artax.karlin.mff.cuni.cz,
       jffs-dev@axis.com, shaggy@austin.ibm.com,
       jfs-discussion@lists.sourceforge.net, vandrove@vc.cvut.cz,
       linware@sh.cvut.cz, trond.myklebust@fys.uio.no, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, xfs-masters@oss.sgi.com,
       nathans@sgi.com, xfs@oss.sgi.com, neilb@cse.unsw.edu.au,
       nfs@lists.sourceforge.net
Subject: [PATCH 3/4] fs: Removing useless casts
Message-ID: <20060721140637.GC27097@issaris.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: takis@issaris.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

* Removing useless casts
* Removing useless wrapper
* Conversion from kmalloc+memset to kzalloc

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
 fs/coda/dir.c               |    2 +-
 fs/ext2/acl.c               |    4 ++--
 fs/ext3/acl.c               |    4 ++--
 fs/ext3/resize.c            |    4 ++--
 fs/hpfs/buffer.c            |    2 +-
 fs/jffs/inode-v23.c         |    8 ++++----
 fs/jffs/intrep.c            |   11 ++++-------
 fs/jffs/jffs_fm.c           |    6 ++----
 fs/jfs/jfs_txnmgr.c         |    4 ++--
 fs/lockd/clntproc.c         |    2 +-
 fs/ncpfs/symlink.c          |    4 ++--
 fs/nfs/delegation.c         |    7 +------
 fs/nfs/inode.c              |    2 +-
 fs/nfs/nfs3proc.c           |    2 +-
 fs/nfs/proc.c               |    2 +-
 fs/ntfs/dir.c               |    5 ++---
 fs/ntfs/inode.c             |    2 +-
 fs/ntfs/mft.c               |    4 ++--
 fs/ntfs/unistr.c            |    4 ++--
 fs/xfs/linux-2.6/xfs_file.c |    2 +-
 fs/xfs/linux-2.6/xfs_iops.c |    4 ++--
 21 files changed, 37 insertions(+), 48 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 71f2ea6..8651ea6 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -513,7 +513,7 @@ static int coda_venus_readdir(struct fil
 	ino_t ino;
 	int ret, i;
 
-	vdir = (struct venus_dirent *)kmalloc(sizeof(*vdir), GFP_KERNEL);
+	vdir = kmalloc(sizeof(*vdir), GFP_KERNEL);
 	if (!vdir) return -ENOMEM;
 
 	i = filp->f_pos;
diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
index da52b4a..d87586e 100644
--- a/fs/ext2/acl.c
+++ b/fs/ext2/acl.c
@@ -89,8 +89,8 @@ ext2_acl_to_disk(const struct posix_acl 
 	size_t n;
 
 	*size = ext2_acl_size(acl->a_count);
-	ext_acl = (ext2_acl_header *)kmalloc(sizeof(ext2_acl_header) +
-		acl->a_count * sizeof(ext2_acl_entry), GFP_KERNEL);
+	ext_acl = kmalloc(sizeof(ext2_acl_header) + acl->a_count * 
+			sizeof(ext2_acl_entry), GFP_KERNEL);
 	if (!ext_acl)
 		return ERR_PTR(-ENOMEM);
 	ext_acl->a_version = cpu_to_le32(EXT2_ACL_VERSION);
diff --git a/fs/ext3/acl.c b/fs/ext3/acl.c
index 0d21d55..2ad4b73 100644
--- a/fs/ext3/acl.c
+++ b/fs/ext3/acl.c
@@ -90,8 +90,8 @@ ext3_acl_to_disk(const struct posix_acl 
 	size_t n;
 
 	*size = ext3_acl_size(acl->a_count);
-	ext_acl = (ext3_acl_header *)kmalloc(sizeof(ext3_acl_header) +
-		acl->a_count * sizeof(ext3_acl_entry), GFP_KERNEL);
+	ext_acl = kmalloc(sizeof(ext3_acl_header) + acl->a_count * 
+			sizeof(ext3_acl_entry), GFP_KERNEL);
 	if (!ext_acl)
 		return ERR_PTR(-ENOMEM);
 	ext_acl->a_version = cpu_to_le32(EXT3_ACL_VERSION);
diff --git a/fs/ext3/resize.c b/fs/ext3/resize.c
index 5e1337f..2b9d65b 100644
--- a/fs/ext3/resize.c
+++ b/fs/ext3/resize.c
@@ -439,8 +439,8 @@ static int add_new_gdb(handle_t *handle,
 	if ((err = ext3_reserve_inode_write(handle, inode, &iloc)))
 		goto exit_dindj;
 
-	n_group_desc = (struct buffer_head **)kmalloc((gdb_num + 1) *
-				sizeof(struct buffer_head *), GFP_KERNEL);
+	n_group_desc = kmalloc((gdb_num + 1) * sizeof(struct buffer_head *), 
+			GFP_KERNEL);
 	if (!n_group_desc) {
 		err = -ENOMEM;
 		ext3_warning (sb, __FUNCTION__,
diff --git a/fs/hpfs/buffer.c b/fs/hpfs/buffer.c
index 2807aa8..b52b738 100644
--- a/fs/hpfs/buffer.c
+++ b/fs/hpfs/buffer.c
@@ -76,7 +76,7 @@ void *hpfs_map_4sectors(struct super_blo
 		return NULL;
 	}
 
-	qbh->data = data = (char *)kmalloc(2048, GFP_NOFS);
+	qbh->data = data = kmalloc(2048, GFP_NOFS);
 	if (!data) {
 		printk("HPFS: hpfs_map_4sectors: out of memory\n");
 		goto bail;
diff --git a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
index ac831aa..0a0ae2e 100644
--- a/fs/jffs/inode-v23.c
+++ b/fs/jffs/inode-v23.c
@@ -652,7 +652,7 @@ jffs_lookup(struct inode *dir, struct de
 	lock_kernel();
 
 	D3({
-		char *s = (char *)kmalloc(len + 1, GFP_KERNEL);
+		char *s = kmalloc(len + 1, GFP_KERNEL);
 		memcpy(s, name, len);
 		s[len] = '\0';
 		printk("jffs_lookup(): dir: 0x%p, name: \"%s\"\n", dir, s);
@@ -1173,8 +1173,8 @@ jffs_symlink(struct inode *dir, struct d
 	lock_kernel();
 	D1({
 		int len = dentry->d_name.len; 
-		char *_name = (char *)kmalloc(len + 1, GFP_KERNEL);
-		char *_symname = (char *)kmalloc(symname_len + 1, GFP_KERNEL);
+		char *_name = kmalloc(len + 1, GFP_KERNEL);
+		char *_symname = kmalloc(symname_len + 1, GFP_KERNEL);
 		memcpy(_name, dentry->d_name.name, len);
 		_name[len] = '\0';
 		memcpy(_symname, symname, symname_len);
@@ -1282,7 +1282,7 @@ jffs_create(struct inode *dir, struct de
 	lock_kernel();
 	D1({
 		int len = dentry->d_name.len;
-		char *s = (char *)kmalloc(len + 1, GFP_KERNEL);
+		char *s = kmalloc(len + 1, GFP_KERNEL);
 		memcpy(s, dentry->d_name.name, len);
 		s[len] = '\0';
 		printk("jffs_create(): dir: 0x%p, name: \"%s\"\n", dir, s);
diff --git a/fs/jffs/intrep.c b/fs/jffs/intrep.c
index fd637e9..92f9983 100644
--- a/fs/jffs/intrep.c
+++ b/fs/jffs/intrep.c
@@ -488,13 +488,11 @@ jffs_create_file(struct jffs_control *c,
 {
 	struct jffs_file *f;
 
-	if (!(f = (struct jffs_file *)kmalloc(sizeof(struct jffs_file),
-					      GFP_KERNEL))) {
+	if (!(f = kzalloc(sizeof(*f), GFP_KERNEL))) {
 		D(printk("jffs_create_file(): Failed!\n"));
 		return NULL;
 	}
 	no_jffs_file++;
-	memset(f, 0, sizeof(struct jffs_file));
 	f->ino = raw_inode->ino;
 	f->pino = raw_inode->pino;
 	f->nlink = raw_inode->nlink;
@@ -516,7 +514,7 @@ jffs_create_control(struct super_block *
 
 	D2(printk("jffs_create_control()\n"));
 
-	if (!(c = (struct jffs_control *)kmalloc(s, GFP_KERNEL))) {
+	if (!(c = kmalloc(s, GFP_KERNEL))) {
 		goto fail_control;
 	}
 	DJM(no_jffs_control++);
@@ -524,7 +522,7 @@ jffs_create_control(struct super_block *
 	c->gc_task = NULL;
 	c->hash_len = JFFS_HASH_SIZE;
 	s = sizeof(struct list_head) * c->hash_len;
-	if (!(c->hash = (struct list_head *)kmalloc(s, GFP_KERNEL))) {
+	if (!(c->hash = kmalloc(s, GFP_KERNEL))) {
 		goto fail_hash;
 	}
 	DJM(no_hash++);
@@ -593,8 +591,7 @@ jffs_add_virtual_root(struct jffs_contro
 	D2(printk("jffs_add_virtual_root(): "
 		  "Creating a virtual root directory.\n"));
 
-	if (!(root = (struct jffs_file *)kmalloc(sizeof(struct jffs_file),
-						 GFP_KERNEL))) {
+	if (!(root = kmalloc(sizeof(struct jffs_file), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
 	no_jffs_file++;
diff --git a/fs/jffs/jffs_fm.c b/fs/jffs/jffs_fm.c
index 7d8ca1a..29b68d9 100644
--- a/fs/jffs/jffs_fm.c
+++ b/fs/jffs/jffs_fm.c
@@ -94,8 +94,7 @@ jffs_build_begin(struct jffs_control *c,
 	struct mtd_info *mtd;
 	
 	D3(printk("jffs_build_begin()\n"));
-	fmc = (struct jffs_fmcontrol *)kmalloc(sizeof(struct jffs_fmcontrol),
-					       GFP_KERNEL);
+	fmc = kmalloc(sizeof(*fmc), GFP_KERNEL);
 	if (!fmc) {
 		D(printk("jffs_build_begin(): Allocation of "
 			 "struct jffs_fmcontrol failed!\n"));
@@ -486,8 +485,7 @@ jffs_add_node(struct jffs_node *node)
 
 	D3(printk("jffs_add_node(): ino = %u\n", node->ino));
 
-	ref = (struct jffs_node_ref *)kmalloc(sizeof(struct jffs_node_ref),
-					      GFP_KERNEL);
+	ref = kmalloc(sizeof(*ref), GFP_KERNEL);
 	if (!ref)
 		return -ENOMEM;
 
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index efbb586..3856efc 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -282,7 +282,7 @@ int txInit(void)
 	TxLockVHWM = (nTxLock * 8) / 10;
 
 	size = sizeof(struct tblock) * nTxBlock;
-	TxBlock = (struct tblock *) vmalloc(size);
+	TxBlock = vmalloc(size);
 	if (TxBlock == NULL)
 		return -ENOMEM;
 
@@ -307,7 +307,7 @@ int txInit(void)
 	 * tlock id = 0 is reserved.
 	 */
 	size = sizeof(struct tlock) * nTxLock;
-	TxLock = (struct tlock *) vmalloc(size);
+	TxLock = vmalloc(size);
 	if (TxLock == NULL) {
 		vfree(TxBlock);
 		return -ENOMEM;
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index 89ba0df..1e32c39 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -100,7 +100,7 @@ static struct nlm_lockowner *nlm_find_lo
 	res = __nlm_find_lockowner(host, owner);
 	if (res == NULL) {
 		spin_unlock(&host->h_lock);
-		new = (struct nlm_lockowner *)kmalloc(sizeof(*new), GFP_KERNEL);
+		new = kmalloc(sizeof(*new), GFP_KERNEL);
 		spin_lock(&host->h_lock);
 		res = __nlm_find_lockowner(host, owner);
 		if (res == NULL && new != NULL) {
diff --git a/fs/ncpfs/symlink.c b/fs/ncpfs/symlink.c
index ca92c24..e3d26c1 100644
--- a/fs/ncpfs/symlink.c
+++ b/fs/ncpfs/symlink.c
@@ -48,7 +48,7 @@ static int ncp_symlink_readpage(struct f
 	char *buf = kmap(page);
 
 	error = -ENOMEM;
-	rawlink=(char *)kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_KERNEL);
+	rawlink = kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_KERNEL);
 	if (!rawlink)
 		goto fail;
 
@@ -126,7 +126,7 @@ #endif
 	/* EPERM is returned by VFS if symlink procedure does not exist */
 		return -EPERM;
   
-	rawlink=(char *)kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_KERNEL);
+	rawlink = kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_KERNEL);
 	if (!rawlink)
 		return -ENOMEM;
 
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 9540a31..70a2729 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -19,11 +19,6 @@ #include <linux/nfs_xdr.h>
 #include "nfs4_fs.h"
 #include "delegation.h"
 
-static struct nfs_delegation *nfs_alloc_delegation(void)
-{
-	return (struct nfs_delegation *)kmalloc(sizeof(struct nfs_delegation), GFP_KERNEL);
-}
-
 static void nfs_free_delegation(struct nfs_delegation *delegation)
 {
 	if (delegation->cred)
@@ -123,7 +118,7 @@ int nfs_inode_set_delegation(struct inod
 	if ((nfsi->cache_validity & (NFS_INO_REVAL_PAGECACHE|NFS_INO_INVALID_ATTR)))
 		__nfs_revalidate_inode(NFS_SERVER(inode), inode);
 
-	delegation = nfs_alloc_delegation();
+	delegation = kmalloc(sizeof(*delegation), GFP_KERNEL);
 	if (delegation == NULL)
 		return -ENOMEM;
 	memcpy(delegation->stateid.data, res->delegation.data,
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index d349fb2..41c8d06 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -448,7 +448,7 @@ static struct nfs_open_context *alloc_nf
 {
 	struct nfs_open_context *ctx;
 
-	ctx = (struct nfs_open_context *)kmalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
 	if (ctx != NULL) {
 		atomic_set(&ctx->count, 1);
 		ctx->dentry = dget(dentry);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 7143b1f..fd6643b 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -449,7 +449,7 @@ nfs3_proc_unlink_setup(struct rpc_messag
 		struct nfs_fattr res;
 	} *ptr;
 
-	ptr = (struct unlinkxdr *)kmalloc(sizeof(*ptr), GFP_KERNEL);
+	ptr = kmalloc(sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	ptr->arg.fh = NFS_FH(dir->d_inode);
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index b3899ea..b0d391a 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -352,7 +352,7 @@ nfs_proc_unlink_setup(struct rpc_message
 {
 	struct nfs_diropargs	*arg;
 
-	arg = (struct nfs_diropargs *)kmalloc(sizeof(*arg), GFP_KERNEL);
+	arg = kmalloc(sizeof(*arg), GFP_KERNEL);
 	if (!arg)
 		return -ENOMEM;
 	arg->fh = NFS_FH(dir->d_inode);
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index d1e2c6f..85c36b8 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1149,8 +1149,7 @@ static int ntfs_readdir(struct file *fil
 	 * Allocate a buffer to store the current name being processed
 	 * converted to format determined by current NLS.
 	 */
-	name = (u8*)kmalloc(NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1,
-			GFP_NOFS);
+	name = kmalloc(NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1, GFP_NOFS);
 	if (unlikely(!name)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -1191,7 +1190,7 @@ static int ntfs_readdir(struct file *fil
 	 * map the mft record without deadlocking.
 	 */
 	rc = le32_to_cpu(ctx->attr->data.resident.value_length);
-	ir = (INDEX_ROOT*)kmalloc(rc, GFP_NOFS);
+	ir = kmalloc(rc, GFP_NOFS);
 	if (unlikely(!ir)) {
 		err = -ENOMEM;
 		goto err_out;
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index d313f35..3185212 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -137,7 +137,7 @@ static int ntfs_init_locked_inode(struct
 
 		BUG_ON(!na->name);
 		i = na->name_len * sizeof(ntfschar);
-		ni->name = (ntfschar*)kmalloc(i + sizeof(ntfschar), GFP_ATOMIC);
+		ni->name = kmalloc(i + sizeof(ntfschar), GFP_ATOMIC);
 		if (!ni->name)
 			return -ENOMEM;
 		memcpy(ni->name, na->name, i);
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 2438c00..578fb3d 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -331,7 +331,7 @@ map_err_out:
 		ntfs_inode **tmp;
 		int new_size = (base_ni->nr_extents + 4) * sizeof(ntfs_inode *);
 
-		tmp = (ntfs_inode **)kmalloc(new_size, GFP_NOFS);
+		tmp = kmalloc(new_size, GFP_NOFS);
 		if (unlikely(!tmp)) {
 			ntfs_error(base_ni->vol->sb, "Failed to allocate "
 					"internal buffer.");
@@ -2893,7 +2893,7 @@ rollback:
 	if (!(base_ni->nr_extents & 3)) {
 		int new_size = (base_ni->nr_extents + 4) * sizeof(ntfs_inode*);
 
-		extent_nis = (ntfs_inode**)kmalloc(new_size, GFP_NOFS);
+		extent_nis = kmalloc(new_size, GFP_NOFS);
 		if (unlikely(!extent_nis)) {
 			ntfs_error(vol->sb, "Failed to allocate internal "
 					"buffer during rollback.%s", es);
diff --git a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
index b123c0f..a1b5721 100644
--- a/fs/ntfs/unistr.c
+++ b/fs/ntfs/unistr.c
@@ -350,7 +350,7 @@ int ntfs_ucstonls(const ntfs_volume *vol
 		}
 		if (!ns) {
 			ns_len = ins_len * NLS_MAX_CHARSET_SIZE;
-			ns = (unsigned char*)kmalloc(ns_len + 1, GFP_NOFS);
+			ns = kmalloc(ns_len + 1, GFP_NOFS);
 			if (!ns)
 				goto mem_err_out;
 		}
@@ -365,7 +365,7 @@ retry:			wc = nls->uni2char(le16_to_cpu(
 			else if (wc == -ENAMETOOLONG && ns != *outs) {
 				unsigned char *tc;
 				/* Grow in multiples of 64 bytes. */
-				tc = (unsigned char*)kmalloc((ns_len + 64) &
+				tc = kmalloc((ns_len + 64) &
 						~63, GFP_NOFS);
 				if (tc) {
 					memcpy(tc, ns, ns_len);
diff --git a/fs/xfs/linux-2.6/xfs_file.c b/fs/xfs/linux-2.6/xfs_file.c
index 3d4f6df..41cfcba 100644
--- a/fs/xfs/linux-2.6/xfs_file.c
+++ b/fs/xfs/linux-2.6/xfs_file.c
@@ -370,7 +370,7 @@ xfs_file_readdir(
 
 	/* Try fairly hard to get memory */
 	do {
-		if ((read_buf = (caddr_t)kmalloc(rlen, GFP_KERNEL)))
+		if ((read_buf = kmalloc(rlen, GFP_KERNEL)))
 			break;
 		rlen >>= 1;
 	} while (rlen >= 1024);
diff --git a/fs/xfs/linux-2.6/xfs_iops.c b/fs/xfs/linux-2.6/xfs_iops.c
index d918002..22e3b71 100644
--- a/fs/xfs/linux-2.6/xfs_iops.c
+++ b/fs/xfs/linux-2.6/xfs_iops.c
@@ -553,13 +553,13 @@ xfs_vn_follow_link(
 	ASSERT(dentry);
 	ASSERT(nd);
 
-	link = (char *)kmalloc(MAXPATHLEN+1, GFP_KERNEL);
+	link = kmalloc(MAXPATHLEN+1, GFP_KERNEL);
 	if (!link) {
 		nd_set_link(nd, ERR_PTR(-ENOMEM));
 		return NULL;
 	}
 
-	uio = (uio_t *)kmalloc(sizeof(uio_t), GFP_KERNEL);
+	uio = kmalloc(sizeof(uio_t), GFP_KERNEL);
 	if (!uio) {
 		kfree(link);
 		nd_set_link(nd, ERR_PTR(-ENOMEM));
-- 
1.4.2.rc1.ge7a0-dirty

