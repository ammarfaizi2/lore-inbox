Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289515AbSAJQNz>; Thu, 10 Jan 2002 11:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289518AbSAJQNq>; Thu, 10 Jan 2002 11:13:46 -0500
Received: from sr1.terra.com.br ([200.176.3.16]:13032 "EHLO sr1.terra.com.br")
	by vger.kernel.org with ESMTP id <S289515AbSAJQNg>;
	Thu, 10 Jan 2002 11:13:36 -0500
Date: Thu, 10 Jan 2002 14:10:35 -0200
From: Rodrigo Souza de Castro <rcastro@ime.usp.br>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pager_daemon removal
Message-ID: <20020110161035.GC1780@vinci>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

In 2.4.14, the only reference to pager_daemon structure (in
mm/page_io.c) was removed. That struct was used to store the values
for swap cluster, which was the maximum number of asynchronous swapout
pages in rw_swap_page_base().

In this cleanup patch (against 2.4.18-pre2), I removed the
pager_daemon struct (along with the include/linux/swapctl.h file) and
also the kswapd entry in /proc/sys/vm, which was used to change the
values in this structure. All references to this swpctl.h file and a
bogus comment in page_io.c were removed as well.

Comments?

Regards,
Rodrigo


diff -Naur -X exclude-files orig/arch/arm/mm/init.c linux/arch/arm/mm/init.c
--- orig/arch/arm/mm/init.c	Thu Oct 11 13:04:57 2001
+++ linux/arch/arm/mm/init.c	Thu Jan 10 13:25:22 2002
@@ -18,7 +18,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
diff -Naur -X exclude-files orig/arch/mips/mm/init.c linux/arch/mips/mm/init.c
--- orig/arch/mips/mm/init.c	Wed Jul  4 15:50:39 2001
+++ linux/arch/mips/mm/init.c	Thu Jan 10 13:24:57 2002
@@ -24,7 +24,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
diff -Naur -X exclude-files orig/arch/mips64/mm/init.c linux/arch/mips64/mm/init.c
--- orig/arch/mips64/mm/init.c	Wed Jul  4 15:50:39 2001
+++ linux/arch/mips64/mm/init.c	Thu Jan 10 13:25:38 2002
@@ -21,7 +21,6 @@
 #include <linux/bootmem.h>
 #include <linux/highmem.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
diff -Naur -X exclude-files orig/arch/sparc/mm/init.c linux/arch/sparc/mm/init.c
--- orig/arch/sparc/mm/init.c	Fri Dec 21 16:18:47 2001
+++ linux/arch/sparc/mm/init.c	Thu Jan 10 13:24:41 2002
@@ -18,7 +18,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
diff -Naur -X exclude-files orig/arch/sparc64/mm/init.c linux/arch/sparc64/mm/init.c
--- orig/arch/sparc64/mm/init.c	Fri Dec 21 16:18:47 2001
+++ linux/arch/sparc64/mm/init.c	Thu Jan 10 13:25:11 2002
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/blk.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
diff -Naur -X exclude-files orig/fs/buffer.c linux/fs/buffer.c
--- orig/fs/buffer.c	Tue Jan  8 16:30:56 2002
+++ linux/fs/buffer.c	Thu Jan 10 13:20:41 2002
@@ -35,7 +35,6 @@
 #include <linux/locks.h>
 #include <linux/errno.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
 #include <linux/blkdev.h>
diff -Naur -X exclude-files orig/fs/coda/sysctl.c linux/fs/coda/sysctl.c
--- orig/fs/coda/sysctl.c	Fri Dec 21 16:18:50 2001
+++ linux/fs/coda/sysctl.c	Thu Jan 10 13:21:07 2002
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/sysctl.h>
-#include <linux/swapctl.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
diff -Naur -X exclude-files orig/fs/inode.c linux/fs/inode.c
--- orig/fs/inode.c	Fri Dec 21 16:18:50 2001
+++ linux/fs/inode.c	Thu Jan 10 13:20:49 2002
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/cache.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/prefetch.h>
 #include <linux/locks.h>
 
diff -Naur -X exclude-files orig/fs/intermezzo/sysctl.c linux/fs/intermezzo/sysctl.c
--- orig/fs/intermezzo/sysctl.c	Sun Nov 11 16:20:21 2001
+++ linux/fs/intermezzo/sysctl.c	Thu Jan 10 13:21:28 2002
@@ -8,7 +8,6 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/sysctl.h>
-#include <linux/swapctl.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
diff -Naur -X exclude-files orig/include/linux/swapctl.h linux/include/linux/swapctl.h
--- orig/include/linux/swapctl.h	Mon Sep 17 20:15:02 2001
+++ linux/include/linux/swapctl.h	Wed Dec 31 21:00:00 1969
@@ -1,13 +0,0 @@
-#ifndef _LINUX_SWAPCTL_H
-#define _LINUX_SWAPCTL_H
-
-typedef struct pager_daemon_v1
-{
-	unsigned int	tries_base;
-	unsigned int	tries_min;
-	unsigned int	swap_cluster;
-} pager_daemon_v1;
-typedef pager_daemon_v1 pager_daemon_t;
-extern pager_daemon_t pager_daemon;
-
-#endif /* _LINUX_SWAPCTL_H */
diff -Naur -X exclude-files orig/include/linux/sysctl.h linux/include/linux/sysctl.h
--- orig/include/linux/sysctl.h	Tue Jan  8 16:30:56 2002
+++ linux/include/linux/sysctl.h	Thu Jan 10 13:39:36 2002
@@ -137,11 +137,10 @@
 	VM_OVERCOMMIT_MEMORY=5,	/* Turn off the virtual memory safety limit */
 	VM_BUFFERMEM=6,		/* struct: Set buffer memory thresholds */
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
-	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
-	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
-       VM_MIN_READAHEAD=12,    /* Min file readahead */
-       VM_MAX_READAHEAD=13     /* Max file readahead */
+	VM_PGT_CACHE=8,		/* struct: Set page table cache parameters */
+	VM_PAGE_CLUSTER=9,	/* int: set number of pages to swap together */
+       VM_MIN_READAHEAD=10,    /* Min file readahead */
+       VM_MAX_READAHEAD=11     /* Max file readahead */
 };
 
 
