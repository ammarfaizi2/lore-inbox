Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318399AbSGaQcD>; Wed, 31 Jul 2002 12:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318402AbSGaQcD>; Wed, 31 Jul 2002 12:32:03 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:18198 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S318399AbSGaQcA>; Wed, 31 Jul 2002 12:32:00 -0400
Date: Wed, 31 Jul 2002 17:35:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Art Haas <ahaas@neosoft.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializers for mm
Message-ID: <Pine.LNX.4.21.0207311726160.2990-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ISO C99 designated initializers by Art Haas for mm.
Rediffed against 2.5.29 + .... 1.548: please apply.

 filemap.c    |    2 -
 numa.c       |    2 -
 page_io.c    |   10 +++----
 readahead.c  |    4 +--
 shmem.c      |   76 +++++++++++++++++++++++++++++------------------------------
 slab.c       |   24 +++++++++---------
 swap_state.c |   24 +++++++++---------
 7 files changed, 71 insertions, 71 deletions

--- 2.5.29-548/mm/filemap.c	Wed Jul 31 15:58:32 2002
+++ linux/mm/filemap.c	Wed Jul 31 16:20:39 2002
@@ -1346,7 +1346,7 @@
 }
 
 static struct vm_operations_struct generic_file_vm_ops = {
-	nopage:		filemap_nopage,
+	.nopage		= filemap_nopage,
 };
 
 /* This is used for a general mmap of a disk file */
--- 2.5.29-548/mm/numa.c	Wed Jul 31 15:58:32 2002
+++ linux/mm/numa.c	Wed Jul 31 16:20:39 2002
@@ -12,7 +12,7 @@
 int numnodes = 1;	/* Initialized for UMA platforms */
 
 static bootmem_data_t contig_bootmem_data;
-pg_data_t contig_page_data = { bdata: &contig_bootmem_data };
+pg_data_t contig_page_data = { .bdata = &contig_bootmem_data };
 
 #ifndef CONFIG_DISCONTIGMEM
 
