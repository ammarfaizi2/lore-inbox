Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSGSFJT>; Fri, 19 Jul 2002 01:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSGSFJT>; Fri, 19 Jul 2002 01:09:19 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:37573 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315455AbSGSFJK>;
	Fri, 19 Jul 2002 01:09:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/, mm/, ipc/ designated initializer rework
Date: Fri, 19 Jul 2002 14:48:20 +1000
Message-Id: <20020719051255.3763B43FF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Misc bits of the kernel rework.

Please apply,
Rusty.
PS.  Whitespace is not *perfect*, but I really don't care.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Designated initializers for kernel/, mm/ and ipc/
Author: Rusty Russell
Status: Trivial

D: The old form of designated initializers are obsolete: we need to
D: replace them with the ISO C forms before 2.6.  Gcc has always supported
D: both forms anyway.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/kernel/futex.c working-2.5.26-designated-init/kernel/futex.c
--- linux-2.5.26/kernel/futex.c	Wed Jul 17 10:25:53 2002
+++ working-2.5.26-designated-init/kernel/futex.c	Thu Jul 18 18:48:10 2002
@@ -245,8 +245,8 @@
 }
 
 static struct file_operations futex_fops = {
-	release:	futex_close,
-	poll:		futex_poll,
+	.release =	futex_close,
+	.poll =		futex_poll,
 };
 
 /* Signal allows caller to avoid the race which would occur if they
@@ -357,8 +357,8 @@
 }
 
 static struct file_system_type futex_fs_type = {
-	name:		"futexfs",
-	get_sb:		futexfs_get_sb,
+	.name =		"futexfs",
+	.get_sb =	futexfs_get_sb,
 };
 
 static int __init init(void)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/kernel/kmod.c working-2.5.26-designated-init/kernel/kmod.c
--- linux-2.5.26/kernel/kmod.c	Thu Jun 20 01:28:52 2002
+++ working-2.5.26-designated-init/kernel/kmod.c	Thu Jul 18 18:48:10 2002
@@ -338,15 +338,15 @@
 {
 	DECLARE_COMPLETION(work);
 	struct subprocess_info sub_info = {
-		complete:	&work,
-		path:		path,
-		argv:		argv,
-		envp:		envp,
-		retval:		0,
+		.complete =	&work,
+		.path =		path,
+		.argv =		argv,
+		.envp =		envp,
+		.retval =	0,
 	};
 	struct tq_struct tqs = {
-		routine:	__call_usermodehelper,
-		data:		&sub_info,
+		.routine =	__call_usermodehelper,
+		.data =		&sub_info,
 	};
 
 	if (path[0] == '\0')
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/kernel/module.c working-2.5.26-designated-init/kernel/module.c
--- linux-2.5.26/kernel/module.c	Mon Apr 15 11:47:51 2002
+++ working-2.5.26-designated-init/kernel/module.c	Thu Jul 18 18:48:09 2002
@@ -44,15 +44,15 @@
 
 struct module kernel_module =
 {
-	size_of_struct:		sizeof(struct module),
-	name: 			"",
-	uc:	 		{ATOMIC_INIT(1)},
-	flags:			MOD_RUNNING,
-	syms:			__start___ksymtab,
-	ex_table_start:		__start___ex_table,
-	ex_table_end:		__stop___ex_table,
-	kallsyms_start:		__start___kallsyms,
-	kallsyms_end:		__stop___kallsyms,
+	.size_of_struct =	sizeof(struct module),
+	.name = 		"",
+	.uc =	 		{ATOMIC_INIT(1)},
+	.flags =		MOD_RUNNING,
+	.syms =			__start___ksymtab,
+	.ex_table_start =	__start___ex_table,
+	.ex_table_end =		__stop___ex_table,
+	.kallsyms_start =	__start___kallsyms,
+	.kallsyms_end =		__stop___kallsyms,
 };
 
 struct module *module_list = &kernel_module;
@@ -1132,10 +1132,10 @@
 	return 0;
 }
 struct seq_operations modules_op = {
-	start:	m_start,
-	next:	m_next,
-	stop:	m_stop,
-	show:	m_show
+	.start =m_start,
+	.next =	m_next,
+	.stop =	m_stop,
+	.show =	m_show
 };
 
 /*
@@ -1214,10 +1214,10 @@
 }
 
 struct seq_operations ksyms_op = {
-	start:	s_start,
-	next:	s_next,
-	stop:	s_stop,
-	show:	s_show
+	.start =s_start,
+	.next =	s_next,
+	.stop =	s_stop,
+	.show =	s_show
 };
 
 #else		/* CONFIG_MODULES */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/kernel/platform.c working-2.5.26-designated-init/kernel/platform.c
