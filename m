Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTIXKua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 06:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbTIXKua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 06:50:30 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:65468 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261178AbTIXKuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 06:50:17 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] if(foo) BUG() -> BUG_ON(foo) for include/arch/
Date: Wed, 24 Sep 2003 12:52:54 +0200
User-Agent: KMail/1.5.3
References: <200309241233.09877@bilbo.math.uni-mannheim.de> <200309241234.58125@bilbo.math.uni-mannheim.de> <200309241236.31384@bilbo.math.uni-mannheim.de>
In-Reply-To: <200309241236.31384@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309241252.54097@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, last one. I'm too lazy to look who is responsible for each
part, so see it as FYI. If someone feels responsible for parts of this just
copy the relevant parts to the arch maintainers.

Eike

diff -aur linux-2.6.0-test5-bk6/include/asm-alpha/topology.h linux-2.6.0-test5-bk6-caliban/include/asm-alpha/topology.h
--- linux-2.6.0-test5-bk6/include/asm-alpha/topology.h	2003-09-11 10:17:56.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-alpha/topology.h	2003-09-11 10:26:38.000000000 +0200
@@ -16,8 +16,7 @@
 	node = alpha_mv.cpuid_to_nid(cpu);
 
 #ifdef DEBUG_NUMA
-	if (node < 0)
-		BUG();
+	BUG_ON(node < 0);
 #endif
 
 	return node;
diff -aur linux-2.6.0-test5-bk6/include/asm-arm/arch-ebsa285/io.h linux-2.6.0-test5-bk6-caliban/include/asm-arm/arch-ebsa285/io.h
--- linux-2.6.0-test5-bk6/include/asm-arm/arch-ebsa285/io.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-arm/arch-ebsa285/io.h	2003-09-11 10:26:39.000000000 +0200
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
diff -aur linux-2.6.0-test5-bk6/include/asm-arm/arch-nexuspci/io.h linux-2.6.0-test5-bk6-caliban/include/asm-arm/arch-nexuspci/io.h
--- linux-2.6.0-test5-bk6/include/asm-arm/arch-nexuspci/io.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-arm/arch-nexuspci/io.h	2003-09-11 10:26:39.000000000 +0200
@@ -28,8 +28,7 @@
 
 static inline unsigned long ___mem_isa(unsigned long a)
 {
-	if (a >= 16*1048576)
-		BUG();
+	BUG_ON(a >= 16*1048576);
 	return PCIMEM_BASE + a;
 }
 #define __mem_pci(a)		___mem_pci((unsigned long)(a))