--- 2.5.29-548/mm/page_io.c	Mon Jul 22 19:08:59 2002
+++ linux/mm/page_io.c	Wed Jul 31 16:20:39 2002
@@ -132,11 +132,11 @@
 }
 
 struct address_space_operations swap_aops = {
-	vm_writeback:	swap_vm_writeback,
-	writepage:	swap_writepage,
-	readpage:	swap_readpage,
-	sync_page:	block_sync_page,
-	set_page_dirty:	__set_page_dirty_nobuffers,
+	.vm_writeback	= swap_vm_writeback,
+	.writepage	= swap_writepage,
+	.readpage	= swap_readpage,
+	.sync_page	= block_sync_page,
+	.set_page_dirty	= __set_page_dirty_nobuffers,
 };
 
 /*
--- 2.5.29-548/mm/readahead.c	Mon Jul 22 19:08:59 2002
+++ linux/mm/readahead.c	Wed Jul 31 16:20:39 2002
@@ -14,8 +14,8 @@
 #include <linux/backing-dev.h>
 
 struct backing_dev_info default_backing_dev_info = {
-	ra_pages:	(VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
-	state:		0,
+	.ra_pages	= (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
+	.state		= 0,
 };
 
 /*
--- 2.5.29-548/mm/shmem.c	Wed Jul 31 15:58:32 2002
+++ linux/mm/shmem.c	Wed Jul 31 16:20:39 2002
@@ -1312,14 +1312,14 @@
 }
 
 static struct inode_operations shmem_symlink_inline_operations = {
-	readlink:	shmem_readlink_inline,
-	follow_link:	shmem_follow_link_inline,
+	.readlink	= shmem_readlink_inline,
+	.follow_link	= shmem_follow_link_inline,
 };
 
 static struct inode_operations shmem_symlink_inode_operations = {
-	truncate:	shmem_truncate,
-	readlink:	shmem_readlink,
-	follow_link:	shmem_follow_link,
+	.truncate	= shmem_truncate,
+	.readlink	= shmem_readlink,
+	.follow_link	= shmem_follow_link,
 };
 
 static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long * blocks, unsigned long *inodes)
@@ -1520,52 +1520,52 @@
 }
 
 static struct address_space_operations shmem_aops = {
-	writepage:	shmem_writepage,
-	set_page_dirty:	__set_page_dirty_nobuffers,
+	.writepage	= shmem_writepage,
+	.set_page_dirty	= __set_page_dirty_nobuffers,
 };
 
 static struct file_operations shmem_file_operations = {
-	mmap:	shmem_mmap,
+	.mmap		= shmem_mmap,
 #ifdef CONFIG_TMPFS
-	read:	shmem_file_read,
-	write:	shmem_file_write,
-	fsync:	shmem_sync_file,
+	.read		= shmem_file_read,
+	.write		= shmem_file_write,
+	.fsync		= shmem_sync_file,
 #endif
 };
 
 static struct inode_operations shmem_inode_operations = {
-	truncate:	shmem_truncate,
-	setattr:	shmem_notify_change,
+	.truncate	= shmem_truncate,
+	.setattr	= shmem_notify_change,
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
-	create:		shmem_create,
-	lookup:		simple_lookup,
-	link:		shmem_link,
-	unlink:		shmem_unlink,
-	symlink:	shmem_symlink,
-	mkdir:		shmem_mkdir,
-	rmdir:		shmem_rmdir,
-	mknod:		shmem_mknod,
-	rename:		shmem_rename,
+	.create		= shmem_create,
+	.lookup		= simple_lookup,
+	.link		= shmem_link,
+	.unlink		= shmem_unlink,
+	.symlink	= shmem_symlink,
+	.mkdir		= shmem_mkdir,
+	.rmdir		= shmem_rmdir,
+	.mknod		= shmem_mknod,
+	.rename		= shmem_rename,
 #endif
 };
 
 static struct super_operations shmem_ops = {
-	alloc_inode:	shmem_alloc_inode,
-	destroy_inode:	shmem_destroy_inode,
+	.alloc_inode	= shmem_alloc_inode,
+	.destroy_inode	= shmem_destroy_inode,
 #ifdef CONFIG_TMPFS
-	statfs:		shmem_statfs,
-	remount_fs:	shmem_remount_fs,
+	.statfs		= shmem_statfs,
+	.remount_fs	= shmem_remount_fs,
 #endif
-	delete_inode:	shmem_delete_inode,
-	drop_inode:	generic_delete_inode,
-	put_super:	shmem_put_super,
+	.delete_inode	= shmem_delete_inode,
+	.drop_inode	= generic_delete_inode,
+	.put_super	= shmem_put_super,
 };
 
 static struct vm_operations_struct shmem_vm_ops = {
-	nopage:	shmem_nopage,
+	.nopage		= shmem_nopage,
 };
 
 static struct super_block *shmem_get_sb(struct file_system_type *fs_type,
@@ -1577,17 +1577,17 @@
 #ifdef CONFIG_TMPFS
 /* type "shm" will be tagged obsolete in 2.5 */
 static struct file_system_type shmem_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"shmem",
-	get_sb:		shmem_get_sb,
-	kill_sb:	kill_litter_super,
+	.owner		= THIS_MODULE,
+	.name		= "shmem",
+	.get_sb		= shmem_get_sb,
+	.kill_sb	= kill_litter_super,
 };
 #endif
 static struct file_system_type tmpfs_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"tmpfs",
-	get_sb:		shmem_get_sb,
-	kill_sb:	kill_litter_super,
+	.owner		= THIS_MODULE,
+	.name		= "tmpfs",
+	.get_sb		= shmem_get_sb,
+	.kill_sb	= kill_litter_super,
 };
 static struct vfsmount *shm_mnt;
 