--- linux-2.5.26/kernel/platform.c	Wed Jul 17 10:25:53 2002
+++ working-2.5.26-designated-init/kernel/platform.c	Thu Jul 18 18:48:11 2002
@@ -23,13 +23,13 @@
 }
 
 static struct platform_t default_platform = {
-	name:		"Default Platform",
-	suspend_states:	0,
-	reboot:		default_reboot,
-	halt:		default_halt,
-	power_off:	default_halt,
-	suspend:	default_suspend,
-	idle:		default_idle,
+	.name =		"Default Platform",
+	.suspend_states =0,
+	.reboot =	default_reboot,
+	.halt =		default_halt,
+	.power_off =	default_halt,
+	.suspend =	default_suspend,
+	.idle =		default_idle,
 };
 
 struct platform_t * platform = &default_platform;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/kernel/sys.c working-2.5.26-designated-init/kernel/sys.c
--- linux-2.5.26/kernel/sys.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.26-designated-init/kernel/sys.c	Thu Jul 18 18:48:08 2002
@@ -382,7 +382,7 @@
 void ctrl_alt_del(void)
 {
 	static struct tq_struct cad_tq = {
-		routine: deferred_cad,
+		.routine = deferred_cad,
 	};
 
 	if (C_A_D)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/kernel/sysctl.c working-2.5.26-designated-init/kernel/sysctl.c
--- linux-2.5.26/kernel/sysctl.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.26-designated-init/kernel/sysctl.c	Thu Jul 18 18:48:09 2002
@@ -126,12 +126,12 @@
 static int proc_sys_permission(struct inode *, int);
 
 struct file_operations proc_sys_file_operations = {
-	read:		proc_readsys,
-	write:		proc_writesys,
+	.read =		proc_readsys,
+	.write =	proc_writesys,
 };
 
 static struct inode_operations proc_sys_inode_operations = {
-	permission:	proc_sys_permission,
+	.permission =	proc_sys_permission,
 };
 
 extern struct proc_dir_entry *proc_sys_root;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/kernel/user.c working-2.5.26-designated-init/kernel/user.c
--- linux-2.5.26/kernel/user.c	Mon Jun  3 12:21:28 2002
+++ working-2.5.26-designated-init/kernel/user.c	Thu Jul 18 18:48:10 2002
@@ -28,9 +28,9 @@
 static spinlock_t uidhash_lock = SPIN_LOCK_UNLOCKED;
 
 struct user_struct root_user = {
-	__count:	ATOMIC_INIT(1),
-	processes:	ATOMIC_INIT(1),
-	files:		ATOMIC_INIT(0)
+	.__count =	ATOMIC_INIT(1),
+	.processes =	ATOMIC_INIT(1),
+	.files =	ATOMIC_INIT(0)
 };
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/mm/filemap.c working-2.5.26-designated-init/mm/filemap.c
--- linux-2.5.26/mm/filemap.c	Wed Jul 17 10:25:53 2002
+++ working-2.5.26-designated-init/mm/filemap.c	Thu Jul 18 18:48:11 2002
@@ -1591,7 +1591,7 @@
 }
 
 static struct vm_operations_struct generic_file_vm_ops = {
-	nopage:		filemap_nopage,
+	.nopage =	filemap_nopage,
 };
 
 /* This is used for a general mmap of a disk file */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/mm/page_io.c working-2.5.26-designated-init/mm/page_io.c