diff -Naur -X exclude-files orig/kernel/sysctl.c linux/kernel/sysctl.c
--- orig/kernel/sysctl.c	Tue Jan  8 16:30:56 2002
+++ linux/kernel/sysctl.c	Thu Jan 10 13:21:43 2002
@@ -21,7 +21,6 @@
 #include <linux/config.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
-#include <linux/swapctl.h>
 #include <linux/proc_fs.h>
 #include <linux/ctype.h>
 #include <linux/utsname.h>
@@ -265,8 +264,6 @@
 	 &bdflush_min, &bdflush_max},
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
-	{VM_PAGERDAEMON, "kswapd",
-	 &pager_daemon, sizeof(pager_daemon_t), 0644, NULL, &proc_dointvec},
 	{VM_PGT_CACHE, "pagetable_cache", 
 	 &pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
diff -Naur -X exclude-files orig/mm/bootmem.c linux/mm/bootmem.c
--- orig/mm/bootmem.c	Fri Dec 21 16:18:51 2001
+++ linux/mm/bootmem.c	Thu Jan 10 13:23:50 2002
@@ -12,7 +12,6 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
diff -Naur -X exclude-files orig/mm/filemap.c linux/mm/filemap.c
--- orig/mm/filemap.c	Thu Jan 10 13:40:05 2002
+++ linux/mm/filemap.c	Thu Jan 10 13:38:12 2002
@@ -19,7 +19,6 @@
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/file.h>
-#include <linux/swapctl.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/iobuf.h>
diff -Naur -X exclude-files orig/mm/memory.c linux/mm/memory.c
--- orig/mm/memory.c	Tue Jan  8 16:30:56 2002
+++ linux/mm/memory.c	Thu Jan 10 13:22:05 2002
@@ -40,7 +40,6 @@
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/smp_lock.h>
-#include <linux/swapctl.h>
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
diff -Naur -X exclude-files orig/mm/mmap.c linux/mm/mmap.c
--- orig/mm/mmap.c	Tue Jan  8 16:30:56 2002
+++ linux/mm/mmap.c	Thu Jan 10 13:22:21 2002
@@ -8,7 +8,6 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/file.h>
diff -Naur -X exclude-files orig/mm/oom_kill.c linux/mm/oom_kill.c
--- orig/mm/oom_kill.c	Tue Jan  8 16:30:56 2002
+++ linux/mm/oom_kill.c	Thu Jan 10 13:24:23 2002
@@ -18,7 +18,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/timex.h>
 
 /* #define DEBUG */
diff -Naur -X exclude-files orig/mm/page_alloc.c linux/mm/page_alloc.c
--- orig/mm/page_alloc.c	Tue Jan  8 16:30:56 2002
+++ linux/mm/page_alloc.c	Thu Jan 10 13:22:50 2002
@@ -12,7 +12,6 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/interrupt.h>
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
diff -Naur -X exclude-files orig/mm/page_io.c linux/mm/page_io.c
--- orig/mm/page_io.c	Mon Nov 19 21:19:42 2001
+++ linux/mm/page_io.c	Thu Jan 10 14:02:19 2002
@@ -14,13 +14,11 @@
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
 #include <linux/locks.h>
-#include <linux/swapctl.h>
 
 #include <asm/pgtable.h>
 
 /*
  * Reads or writes a swap page.
- * wait=1: start I/O and wait for completion. wait=0: start asynchronous I/O.
  *
  * Important prevention of race condition: the caller *must* atomically 
  * create a unique swap cache entry for this swap page before calling
diff -Naur -X exclude-files orig/mm/swap.c linux/mm/swap.c
--- orig/mm/swap.c	Wed Nov  7 04:44:20 2001
+++ linux/mm/swap.c	Thu Jan 10 13:22:14 2002
@@ -16,7 +16,6 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 
@@ -26,12 +25,6 @@
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
-
-pager_daemon_t pager_daemon = {
-	512,	/* base number for calculating the number of tries */
-	SWAP_CLUSTER_MAX,	/* minimum number of tries */
-	8,	/* do swap I/O in clusters of this size */
-};
 
 /*
  * Move an inactive page to the active list.
diff -Naur -X exclude-files orig/mm/swap_state.c linux/mm/swap_state.c
--- orig/mm/swap_state.c	Tue Jan  8 16:30:56 2002
+++ linux/mm/swap_state.c	Thu Jan 10 13:23:40 2002
@@ -10,7 +10,6 @@
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
diff -Naur -X exclude-files orig/mm/swapfile.c linux/mm/swapfile.c
--- orig/mm/swapfile.c	Tue Jan  8 16:30:56 2002
+++ linux/mm/swapfile.c	Thu Jan 10 13:23:34 2002
@@ -9,7 +9,6 @@
 #include <linux/smp_lock.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/blkdev.h> /* for blk_size */
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
diff -Naur -X exclude-files orig/mm/vmscan.c linux/mm/vmscan.c
--- orig/mm/vmscan.c	Thu Jan 10 13:40:05 2002
+++ linux/mm/vmscan.c	Thu Jan 10 13:38:12 2002
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
-#include <linux/swapctl.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>