--- 2.5.29-548/mm/slab.c	Wed Jul 31 15:58:32 2002
+++ linux/mm/slab.c	Wed Jul 31 16:20:39 2002
@@ -384,14 +384,14 @@
 
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
-	slabs_full:	LIST_HEAD_INIT(cache_cache.slabs_full),
-	slabs_partial:	LIST_HEAD_INIT(cache_cache.slabs_partial),
-	slabs_free:	LIST_HEAD_INIT(cache_cache.slabs_free),
-	objsize:	sizeof(kmem_cache_t),
-	flags:		SLAB_NO_REAP,
-	spinlock:	SPIN_LOCK_UNLOCKED,
-	colour_off:	L1_CACHE_BYTES,
-	name:		"kmem_cache",
+	.slabs_full	= LIST_HEAD_INIT(cache_cache.slabs_full),
+	.slabs_partial	= LIST_HEAD_INIT(cache_cache.slabs_partial),
+	.slabs_free	= LIST_HEAD_INIT(cache_cache.slabs_free),
+	.objsize	= sizeof(kmem_cache_t),
+	.flags		= SLAB_NO_REAP,
+	.spinlock	= SPIN_LOCK_UNLOCKED,
+	.colour_off	= L1_CACHE_BYTES,
+	.name		= "kmem_cache",
 };
 
 /* Guard access to the cache-chain. */
@@ -2053,10 +2053,10 @@
  */
 
 struct seq_operations slabinfo_op = {
-	start:	s_start,
-	next:	s_next,
-	stop:	s_stop,
-	show:	s_show
+	.start	= s_start,
+	.next	= s_next,
+	.stop	= s_stop,
+	.show	= s_show,
 };
 
 #define MAX_SLABINFO_WRITE 128
--- 2.5.29-548/mm/swap_state.c	Wed Jul 31 15:58:32 2002
+++ linux/mm/swap_state.c	Wed Jul 31 16:20:39 2002
@@ -22,23 +22,23 @@
  * avoid some special-casing in other parts of the kernel.
  */
 static struct inode swapper_inode = {
-	i_mapping:	&swapper_space,
+	.i_mapping	= &swapper_space,
 };
 
 extern struct address_space_operations swap_aops;
 
 struct address_space swapper_space = {
-	page_tree:	RADIX_TREE_INIT(GFP_ATOMIC),
-	page_lock:	RW_LOCK_UNLOCKED,
-	clean_pages:	LIST_HEAD_INIT(swapper_space.clean_pages),
-	dirty_pages:	LIST_HEAD_INIT(swapper_space.dirty_pages),
-	io_pages:	LIST_HEAD_INIT(swapper_space.io_pages),
-	locked_pages:	LIST_HEAD_INIT(swapper_space.locked_pages),
-	host:		&swapper_inode,
-	a_ops:		&swap_aops,
-	i_shared_lock:	SPIN_LOCK_UNLOCKED,
-	private_lock:	SPIN_LOCK_UNLOCKED,
-	private_list:	LIST_HEAD_INIT(swapper_space.private_list),
+	.page_tree	= RADIX_TREE_INIT(GFP_ATOMIC),
+	.page_lock	= RW_LOCK_UNLOCKED,
+	.clean_pages	= LIST_HEAD_INIT(swapper_space.clean_pages),
+	.dirty_pages	= LIST_HEAD_INIT(swapper_space.dirty_pages),
+	.io_pages	= LIST_HEAD_INIT(swapper_space.io_pages),
+	.locked_pages	= LIST_HEAD_INIT(swapper_space.locked_pages),
+	.host		= &swapper_inode,
+	.a_ops		= &swap_aops,
+	.i_shared_lock	= SPIN_LOCK_UNLOCKED,
+	.private_lock	= SPIN_LOCK_UNLOCKED,
+	.private_list	= LIST_HEAD_INIT(swapper_space.private_list),
 };
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)

