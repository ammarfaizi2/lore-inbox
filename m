Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWIAWev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWIAWev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 18:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWIAWeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 18:34:50 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:204 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751139AbWIAWes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 18:34:48 -0400
Date: Fri, 1 Sep 2006 15:34:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       mpm@selenic.com, Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20060901223413.21034.69888.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
References: <20060901223358.21034.83736.sendpatchset@schroedinger.engr.sgi.com>
Subject: [MODSLAB 3/5] /proc/slabinfo display
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generic Slab statistics module

A statistic module for generic slab allocator framework.

The creator of a cache must register the slab cache with

register_slab()

in order for something to show up in slabinfo.

Here is a sample of slabinfo output:

slabinfo - version: 3.0
# name            <objects> <objsize> <num_slabs> <partial_slabs> <active_slabs> <order> <allocator>
nfs_direct_cache           0     136       0       0       0  0 reclaimable:page_allocator
nfs_write_data            36     896       2       0       0  0 unreclaimable:page_allocator
nfs_read_data             21     768       2       1       0  0 unreclaimable:page_allocator
nfs_inode_cache           17    1032       3       3       0  0 ctor_dtor:reclaimable:page_allocator
rpc_tasks                  0     384       1       1       0  0 unreclaimable:page_allocator
rpc_inode_cache            0     896       1       1       0  0 ctor_dtor:reclaimable:page_allocator
ip6_dst_cache              0     384       1       1       0  0 unreclaimable:page_allocator
TCPv6                      1    1792       2       2       0  0 unreclaimable:page_allocator
UNIX                     112     768      11       7       0  0 unreclaimable:page_allocator
dm_tio                     0      24       0       0       0  0 unreclaimable:page_allocator
dm_io                      0      40       0       0       0  0 unreclaimable:page_allocator
kmalloc                    0      64       0       0       0  0 dma:unreclaimable:page_allocator
cfq_ioc_pool               0     160       0       0       0  0 unreclaimable:page_allocator
cfq_pool                   0     160       0       0       0  0 unreclaimable:page_allocator
mqueue_inode_cache         0     896       1       1       0  0 ctor_dtor:unreclaimable:page_allocator
xfs_chashlist            822      40       9       9       0  0 unreclaimable:page_allocator
xfs_ili                  183     192       9       8       1  0 unreclaimable:page_allocator
xfs_inode               7890     640     319       6       1  0 reclaimable:page_allocator
xfs_efi_item               0     352       0       0       0  0 unreclaimable:page_allocator
xfs_efd_item               0     360       0       0       0  0 unreclaimable:page_allocator
xfs_buf_item               4     184       1       0       1  0 unreclaimable:page_allocator
xfs_acl                    0     304       0       0       0  0 unreclaimable:page_allocator
xfs_dabuf                  0      24       1       0       1  0 unreclaimable:page_allocator
xfs_da_state               0     488       0       0       0  0 unreclaimable:page_allocator
xfs_trans                  1     832       1       0       1  0 unreclaimable:page_allocator
xfs_btree_cur              0     192       1       0       1  0 unreclaimable:page_allocator
xfs_bmap_free_item         0      24       0       0       0  0 unreclaimable:page_allocator
xfs_ioend                128     160       2       0       1  0 unreclaimable:page_allocator
xfs_vnode               7891     768     380       5       1  0 ctor_dtor:reclaimable:page_allocator
isofs_inode_cache          0     656       0       0       0  0 ctor_dtor:reclaimable:page_allocator
fat_inode_cache            0     688       1       1       0  0 ctor_dtor:reclaimable:page_allocator
fat_cache                  0      40       0       0       0  0 ctor_dtor:reclaimable:page_allocator
hugetlbfs_inode_cache      0     624       1       1       0  0 ctor_dtor:unreclaimable:page_allocator
ext2_inode_cache           0     776       0       0       0  0 ctor_dtor:reclaimable:page_allocator
ext2_xattr                 0      88       0       0       0  0 reclaimable:page_allocator
journal_handle             0      24       0       0       0  0 unreclaimable:page_allocator
journal_head               0      96       0       0       0  0 unreclaimable:page_allocator
ext3_inode_cache           0     824       0       0       0  0 ctor_dtor:reclaimable:page_allocator
ext3_xattr                 0      88       0       0       0  0 reclaimable:page_allocator
reiser_inode_cache         0     736       0       0       0  0 ctor_dtor:reclaimable:page_allocator
dnotify_cache              0      40       0       0       0  0 unreclaimable:page_allocator
dquot                      0     256       0       0       0  0 reclaimable:page_allocator
eventpoll_pwq              0      72       1       1       0  0 unreclaimable:page_allocator
inotify_event_cache        0      40       0       0       0  0 unreclaimable:page_allocator
inotify_watch_cache        0      72       1       1       0  0 unreclaimable:page_allocator
kioctx                     0     384       0       0       0  0 unreclaimable:page_allocator
fasync_cache               0      24       0       0       0  0 unreclaimable:page_allocator
shmem_inode_cache        794     816      45      12       0  0 ctor_dtor:unreclaimable:page_allocator
posix_timers_cache         0     136       0       0       0  0 unreclaimable:page_allocator
partial_page_cache         0      48       0       0       0  0 unreclaimable:page_allocator
xfrm_dst_cache             0     384       0       0       0  0 unreclaimable:page_allocator
ip_dst_cache              21     384       2       2       0  0 unreclaimable:page_allocator
RAW                        0     896       1       1       0  0 unreclaimable:page_allocator
UDP                        3     896       3       2       1  0 unreclaimable:page_allocator
TCP                       12    1664       4       4       0  0 unreclaimable:page_allocator
scsi_io_context            0     112       0       0       0  0 unreclaimable:page_allocator
blkdev_ioc                26      56       7       7       0  0 unreclaimable:page_allocator
blkdev_queue              24    1616       4       2       0  0 unreclaimable:page_allocator
blkdev_requests           12     280       2       0       2  0 unreclaimable:page_allocator
sock_inode_cache         167     768      12       6       1  0 ctor_dtor:reclaimable:page_allocator
file_lock_cache            1     184       2       2       0  0 ctor_dtor:unreclaimable:page_allocator
Acpi-Parse                 0      40       0       0       0  0 unreclaimable:page_allocator
Acpi-State                 0      80       0       0       0  0 unreclaimable:page_allocator
proc_inode_cache         696     640      36      16       1  0 ctor_dtor:reclaimable:page_allocator
sigqueue                   0     160       4       0       4  0 unreclaimable:page_allocator
radix_tree_node         2068     560      75       5       0  0 ctor_dtor:unreclaimable:page_allocator
bdev_cache                42     896       5       4       0  0 ctor_dtor:reclaimable:page_allocator
sysfs_dir_cache         4283      80      24       4       0  0 unreclaimable:page_allocator
inode_cache             2571     608     103       8       1  0 ctor_dtor:reclaimable:page_allocator
dentry_cache           13014     200     166       7       3  0 reclaimable:page_allocator
idr_layer_cache           76     536       4       2       0  0 ctor_dtor:unreclaimable:page_allocator
buffer_head             4417     104      33       9       0  0 ctor_dtor:reclaimable:page_allocator
vm_area_struct          1503     176      24      19       3  0 unreclaimable:page_allocator
files_cache               47     768       7       6       1  0 unreclaimable:page_allocator
signal_cache             136     640      10       6       1  0 unreclaimable:page_allocator
sighand_cache            136    1664      19       6       1  0 ctor_dtor:rcu:unreclaimable:page_allocator
anon_vma                 264      32       9       8       1  0 ctor_dtor:rcu:unreclaimable:page_allocator
shared_policy_node         0      48       0       0       0  0 unreclaimable:page_allocator
numa_policy               85     264       4       3       0  0 unreclaimable:page_allocator
kmalloc                    0  262144       0       0       0  4 unreclaimable:page_allocator
kmalloc                    2  131072       2       0       0  3 unreclaimable:page_allocator
kmalloc                    1   65536       1       0       0  2 unreclaimable:page_allocator
kmalloc                   10   32768      10       0       0  1 unreclaimable:page_allocator
kmalloc                   93   16384      93       0       0  0 unreclaimable:page_allocator
kmalloc                   98    8192      49       0       0  0 unreclaimable:page_allocator
kmalloc                   99    4096      31       8       4  0 unreclaimable:page_allocator
kmalloc                  345    2048      47      14       2  0 unreclaimable:page_allocator
kmalloc                  228    1024      21      12       2  0 unreclaimable:page_allocator
kmalloc                  183     512      14       9       3  0 unreclaimable:page_allocator
kmalloc                 3892     256      78      31       3  0 unreclaimable:page_allocator
kmalloc                 1244     128      18       9       4  0 unreclaimable:page_allocator
kmalloc                 1619      64      12       8       1  0 unreclaimable:page_allocator
kmalloc                  121      32       8       5       3  0 unreclaimable:page_allocator
kmalloc                 1644      16       5       4       0  0 unreclaimable:page_allocator
kmalloc                  128       8       4       4       0  0 unreclaimable:page_allocator