diff -aur linux-2.6.0-test5-bk6/include/asm-mips/dma-mapping.h linux-2.6.0-test5-bk6-caliban/include/asm-mips/dma-mapping.h
--- linux-2.6.0-test5-bk6/include/asm-mips/dma-mapping.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-mips/dma-mapping.h	2003-09-11 10:26:39.000000000 +0200
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
diff -aur linux-2.6.0-test5-bk6/include/asm-mips/pci.h linux-2.6.0-test5-bk6-caliban/include/asm-mips/pci.h
--- linux-2.6.0-test5-bk6/include/asm-mips/pci.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-mips/pci.h	2003-09-11 10:26:39.000000000 +0200
@@ -113,8 +113,7 @@
 {
 	unsigned long addr;
 
-	if (direction == PCI_DMA_NONE)
-		BUG();
+	BUG_ON(direction == PCI_DMA_NONE);
 
 	addr = baddr_to_bus(pdev->bus, dma_addr) + PAGE_OFFSET;
 	dma_cache_wback_inv(addr, len);
diff -aur linux-2.6.0-test5-bk6/include/asm-parisc/mmu_context.h linux-2.6.0-test5-bk6-caliban/include/asm-parisc/mmu_context.h
--- linux-2.6.0-test5-bk6/include/asm-parisc/mmu_context.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-parisc/mmu_context.h	2003-09-11 10:26:39.000000000 +0200
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
diff -aur linux-2.6.0-test5-bk6/include/asm-parisc/tlbflush.h linux-2.6.0-test5-bk6-caliban/include/asm-parisc/tlbflush.h
--- linux-2.6.0-test5-bk6/include/asm-parisc/tlbflush.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-parisc/tlbflush.h	2003-09-11 10:26:39.000000000 +0200
@@ -26,7 +26,7 @@
 
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
-	if (mm == &init_mm) BUG(); /* Should never happen */
+	BUG_ON(mm == &init_mm); /* Should never happen */
 
 #ifdef CONFIG_SMP
 	flush_tlb_all();
diff -aur linux-2.6.0-test5-bk6/include/asm-ppc/highmem.h linux-2.6.0-test5-bk6-caliban/include/asm-ppc/highmem.h
--- linux-2.6.0-test5-bk6/include/asm-ppc/highmem.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-ppc/highmem.h	2003-09-11 10:26:39.000000000 +0200
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
diff -aur linux-2.6.0-test5-bk6/include/asm-ppc/pci.h linux-2.6.0-test5-bk6-caliban/include/asm-ppc/pci.h
--- linux-2.6.0-test5-bk6/include/asm-ppc/pci.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-ppc/pci.h	2003-09-11 10:26:39.000000000 +0200
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
diff -aur linux-2.6.0-test5-bk6/include/asm-ppc64/pci.h linux-2.6.0-test5-bk6-caliban/include/asm-ppc64/pci.h
--- linux-2.6.0-test5-bk6/include/asm-ppc64/pci.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-ppc64/pci.h	2003-09-11 10:26:39.000000000 +0200
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
 
diff -aur linux-2.6.0-test5-bk6/include/asm-ppc64/topology.h linux-2.6.0-test5-bk6-caliban/include/asm-ppc64/topology.h
--- linux-2.6.0-test5-bk6/include/asm-ppc64/topology.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-ppc64/topology.h	2003-09-11 10:26:39.000000000 +0200
@@ -13,8 +13,7 @@
 	node = numa_cpu_lookup_table[cpu];
 
 #ifdef DEBUG_NUMA
-	if (node == -1)
-		BUG();
+	BUG_ON(node == -1);
 #endif
 
 	return node;
diff -aur linux-2.6.0-test5-bk6/include/asm-s390/idals.h linux-2.6.0-test5-bk6-caliban/include/asm-s390/idals.h
--- linux-2.6.0-test5-bk6/include/asm-s390/idals.h	2003-09-11 10:17:58.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-s390/idals.h	2003-09-11 10:26:39.000000000 +0200
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
diff -aur linux-2.6.0-test5-bk6/include/asm-sh/spinlock.h linux-2.6.0-test5-bk6-caliban/include/asm-sh/spinlock.h
--- linux-2.6.0-test5-bk6/include/asm-sh/spinlock.h	2003-09-11 10:17:58.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-sh/spinlock.h	2003-09-11 10:26:39.000000000 +0200
@@ -48,8 +48,7 @@
 static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if (!spin_is_locked(lock))
-		BUG();
+	BUG_ON(!spin_is_locked(lock));
 #endif
 
 	lock->lock = 0;
diff -aur linux-2.6.0-test5-bk6/include/asm-sparc/highmem.h linux-2.6.0-test5-bk6-caliban/include/asm-sparc/highmem.h
--- linux-2.6.0-test5-bk6/include/asm-sparc/highmem.h	2003-09-11 10:17:56.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-sparc/highmem.h	2003-09-11 10:26:39.000000000 +0200
@@ -57,8 +57,7 @@
 
 static inline void *kmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 	if (page < highmem_start_page)
 		return page_address(page);
 	return kmap_high(page);
@@ -66,8 +65,7 @@
 
 static inline void kunmap(struct page *page)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 	if (page < highmem_start_page)
 		return;
 	kunmap_high(page);
diff -aur linux-2.6.0-test5-bk6/include/asm-sparc64/floppy.h linux-2.6.0-test5-bk6-caliban/include/asm-sparc64/floppy.h
--- linux-2.6.0-test5-bk6/include/asm-sparc64/floppy.h	2003-09-11 10:17:58.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-sparc64/floppy.h	2003-09-11 10:26:39.000000000 +0200
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
@@ -352,10 +351,9 @@
 			       sun_pci_dma_current.len,
 			       sun_pci_dma_current.direction);
 
-	if (ebus_dma_request(&sun_pci_fd_ebus_dma,
+	BUG_ON(ebus_dma_request(&sun_pci_fd_ebus_dma,
 			     sun_pci_dma_current.addr,
-			     sun_pci_dma_current.len))
-		BUG();
+			     sun_pci_dma_current.len));
 
 	ebus_dma_enable(&sun_pci_fd_ebus_dma, 1);
 }
diff -aur linux-2.6.0-test5-bk6/include/asm-sparc64/tlbflush.h linux-2.6.0-test5-bk6-caliban/include/asm-sparc64/tlbflush.h
--- linux-2.6.0-test5-bk6/include/asm-sparc64/tlbflush.h	2003-09-11 10:17:58.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-sparc64/tlbflush.h	2003-09-11 10:26:39.000000000 +0200
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
diff -aur linux-2.6.0-test5-bk6/include/asm-x86_64/pgalloc.h linux-2.6.0-test5-bk6-caliban/include/asm-x86_64/pgalloc.h
--- linux-2.6.0-test5-bk6/include/asm-x86_64/pgalloc.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-x86_64/pgalloc.h	2003-09-11 10:26:39.000000000 +0200
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
 
diff -aur linux-2.6.0-test5-bk6/include/asm-x86_64/spinlock.h linux-2.6.0-test5-bk6-caliban/include/asm-x86_64/spinlock.h
--- linux-2.6.0-test5-bk6/include/asm-x86_64/spinlock.h	2003-09-11 10:17:54.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/asm-x86_64/spinlock.h	2003-09-11 10:26:39.000000000 +0200
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
