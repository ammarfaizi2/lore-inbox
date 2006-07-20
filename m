Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWGTTVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWGTTVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 15:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWGTTVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 15:21:04 -0400
Received: from student.uhasselt.be ([193.190.2.1]:1293 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S964833AbWGTTVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 15:21:02 -0400
Date: Thu, 20 Jul 2006 21:20:59 +0200
To: linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org, rathamahata@php4.ru, tigran@veritas.com,
       sfrench@samba.org, viro@zeniv.linux.org.uk,
       mikulas@artax.karlin.mff.cuni.cz, dwmw2@infradead.org,
       neilb@cse.unsw.edu.au
Subject: [PATCH] fs: Conversions from kmalloc+memset to k(z|c)alloc
Message-ID: <20060720192059.GE7643@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

Conversions from kmalloc+memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
 fs/adfs/super.c     |    3 +--
 fs/affs/super.c     |    3 +--
 fs/afs/vlocation.c  |    3 +--
 fs/afs/volume.c     |    3 +--
 fs/autofs/inode.c   |    3 +--
 fs/bfs/inode.c      |    6 ++----
 fs/configfs/file.c  |    3 +--
 fs/configfs/inode.c |    3 +--
 fs/cramfs/inode.c   |    3 +--
 fs/efs/super.c      |    3 +--
 fs/ext2/super.c     |    3 +--
 fs/ext2/xattr.c     |    3 +--
 fs/ext3/dir.c       |    3 +--
 fs/ext3/super.c     |    3 +--
 fs/fat/inode.c      |    3 +--
 fs/hfs/bnode.c      |    3 +--
 fs/hfs/btree.c      |    3 +--
 fs/hfs/super.c      |    3 +--
 fs/hfsplus/bnode.c  |    3 +--
 fs/hfsplus/btree.c  |    3 +--
 fs/hpfs/super.c     |    3 +--
 fs/isofs/inode.c    |    3 +--
 fs/jffs2/super.c    |    3 +--
 fs/lockd/host.c     |    4 ++--
 fs/lockd/svcsubs.c  |    3 +--
 fs/minix/inode.c    |    6 ++----
 fs/ncpfs/inode.c    |    3 +--
 fs/nfsd/nfs4idmap.c |    3 +--
 fs/nfsd/nfs4state.c |    3 +--
 fs/partitions/efi.c |    9 +++------
 fs/proc/kcore.c     |    6 ++----
 fs/qnx4/inode.c     |    3 +--
 fs/sysv/super.c     |    6 ++----
 fs/udf/ialloc.c     |    6 ++----
 fs/ufs/super.c      |    3 +--
 35 files changed, 43 insertions(+), 84 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index ba1c88a..39065c5 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -339,11 +339,10 @@ static int adfs_fill_super(struct super_
 
 	sb->s_flags |= MS_NODIRATIME;
 
-	asb = kmalloc(sizeof(*asb), GFP_KERNEL);
+	asb = kzalloc(sizeof(*asb), GFP_KERNEL);
 	if (!asb)
 		return -ENOMEM;
 	sb->s_fs_info = asb;
-	memset(asb, 0, sizeof(*asb));
 
 	/* set default options */
 	asb->s_uid = 0;
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 5200f49..799cd87 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -279,11 +279,10 @@ static int affs_fill_super(struct super_
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
diff --git a/fs/afs/vlocation.c b/fs/afs/vlocation.c
index 331f730..782ee7c 100644
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
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index cf74f3d..3e4d6c7 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -311,11 +311,10 @@ static int bfs_fill_super(struct super_b
 	unsigned i, imap_len;
 	struct bfs_sb_info * info;
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 	s->s_fs_info = info;
-	memset(info, 0, sizeof(*info));
 
 	sb_set_blocksize(s, BFS_BSIZE);
 
@@ -338,10 +337,9 @@ static int bfs_fill_super(struct super_b
 			+ BFS_ROOT_INO - 1;
 
 	imap_len = info->si_lasti/8 + 1;
-	info->si_imap = kmalloc(imap_len, GFP_KERNEL);
+	info->si_imap = kzalloc(imap_len, GFP_KERNEL);
 	if (!info->si_imap)
 		goto out;
-	memset(info->si_imap, 0, imap_len);
 	for (i=0; i<BFS_ROOT_INO; i++) 
 		set_bit(i, info->si_imap);
 
diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index f499803..85105e5 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -274,9 +274,8 @@ static int check_perm(struct inode * ino
 	/* No error? Great, allocate a buffer for the file, and store it
 	 * it in file->private_data for easy access.
 	 */
-	buffer = kmalloc(sizeof(struct configfs_buffer),GFP_KERNEL);
+	buffer = kzalloc(sizeof(struct configfs_buffer),GFP_KERNEL);
 	if (buffer) {
-		memset(buffer,0,sizeof(struct configfs_buffer));
 		init_MUTEX(&buffer->sem);
 		buffer->needs_read_fill = 1;
 		buffer->ops = ops;
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index e14488c..5047e6a 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -76,11 +76,10 @@ int configfs_setattr(struct dentry * den
 
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
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 223c043..d09b677 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -242,11 +242,10 @@ static int cramfs_fill_super(struct supe
 
 	sb->s_flags |= MS_RDONLY;
 
-	sbi = kmalloc(sizeof(struct cramfs_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct cramfs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(struct cramfs_sb_info));
 
 	/* Invalidate the read buffers on mount: think disk change.. */
 	mutex_lock(&read_mutex);
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 8ac2462..7089269 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -248,11 +248,10 @@ static int efs_fill_super(struct super_b
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
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index f2702cd..c8a42a6 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -609,11 +609,10 @@ static int ext2_fill_super(struct super_
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
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 86ae8e9..af52a7f 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -521,11 +521,10 @@ bad_block:		ext2_error(sb, "ext2_xattr_s
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
index fbb0d4e..e35b70b 100644
--- a/fs/ext3/dir.c
+++ b/fs/ext3/dir.c
@@ -343,10 +343,9 @@ int ext3_htree_store_dirent(struct file 
 
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
index 813d589..4580529 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -1359,11 +1359,10 @@ static int ext3_fill_super (struct super
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
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 31b7174..bc4da3a 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1168,11 +1168,10 @@ int fat_fill_super(struct super_block *s
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
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 13231dd..0d20006 100644
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
index 4003579..5fd0ed7 100644
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
index 34937ee..05dffff 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -356,11 +356,10 @@ static int hfs_fill_super(struct super_b
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
index 77bf434..29da657 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -409,10 +409,9 @@ static struct hfs_bnode *__hfs_bnode_cre
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
index cfc852f..a9b9e87 100644
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
index f798480..dcba617 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -461,11 +461,10 @@ static int hpfs_fill_super(struct super_
 
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
index 1439136..ab15e90 100644
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
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 68e3953..6de3745 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -119,10 +119,9 @@ static int jffs2_get_sb_mtd(struct file_
 	struct jffs2_sb_info *c;
 	int ret;
 
-	c = kmalloc(sizeof(*c), GFP_KERNEL);
+	c = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return -ENOMEM;
-	memset(c, 0, sizeof(*c));
 	c->mtd = mtd;
 
 	sb = sget(fs_type, jffs2_sb_compare, jffs2_sb_set, c);
diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index 38b0e8a..473a0e9 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -100,9 +100,9 @@ nlm_lookup_host(int server, struct socka
 	/* Ooops, no host found, create it */
 	dprintk("lockd: creating host entry\n");
 
-	if (!(host = (struct nlm_host *) kmalloc(sizeof(*host), GFP_KERNEL)))
+	host = kzalloc(sizeof(*host), GFP_KERNEL);
+	if (!host)
 		goto nohost;
-	memset(host, 0, sizeof(*host));
 
 	addr = sin->sin_addr.s_addr;
 	sprintf(host->h_name, "%u.%u.%u.%u", NIPQUAD(addr));
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 2a4df9b..c917802 100644
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
index 9ea91c5..adea026 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -145,11 +145,10 @@ static int minix_fill_super(struct super
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
@@ -205,10 +204,9 @@ static int minix_fill_super(struct super
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
index 1ddf77b..752f02e 100644
--- a/fs/ncpfs/inode.c
+++ b/fs/ncpfs/inode.c
@@ -411,11 +411,10 @@ #ifdef CONFIG_NCPFS_PACKET_SIGNING
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
diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index bea6b94..b1902eb 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -573,10 +573,9 @@ idmap_lookup(struct svc_rqst *rqstp,
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
index 9daa0b9..1a25c01 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -339,8 +339,7 @@ alloc_client(struct xdr_netobj name)
 {
 	struct nfs4_client *clp;
 
-	if ((clp = kmalloc(sizeof(struct nfs4_client), GFP_KERNEL))!= NULL) {
-		memset(clp, 0, sizeof(*clp));
+	if ((clp = kzalloc(sizeof(struct nfs4_client), GFP_KERNEL))!= NULL) {
 		if ((clp->cl_name.data = kmalloc(name.len, GFP_KERNEL)) != NULL) {
 			memcpy(clp->cl_name.data, name.data, name.len);
 			clp->cl_name.len = name.len;
diff --git a/fs/partitions/efi.c b/fs/partitions/efi.c
index 6373028..1bea610 100644
--- a/fs/partitions/efi.c
+++ b/fs/partitions/efi.c
@@ -238,10 +238,9 @@ alloc_read_gpt_entries(struct block_devi
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
@@ -269,10 +268,9 @@ alloc_read_gpt_header(struct block_devic
 	if (!bdev)
 		return NULL;
 
-	gpt = kmalloc(sizeof (gpt_header), GFP_KERNEL);
+	gpt = kzalloc(sizeof (gpt_header), GFP_KERNEL);
 	if (!gpt)
 		return NULL;
-	memset(gpt, 0, sizeof (gpt_header));
 
 	if (read_lba(bdev, lba, (u8 *) gpt,
 		     sizeof (gpt_header)) < sizeof (gpt_header)) {
@@ -526,9 +524,8 @@ find_valid_gpt(struct block_device *bdev
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
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 6a984f6..3ceff38 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -279,12 +279,11 @@ read_kcore(struct file *file, char __use
 		tsz = elf_buflen - *fpos;
 		if (buflen < tsz)
 			tsz = buflen;
-		elf_buf = kmalloc(elf_buflen, GFP_ATOMIC);
+		elf_buf = kzalloc(elf_buflen, GFP_ATOMIC);
 		if (!elf_buf) {
 			read_unlock(&kclist_lock);
 			return -ENOMEM;
 		}
-		memset(elf_buf, 0, elf_buflen);
 		elf_kcore_store_hdr(elf_buf, nphdr, elf_buflen);
 		read_unlock(&kclist_lock);
 		if (copy_to_user(buffer, elf_buf + *fpos, tsz)) {
@@ -330,10 +329,9 @@ read_kcore(struct file *file, char __use
 			unsigned long curstart = start;
 			unsigned long cursize = tsz;
 
-			elf_buf = kmalloc(tsz, GFP_KERNEL);
+			elf_buf = kzalloc(tsz, GFP_KERNEL);
 			if (!elf_buf)
 				return -ENOMEM;
-			memset(elf_buf, 0, tsz);
 
 			read_lock(&vmlist_lock);
 			for (m=vmlist; m && cursize; m=m->next) {
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 5a90349..8497609 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -358,11 +358,10 @@ static int qnx4_fill_super(struct super_
 	const char *errmsg;
 	struct qnx4_sb_info *qs;
 
-	qs = kmalloc(sizeof(struct qnx4_sb_info), GFP_KERNEL);
+	qs = kzalloc(sizeof(struct qnx4_sb_info), GFP_KERNEL);
 	if (!qs)
 		return -ENOMEM;
 	s->s_fs_info = qs;
-	memset(qs, 0, sizeof(struct qnx4_sb_info));
 
 	sb_set_blocksize(s, QNX4_BLOCK_SIZE);
 
diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index 876639b..350cba5 100644
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
diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index 3873c67..4e42411 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -129,14 +129,12 @@ struct inode * udf_new_inode (struct ino
 	{
 		UDF_I_EFE(inode) = 1;
 		UDF_UPDATE_UDFREV(inode->i_sb, UDF_VERS_USE_EXTENDED_FE);
-		UDF_I_DATA(inode) = kmalloc(inode->i_sb->s_blocksize - sizeof(struct extendedFileEntry), GFP_KERNEL);
-		memset(UDF_I_DATA(inode), 0x00, inode->i_sb->s_blocksize - sizeof(struct extendedFileEntry));
+		UDF_I_DATA(inode) = kzalloc(inode->i_sb->s_blocksize - sizeof(struct extendedFileEntry), GFP_KERNEL);
 	}
 	else
 	{
 		UDF_I_EFE(inode) = 0;
-		UDF_I_DATA(inode) = kmalloc(inode->i_sb->s_blocksize - sizeof(struct fileEntry), GFP_KERNEL);
-		memset(UDF_I_DATA(inode), 0x00, inode->i_sb->s_blocksize - sizeof(struct fileEntry));
+		UDF_I_DATA(inode) = kzalloc(inode->i_sb->s_blocksize - sizeof(struct fileEntry), GFP_KERNEL);
 	}
 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_AD_IN_ICB))
 		UDF_I_ALLOCTYPE(inode) = ICBTAG_FLAG_AD_IN_ICB;
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 992ee0b..ef910e7 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -611,11 +611,10 @@ static int ufs_fill_super(struct super_b
 	
 	UFSD("ENTER\n");
 		
-	sbi = kmalloc(sizeof(struct ufs_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct ufs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		goto failed_nomem;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(struct ufs_sb_info));
 
 	UFSD("flag %u\n", (int)(sb->s_flags & MS_RDONLY));
 	
-- 
1.4.2.rc1.ge7a0-dirty

