Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbUAMVd2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUAMVd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:33:28 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59094 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265529AbUAMVck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:32:40 -0500
Date: Tue, 13 Jan 2004 22:32:30 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: [2.6 patch] if ... BUG() -> BUG_ON()
Message-ID: <20040113213230.GY9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

four months ago, Rolf Eike Beer <eike-kernel@sf-tec.de> sent a patch 
against 2.6.0-test5-bk1 that converted several if ... BUG() to BUG_ON()
(this might in some cases result in slightly faster code).

Below are the parts of his patch that still apply against 2.6.1-mm2.

I've tested the compilation with 2.6.1-mm2.

diffstat output:

 include/asm-alpha/topology.h       |    3 +--
 include/asm-arm/arch-ebsa285/io.h  |    6 ++----
 include/asm-arm/arch-nexuspci/io.h |    3 +--
 include/asm-mips/dma-mapping.h     |   12 ++++--------
 include/asm-mips/pci.h             |    3 +--
 include/asm-parisc/mmu_context.h   |    5 ++---
 include/asm-parisc/tlbflush.h      |    2 +-
 include/asm-ppc/highmem.h          |    9 +++------
 include/asm-ppc/pci.h              |    9 +++------
 include/asm-ppc64/pci.h            |    6 ++----
 include/asm-ppc64/topology.h       |    3 +--
 include/asm-s390/idals.h           |    6 ++----
 include/asm-sh/spinlock.h          |    3 +--
 include/asm-sparc64/floppy.h       |    5 ++---
 include/asm-sparc64/tlbflush.h     |    3 +--
 include/asm-x86_64/pgalloc.h       |    9 +++------
 include/asm-x86_64/spinlock.h      |   18 ++++++------------
 include/linux/bio.h                |    3 +--
 include/linux/buffer_head.h        |    3 +--
 include/linux/dcache.h             |    3 +--
 include/linux/highmem.h            |    3 +--
 include/linux/netdevice.h          |    4 ++--
 include/linux/nfs_fs.h             |    3 +--
 include/linux/quotaops.h           |    6 ++----
 include/linux/smp_lock.h           |    3 +--
 include/net/sock.h                 |    4 ++--
 include/net/tcp.h                  |    2 +-
 include/rxrpc/call.h               |    3 +--
 include/rxrpc/connection.h         |    3 +--
 include/rxrpc/message.h            |    3 +--
 include/rxrpc/peer.h               |    3 +--
 include/rxrpc/transport.h          |    3 +--
 32 files changed, 54 insertions(+), 100 deletions(-)


Please apply
Adrian


diff -aur linux-2.6.0-test5-bk1/include/asm-alpha/topology.h linux-2.6.0-test5-bk1-caliban/include/asm-alpha/topology.h
--- linux-2.6.0-test5-bk1/include/asm-alpha/topology.h	2003-09-11 10:17:56.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-alpha/topology.h	2003-09-11 10:26:38.000000000 +0200
@@ -16,8 +16,7 @@
 	node = alpha_mv.cpuid_to_nid(cpu);
 
 #ifdef DEBUG_NUMA
-	if (node < 0)
-		BUG();
+	BUG_ON(node < 0);
 #endif
 
 	return node;
diff -aur linux-2.6.0-test5-bk1/include/asm-arm/arch-ebsa285/io.h linux-2.6.0-test5-bk1-caliban/include/asm-arm/arch-ebsa285/io.h
--- linux-2.6.0-test5-bk1/include/asm-arm/arch-ebsa285/io.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-arm/arch-ebsa285/io.h	2003-09-11 10:26:39.000000000 +0200
@@ -27,15 +27,13 @@
 
 static inline unsigned long ___mem_pci(unsigned long a)
 {
-	if (a <= 0xc0000000 || a >= 0xe0000000)
-		BUG();
+	BUG_ON(a <= 0xc0000000 || a >= 0xe0000000);
 	return a;
 }
 
 static inline unsigned long ___mem_isa(unsigned long a)
 {
-	if (a >= 16*1048576)
-		BUG();
+	BUG_ON(a >= 16*1048576);
 	return PCIMEM_BASE + a;
 }
 #define __mem_pci(a)		___mem_pci((unsigned long)(a))
