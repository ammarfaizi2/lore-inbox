Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbUDRWRl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 18:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbUDRWRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 18:17:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12051 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264198AbUDRWRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 18:17:24 -0400
Date: Sun, 18 Apr 2004 23:17:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] Clean up asm/pgalloc.h include
Message-ID: <20040418231720.C12222@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up needless includes of asm/pgalloc.h from the
fs/ kernel/ and mm/ subtrees.  Compile tested on multiple ARM
platforms, and x86, this patch appears safe.

This patch is part of a larger patch aiming towards getting the
include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
can sanely get at things like mm_struct and friends.

I suggest testing in -mm for a while to ensure there aren't any
hidden arch issues.

 fs/binfmt_aout.c          |    1 -
 fs/binfmt_elf.c           |    1 -
 fs/binfmt_flat.c          |    1 -
 fs/exec.c                 |    1 -
 fs/proc/proc_misc.c       |    1 -
 include/asm-arm26/tlb.h   |    1 +
 include/asm-generic/tlb.h |    1 +
 kernel/module.c           |    1 -
 mm/highmem.c              |    1 -
 mm/mincore.c              |    1 -
 mm/mmap.c                 |    1 -
 mm/mprotect.c             |    1 -
 mm/mremap.c               |    1 -
 mm/msync.c                |    1 -
 mm/nommu.c                |    1 -
 mm/rmap.c                 |    1 -
 mm/vmalloc.c              |    1 -
 mm/vmscan.c               |    1 -
 18 files changed, 2 insertions(+), 16 deletions(-)

diff -urpN orig/fs/binfmt_aout.c linux/fs/binfmt_aout.c
--- orig/fs/binfmt_aout.c	Tue Apr 13 19:40:58 2004
+++ linux/fs/binfmt_aout.c	Sun Apr 18 17:40:04 2004
@@ -27,7 +27,6 @@
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 
 static int load_aout_binary(struct linux_binprm *, struct pt_regs * regs);
diff -urpN orig/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- orig/fs/binfmt_elf.c	Tue Apr 13 19:40:58 2004
+++ linux/fs/binfmt_elf.c	Sun Apr 18 17:41:05 2004
@@ -40,7 +40,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/param.h>
-#include <asm/pgalloc.h>
 
 #include <linux/elf.h>
 
diff -urpN orig/fs/binfmt_flat.c linux/fs/binfmt_flat.c
--- orig/fs/binfmt_flat.c	Sat Feb 28 10:10:05 2004
+++ linux/fs/binfmt_flat.c	Sun Apr 18 19:45:54 2004
@@ -40,7 +40,6 @@
 #include <asm/byteorder.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/unaligned.h>
 #include <asm/cacheflush.h>
 
diff -urpN orig/fs/exec.c linux/fs/exec.c
--- orig/fs/exec.c	Tue Apr 13 19:40:59 2004
+++ linux/fs/exec.c	Sun Apr 18 17:39:15 2004
@@ -48,7 +48,6 @@
 #include <linux/rmap.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 
 #ifdef CONFIG_KMOD
diff -urpN orig/fs/proc/proc_misc.c linux/fs/proc/proc_misc.c
--- orig/fs/proc/proc_misc.c	Thu Apr  1 19:33:30 2004
+++ linux/fs/proc/proc_misc.c	Sun Apr 18 22:44:44 2004
@@ -47,7 +47,6 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/div64.h>
 
diff -urpN orig/kernel/module.c linux/kernel/module.c
--- orig/kernel/module.c	Tue Apr 13 19:41:19 2004
+++ linux/kernel/module.c	Sun Apr 18 17:26:31 2004
@@ -36,7 +36,6 @@
 #include <linux/stop_machine.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 
 #if 0
diff -urpN orig/include/asm-arm26/tlb.h linux/include/asm-arm26/tlb.h
--- orig/include/asm-arm26/tlb.h	Sat Jun 14 22:34:36 2003
+++ linux/include/asm-arm26/tlb.h	Sun Apr 18 22:58:37 2004
@@ -1,6 +1,7 @@
 #ifndef __ASMARM_TLB_H
 #define __ASMARM_TLB_H
 