Signed-off-by: Christoph Lameter <clameter@sgi.com>


Index: linux-2.6.18-rc5-mm1/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/fs/proc/proc_misc.c	2006-09-01 10:13:26.836324579 -0700
+++ linux-2.6.18-rc5-mm1/fs/proc/proc_misc.c	2006-09-01 11:48:20.608777567 -0700
@@ -399,9 +399,11 @@ static struct file_operations proc_modul
 };
 #endif
 
-#ifdef CONFIG_SLAB
+#if defined(CONFIG_SLAB) || defined(CONFIG_MODULAR_SLAB)
 extern struct seq_operations slabinfo_op;
+#ifdef CONFIG_SLAB
 extern ssize_t slabinfo_write(struct file *, const char __user *, size_t, loff_t *);
+#endif
 static int slabinfo_open(struct inode *inode, struct file *file)
 {
 	return seq_open(file, &slabinfo_op);
@@ -409,12 +411,14 @@ static int slabinfo_open(struct inode *i
 static struct file_operations proc_slabinfo_operations = {
 	.open		= slabinfo_open,
 	.read		= seq_read,
+#ifdef CONFIG_SLAB
 	.write		= slabinfo_write,
+#endif
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
 
-#ifdef CONFIG_DEBUG_SLAB_LEAK
+#if defined(CONFIG_DEBUG_SLAB_LEAK) && defined(CONFIG_SLAB)
 extern struct seq_operations slabstats_op;
 static int slabstats_open(struct inode *inode, struct file *file)
 {
@@ -787,9 +791,9 @@ void __init proc_misc_init(void)
 #endif
 	create_seq_entry("stat", 0, &proc_stat_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
-#ifdef CONFIG_SLAB
+#if defined(CONFIG_SLAB) || defined(CONFIG_MODULAR_SLAB)
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
-#ifdef CONFIG_DEBUG_SLAB_LEAK
+#if defined(CONFIG_DEBUG_SLAB_LEAK) && defined(CONFIG_SLAB)
 	create_seq_entry("slab_allocators", 0 ,&proc_slabstats_operations);
 #endif
 #endif
Index: linux-2.6.18-rc5-mm1/mm/Makefile
===================================================================
--- linux-2.6.18-rc5-mm1.orig/mm/Makefile	2006-09-01 11:48:08.244307287 -0700
+++ linux-2.6.18-rc5-mm1/mm/Makefile	2006-09-01 11:48:20.608777567 -0700
@@ -28,4 +28,4 @@ obj-$(CONFIG_MEMORY_HOTPLUG) += memory_h
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_SMP) += allocpercpu.o
-obj-$(CONFIG_MODULAR_SLAB) += allocator.o slabifier.o
+obj-$(CONFIG_MODULAR_SLAB) += allocator.o slabifier.o slabstat.o
Index: linux-2.6.18-rc5-mm1/mm/slabstat.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc5-mm1/mm/slabstat.c	2006-09-01 11:48:20.609754070 -0700
@@ -0,0 +1,96 @@
+/*
+ * linux/mm/slabstat.c
+ */
+
+#include <linux/mm.h>
+#include <linux/seq_file.h>
+
+static DECLARE_RWSEM(slabstat_sem);
+
+LIST_HEAD(slab_caches);
+
+void register_slab(struct slab_cache *s)
+{
+	down_write(&slabstat_sem);
+	list_add(&s->list, &slab_caches);
+	up_write(&slabstat_sem);
+}
+
+void unregister_slab(struct slab_cache *s)
+{
+	down_write(&slabstat_sem);
+	list_add(&s->list, &slab_caches);
+	up_write(&slabstat_sem);
+}
+
+static void print_slabinfo_header(struct seq_file *m)
+{
+	/*
+	 * Output format version, so at least we can change it
+	 * without _too_ many complaints.
+	 */
+	seq_puts(m, "slabinfo - version: 3.0\n");
+	seq_puts(m, "# name            <objects> <objsize> <num_slabs> "
+		"<partial_slabs> <active_slabs> <order> <allocator>");
+	seq_putc(m, '\n');
+}
+
+static void *s_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t n = *pos;
+	struct list_head *p;
+
+	down_read(&slabstat_sem);
+	if (!n)
+		print_slabinfo_header(m);
+	p = slab_caches.next;
+	while (n--) {
+		p = p->next;
+		if (p == &slab_caches)
+			return NULL;
+	}
+	return list_entry(p, struct slab_cache, list);
+}
+
+static void *s_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	struct slab_cache *s = p;
+	++*pos;
+	return s->list.next == &slab_caches ?
+		NULL : list_entry(s->list.next, struct slab_cache, list);
+}
+
+static void s_stop(struct seq_file *m, void *p)
+{
+	up_read(&slabstat_sem);
+}
+
+static int s_show(struct seq_file *m, void *p)
+{
+	struct slab_cache *s = p;
+	unsigned long total_slabs;
+	unsigned long active_slabs;
+	unsigned long partial_slabs;
+	unsigned long objects;
+
+	objects = s->slab_alloc->get_objects(s, &total_slabs,
+					&active_slabs, &partial_slabs);
+
+	seq_printf(m, "%-21s %7lu %7u %7lu %7lu %7lu %2d %s",
+		   s->name, objects, s->size, total_slabs, partial_slabs,
+		   active_slabs, s->order, s->page_alloc->name);
+
+	seq_putc(m, '\n');
+	return 0;
+}
+
+/*
+ * slabinfo_op - iterator that generates /proc/slabinfo
+ */
+struct seq_operations slabinfo_op = {
+	.start = s_start,
+	.next = s_next,
+	.stop = s_stop,
+	.show = s_show,
+};
+
Index: linux-2.6.18-rc5-mm1/include/linux/slabstat.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc5-mm1/include/linux/slabstat.h	2006-09-01 11:48:20.611707074 -0700
@@ -0,0 +1,9 @@
+#ifndef _LINUX_SLABSTAT_H
+#define _LINUX_SLABSTAT_H
+#include <linux/allocator.h>
+
+void register_slab(struct slab_cache *s);
+void unregister_slab(struct slab_cache *s);
+
+#endif /* _LINUX_SLABSTAT_H */
+

-- 
VGER BF report: H 0