diff -aur linux-2.6.0-test5-bk1/include/asm-arm/arch-nexuspci/io.h linux-2.6.0-test5-bk1-caliban/include/asm-arm/arch-nexuspci/io.h
--- linux-2.6.0-test5-bk1/include/asm-arm/arch-nexuspci/io.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-arm/arch-nexuspci/io.h	2003-09-11 10:26:39.000000000 +0200
@@ -28,8 +28,7 @@
 
 static inline unsigned long ___mem_isa(unsigned long a)
 {
-	if (a >= 16*1048576)
-		BUG();
+	BUG_ON(a >= 16*1048576);
 	return PCIMEM_BASE + a;
 }
 #define __mem_pci(a)		___mem_pci((unsigned long)(a))
diff -aur linux-2.6.0-test5-bk1/include/asm-mips/dma-mapping.h linux-2.6.0-test5-bk1-caliban/include/asm-mips/dma-mapping.h
--- linux-2.6.0-test5-bk1/include/asm-mips/dma-mapping.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-mips/dma-mapping.h	2003-09-11 10:26:39.000000000 +0200
@@ -124,8 +124,7 @@
 	for (i = 0; i < nhwentries; i++, sg++) {
 		unsigned long addr;
 
-		if (!sg->page)
-			BUG();
+		BUG_ON(!sg->page);
 
 		addr = (unsigned long) page_address(sg->page);
 		if (addr)
@@ -139,8 +138,7 @@
 {
 	unsigned long addr;
  
-	if (direction == DMA_NONE)
-		BUG();
+	BUG_ON(direction == DMA_NONE);
  
 	addr = baddr_to_bus(hwdev->bus, dma_handle) + PAGE_OFFSET;
 	dma_cache_wback_inv(addr, size);
@@ -153,8 +151,7 @@
 {
 	unsigned long addr;
 
-	if (direction == DMA_NONE)
-		BUG();
+	BUG_ON(direction == DMA_NONE);
 
 	addr = baddr_to_bus(hwdev->bus, dma_handle) + PAGE_OFFSET;
 	dma_cache_wback_inv(addr, size);
@@ -168,8 +165,7 @@
 	int i;
 #endif
  
-	if (direction == DMA_NONE)
-		BUG();
+	BUG_ON(direction == DMA_NONE);
  
 	/* Make sure that gcc doesn't leave the empty loop body.  */
 #ifdef CONFIG_NONCOHERENT_IO
diff -aur linux-2.6.0-test5-bk1/include/asm-mips/pci.h linux-2.6.0-test5-bk1-caliban/include/asm-mips/pci.h
--- linux-2.6.0-test5-bk1/include/asm-mips/pci.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-mips/pci.h	2003-09-11 10:26:39.000000000 +0200
@@ -113,8 +113,7 @@
 {
 	unsigned long addr;
 
-	if (direction == PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction == PCI_DMA_NONE);
 
 	addr = baddr_to_bus(pdev->bus, dma_addr) + PAGE_OFFSET;
 	dma_cache_wback_inv(addr, len);
diff -aur linux-2.6.0-test5-bk1/include/asm-parisc/mmu_context.h linux-2.6.0-test5-bk1-caliban/include/asm-parisc/mmu_context.h
--- linux-2.6.0-test5-bk1/include/asm-parisc/mmu_context.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-parisc/mmu_context.h	2003-09-11 10:26:39.000000000 +0200
@@ -19,8 +19,7 @@
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
-	if (atomic_read(&mm->mm_users) != 1)
-	    BUG();
+	BUG_ON(atomic_read(&mm->mm_users) != 1);
 
 	mm->context = alloc_sid();
 	return 0;
@@ -64,7 +63,7 @@
 	 * already, so we should be OK.
 	 */
 
-	if (next == &init_mm) BUG(); /* Should never happen */
+	BUG_ON(next == &init_mm); /* Should never happen */
 
 	if (next->context == 0)
 	    next->context = alloc_sid();
diff -aur linux-2.6.0-test5-bk1/include/asm-parisc/tlbflush.h linux-2.6.0-test5-bk1-caliban/include/asm-parisc/tlbflush.h
--- linux-2.6.0-test5-bk1/include/asm-parisc/tlbflush.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-parisc/tlbflush.h	2003-09-11 10:26:39.000000000 +0200
@@ -26,7 +26,7 @@
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
-	if (mm == &init_mm) BUG(); /* Should never happen */
+	BUG_ON(mm == &init_mm); /* Should never happen */
 
 #ifdef CONFIG_SMP
 	flush_tlb_all();
diff -aur linux-2.6.0-test5-bk1/include/asm-ppc/highmem.h linux-2.6.0-test5-bk1-caliban/include/asm-ppc/highmem.h
--- linux-2.6.0-test5-bk1/include/asm-ppc/highmem.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-ppc/highmem.h	2003-09-11 10:26:39.000000000 +0200
@@ -63,8 +63,7 @@
 
 static inline void kunmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 	if (page < highmem_start_page)
 		return;
 	kunmap_high(page);
@@ -88,8 +87,7 @@
 	idx = type + KM_TYPE_NR*smp_processor_id();
 	vaddr = KMAP_FIX_BEGIN + idx * PAGE_SIZE;
 #if HIGHMEM_DEBUG
-	if (!pte_none(*(kmap_pte+idx)))
-		BUG();
+	BUG_ON(!pte_none(*(kmap_pte+idx)));
 #endif
 	set_pte(kmap_pte+idx, mk_pte(page, kmap_prot));
 	flush_tlb_page(0, vaddr);
@@ -108,8 +106,7 @@
 		return;
 	}
 
-	if (vaddr != KMAP_FIX_BEGIN + idx * PAGE_SIZE)
-		BUG();
+	BUG_ON(vaddr != KMAP_FIX_BEGIN + idx * PAGE_SIZE);
 
 	/*
 	 * force other mappings to Oops if they'll try to access
diff -aur linux-2.6.0-test5-bk1/include/asm-ppc/pci.h linux-2.6.0-test5-bk1-caliban/include/asm-ppc/pci.h
--- linux-2.6.0-test5-bk1/include/asm-ppc/pci.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-ppc/pci.h	2003-09-11 10:26:39.000000000 +0200
@@ -105,8 +105,7 @@
 static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
 				    size_t size, int direction)
 {
-	if (direction == PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction == PCI_DMA_NONE);
 	/* nothing to do */
 }
 
@@ -134,8 +133,7 @@
 static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
 				  size_t size, int direction)
 {
-	if (direction == PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction == PCI_DMA_NONE);
 	/* Nothing to do */
 }
 
@@ -159,8 +157,7 @@
 {
 	int i;
 
-	if (direction == PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction == PCI_DMA_NONE);
 
 	/*
 	 * temporary 2.4 hack
diff -aur linux-2.6.0-test5-bk1/include/asm-ppc64/pci.h linux-2.6.0-test5-bk1-caliban/include/asm-ppc64/pci.h
--- linux-2.6.0-test5-bk1/include/asm-ppc64/pci.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-ppc64/pci.h	2003-09-11 10:26:39.000000000 +0200
@@ -62,8 +62,7 @@
 				       dma_addr_t dma_handle,
 				       size_t size, int direction)
 {
-	if (direction == PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction == PCI_DMA_NONE);
 	/* nothing to do */
 }
 
@@ -71,8 +70,7 @@
 				   struct scatterlist *sg,
 				   int nelems, int direction)
 {
-	if (direction == PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction == PCI_DMA_NONE);
 	/* nothing to do */
 }
 