+#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 /*
diff -urpN orig/include/asm-generic/tlb.h linux/include/asm-generic/tlb.h
--- orig/include/asm-generic/tlb.h	Sat Feb 28 10:10:14 2004
+++ linux/include/asm-generic/tlb.h	Sun Apr 18 22:58:51 2004
@@ -15,6 +15,7 @@
 
 #include <linux/config.h>
 #include <linux/swap.h>
+#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 /*
diff -urpN orig/mm/highmem.c linux/mm/highmem.c
--- orig/mm/highmem.c	Thu Mar 11 09:57:01 2004
+++ linux/mm/highmem.c	Sun Apr 18 17:30:16 2004
@@ -26,7 +26,6 @@
 #include <linux/init.h>
 #include <linux/hash.h>
 #include <linux/highmem.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 static mempool_t *page_pool, *isa_page_pool;
diff -urpN orig/mm/mincore.c linux/mm/mincore.c
--- orig/mm/mincore.c	Thu Feb  5 15:27:04 2004
+++ linux/mm/mincore.c	Sun Apr 18 22:44:25 2004
@@ -14,7 +14,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 
 /*
  * Later we can get more picky about what "in core" means precisely.
diff -urpN orig/mm/mmap.c linux/mm/mmap.c
--- orig/mm/mmap.c	Tue Apr 13 19:41:20 2004
+++ linux/mm/mmap.c	Sun Apr 18 22:44:19 2004
@@ -23,7 +23,6 @@
 #include <linux/mount.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
 /*
diff -urpN orig/mm/mprotect.c linux/mm/mprotect.c
--- orig/mm/mprotect.c	Sat Apr 10 12:31:53 2004
+++ linux/mm/mprotect.c	Sun Apr 18 17:35:19 2004
@@ -18,7 +18,6 @@
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
diff -urpN orig/mm/mremap.c linux/mm/mremap.c
--- orig/mm/mremap.c	Tue Apr 13 19:41:20 2004
+++ linux/mm/mremap.c	Sun Apr 18 17:36:04 2004
@@ -19,7 +19,6 @@
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
diff -urpN orig/mm/msync.c linux/mm/msync.c
--- orig/mm/msync.c	Thu Feb  5 15:27:04 2004
+++ linux/mm/msync.c	Sun Apr 18 22:43:53 2004
@@ -13,7 +13,6 @@
 #include <linux/mman.h>
 
 #include <asm/pgtable.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 /*
diff -urpN orig/mm/nommu.c linux/mm/nommu.c
--- orig/mm/nommu.c	Tue Apr 13 19:41:20 2004
+++ linux/mm/nommu.c	Sun Apr 18 23:04:41 2004
@@ -20,7 +20,6 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 
-#include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
diff -urpN orig/mm/rmap.c linux/mm/rmap.c
--- orig/mm/rmap.c	Tue Apr 13 19:41:20 2004
+++ linux/mm/rmap.c	Sun Apr 18 22:43:45 2004
@@ -30,7 +30,6 @@
 #include <linux/cache.h>
 #include <linux/percpu.h>
 
-#include <asm/pgalloc.h>
 #include <asm/rmap.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
diff -urpN orig/mm/vmalloc.c linux/mm/vmalloc.c
--- orig/mm/vmalloc.c	Wed Feb 18 22:35:30 2004
+++ linux/mm/vmalloc.c	Sun Apr 18 22:46:15 2004
@@ -17,7 +17,6 @@
 #include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 
diff -urpN orig/mm/vmscan.c linux/mm/vmscan.c
--- orig/mm/vmscan.c	Tue Apr 13 19:41:20 2004
+++ linux/mm/vmscan.c	Sun Apr 18 17:28:19 2004
@@ -33,7 +33,6 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
