Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbVKIBS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVKIBS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbVKIBS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:18:26 -0500
Received: from outmx022.isp.belgacom.be ([195.238.2.203]:47252 "EHLO
	outmx022.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030283AbVKIBSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:18:24 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Conversions from kmalloc/memset to kzalloc.
Message-Id: <20051109011744.6E14620A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 02:17:44 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Conversions from kmalloc/memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 fs/adfs/super.c       |    3 +--
 fs/affs/bitmap.c      |    3 +--
 fs/affs/super.c       |    3 +--
 fs/afs/server.c       |    3 +--
 fs/afs/super.c        |    4 +---
 fs/afs/vlocation.c    |    3 +--
 fs/afs/volume.c       |    3 +--
 fs/aio.c              |    3 +--
 fs/autofs/inode.c     |    3 +--
 fs/autofs4/inode.c    |    4 +---
 fs/bfs/inode.c        |    6 ++----
 fs/binfmt_elf.c       |    3 +--
 fs/binfmt_elf_fdpic.c |    3 +--
 fs/bio.c              |    7 ++-----
 fs/char_dev.c         |    7 ++-----
 fs/cifs/connect.c     |    3 +--
 fs/cifs/dir.c         |    4 +---
 fs/cifs/inode.c       |    3 +--
 fs/cifs/misc.c        |    9 ++-------
 fs/cifs/readdir.c     |    4 +---
 fs/compat.c           |    3 +--
 fs/cramfs/inode.c     |    3 +--
 fs/devfs/base.c       |    4 ++--
 fs/efs/super.c        |    3 +--
 fs/exec.c             |    3 +--
 fs/ext2/super.c       |    6 ++----
 fs/ext2/xattr.c       |    3 +--
 fs/ext3/dir.c         |    3 +--
 fs/ext3/super.c       |    3 +--
 fs/ext3/xattr.c       |    3 +--
 fs/fat/inode.c        |    3 +--
 fs/file.c             |    3 +--
 fs/fuse/inode.c       |    3 +--
 fs/hfs/bnode.c        |    3 +--
 fs/hfs/btree.c        |    3 +--
 fs/hfs/super.c        |    3 +--
 fs/hfsplus/bnode.c    |    3 +--
 fs/hfsplus/btree.c    |    3 +--
 fs/hpfs/super.c       |    3 +--
 fs/isofs/inode.c      |    3 +--
 fs/jffs/intrep.c      |    7 ++-----
 fs/jffs2/build.c      |    3 +--
 fs/jffs2/fs.c         |    3 +--
 fs/jffs2/readinode.c  |    3 +--
 fs/jffs2/scan.c       |    3 +--
 fs/jffs2/summary.c    |    4 +---
 fs/jffs2/super.c      |    3 +--
 fs/jfs/jfs_logmgr.c   |    9 +++------
 fs/jfs/jfs_metapage.c |    3 +--
 fs/jfs/super.c        |    3 +--
 fs/lockd/clntproc.c   |    3 +--
 fs/lockd/host.c       |    3 +--
 fs/lockd/svclock.c    |    3 +--
 fs/lockd/svcsubs.c    |    3 +--
 fs/minix/inode.c      |    6 ++----
 fs/ncpfs/inode.c      |    3 +--
 fs/nfs/idmap.c        |    4 +---
 fs/nfs/inode.c        |    6 ++----
 fs/nfs/nfs4state.c    |    3 +--
 fs/nfs/unlink.c       |    3 +--
 fs/nfsd/nfs4idmap.c   |    3 +--
 fs/nfsd/nfs4state.c   |    3 +--
 fs/nfsd/nfscache.c    |    3 +--
 fs/nfsd/vfs.c         |    3 +--
 fs/partitions/check.c |    3 +--
 fs/partitions/efi.c   |    9 +++------
 fs/pipe.c             |    3 +--
 fs/proc/kcore.c       |    3 +--
 fs/proc/vmcore.c      |    4 +---
 fs/qnx4/inode.c       |    3 +--
 fs/reiserfs/file.c    |    3 +--
 fs/reiserfs/inode.c   |    7 ++-----
 fs/reiserfs/super.c   |    3 +--
 fs/seq_file.c         |    3 +--
 fs/super.c            |    3 +--
 fs/sysfs/file.c       |    3 +--
 fs/sysfs/inode.c      |    3 +--
 fs/sysv/super.c       |    6 ++----
 fs/ufs/super.c        |    3 +--
 79 files changed, 94 insertions(+), 200 deletions(-)

applies-to: 48f4e55388212f8dd36ab3dc47799414e5fab263
3b93c9d3b05e9fdb7acfdecd25c40471c7d850d9
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 2439632..7b56f66 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -338,11 +338,10 @@ static int adfs_fill_super(struct super_
 
 	sb->s_flags |= MS_NODIRATIME;
 
-	asb = kmalloc(sizeof(*asb), GFP_KERNEL);
+	asb = kzalloc(sizeof(*asb), GFP_KERNEL);
 	if (!asb)
 		return -ENOMEM;
 	sb->s_fs_info = asb;
-	memset(asb, 0, sizeof(*asb));
 
 	/* set default options */
 	asb->s_uid = 0;
diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
index b0b9536..b330009 100644
--- a/fs/affs/bitmap.c
+++ b/fs/affs/bitmap.c
@@ -289,12 +289,11 @@ int affs_init_bitmap(struct super_block 
 	sbi->s_bmap_count = (sbi->s_partition_size - sbi->s_reserved +
 				 sbi->s_bmap_bits - 1) / sbi->s_bmap_bits;
 	size = sbi->s_bmap_count * sizeof(*bm);
-	bm = sbi->s_bitmap = kmalloc(size, GFP_KERNEL);
+	bm = sbi->s_bitmap = kzalloc(size, GFP_KERNEL);
 	if (!sbi->s_bitmap) {
 		printk(KERN_ERR "AFFS: Bitmap allocation failed\n");
 		return -ENOMEM;
 	}
-	memset(sbi->s_bitmap, 0, size);
 
 	bmap_blk = (__be32 *)sbi->s_root_bh->b_data;
 	blk = sb->s_blocksize / 4 - 49;
diff --git a/fs/affs/super.c b/fs/affs/super.c
index aaec015..62251bc 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -277,11 +277,10 @@ static int affs_fill_super(struct super_
 	sb->s_op                = &affs_sops;
 	sb->s_flags |= MS_NODIRATIME;
 
-	sbi = kmalloc(sizeof(struct affs_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct affs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(*sbi));
 	init_MUTEX(&sbi->s_bmlock);
 
 	if (!parse_options(data,&uid,&gid,&i,&reserved,&root_block,
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 62b093a..163a337 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -55,13 +55,12 @@ int afs_server_lookup(struct afs_cell *c
 	_enter("%p,%08x,", cell, ntohl(addr->s_addr));
 
 	/* allocate and initialise a server record */
-	server = kmalloc(sizeof(struct afs_server), GFP_KERNEL);
+	server = kzalloc(sizeof(struct afs_server), GFP_KERNEL);
 	if (!server) {
 		_leave(" = -ENOMEM");
 		return -ENOMEM;
 	}
 
-	memset(server, 0, sizeof(struct afs_server));
 	atomic_set(&server->usage, 1);
 
 	INIT_LIST_HEAD(&server->link);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index d6fa8e5..8be45a8 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -242,14 +242,12 @@ static int afs_fill_super(struct super_b
 	kenter("");
 
 	/* allocate a superblock info record */
-	as = kmalloc(sizeof(struct afs_super_info), GFP_KERNEL);
+	as = kzalloc(sizeof(struct afs_super_info), GFP_KERNEL);
 	if (!as) {
 		_leave(" = -ENOMEM");
 		return -ENOMEM;
 	}
 
-	memset(as, 0, sizeof(struct afs_super_info));
-
 	afs_get_volume(params->volume);
 	as->volume = params->volume;
 
diff --git a/fs/afs/vlocation.c b/fs/afs/vlocation.c
index eced206..79d50cf 100644
--- a/fs/afs/vlocation.c
+++ b/fs/afs/vlocation.c
@@ -281,11 +281,10 @@ int afs_vlocation_lookup(struct afs_cell
 	spin_unlock(&cell->vl_gylock);
 
 	/* not in the cell's in-memory lists - create a new record */
-	vlocation = kmalloc(sizeof(struct afs_vlocation), GFP_KERNEL);
+	vlocation = kzalloc(sizeof(struct afs_vlocation), GFP_KERNEL);
 	if (!vlocation)
 		return -ENOMEM;
 
-	memset(vlocation, 0, sizeof(struct afs_vlocation));
 	atomic_set(&vlocation->usage, 1);
 	INIT_LIST_HEAD(&vlocation->link);
 	rwlock_init(&vlocation->lock);
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 0ff4b86..768c6db 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -186,11 +186,10 @@ int afs_volume_lookup(const char *name, 
 	_debug("creating new volume record");
 
 	ret = -ENOMEM;
-	volume = kmalloc(sizeof(struct afs_volume), GFP_KERNEL);
+	volume = kzalloc(sizeof(struct afs_volume), GFP_KERNEL);
 	if (!volume)
 		goto error_up;
 
-	memset(volume, 0, sizeof(struct afs_volume));
 	atomic_set(&volume->usage, 1);
 	volume->type		= type;
 	volume->type_force	= force;
diff --git a/fs/aio.c b/fs/aio.c
index 20bb919..ff16418 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -123,10 +123,9 @@ static int aio_setup_ring(struct kioctx 
 	info->nr = 0;
 	info->ring_pages = info->internal_pages;
 	if (nr_pages > AIO_RING_PAGES) {
-		info->ring_pages = kmalloc(sizeof(struct page *) * nr_pages, GFP_KERNEL);
+		info->ring_pages = kzalloc(sizeof(struct page *) * nr_pages, GFP_KERNEL);
 		if (!info->ring_pages)
 			return -ENOMEM;
-		memset(info->ring_pages, 0, sizeof(struct page *) * nr_pages);
 	}
 
 	info->mmap_size = nr_pages * PAGE_SIZE;
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 65e5ed4..c8d700d 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -128,10 +128,9 @@ int autofs_fill_super(struct super_block
 	struct autofs_sb_info *sbi;
 	int minproto, maxproto;
 
-	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if ( !sbi )
 		goto fail_unlock;
-	memset(sbi, 0, sizeof(*sbi));
 	DPRINTK(("autofs: starting up, sbi = %p\n",sbi));
 
 	s->s_fs_info = sbi;
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 818b37b..3542ef7 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -253,13 +253,11 @@ int autofs4_fill_super(struct super_bloc
 	struct autofs_info *ino;
 	int minproto, maxproto;
 
-	sbi = (struct autofs_sb_info *) kmalloc(sizeof(*sbi), GFP_KERNEL);
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if ( !sbi )
 		goto fail_unlock;
 	DPRINTK("starting up, sbi = %p",sbi);
 
-	memset(sbi, 0, sizeof(*sbi));
-
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->root = NULL;
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 3af6c73..ae06be5 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -309,11 +309,10 @@ static int bfs_fill_super(struct super_b
 	unsigned i, imap_len;
 	struct bfs_sb_info * info;
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 	s->s_fs_info = info;
-	memset(info, 0, sizeof(*info));
 
 	sb_set_blocksize(s, BFS_BSIZE);
 
@@ -336,10 +335,9 @@ static int bfs_fill_super(struct super_b
 			+ BFS_ROOT_INO - 1;
 
 	imap_len = info->si_lasti/8 + 1;
-	info->si_imap = kmalloc(imap_len, GFP_KERNEL);
+	info->si_imap = kzalloc(imap_len, GFP_KERNEL);
 	if (!info->si_imap)
 		goto out;
-	memset(info->si_imap, 0, imap_len);
 	for (i=0; i<BFS_ROOT_INO; i++) 
 		set_bit(i, info->si_imap);
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f36f221..d903ac9 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1454,12 +1454,11 @@ static int elf_core_dump(long signr, str
 		read_lock(&tasklist_lock);
 		do_each_thread(g,p)
 			if (current->mm == p->mm && current != p) {
-				tmp = kmalloc(sizeof(*tmp), GFP_ATOMIC);
+				tmp = kzalloc(sizeof(*tmp), GFP_ATOMIC);
 				if (!tmp) {
 					read_unlock(&tasklist_lock);
 					goto cleanup;
 				}
-				memset(tmp, 0, sizeof(*tmp));
 				INIT_LIST_HEAD(&tmp->list);
 				tmp->thread = p;
 				list_add(&tmp->list, &thread_list);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index e0344f6..7bc3b92 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -678,12 +678,11 @@ static int elf_fdpic_map_file(struct elf
 		return -ELIBBAD;
 
 	size = sizeof(*loadmap) + nloads * sizeof(*seg);
-	loadmap = kmalloc(size, GFP_KERNEL);
+	loadmap = kzalloc(size, GFP_KERNEL);
 	if (!loadmap)
 		return -ENOMEM;
 
 	params->loadmap = loadmap;
-	memset(loadmap, 0, size);
 
 	loadmap->version = ELF32_FDPIC_LOADMAP_VERSION;
 	loadmap->nsegs = nloads;
diff --git a/fs/bio.c b/fs/bio.c
index 460554b..b77306a 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -591,12 +591,10 @@ static struct bio *__bio_map_user_iov(re
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
+	pages = kzalloc(nr_pages * sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		goto out;
 
-	memset(pages, 0, nr_pages * sizeof(struct page *));
-
 	for (i = 0; i < iov_count; i++) {
 		unsigned long uaddr = (unsigned long)iov[i].iov_base;
 		unsigned long len = iov[i].iov_len;
@@ -1137,12 +1135,11 @@ void bioset_free(struct bio_set *bs)
 
 struct bio_set *bioset_create(int bio_pool_size, int bvec_pool_size, int scale)
 {
-	struct bio_set *bs = kmalloc(sizeof(*bs), GFP_KERNEL);
+	struct bio_set *bs = kzalloc(sizeof(*bs), GFP_KERNEL);
 
 	if (!bs)
 		return NULL;
 
-	memset(bs, 0, sizeof(*bs));
 	bs->bio_pool = mempool_create(bio_pool_size, mempool_alloc_slab,
 			mempool_free_slab, bio_slab);
 
diff --git a/fs/char_dev.c b/fs/char_dev.c
index 3b1b1ee..86f736f 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -95,12 +95,10 @@ __register_chrdev_region(unsigned int ma
 	int ret = 0;
 	int i;
 
-	cd = kmalloc(sizeof(struct char_device_struct), GFP_KERNEL);
+	cd = kzalloc(sizeof(struct char_device_struct), GFP_KERNEL);
 	if (cd == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	memset(cd, 0, sizeof(struct char_device_struct));
-
 	down(&chrdevs_lock);
 
 	/* temporary */
@@ -415,9 +413,8 @@ static struct kobj_type ktype_cdev_dynam
 
 struct cdev *cdev_alloc(void)
 {
-	struct cdev *p = kmalloc(sizeof(struct cdev), GFP_KERNEL);
+	struct cdev *p = kzalloc(sizeof(struct cdev), GFP_KERNEL);
 	if (p) {
-		memset(p, 0, sizeof(struct cdev));
 		p->kobj.ktype = &ktype_cdev_dynamic;
 		INIT_LIST_HEAD(&p->list);
 		kobject_init(&p->kobj);
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 450ab75..544fee1 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1645,7 +1645,7 @@ cifs_mount(struct super_block *sb, struc
 			return rc;
 		}
 
-		srvTcp = kmalloc(sizeof (struct TCP_Server_Info), GFP_KERNEL);
+		srvTcp = kzalloc(sizeof (struct TCP_Server_Info), GFP_KERNEL);
 		if (srvTcp == NULL) {
 			rc = -ENOMEM;
 			sock_release(csocket);
@@ -1654,7 +1654,6 @@ cifs_mount(struct super_block *sb, struc
 			FreeXid(xid);
 			return rc;
 		} else {
-			memset(srvTcp, 0, sizeof (struct TCP_Server_Info));
 			memcpy(&srvTcp->addr.sockAddr, &sin_server, sizeof (struct sockaddr_in));
 			atomic_set(&srvTcp->inFlight,0);
 			/* BB Add code for ipv6 case too */
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 8dfe717..607fa1a 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -248,12 +248,10 @@ cifs_create(struct inode *inode, struct 
 			CIFSSMBClose(xid, pTcon, fileHandle);
 		} else if(newinode) {
 			pCifsFile =
-			   kmalloc(sizeof (struct cifsFileInfo), GFP_KERNEL);
+			   kzalloc(sizeof (struct cifsFileInfo), GFP_KERNEL);
 			
 			if(pCifsFile == NULL)
 				goto cifs_create_out;
-			memset((char *)pCifsFile, 0,
-			       sizeof (struct cifsFileInfo));
 			pCifsFile->netfid = fileHandle;
 			pCifsFile->pid = current->tgid;
 			pCifsFile->pInode = newinode;
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 912d401..1422ed8 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -477,9 +477,8 @@ int cifs_unlink(struct inode *inode, str
 		}
 	} else if (rc == -EACCES) {
 		/* try only if r/o attribute set in local lookup data? */
-		pinfo_buf = kmalloc(sizeof(FILE_BASIC_INFO), GFP_KERNEL);
+		pinfo_buf = kzalloc(sizeof(FILE_BASIC_INFO), GFP_KERNEL);
 		if (pinfo_buf) {
-			memset(pinfo_buf, 0, sizeof(FILE_BASIC_INFO));
 			/* ATTRS set to normal clears r/o bit */
 			pinfo_buf->Attributes = cpu_to_le32(ATTR_NORMAL);
 			if (!(pTcon->ses->flags & CIFS_SES_NT4))
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 34a0669..f322018 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -71,11 +71,8 @@ sesInfoAlloc(void)
 {
 	struct cifsSesInfo *ret_buf;
 
-	ret_buf =
-	    (struct cifsSesInfo *) kmalloc(sizeof (struct cifsSesInfo),
-					   GFP_KERNEL);
+	ret_buf = kzalloc(sizeof (struct cifsSesInfo), GFP_KERNEL);
 	if (ret_buf) {
-		memset(ret_buf, 0, sizeof (struct cifsSesInfo));
 		write_lock(&GlobalSMBSeslock);
 		atomic_inc(&sesInfoAllocCount);
 		ret_buf->status = CifsNew;
@@ -109,11 +106,9 @@ struct cifsTconInfo *
 tconInfoAlloc(void)
 {
 	struct cifsTconInfo *ret_buf;
-	ret_buf =
-	    (struct cifsTconInfo *) kmalloc(sizeof (struct cifsTconInfo),
+	ret_buf = kzalloc(sizeof (struct cifsTconInfo),
 					    GFP_KERNEL);
 	if (ret_buf) {
-		memset(ret_buf, 0, sizeof (struct cifsTconInfo));
 		write_lock(&GlobalSMBSeslock);
 		atomic_inc(&tconInfoAllocCount);
 		list_add(&ret_buf->cifsConnectionList,
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index a86bd1c..25bddd7 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -351,13 +351,11 @@ static int initiate_cifs_search(const in
 
 	if(file->private_data == NULL) {
 		file->private_data = 
-			kmalloc(sizeof(struct cifsFileInfo),GFP_KERNEL);
+			kzalloc(sizeof(struct cifsFileInfo),GFP_KERNEL);
 	}
 
 	if(file->private_data == NULL) {
 		return -ENOMEM;
-	} else {
-		memset(file->private_data,0,sizeof(struct cifsFileInfo));
 	}
 	cifsFile = file->private_data;
 	cifsFile->invalidHandle = TRUE;
diff --git a/fs/compat.c b/fs/compat.c
index 8e71cdb..2068d7a 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -1429,10 +1429,9 @@ int compat_do_execve(char * filename,
 	int i;
 
 	retval = -ENOMEM;
-	bprm = kmalloc(sizeof(*bprm), GFP_KERNEL);
+	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
 	if (!bprm)
 		goto out_ret;
-	memset(bprm, 0, sizeof(*bprm));
 
 	file = open_exec(filename);
 	retval = PTR_ERR(file);
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 7fe8541..65ffb12 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -245,11 +245,10 @@ static int cramfs_fill_super(struct supe
 
 	sb->s_flags |= MS_RDONLY;
 
-	sbi = kmalloc(sizeof(struct cramfs_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct cramfs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(struct cramfs_sb_info));
 
 	/* Invalidate the read buffers on mount: think disk change.. */
 	down(&read_mutex);
diff --git a/fs/devfs/base.c b/fs/devfs/base.c
index 1274422..c21c571 100644
--- a/fs/devfs/base.c
+++ b/fs/devfs/base.c
@@ -970,9 +970,9 @@ static struct devfs_entry *_devfs_alloc_
 
 	if (name && (namelen < 1))
 		namelen = strlen(name);
-	if ((new = kmalloc(sizeof *new + namelen, GFP_KERNEL)) == NULL)
+	/*  Will set '\0' on name  */
+	if ((new = kzalloc(sizeof *new + namelen, GFP_KERNEL)) == NULL)
 		return NULL;
-	memset(new, 0, sizeof *new + namelen);	/*  Will set '\0' on name  */
 	new->mode = mode;
 	if (S_ISDIR(mode))
 		rwlock_init(&new->u.dir.lock);
diff --git a/fs/efs/super.c b/fs/efs/super.c
index d8d5ea9..583ec4b 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -247,11 +247,10 @@ static int efs_fill_super(struct super_b
 	struct buffer_head *bh;
 	struct inode *root;
 
- 	sb = kmalloc(sizeof(struct efs_sb_info), GFP_KERNEL);
+ 	sb = kzalloc(sizeof(struct efs_sb_info), GFP_KERNEL);
 	if (!sb)
 		return -ENOMEM;
 	s->s_fs_info = sb;
-	memset(sb, 0, sizeof(struct efs_sb_info));
  
 	s->s_magic		= EFS_SUPER_MAGIC;
 	if (!sb_set_blocksize(s, EFS_BLOCKSIZE)) {
diff --git a/fs/exec.c b/fs/exec.c
index 5a4e3ac..b886208 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1147,10 +1147,9 @@ int do_execve(char * filename,
 	int i;
 
 	retval = -ENOMEM;
-	bprm = kmalloc(sizeof(*bprm), GFP_KERNEL);
+	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
 	if (!bprm)
 		goto out_ret;
-	memset(bprm, 0, sizeof(*bprm));
 
 	file = open_exec(filename);
 	retval = PTR_ERR(file);
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 3c0c7c6..ff6457c 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -621,11 +621,10 @@ static int ext2_fill_super(struct super_
 	int i, j;
 	__le32 features;
 
-	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(*sbi));
 
 	/*
 	 * See what the current blocksize for the device is, and
@@ -849,13 +848,12 @@ static int ext2_fill_super(struct super_
 	percpu_counter_init(&sbi->s_freeinodes_counter);
 	percpu_counter_init(&sbi->s_dirs_counter);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
-	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
+	sbi->s_debts = kzalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
 			       GFP_KERNEL);
 	if (!sbi->s_debts) {
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount_group_desc;
 	}
-	memset(sbi->s_debts, 0, sbi->s_groups_count * sizeof(*sbi->s_debts));
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logic_sb_block, i);
 		sbi->s_group_desc[i] = sb_bread(sb, block);
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 0099462..8592fb4 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -525,11 +525,10 @@ bad_block:		ext2_error(sb, "ext2_xattr_s
 		}
 	} else {
 		/* Allocate a buffer where we construct the new block. */
-		header = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		header = kzalloc(sb->s_blocksize, GFP_KERNEL);
 		error = -ENOMEM;
 		if (header == NULL)
 			goto cleanup;
-		memset(header, 0, sb->s_blocksize);
 		end = (char *)header + sb->s_blocksize;
 		header->h_magic = cpu_to_le32(EXT2_XATTR_MAGIC);
 		header->h_blocks = header->h_refcount = cpu_to_le32(1);
diff --git a/fs/ext3/dir.c b/fs/ext3/dir.c
index 832867a..7d25472 100644
--- a/fs/ext3/dir.c
+++ b/fs/ext3/dir.c
@@ -346,10 +346,9 @@ int ext3_htree_store_dirent(struct file 
 
 	/* Create and allocate the fname structure */
 	len = sizeof(struct fname) + dirent->name_len + 1;
-	new_fn = kmalloc(len, GFP_KERNEL);
+	new_fn = kzalloc(len, GFP_KERNEL);
 	if (!new_fn)
 		return -ENOMEM;
-	memset(new_fn, 0, len);
 	new_fn->hash = hash;
 	new_fn->minor_hash = minor_hash;
 	new_fn->inode = le32_to_cpu(dirent->inode);
diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index f594989..dcc8f85 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -1355,11 +1355,10 @@ static int ext3_fill_super (struct super
 	int needs_recovery;
 	__le32 features;
 
-	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(*sbi));
 	sbi->s_mount_opt = 0;
 	sbi->s_resuid = EXT3_DEF_RESUID;
 	sbi->s_resgid = EXT3_DEF_RESGID;
diff --git a/fs/ext3/xattr.c b/fs/ext3/xattr.c
index 430de9f..3f14913 100644
--- a/fs/ext3/xattr.c
+++ b/fs/ext3/xattr.c
@@ -733,12 +733,11 @@ ext3_xattr_block_set(handle_t *handle, s
 		}
 	} else {
 		/* Allocate a buffer where we construct the new block. */
-		s->base = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		s->base = kzalloc(sb->s_blocksize, GFP_KERNEL);
 		/* assert(header == s->base) */
 		error = -ENOMEM;
 		if (s->base == NULL)
 			goto cleanup;
-		memset(s->base, 0, sb->s_blocksize);
 		header(s->base)->h_magic = cpu_to_le32(EXT3_XATTR_MAGIC);
 		header(s->base)->h_blocks = cpu_to_le32(1);
 		header(s->base)->h_refcount = cpu_to_le32(1);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index e2effe2..2e3df22 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1079,11 +1079,10 @@ int fat_fill_super(struct super_block *s
 	long error;
 	char buf[50];
 
-	sbi = kmalloc(sizeof(struct msdos_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct msdos_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(struct msdos_sb_info));
 
 	sb->s_flags |= MS_NODIRATIME;
 	sb->s_magic = MSDOS_SUPER_MAGIC;
diff --git a/fs/file.c b/fs/file.c
index fd066b2..1988fe9 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -237,10 +237,9 @@ static struct fdtable *alloc_fdtable(int
   	fd_set *new_openset = NULL, *new_execset = NULL;
 	struct file **new_fds;
 
-	fdt = kmalloc(sizeof(*fdt), GFP_KERNEL);
+	fdt = kzalloc(sizeof(*fdt), GFP_KERNEL);
 	if (!fdt)
   		goto out;
-	memset(fdt, 0, sizeof(*fdt));
 
 	nfds = __FD_SETSIZE;
   	/* Expand to the max in easy steps */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e69a546..ad425cf 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -380,10 +380,9 @@ static struct fuse_conn *new_conn(void)
 {
 	struct fuse_conn *fc;
 
-	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
+	fc = kzalloc(sizeof(*fc), GFP_KERNEL);
 	if (fc != NULL) {
 		int i;
-		memset(fc, 0, sizeof(*fc));
 		init_waitqueue_head(&fc->waitq);
 		INIT_LIST_HEAD(&fc->pending);
 		INIT_LIST_HEAD(&fc->processing);
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 3d5cdc6..bdd8c92 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -249,10 +249,9 @@ static struct hfs_bnode *__hfs_bnode_cre
 	sb = tree->inode->i_sb;
 	size = sizeof(struct hfs_bnode) + tree->pages_per_bnode *
 		sizeof(struct page *);
-	node = kmalloc(size, GFP_KERNEL);
+	node = kzalloc(size, GFP_KERNEL);
 	if (!node)
 		return NULL;
-	memset(node, 0, size);
 	node->tree = tree;
 	node->this = cnid;
 	set_bit(HFS_BNODE_NEW, &node->flags);
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 394725e..4a100bb 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -21,10 +21,9 @@ struct hfs_btree *hfs_btree_open(struct 
 	struct page *page;
 	unsigned int size;
 
-	tree = kmalloc(sizeof(*tree), GFP_KERNEL);
+	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
 	if (!tree)
 		return NULL;
-	memset(tree, 0, sizeof(*tree));
 
 	init_MUTEX(&tree->tree_lock);
 	spin_lock_init(&tree->hash_lock);
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index c5074ae..5bfae40 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -355,11 +355,10 @@ static int hfs_fill_super(struct super_b
 	struct inode *root_inode;
 	int res;
 
-	sbi = kmalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(struct hfs_sb_info));
 	INIT_HLIST_HEAD(&sbi->rsrc_inodes);
 
 	res = -EINVAL;
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index b85abc6..a0a4c15 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -410,10 +410,9 @@ static struct hfs_bnode *__hfs_bnode_cre
 	sb = tree->inode->i_sb;
 	size = sizeof(struct hfs_bnode) + tree->pages_per_bnode *
 		sizeof(struct page *);
-	node = kmalloc(size, GFP_KERNEL);
+	node = kzalloc(size, GFP_KERNEL);
 	if (!node)
 		return NULL;
-	memset(node, 0, size);
 	node->tree = tree;
 	node->this = cnid;
 	set_bit(HFS_BNODE_NEW, &node->flags);
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 44326aa..20d62e8 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -24,10 +24,9 @@ struct hfs_btree *hfs_btree_open(struct 
 	struct page *page;
 	unsigned int size;
 
-	tree = kmalloc(sizeof(*tree), GFP_KERNEL);
+	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
 	if (!tree)
 		return NULL;
-	memset(tree, 0, sizeof(*tree));
 
 	init_MUTEX(&tree->tree_lock);
 	spin_lock_init(&tree->hash_lock);
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 63e88d7..6193820 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -459,11 +459,10 @@ static int hpfs_fill_super(struct super_
 
 	int o;
 
-	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	s->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(*sbi));
 
 	sbi->sb_bmp_dir = NULL;
 	sbi->sb_cp_table = NULL;
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 298f08b..8015ad1 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -557,11 +557,10 @@ static int isofs_fill_super(struct super
 	struct iso9660_options		opt;
 	struct isofs_sb_info	      * sbi;
 
-	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	s->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(*sbi));
 
 	if (!parse_options((char *)data, &opt))
 		goto out_freesbi;
diff --git a/fs/jffs/intrep.c b/fs/jffs/intrep.c
index b2e9542..5a6ac50 100644
--- a/fs/jffs/intrep.c
+++ b/fs/jffs/intrep.c
@@ -488,13 +488,12 @@ jffs_create_file(struct jffs_control *c,
 {
 	struct jffs_file *f;
 
-	if (!(f = (struct jffs_file *)kmalloc(sizeof(struct jffs_file),
+	if (!(f = kzalloc(sizeof(struct jffs_file),
 					      GFP_KERNEL))) {
 		D(printk("jffs_create_file(): Failed!\n"));
 		return NULL;
 	}
 	no_jffs_file++;
-	memset(f, 0, sizeof(struct jffs_file));
 	f->ino = raw_inode->ino;
 	f->pino = raw_inode->pino;
 	f->nlink = raw_inode->nlink;
@@ -593,8 +592,7 @@ jffs_add_virtual_root(struct jffs_contro
 	D2(printk("jffs_add_virtual_root(): "
 		  "Creating a virtual root directory.\n"));
 
-	if (!(root = (struct jffs_file *)kmalloc(sizeof(struct jffs_file),
-						 GFP_KERNEL))) {
+	if (!(root = kzalloc(sizeof(struct jffs_file), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
 	no_jffs_file++;
@@ -606,7 +604,6 @@ jffs_add_virtual_root(struct jffs_contro
 	DJM(no_jffs_node++);
 	memset(node, 0, sizeof(struct jffs_node));
 	node->ino = JFFS_MIN_INO;
-	memset(root, 0, sizeof(struct jffs_file));
 	root->ino = JFFS_MIN_INO;
 	root->mode = S_IFDIR | S_IRWXU | S_IRGRP
 		     | S_IXGRP | S_IROTH | S_IXOTH;
diff --git a/fs/jffs2/build.c b/fs/jffs2/build.c
index fff108b..15ed8d1 100644
--- a/fs/jffs2/build.c
+++ b/fs/jffs2/build.c
@@ -319,11 +319,10 @@ int jffs2_do_mount_fs(struct jffs2_sb_in
 		c->blocks = vmalloc(size);
 	else
 #endif
-		c->blocks = kmalloc(size, GFP_KERNEL);
+		c->blocks = kzalloc(size, GFP_KERNEL);
 	if (!c->blocks)
 		return -ENOMEM;
 
-	memset(c->blocks, 0, size);
 	for (i=0; i<c->nr_blocks; i++) {
 		INIT_LIST_HEAD(&c->blocks[i].list);
 		c->blocks[i].offset = i * c->sector_size;
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 5434206..93e41dc 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -482,12 +482,11 @@ int jffs2_do_fill_super(struct super_blo
 	if (ret)
 		return ret;
 
-	c->inocache_list = kmalloc(INOCACHE_HASHSIZE * sizeof(struct jffs2_inode_cache *), GFP_KERNEL);
+	c->inocache_list = kzalloc(INOCACHE_HASHSIZE * sizeof(struct jffs2_inode_cache *), GFP_KERNEL);
 	if (!c->inocache_list) {
 		ret = -ENOMEM;
 		goto out_wbuf;
 	}
-	memset(c->inocache_list, 0, INOCACHE_HASHSIZE * sizeof(struct jffs2_inode_cache *));
 
 	if ((ret = jffs2_do_mount_fs(c)))
 		goto out_inohash;
diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index 5f0652d..cb4700e 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -915,13 +915,12 @@ int jffs2_do_read_inode(struct jffs2_sb_
 int jffs2_do_crccheck_inode(struct jffs2_sb_info *c, struct jffs2_inode_cache *ic)
 {
 	struct jffs2_raw_inode n;
-	struct jffs2_inode_info *f = kmalloc(sizeof(*f), GFP_KERNEL);
+	struct jffs2_inode_info *f = kzalloc(sizeof(*f), GFP_KERNEL);
 	int ret;
 
 	if (!f)
 		return -ENOMEM;
 
-	memset(f, 0, sizeof(*f));
 	init_MUTEX_LOCKED(&f->sem);
 	f->inocache = ic;
 
diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 0e7456e..e1a6a7a 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -106,12 +106,11 @@ int jffs2_scan_medium(struct jffs2_sb_in
 	}
 
 	if (jffs2_sum_active()) {
-		s = kmalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
+		s = kzalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
 		if (!s) {
 			JFFS2_WARNING("Can't allocate memory for summary\n");
 			return -ENOMEM;
 		}
-		memset(s, 0, sizeof(struct jffs2_summary));
 	}
 
 	for (i=0; i<c->nr_blocks; i++) {
diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
index fb9cec6..1044dc0 100644
--- a/fs/jffs2/summary.c
+++ b/fs/jffs2/summary.c
@@ -25,15 +25,13 @@
 
 int jffs2_sum_init(struct jffs2_sb_info *c)
 {
-	c->summary = kmalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
+	c->summary = kzalloc(sizeof(struct jffs2_summary), GFP_KERNEL);
 
 	if (!c->summary) {
 		JFFS2_WARNING("Can't allocate memory for summary information!\n");
 		return -ENOMEM;
 	}
 
-	memset(c->summary, 0, sizeof(struct jffs2_summary));
-
 	c->summary->sum_buf = vmalloc(c->sector_size);
 
 	if (!c->summary->sum_buf) {
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 9e0b545..fc9a85b 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -119,10 +119,9 @@ static struct super_block *jffs2_get_sb_
 	struct jffs2_sb_info *c;
 	int ret;
 
-	c = kmalloc(sizeof(*c), GFP_KERNEL);
+	c = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return ERR_PTR(-ENOMEM);
-	memset(c, 0, sizeof(*c));
 	c->mtd = mtd;
 
 	sb = sget(fs_type, jffs2_sb_compare, jffs2_sb_set, c);
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index d27bac6..f57ca7b 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1105,11 +1105,10 @@ int lmLogOpen(struct super_block *sb)
 		}
 	}
 
-	if (!(log = kmalloc(sizeof(struct jfs_log), GFP_KERNEL))) {
+	if (!(log = kzalloc(sizeof(struct jfs_log), GFP_KERNEL))) {
 		up(&jfs_log_sem);
 		return -ENOMEM;
 	}
-	memset(log, 0, sizeof(struct jfs_log));
 	INIT_LIST_HEAD(&log->sb_list);
 	init_waitqueue_head(&log->syncwait);
 
@@ -1181,9 +1180,8 @@ static int open_inline_log(struct super_
 	struct jfs_log *log;
 	int rc;
 
-	if (!(log = kmalloc(sizeof(struct jfs_log), GFP_KERNEL)))
+	if (!(log = kzalloc(sizeof(struct jfs_log), GFP_KERNEL)))
 		return -ENOMEM;
-	memset(log, 0, sizeof(struct jfs_log));
 	INIT_LIST_HEAD(&log->sb_list);
 	init_waitqueue_head(&log->syncwait);
 
@@ -1216,12 +1214,11 @@ static int open_dummy_log(struct super_b
 
 	down(&jfs_log_sem);
 	if (!dummy_log) {
-		dummy_log = kmalloc(sizeof(struct jfs_log), GFP_KERNEL);
+		dummy_log = kzalloc(sizeof(struct jfs_log), GFP_KERNEL);
 		if (!dummy_log) {
 			up(&jfs_log_sem);
 			return -ENOMEM;
 		}
-		memset(dummy_log, 0, sizeof(struct jfs_log));
 		INIT_LIST_HEAD(&dummy_log->sb_list);
 		init_waitqueue_head(&dummy_log->syncwait);
 		dummy_log->no_integrity = 1;
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 8a53981..5fbaeaa 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -104,10 +104,9 @@ static inline int insert_metapage(struct
 	if (PagePrivate(page))
 		a = mp_anchor(page);
 	else {
-		a = kmalloc(sizeof(struct meta_anchor), GFP_NOFS);
+		a = kzalloc(sizeof(struct meta_anchor), GFP_NOFS);
 		if (!a)
 			return -ENOMEM;
-		memset(a, 0, sizeof(struct meta_anchor));
 		set_page_private(page, (unsigned long)a);
 		SetPagePrivate(page);
 		kmap(page);
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 4226af3..4109b04 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -396,10 +396,9 @@ static int jfs_fill_super(struct super_b
 	if (!new_valid_dev(sb->s_bdev->bd_dev))
 		return -EOVERFLOW;
 
-	sbi = kmalloc(sizeof (struct jfs_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof (struct jfs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOSPC;
-	memset(sbi, 0, sizeof (struct jfs_sb_info));
 	sb->s_fs_info = sbi;
 	sbi->sb = sb;
 
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index c5a3364..bd3b41c 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -290,9 +290,8 @@ nlmclnt_alloc_call(void)
 	struct nlm_rqst	*call;
 
 	while (!signalled()) {
-		call = (struct nlm_rqst *) kmalloc(sizeof(struct nlm_rqst), GFP_KERNEL);
+		call = kzalloc(sizeof(struct nlm_rqst), GFP_KERNEL);
 		if (call) {
-			memset(call, 0, sizeof(*call));
 			locks_init_lock(&call->a_args.lock.fl);
 			locks_init_lock(&call->a_res.lock.fl);
 			return call;
diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index c4c8601..7f5d748 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -99,9 +99,8 @@ nlm_lookup_host(int server, struct socka
 	/* Ooops, no host found, create it */
 	dprintk("lockd: creating host entry\n");
 
-	if (!(host = (struct nlm_host *) kmalloc(sizeof(*host), GFP_KERNEL)))
+	if (!(host = kzalloc(sizeof(*host), GFP_KERNEL)))
 		goto nohost;
-	memset(host, 0, sizeof(*host));
 
 	addr = sin->sin_addr.s_addr;
 	sprintf(host->h_name, "%u.%u.%u.%u", NIPQUAD(addr));
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 49f9597..34010cd 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -182,9 +182,8 @@ nlmsvc_create_block(struct svc_rqst *rqs
 		return NULL;
 
 	/* Allocate memory for block, and initialize arguments */
-	if (!(block = (struct nlm_block *) kmalloc(sizeof(*block), GFP_KERNEL)))
+	if (!(block = kzalloc(sizeof(*block), GFP_KERNEL)))
 		goto failed;
-	memset(block, 0, sizeof(*block));
 	locks_init_lock(&block->b_call.a_args.lock.fl);
 	locks_init_lock(&block->b_call.a_res.lock.fl);
 
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 62f4a38..4315093 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -100,11 +100,10 @@ nlm_lookup_file(struct svc_rqst *rqstp, 
 	nlm_debug_print_fh("creating file for", f);
 
 	nfserr = nlm_lck_denied_nolocks;
-	file = (struct nlm_file *) kmalloc(sizeof(*file), GFP_KERNEL);
+	file = kzalloc(sizeof(*file), GFP_KERNEL);
 	if (!file)
 		goto out_unlock;
 
-	memset(file, 0, sizeof(*file));
 	memcpy(&file->f_handle, f, sizeof(struct nfs_fh));
 	file->f_hash = hash;
 	init_MUTEX(&file->f_sema);
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 790cc0d..9a58e44 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -144,11 +144,10 @@ static int minix_fill_super(struct super
 	struct inode *root_inode;
 	struct minix_sb_info *sbi;
 
-	sbi = kmalloc(sizeof(struct minix_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct minix_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	s->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(struct minix_sb_info));
 
 	/* N.B. These should be compile-time tests.
 	   Unfortunately that is impossible. */
@@ -204,10 +203,9 @@ static int minix_fill_super(struct super
 	 * Allocate the buffer map to keep the superblock small.
 	 */
 	i = (sbi->s_imap_blocks + sbi->s_zmap_blocks) * sizeof(bh);
-	map = kmalloc(i, GFP_KERNEL);
+	map = kzalloc(i, GFP_KERNEL);
 	if (!map)
 		goto out_no_map;
-	memset(map, 0, i);
 	sbi->s_imap = &map[0];
 	sbi->s_zmap = &map[sbi->s_imap_blocks];
 
diff --git a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
index 8c88392..17581d0 100644
--- a/fs/ncpfs/inode.c
+++ b/fs/ncpfs/inode.c
@@ -411,11 +411,10 @@ static int ncp_fill_super(struct super_b
 #endif
 	struct ncp_entry_info finfo;
 
-	server = kmalloc(sizeof(struct ncp_server), GFP_KERNEL);
+	server = kzalloc(sizeof(struct ncp_server), GFP_KERNEL);
 	if (!server)
 		return -ENOMEM;
 	sb->s_fs_info = server;
-	memset(server, 0, sizeof(struct ncp_server));
 
 	error = -EFAULT;
 	if (raw_data == NULL)
diff --git a/fs/nfs/idmap.c b/fs/nfs/idmap.c
index ffb8df9..48fba97 100644
--- a/fs/nfs/idmap.c
+++ b/fs/nfs/idmap.c
@@ -97,11 +97,9 @@ nfs_idmap_new(struct nfs4_client *clp)
 
 	if (clp->cl_idmap != NULL)
 		return;
-        if ((idmap = kmalloc(sizeof(*idmap), GFP_KERNEL)) == NULL)
+        if ((idmap = kzalloc(sizeof(*idmap), GFP_KERNEL)) == NULL)
                 return;
 
-	memset(idmap, 0, sizeof(*idmap));
-
 	snprintf(idmap->idmap_path, sizeof(idmap->idmap_path),
 	    "%s/idmap", clp->cl_rpcclient->cl_pathname);
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 6391d89..cae8569 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1613,10 +1613,9 @@ static struct super_block *nfs_get_sb(st
 #endif /* CONFIG_NFS_V3 */
 
 	s = ERR_PTR(-ENOMEM);
-	server = kmalloc(sizeof(struct nfs_server), GFP_KERNEL);
+	server = kzalloc(sizeof(struct nfs_server), GFP_KERNEL);
 	if (!server)
 		goto out_err;
-	memset(server, 0, sizeof(struct nfs_server));
 	/* Zero out the NFS state stuff */
 	init_nfsv4_state(server);
 	server->client = server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
@@ -1932,10 +1931,9 @@ static struct super_block *nfs4_get_sb(s
 		return ERR_PTR(-EINVAL);
 	}
 
-	server = kmalloc(sizeof(struct nfs_server), GFP_KERNEL);
+	server = kzalloc(sizeof(struct nfs_server), GFP_KERNEL);
 	if (!server)
 		return ERR_PTR(-ENOMEM);
-	memset(server, 0, sizeof(struct nfs_server));
 	/* Zero out the NFS state stuff */
 	init_nfsv4_state(server);
 	server->client = server->client_sys = server->client_acl = ERR_PTR(-EINVAL);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 0675f32..e1ca5b3 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -91,11 +91,10 @@ nfs4_alloc_client(struct in_addr *addr)
 
 	if (nfs_callback_up() < 0)
 		return NULL;
-	if ((clp = kmalloc(sizeof(*clp), GFP_KERNEL)) == NULL) {
+	if ((clp = kzalloc(sizeof(*clp), GFP_KERNEL)) == NULL) {
 		nfs_callback_down();
 		return NULL;
 	}
-	memset(clp, 0, sizeof(*clp));
 	memcpy(&clp->cl_addr, addr, sizeof(clp->cl_addr));
 	init_rwsem(&clp->cl_sem);
 	INIT_LIST_HEAD(&clp->cl_delegations);
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index d639d17..e66d98f 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -161,10 +161,9 @@ nfs_async_unlink(struct dentry *dentry)
 	struct rpc_clnt	*clnt = NFS_CLIENT(dir->d_inode);
 	int		status = -ENOMEM;
 
-	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		goto out;
-	memset(data, 0, sizeof(*data));
 
 	data->cred = rpcauth_lookupcred(clnt->cl_auth, 0);
 	if (IS_ERR(data->cred)) {
diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 1336965..dbcccad 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -502,10 +502,9 @@ idmap_lookup(struct svc_rqst *rqstp,
 	struct idmap_defer_req *mdr;
 	int ret;
 
-	mdr = kmalloc(sizeof(*mdr), GFP_KERNEL);
+	mdr = kzalloc(sizeof(*mdr), GFP_KERNEL);
 	if (!mdr)
 		return -ENOMEM;
-	memset(mdr, 0, sizeof(*mdr));
 	atomic_set(&mdr->count, 1);
 	init_waitqueue_head(&mdr->waitq);
 	mdr->req.defer = idmap_defer;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6bbefd0..fc5e0af 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -298,8 +298,7 @@ alloc_client(struct xdr_netobj name)
 {
 	struct nfs4_client *clp;
 
-	if ((clp = kmalloc(sizeof(struct nfs4_client), GFP_KERNEL))!= NULL) {
-		memset(clp, 0, sizeof(*clp));
+	if ((clp = kzalloc(sizeof(struct nfs4_client), GFP_KERNEL))!= NULL) {
 		if ((clp->cl_name.data = kmalloc(name.len, GFP_KERNEL)) != NULL) {
 			memcpy(clp->cl_name.data, name.data, name.len);
 			clp->cl_name.len = name.len;
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index d852ebb..1856929 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -66,14 +66,13 @@ nfsd_cache_init(void)
 		printk (KERN_ERR "nfsd: cannot allocate all %d cache entries, only got %d\n",
 			CACHESIZE, CACHESIZE-i);
 
-	hash_list = kmalloc (HASHSIZE * sizeof(struct hlist_head), GFP_KERNEL);
+	hash_list = kzalloc (HASHSIZE * sizeof(struct hlist_head), GFP_KERNEL);
 	if (!hash_list) {
 		nfsd_cache_shutdown();
 		printk (KERN_ERR "nfsd: cannot allocate %Zd bytes for hash list\n",
 			HASHSIZE * sizeof(struct hlist_head));
 		return;
 	}
-	memset(hash_list, 0, HASHSIZE * sizeof(struct hlist_head));
 
 	cache_disabled = 0;
 }
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index af7c3c3..06792c9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1845,12 +1845,11 @@ nfsd_racache_init(int cache_size)
 
 	if (raparm_cache)
 		return 0;
-	raparml = kmalloc(sizeof(struct raparms) * cache_size, GFP_KERNEL);
+	raparml = kzalloc(sizeof(struct raparms) * cache_size, GFP_KERNEL);
 
 	if (raparml != NULL) {
 		dprintk("nfsd: allocating %d readahead buffers.\n",
 			cache_size);
-		memset(raparml, 0, sizeof(struct raparms) * cache_size);
 		for (i = 0; i < cache_size - 1; i++) {
 			raparml[i].p_next = raparml + i + 1;
 		}
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index 8dc1822..a464ede 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -313,11 +313,10 @@ void add_partition(struct gendisk *disk,
 {
 	struct hd_struct *p;
 
-	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return;
 	
-	memset(p, 0, sizeof(*p));
 	p->start_sect = start;
 	p->nr_sects = len;
 	p->partno = part;
diff --git a/fs/partitions/efi.c b/fs/partitions/efi.c
index 0f5b017..69a06ad 100644
--- a/fs/partitions/efi.c
+++ b/fs/partitions/efi.c
@@ -239,10 +239,9 @@ alloc_read_gpt_entries(struct block_devi
                 le32_to_cpu(gpt->sizeof_partition_entry);
 	if (!count)
 		return NULL;
-	pte = kmalloc(count, GFP_KERNEL);
+	pte = kzalloc(count, GFP_KERNEL);
 	if (!pte)
 		return NULL;
-	memset(pte, 0, count);
 
 	if (read_lba(bdev, le64_to_cpu(gpt->partition_entry_lba),
                      (u8 *) pte,
@@ -270,10 +269,9 @@ alloc_read_gpt_header(struct block_devic
 	if (!bdev)
 		return NULL;
 
-	gpt = kmalloc(sizeof (gpt_header), GFP_KERNEL);
+	gpt = kzalloc(sizeof (gpt_header), GFP_KERNEL);
 	if (!gpt)
 		return NULL;
-	memset(gpt, 0, sizeof (gpt_header));
 
 	if (read_lba(bdev, lba, (u8 *) gpt,
 		     sizeof (gpt_header)) < sizeof (gpt_header)) {
@@ -527,9 +525,8 @@ find_valid_gpt(struct block_device *bdev
 	lastlba = last_lba(bdev);
         if (!force_gpt) {
                 /* This will be added to the EFI Spec. per Intel after v1.02. */
-                legacymbr = kmalloc(sizeof (*legacymbr), GFP_KERNEL);
+                legacymbr = kzalloc(sizeof (*legacymbr), GFP_KERNEL);
                 if (legacymbr) {
-                        memset(legacymbr, 0, sizeof (*legacymbr));
                         read_lba(bdev, 0, (u8 *) legacymbr,
                                  sizeof (*legacymbr));
                         good_pmbr = is_pmbr_valid(legacymbr, lastlba);
diff --git a/fs/pipe.c b/fs/pipe.c
index 66aa0b9..3f9d7eb 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -662,10 +662,9 @@ struct inode* pipe_new(struct inode* ino
 {
 	struct pipe_inode_info *info;
 
-	info = kmalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
+	info = kzalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
 	if (!info)
 		goto fail_page;
-	memset(info, 0, sizeof(*info));
 	inode->i_pipe = info;
 
 	init_waitqueue_head(PIPE_WAIT(*inode));
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 1c7da98..cb8e76d 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -332,10 +332,9 @@ read_kcore(struct file *file, char __use
 			unsigned long curstart = start;
 			unsigned long cursize = tsz;
 
-			elf_buf = kmalloc(tsz, GFP_KERNEL);
+			elf_buf = kzalloc(tsz, GFP_KERNEL);
 			if (!elf_buf)
 				return -ENOMEM;
-			memset(elf_buf, 0, tsz);
 
 			read_lock(&vmlist_lock);
 			for (m=vmlist; m && cursize; m=m->next) {
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 3b2e7b6..fba9e0f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -179,9 +179,7 @@ static struct vmcore* __init get_new_ele
 {
 	struct vmcore *p;
 
-	p = kmalloc(sizeof(*p), GFP_KERNEL);
-	if (p)
-		memset(p, 0, sizeof(*p));
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	return p;
 }
 
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 80f3291..742c93b 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -357,11 +357,10 @@ static int qnx4_fill_super(struct super_
 	const char *errmsg;
 	struct qnx4_sb_info *qs;
 
-	qs = kmalloc(sizeof(struct qnx4_sb_info), GFP_KERNEL);
+	qs = kzalloc(sizeof(struct qnx4_sb_info), GFP_KERNEL);
 	if (!qs)
 		return -ENOMEM;
 	s->s_fs_info = qs;
-	memset(qs, 0, sizeof(struct qnx4_sb_info));
 
 	sb_set_blocksize(s, QNX4_BLOCK_SIZE);
 
diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index c20babd..d4d04c6 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -316,12 +316,11 @@ static int reiserfs_allocate_blocks_for_
 			/* area filled with zeroes, to supply as list of zero blocknumbers
 			   We allocate it outside of loop just in case loop would spin for
 			   several iterations. */
-			char *zeros = kmalloc(to_paste * UNFM_P_SIZE, GFP_ATOMIC);	// We cannot insert more than MAX_ITEM_LEN bytes anyway.
+			char *zeros = kzalloc(to_paste * UNFM_P_SIZE, GFP_ATOMIC);	// We cannot insert more than MAX_ITEM_LEN bytes anyway.
 			if (!zeros) {
 				res = -ENOMEM;
 				goto error_exit_free_blocks;
 			}
-			memset(zeros, 0, to_paste * UNFM_P_SIZE);
 			do {
 				to_paste =
 				    min_t(__u64, hole_size,
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 5f82352..9a1984a 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -939,15 +939,12 @@ int reiserfs_get_block(struct inode *ino
 			if (blocks_needed == 1) {
 				un = &unf_single;
 			} else {
-				un = kmalloc(min(blocks_needed, max_to_insert) * UNFM_P_SIZE, GFP_ATOMIC);	// We need to avoid scheduling.
+				un = kzalloc(min(blocks_needed, max_to_insert) * UNFM_P_SIZE, GFP_ATOMIC);	// We need to avoid scheduling.
 				if (!un) {
 					un = &unf_single;
 					blocks_needed = 1;
 					max_to_insert = 0;
-				} else
-					memset(un, 0,
-					       UNFM_P_SIZE * min(blocks_needed,
-								 max_to_insert));
+				}
 			}
 			if (blocks_needed <= max_to_insert) {
 				/* we are going to add target block to the file. Use allocated
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 42afb5b..c562cf0 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1692,13 +1692,12 @@ static int reiserfs_fill_super(struct su
 	struct reiserfs_sb_info *sbi;
 	int errval = -EINVAL;
 
-	sbi = kmalloc(sizeof(struct reiserfs_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct reiserfs_sb_info), GFP_KERNEL);
 	if (!sbi) {
 		errval = -ENOMEM;
 		goto error;
 	}
 	s->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(struct reiserfs_sb_info));
 	/* Set default values for options: non-aggressive tails, RO on errors */
 	REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_SMALLTAIL);
 	REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ERROR_RO);
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 7c40570..4db32c4 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -31,12 +31,11 @@ int seq_open(struct file *file, struct s
 	struct seq_file *p = file->private_data;
 
 	if (!p) {
-		p = kmalloc(sizeof(*p), GFP_KERNEL);
+		p = kzalloc(sizeof(*p), GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
 		file->private_data = p;
 	}
-	memset(p, 0, sizeof(*p));
 	sema_init(&p->sem, 1);
 	p->op = op;
 
diff --git a/fs/super.c b/fs/super.c
index 6689dde..b9988ab 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -55,11 +55,10 @@ DEFINE_SPINLOCK(sb_lock);
  */
 static struct super_block *alloc_super(void)
 {
-	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
+	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
 	static struct super_operations default_op;
 
 	if (s) {
-		memset(s, 0, sizeof(struct super_block));
 		if (security_sb_alloc(s)) {
 			kfree(s);
 			s = NULL;
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 4013d79..1562b7f 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -301,9 +301,8 @@ static int check_perm(struct inode * ino
 	/* No error? Great, allocate a buffer for the file, and store it
 	 * it in file->private_data for easy access.
 	 */
-	buffer = kmalloc(sizeof(struct sysfs_buffer),GFP_KERNEL);
+	buffer = kzalloc(sizeof(struct sysfs_buffer),GFP_KERNEL);
 	if (buffer) {
-		memset(buffer,0,sizeof(struct sysfs_buffer));
 		init_MUTEX(&buffer->sem);
 		buffer->needs_read_fill = 1;
 		buffer->ops = ops;
diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index 970a33f..6c2ea10 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -53,11 +53,10 @@ int sysfs_setattr(struct dentry * dentry
 
 	if (!sd_iattr) {
 		/* setting attributes for the first time, allocate now */
-		sd_iattr = kmalloc(sizeof(struct iattr), GFP_KERNEL);
+		sd_iattr = kzalloc(sizeof(struct iattr), GFP_KERNEL);
 		if (!sd_iattr)
 			return -ENOMEM;
 		/* assign default attributes */
-		memset(sd_iattr, 0, sizeof(struct iattr));
 		sd_iattr->ia_mode = sd->s_mode;
 		sd_iattr->ia_uid = 0;
 		sd_iattr->ia_gid = 0;
diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index 59e76b5..0a65890 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -369,10 +369,9 @@ static int sysv_fill_super(struct super_
 	if (64 != sizeof (struct sysv_inode))
 		panic("sysv fs: bad inode size");
 
-	sbi = kmalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	memset(sbi, 0, sizeof(struct sysv_sb_info));
 
 	sbi->s_sb = sb;
 	sbi->s_block_base = 0;
@@ -453,10 +452,9 @@ static int v7_fill_super(struct super_bl
 	if (64 != sizeof (struct sysv_inode))
 		panic("sysv fs: bad i-node size");
 
-	sbi = kmalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-	memset(sbi, 0, sizeof(struct sysv_sb_info));
 
 	sbi->s_sb = sb;
 	sbi->s_block_base = 0;
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 54828eb..68bd801 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -546,11 +546,10 @@ static int ufs_fill_super(struct super_b
 	
 	UFSD(("ENTER\n"))
 		
-	sbi = kmalloc(sizeof(struct ufs_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct ufs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		goto failed_nomem;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(struct ufs_sb_info));
 
 	UFSD(("flag %u\n", (int)(sb->s_flags & MS_RDONLY)))
 	
---
0.99.9.GIT