diff -aur linux-2.6.0-test5-bk1/include/asm-ppc64/topology.h linux-2.6.0-test5-bk1-caliban/include/asm-ppc64/topology.h
--- linux-2.6.0-test5-bk1/include/asm-ppc64/topology.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-ppc64/topology.h	2003-09-11 10:26:39.000000000 +0200
@@ -13,8 +13,7 @@
 	node = numa_cpu_lookup_table[cpu];
 
 #ifdef DEBUG_NUMA
-	if (node == -1)
-		BUG();
+	BUG_ON(node == -1);
 #endif
 
 	return node;
diff -aur linux-2.6.0-test5-bk1/include/asm-s390/idals.h linux-2.6.0-test5-bk1-caliban/include/asm-s390/idals.h
--- linux-2.6.0-test5-bk1/include/asm-s390/idals.h	2003-09-11 10:17:58.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-s390/idals.h	2003-09-11 10:26:39.000000000 +0200
@@ -223,8 +223,7 @@
 	size_t left;
 	int i;
 
-	if (count > ib->size)
-		BUG();
+	BUG_ON(count > ib->size);
 	for (i = 0; count > IDA_BLOCK_SIZE; i++) {
 		left = copy_to_user(to, ib->data[i], IDA_BLOCK_SIZE);
 		if (left)
@@ -244,8 +243,7 @@
 	size_t left;
 	int i;
 
-	if (count > ib->size)
-		BUG();
+	BUG_ON(count > ib->size);
 	for (i = 0; count > IDA_BLOCK_SIZE; i++) {
 		left = copy_from_user(ib->data[i], from, IDA_BLOCK_SIZE);
 		if (left)
diff -aur linux-2.6.0-test5-bk1/include/asm-sh/spinlock.h linux-2.6.0-test5-bk1-caliban/include/asm-sh/spinlock.h
--- linux-2.6.0-test5-bk1/include/asm-sh/spinlock.h	2003-09-11 10:17:58.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-sh/spinlock.h	2003-09-11 10:26:39.000000000 +0200
@@ -48,8 +48,7 @@
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (!spin_is_locked(lock))
-		BUG();
+	BUG_ON(!spin_is_locked(lock));
 #endif
 
 	lock->lock = 0;
diff -aur linux-2.6.0-test5-bk1/include/asm-sparc64/floppy.h linux-2.6.0-test5-bk1-caliban/include/asm-sparc64/floppy.h
--- linux-2.6.0-test5-bk1/include/asm-sparc64/floppy.h	2003-09-11 10:17:58.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-sparc64/floppy.h	2003-09-11 10:26:39.000000000 +0200
@@ -332,10 +332,9 @@
 
 static void sun_pci_fd_enable_dma(void)
 {
-	if ((NULL == sun_pci_dma_pending.buf) 	||
+	BUG_ON((NULL == sun_pci_dma_pending.buf) 	||
 	    (0	  == sun_pci_dma_pending.len) 	||
-	    (0	  == sun_pci_dma_pending.direction))
-		BUG();
+	    (0	  == sun_pci_dma_pending.direction));
 
 	sun_pci_dma_current.buf = sun_pci_dma_pending.buf;
 	sun_pci_dma_current.len = sun_pci_dma_pending.len;
diff -aur linux-2.6.0-test5-bk1/include/asm-sparc64/tlbflush.h linux-2.6.0-test5-bk1-caliban/include/asm-sparc64/tlbflush.h
--- linux-2.6.0-test5-bk1/include/asm-sparc64/tlbflush.h	2003-09-11 10:17:58.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-sparc64/tlbflush.h	2003-09-11 10:26:39.000000000 +0200
@@ -91,10 +91,9 @@
 {
 	/* Note the signed type.  */
 	long s = start, e = end, vpte_base;
-	if (s > e)
 		/* Nobody should call us with start below VM hole and end above.
 		   See if it is really true.  */
-		BUG();
+	BUG_ON(s > e);
 #if 0
 	/* Currently free_pgtables guarantees this.  */
 	s &= PMD_MASK;
diff -aur linux-2.6.0-test5-bk1/include/asm-x86_64/pgalloc.h linux-2.6.0-test5-bk1-caliban/include/asm-x86_64/pgalloc.h
--- linux-2.6.0-test5-bk1/include/asm-x86_64/pgalloc.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-x86_64/pgalloc.h	2003-09-11 10:26:39.000000000 +0200
@@ -24,8 +24,7 @@
 
 extern __inline__ void pmd_free(pmd_t *pmd)
 {
-	if ((unsigned long)pmd & (PAGE_SIZE-1)) 
-		BUG(); 
+	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
 	free_page((unsigned long)pmd);
 }
 
@@ -41,8 +40,7 @@
 
 static inline void pgd_free (pgd_t *pgd)
 {
-	if ((unsigned long)pgd & (PAGE_SIZE-1)) 
-		BUG(); 
+	BUG_ON((unsigned long)pgd & (PAGE_SIZE-1));
 	free_page((unsigned long)pgd);
 }
 
@@ -64,8 +62,7 @@
 
 extern __inline__ void pte_free_kernel(pte_t *pte)
 {
-	if ((unsigned long)pte & (PAGE_SIZE-1))
-		BUG();
+	BUG_ON((unsigned long)pte & (PAGE_SIZE-1));
 	free_page((unsigned long)pte); 
 }
 
diff -aur linux-2.6.0-test5-bk1/include/asm-x86_64/spinlock.h linux-2.6.0-test5-bk1-caliban/include/asm-x86_64/spinlock.h
--- linux-2.6.0-test5-bk1/include/asm-x86_64/spinlock.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/asm-x86_64/spinlock.h	2003-09-11 10:26:39.000000000 +0200
@@ -70,10 +70,8 @@
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (lock->magic != SPINLOCK_MAGIC)
-		BUG();
-	if (!spin_is_locked(lock))
-		BUG();
+	BUG_ON(lock->magic != SPINLOCK_MAGIC);
+	BUG_ON(!spin_is_locked(lock));
 #endif
 	__asm__ __volatile__(
 		spin_unlock_string
@@ -91,10 +89,8 @@
 {
 	char oldval = 1;
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (lock->magic != SPINLOCK_MAGIC)
-		BUG();
-	if (!spin_is_locked(lock))
-		BUG();
+	BUG_ON(lock->magic != SPINLOCK_MAGIC);
+	BUG_ON(!spin_is_locked(lock));
 #endif
 	__asm__ __volatile__(
 		spin_unlock_string
@@ -174,8 +170,7 @@
 static inline void _raw_read_lock(rwlock_t *rw)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (rw->magic != RWLOCK_MAGIC)
-		BUG();
+	BUG_ON(rw->magic != RWLOCK_MAGIC);
 #endif
 	__build_read_lock(rw, "__read_lock_failed");
 }
@@ -183,8 +178,7 @@
 static inline void _raw_write_lock(rwlock_t *rw)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (rw->magic != RWLOCK_MAGIC)
-		BUG();
+	BUG_ON(rw->magic != RWLOCK_MAGIC);
 #endif
 	__build_write_lock(rw, "__write_lock_failed");
 }
diff -aur linux-2.6.0-test5-bk1/include/linux/bio.h linux-2.6.0-test5-bk1-caliban/include/linux/bio.h
--- linux-2.6.0-test5-bk1/include/linux/bio.h	2003-09-11 10:17:53.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/linux/bio.h	2003-09-11 10:26:39.000000000 +0200
@@ -267,8 +267,7 @@
 	local_irq_save(*flags);
 	addr = (unsigned long) kmap_atomic(bvec->bv_page, KM_BIO_SRC_IRQ);
 
-	if (addr & ~PAGE_MASK)
-		BUG();
+	BUG_ON(addr & ~PAGE_MASK);
 
 	return (char *) addr + bvec->bv_offset;
 }
diff -aur linux-2.6.0-test5-bk1/include/linux/buffer_head.h linux-2.6.0-test5-bk1-caliban/include/linux/buffer_head.h
--- linux-2.6.0-test5-bk1/include/linux/buffer_head.h	2003-09-11 10:17:53.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/linux/buffer_head.h	2003-09-11 10:26:39.000000000 +0200
@@ -125,8 +125,7 @@
 /* If we *know* page->private refers to buffer_heads */
 #define page_buffers(page)					\
 	({							\
-		if (!PagePrivate(page))				\
-			BUG();					\
+		BUG_ON(!PagePrivate(page));		\
 		((struct buffer_head *)(page)->private);	\
 	})
 #define page_has_buffers(page)	PagePrivate(page)
diff -aur linux-2.6.0-test5-bk1/include/linux/dcache.h linux-2.6.0-test5-bk1-caliban/include/linux/dcache.h
--- linux-2.6.0-test5-bk1/include/linux/dcache.h	2003-09-11 10:17:53.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/linux/dcache.h	2003-09-11 10:26:39.000000000 +0200
@@ -270,8 +270,7 @@
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry) {
-		if (!atomic_read(&dentry->d_count))
-			BUG();
+		BUG_ON(!atomic_read(&dentry->d_count));
 		atomic_inc(&dentry->d_count);
 	}
 	return dentry;
diff -aur linux-2.6.0-test5-bk1/include/linux/highmem.h linux-2.6.0-test5-bk1-caliban/include/linux/highmem.h
--- linux-2.6.0-test5-bk1/include/linux/highmem.h	2003-09-11 10:17:53.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/linux/highmem.h	2003-09-11 10:26:39.000000000 +0200
@@ -56,8 +56,7 @@
 {
 	void *kaddr;
 
-	if (offset + size > PAGE_SIZE)
-		BUG();
+	BUG_ON(offset + size > PAGE_SIZE);
 
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset((char *)kaddr + offset, 0, size);
diff -aur linux-2.6.0-test5-bk1/include/linux/netdevice.h linux-2.6.0-test5-bk1-caliban/include/linux/netdevice.h
--- linux-2.6.0-test5-bk1/include/linux/netdevice.h	2003-09-11 10:17:53.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/linux/netdevice.h	2003-09-11 10:26:39.000000000 +0200
@@ -823,7 +823,7 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if (!test_bit(__LINK_STATE_RX_SCHED, &dev->state)) BUG();
+	BUG_ON(!test_bit(__LINK_STATE_RX_SCHED, &dev->state));
 	list_del(&dev->poll_list);
 	smp_mb__before_clear_bit();
 	clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
@@ -849,7 +849,7 @@
  */
 static inline void __netif_rx_complete(struct net_device *dev)
 {
-	if (!test_bit(__LINK_STATE_RX_SCHED, &dev->state)) BUG();
+	BUG_ON(!test_bit(__LINK_STATE_RX_SCHED, &dev->state));
 	list_del(&dev->poll_list);
 	smp_mb__before_clear_bit();
 	clear_bit(__LINK_STATE_RX_SCHED, &dev->state);
diff -aur linux-2.6.0-test5-bk1/include/linux/nfs_fs.h linux-2.6.0-test5-bk1-caliban/include/linux/nfs_fs.h
--- linux-2.6.0-test5-bk1/include/linux/nfs_fs.h	2003-09-11 10:17:53.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/linux/nfs_fs.h	2003-09-11 10:26:39.000000000 +0200
@@ -262,8 +262,7 @@
 	if (file)
 		cred = (struct rpc_cred *)file->private_data;
 #ifdef RPC_DEBUG
-	if (cred && cred->cr_magic != RPCAUTH_CRED_MAGIC)
-		BUG();
+	BUG_ON(cred && cred->cr_magic != RPCAUTH_CRED_MAGIC);
 #endif
 	return cred;
 }
diff -aur linux-2.6.0-test5-bk1/include/linux/quotaops.h linux-2.6.0-test5-bk1-caliban/include/linux/quotaops.h
--- linux-2.6.0-test5-bk1/include/linux/quotaops.h	2003-09-11 10:17:53.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/linux/quotaops.h	2003-09-11 10:26:39.000000000 +0200
@@ -44,8 +44,7 @@
 
 static __inline__ void DQUOT_INIT(struct inode *inode)
 {
-	if (!inode->i_sb)
-		BUG();
+	BUG_ON(!inode->i_sb);
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
 		inode->i_sb->dq_op->initialize(inode, -1);
 }
@@ -53,8 +52,7 @@
 static __inline__ void DQUOT_DROP(struct inode *inode)
 {
 	if (IS_QUOTAINIT(inode)) {
-		if (!inode->i_sb)
-			BUG();
+		BUG_ON(!inode->i_sb);
 		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
 	}
 }
diff -aur linux-2.6.0-test5-bk1/include/linux/smp_lock.h linux-2.6.0-test5-bk1-caliban/include/linux/smp_lock.h
--- linux-2.6.0-test5-bk1/include/linux/smp_lock.h	2003-09-11 10:17:53.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/linux/smp_lock.h	2003-09-11 10:26:39.000000000 +0200
@@ -49,8 +49,7 @@
 
 static inline void unlock_kernel(void)
 {
-	if (unlikely(current->lock_depth < 0))
-		BUG();
+	BUG_ON(current->lock_depth < 0);
 	if (likely(--current->lock_depth < 0))
 		put_kernel_lock();
 }
diff -aur linux-2.6.0-test5-bk1/include/net/sock.h linux-2.6.0-test5-bk1-caliban/include/net/sock.h
--- linux-2.6.0-test5-bk1/include/net/sock.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/net/sock.h	2003-09-11 10:26:39.000000000 +0200
@@ -455,8 +455,8 @@
 	 * change the ownership of this struct sock, with one not needed
 	 * transient sk_set_owner call.
 	 */
-	if (unlikely(sk->sk_owner != NULL))
-		BUG();
+	BUG_ON(sk->sk_owner != NULL);
+
 	sk->sk_owner = owner;
 	__module_get(owner);
 }
diff -aur linux-2.6.0-test5-bk1/include/net/tcp.h linux-2.6.0-test5-bk1-caliban/include/net/tcp.h
--- linux-2.6.0-test5-bk1/include/net/tcp.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/net/tcp.h	2003-09-11 10:26:39.000000000 +0200
@@ -1424,7 +1424,7 @@
 		if (tp->ucopy.memory > sk->sk_rcvbuf) {
 			struct sk_buff *skb1;
 
-			if (sock_owned_by_user(sk)) BUG();
+			BUG_ON(sock_owned_by_user(sk));
 
 			while ((skb1 = __skb_dequeue(&tp->ucopy.prequeue)) != NULL) {
 				sk->sk_backlog_rcv(sk, skb1);
diff -aur linux-2.6.0-test5-bk1/include/rxrpc/call.h linux-2.6.0-test5-bk1-caliban/include/rxrpc/call.h
--- linux-2.6.0-test5-bk1/include/rxrpc/call.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/rxrpc/call.h	2003-09-11 10:26:39.000000000 +0200
@@ -187,8 +187,7 @@
 
 static inline void rxrpc_get_call(struct rxrpc_call *call)
 {
-	if (atomic_read(&call->usage)<=0)
-		BUG();
+	BUG_ON(atomic_read(&call->usage)<=0);
 	atomic_inc(&call->usage);
 	/*printk("rxrpc_get_call(%p{u=%d})\n",(C),atomic_read(&(C)->usage));*/
 }
diff -aur linux-2.6.0-test5-bk1/include/rxrpc/connection.h linux-2.6.0-test5-bk1-caliban/include/rxrpc/connection.h
--- linux-2.6.0-test5-bk1/include/rxrpc/connection.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/rxrpc/connection.h	2003-09-11 10:26:39.000000000 +0200
@@ -67,8 +67,7 @@
 
 static inline void rxrpc_get_connection(struct rxrpc_connection *conn)
 {
-	if (atomic_read(&conn->usage)<0)
-		BUG();
+	BUG_ON(atomic_read(&conn->usage)<0);
 	atomic_inc(&conn->usage);
 	//printk("rxrpc_get_conn(%p{u=%d})\n",conn,atomic_read(&conn->usage));
 }
diff -aur linux-2.6.0-test5-bk1/include/rxrpc/message.h linux-2.6.0-test5-bk1-caliban/include/rxrpc/message.h
--- linux-2.6.0-test5-bk1/include/rxrpc/message.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/rxrpc/message.h	2003-09-11 10:26:39.000000000 +0200
@@ -53,8 +53,7 @@
 extern void __rxrpc_put_message(struct rxrpc_message *msg);
 static inline void rxrpc_put_message(struct rxrpc_message *msg)
 {
-	if (atomic_read(&msg->usage)<=0)
-		BUG();
+	BUG_ON(atomic_read(&msg->usage)<=0);
 	if (atomic_dec_and_test(&msg->usage))
 		__rxrpc_put_message(msg);
 }
diff -aur linux-2.6.0-test5-bk1/include/rxrpc/peer.h linux-2.6.0-test5-bk1-caliban/include/rxrpc/peer.h
--- linux-2.6.0-test5-bk1/include/rxrpc/peer.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/rxrpc/peer.h	2003-09-11 10:26:39.000000000 +0200
@@ -72,8 +72,7 @@
 
 static inline void rxrpc_get_peer(struct rxrpc_peer *peer)
 {
-	if (atomic_read(&peer->usage)<0)
-		BUG();
+	BUG_ON(atomic_read(&peer->usage)<0);
 	atomic_inc(&peer->usage);
 	//printk("rxrpc_get_peer(%p{u=%d})\n",peer,atomic_read(&peer->usage));
 }
diff -aur linux-2.6.0-test5-bk1/include/rxrpc/transport.h linux-2.6.0-test5-bk1-caliban/include/rxrpc/transport.h
--- linux-2.6.0-test5-bk1/include/rxrpc/transport.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk1-caliban/include/rxrpc/transport.h	2003-09-11 10:27:28.000000000 +0200
@@ -85,8 +85,7 @@
 
 static inline void rxrpc_get_transport(struct rxrpc_transport *trans)
 {
-	if (atomic_read(&trans->usage) <= 0)
-		BUG();
+	BUG_ON(atomic_read(&trans->usage) <= 0);
 	atomic_inc(&trans->usage);
 	//printk("rxrpc_get_transport(%p{u=%d})\n",
 	//       trans, atomic_read(&trans->usage));