--- linux-2.5.26/mm/page_io.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.26-designated-init/mm/page_io.c	Thu Jul 18 18:48:11 2002
@@ -131,11 +131,11 @@
 }
 
 struct address_space_operations swap_aops = {
-	vm_writeback:	swap_vm_writeback,
-	writepage:	swap_writepage,
-	readpage:	swap_readpage,
-	sync_page:	block_sync_page,
-	set_page_dirty:	__set_page_dirty_nobuffers,
+	.vm_writeback =	swap_vm_writeback,
+	.writepage =	swap_writepage,
+	.readpage =	swap_readpage,
+	.sync_page =	block_sync_page,
+	.set_page_dirty =__set_page_dirty_nobuffers,
 };
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/mm/readahead.c working-2.5.26-designated-init/mm/readahead.c
--- linux-2.5.26/mm/readahead.c	Mon Jun 17 23:19:26 2002
+++ working-2.5.26-designated-init/mm/readahead.c	Thu Jul 18 18:48:15 2002
@@ -14,8 +14,8 @@
 #include <linux/backing-dev.h>
 
 struct backing_dev_info default_backing_dev_info = {
-	ra_pages:	(VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
-	state:		0,
+	.ra_pages =	(VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE,
+	.state =	0,
 };
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/mm/shmem.c working-2.5.26-designated-init/mm/shmem.c
--- linux-2.5.26/mm/shmem.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.26-designated-init/mm/shmem.c	Thu Jul 18 18:48:15 2002
@@ -1257,14 +1257,14 @@
 }
 
 static struct inode_operations shmem_symlink_inline_operations = {
-	readlink:	shmem_readlink_inline,
-	follow_link:	shmem_follow_link_inline,
+	.readlink =	shmem_readlink_inline,
+	.follow_link =	shmem_follow_link_inline,
 };
 
 static struct inode_operations shmem_symlink_inode_operations = {
-	truncate:	shmem_truncate,
-	readlink:	shmem_readlink,
-	follow_link:	shmem_follow_link,
+	.truncate =	shmem_truncate,
+	.readlink =	shmem_readlink,
+	.follow_link =	shmem_follow_link,
 };
 
 static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long * blocks, unsigned long *inodes)
@@ -1465,51 +1465,51 @@
 }
 
 static struct address_space_operations shmem_aops = {
-	writepage:	shmem_writepage,
-	set_page_dirty:	__set_page_dirty_nobuffers,
+	.writepage =	shmem_writepage,
+	.set_page_dirty =__set_page_dirty_nobuffers,
 };
 
 static struct file_operations shmem_file_operations = {
-	mmap:	shmem_mmap,
+	.mmap =	shmem_mmap,
 #ifdef CONFIG_TMPFS
-	read:	shmem_file_read,
-	write:	shmem_file_write,
-	fsync:	shmem_sync_file,
+	.read =	shmem_file_read,
+	.write =shmem_file_write,
+	.fsync =shmem_sync_file,
 #endif
 };
 
 static struct inode_operations shmem_inode_operations = {
-	truncate:	shmem_truncate,
+	.truncate =	shmem_truncate,
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
+	.create =	shmem_create,
+	.lookup =	simple_lookup,
+	.link =		shmem_link,
+	.unlink =	shmem_unlink,
+	.symlink =	shmem_symlink,
+	.mkdir =	shmem_mkdir,
+	.rmdir =	shmem_rmdir,
+	.mknod =	shmem_mknod,
+	.rename =	shmem_rename,
 #endif
 };
 
 static struct super_operations shmem_ops = {
-	alloc_inode:	shmem_alloc_inode,
-	destroy_inode:	shmem_destroy_inode,
+	.alloc_inode =	shmem_alloc_inode,
+	.destroy_inode =shmem_destroy_inode,
 #ifdef CONFIG_TMPFS
-	statfs:		shmem_statfs,
-	remount_fs:	shmem_remount_fs,
+	.statfs =	shmem_statfs,
+	.remount_fs =	shmem_remount_fs,
 #endif
-	delete_inode:	shmem_delete_inode,
-	drop_inode:	generic_delete_inode,
-	put_super:	shmem_put_super,
+	.delete_inode =	shmem_delete_inode,
+	.drop_inode =	generic_delete_inode,
+	.put_super =	shmem_put_super,
 };
 
 static struct vm_operations_struct shmem_vm_ops = {
-	nopage:	shmem_nopage,
+	.nopage =shmem_nopage,
 };
 
 static struct super_block *shmem_get_sb(struct file_system_type *fs_type,
@@ -1521,17 +1521,17 @@
 #ifdef CONFIG_TMPFS
 /* type "shm" will be tagged obsolete in 2.5 */
 static struct file_system_type shmem_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"shmem",
-	get_sb:		shmem_get_sb,
-	kill_sb:	kill_litter_super,
+	.owner =	THIS_MODULE,
+	.name =		"shmem",
+	.get_sb =	shmem_get_sb,
+	.kill_sb =	kill_litter_super,
 };
 #endif
 static struct file_system_type tmpfs_fs_type = {
-	owner:		THIS_MODULE,
-	name:		"tmpfs",
-	get_sb:		shmem_get_sb,
-	kill_sb:	kill_litter_super,
+	.owner =	THIS_MODULE,
+	.name =		"tmpfs",
+	.get_sb =	shmem_get_sb,
+	.kill_sb =	kill_litter_super,
 };
 static struct vfsmount *shm_mnt;
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/mm/slab.c working-2.5.26-designated-init/mm/slab.c
--- linux-2.5.26/mm/slab.c	Wed Jul 17 10:25:54 2002
+++ working-2.5.26-designated-init/mm/slab.c	Thu Jul 18 18:48:13 2002
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
+	.slabs_full =	LIST_HEAD_INIT(cache_cache.slabs_full),
+	.slabs_partial =LIST_HEAD_INIT(cache_cache.slabs_partial),
+	.slabs_free =	LIST_HEAD_INIT(cache_cache.slabs_free),
+	.objsize =	sizeof(kmem_cache_t),
+	.flags =	SLAB_NO_REAP,
+	.spinlock =	SPIN_LOCK_UNLOCKED,
+	.colour_off =	L1_CACHE_BYTES,
+	.name =		"kmem_cache",
 };
 
 /* Guard access to the cache-chain. */
@@ -2034,10 +2034,10 @@
  */
 
 struct seq_operations slabinfo_op = {
-	start:	s_start,
-	next:	s_next,
-	stop:	s_stop,
-	show:	s_show
+	.start =s_start,
+	.next =	s_next,
+	.stop =	s_stop,
+	.show =	s_show
 };
 
 #define MAX_SLABINFO_WRITE 128
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.26/mm/swap_state.c working-2.5.26-designated-init/mm/swap_state.c
--- linux-2.5.26/mm/swap_state.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.26-designated-init/mm/swap_state.c	Thu Jul 18 18:48:12 2002
@@ -23,23 +23,23 @@
  * avoid some special-casing in other parts of the kernel.
  */
 static struct inode swapper_inode = {
-	i_mapping:	&swapper_space,
+	.i_mapping =	&swapper_space,
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
+	.page_tree =	RADIX_TREE_INIT(GFP_ATOMIC),
+	.page_lock =	RW_LOCK_UNLOCKED,
+	.clean_pages =	LIST_HEAD_INIT(swapper_space.clean_pages),
+	.dirty_pages =	LIST_HEAD_INIT(swapper_space.dirty_pages),
+	.io_pages =	LIST_HEAD_INIT(swapper_space.io_pages),
+	.locked_pages =	LIST_HEAD_INIT(swapper_space.locked_pages),
+	.host =		&swapper_inode,
+	.a_ops =	&swap_aops,
+	.i_shared_lock =SPIN_LOCK_UNLOCKED,
+	.private_lock =	SPIN_LOCK_UNLOCKED,
+	.private_list =	LIST_HEAD_INIT(swapper_space.private_list),
 };
 
 #ifdef SWAP_CACHE_INFO
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.26.31511/ipc/shm.c linux-2.5.26.31511.updated/ipc/shm.c
--- linux-2.5.26.31511/ipc/shm.c	Mon Apr 15 11:47:50 2002
+++ linux-2.5.26.31511.updated/ipc/shm.c	Fri Jul 19 13:59:39 2002
@@ -166,13 +166,13 @@ static int shm_mmap(struct file * file, 
 }
 
 static struct file_operations shm_file_operations = {
-	mmap:	shm_mmap
+	.mmap =	shm_mmap
 };
 
 static struct vm_operations_struct shm_vm_ops = {
-	open:	shm_open,	/* callback for a new vm-area open */
-	close:	shm_close,	/* callback for when the vm-area is released */
-	nopage:	shmem_nopage,
+	.open =	shm_open,	/* callback for a new vm-area open */
+	.close =shm_close,	/* callback for when the vm-area is released */
+	.nopage =shmem_nopage,
 };
 
 static int newseg (key_t key, int shmflg, size_t size)
