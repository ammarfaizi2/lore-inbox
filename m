Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUHSANX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUHSANX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 20:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUHSANW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 20:13:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30606 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267660AbUHSAKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 20:10:23 -0400
Date: Wed, 18 Aug 2004 17:07:15 -0700
From: "David S. Miller" <davem@redhat.com>
To: joshk@triplehelix.org (Joshua Kwan)
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] busybox EFAULT on sparc64
Message-Id: <20040818170715.2c31b4b9.davem@redhat.com>
In-Reply-To: <20040818235528.GA8070@triplehelix.org>
References: <20040818235528.GA8070@triplehelix.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just for fishing around purposes, does this patch fix the problem
for you?

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/14 22:21:11-07:00 davem@nuts.davemloft.net 
#   [MM]: Make set_pte() take mm and address arguments.
#   
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# mm/vmalloc.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +2 -2
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/swapfile.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +2 -1
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/rmap.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +2 -2
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/mremap.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +1 -1
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/mprotect.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +8 -8
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/memory.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +22 -19
#   [MM]: Make set_pte() take mm and address arguments.
# 
# mm/fremap.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +3 -3
#   [MM]: Make set_pte() take mm and address arguments.
# 
# include/asm-sparc64/pgtable.h
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +6 -4
#   [MM]: Make set_pte() take mm and address arguments.
# 
# include/asm-sparc64/pgalloc.h
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +5 -15
#   [MM]: Make set_pte() take mm and address arguments.
# 
# include/asm-generic/pgtable.h
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +38 -37
#   [MM]: Make set_pte() take mm and address arguments.
# 
# fs/exec.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +1 -1
#   [MM]: Make set_pte() take mm and address arguments.
# 
# arch/sparc64/mm/tlb.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +7 -10
#   [MM]: Make set_pte() take mm and address arguments.
# 
# arch/sparc64/mm/init.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +2 -1
#   [MM]: Make set_pte() take mm and address arguments.
# 
# arch/sparc64/mm/hugetlbpage.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +15 -7
#   [MM]: Make set_pte() take mm and address arguments.
# 
# arch/sparc64/mm/generic.c
#   2004/08/14 22:20:36-07:00 davem@nuts.davemloft.net +17 -8
#   [MM]: Make set_pte() take mm and address arguments.
# 
diff -Nru a/arch/sparc64/mm/generic.c b/arch/sparc64/mm/generic.c
--- a/arch/sparc64/mm/generic.c	2004-08-18 15:30:39 -07:00
+++ b/arch/sparc64/mm/generic.c	2004-08-18 15:30:39 -07:00
@@ -33,8 +33,12 @@
  * side-effect bit will be turned off.  This is used as a
  * performance improvement on FFB/AFB. -DaveM
  */
-static inline void io_remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long offset, pgprot_t prot, int space)
+static inline void io_remap_pte_range(struct mm_struct *mm, pte_t * pte,
+				      unsigned long address,
+				      unsigned long size,
+				      unsigned long offset,
+				      pgprot_t prot,
+				      int space)
 {
 	unsigned long end;
 
@@ -76,8 +80,8 @@
 			pte_val(entry) &= ~(_PAGE_E);
 		do {
 			oldpage = *pte;
-			pte_clear(pte);
-			set_pte(pte, entry);
+			pte_clear(mm, address, pte);
+			set_pte(mm, address, pte, entry);
 			forget_pte(oldpage);
 			address += PAGE_SIZE;
 			pte++;
@@ -85,8 +89,12 @@
 	} while (address < end);
 }
 
-static inline int io_remap_pmd_range(pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long offset, pgprot_t prot, int space)
+static inline int io_remap_pmd_range(struct mm_struct *mm, pmd_t * pmd,
+				     unsigned long address,
+				     unsigned long size,
+				     unsigned long offset,
+				     pgprot_t prot,
+				     int space)
 {
 	unsigned long end;
 
@@ -99,7 +107,7 @@
 		pte_t * pte = pte_alloc_map(current->mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
-		io_remap_pte_range(pte, address, end - address, address + offset, prot, space);
+		io_remap_pte_range(mm, pte, address, end - address, address + offset, prot, space);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -126,7 +134,8 @@
 		error = -ENOMEM;
 		if (!pmd)
 			break;
-		error = io_remap_pmd_range(pmd, from, end - from, offset + from, prot, space);
+		error = io_remap_pmd_range(mm, pmd, from, end - from,
+					   offset + from, prot, space);
 		if (error)
 			break;
 		from = (from + PGDIR_SIZE) & PGDIR_MASK;
diff -Nru a/arch/sparc64/mm/hugetlbpage.c b/arch/sparc64/mm/hugetlbpage.c
--- a/arch/sparc64/mm/hugetlbpage.c	2004-08-18 15:30:39 -07:00
+++ b/arch/sparc64/mm/hugetlbpage.c	2004-08-18 15:30:39 -07:00
@@ -53,8 +53,12 @@
 
 #define mk_pte_huge(entry) do { pte_val(entry) |= _PAGE_SZHUGE; } while (0)
 
-static void set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct page *page, pte_t * page_table, int write_access)
+static void set_huge_pte(struct mm_struct *mm,
+			 unsigned long addr,
+			 struct vm_area_struct *vma,
+			 struct page *page,
+			 pte_t *page_table,
+			 int write_access)
 {
 	unsigned long i;
 	pte_t entry;
@@ -70,7 +74,7 @@
 	mk_pte_huge(entry);
 
 	for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-		set_pte(page_table, entry);
+		set_pte(mm, addr, page_table, entry);
 		page_table++;
 
 		pte_val(entry) += PAGE_SIZE;
@@ -108,12 +112,12 @@
 		ptepage = pte_page(entry);
 		get_page(ptepage);
 		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			set_pte(dst_pte, entry);
+			set_pte(dst, addr, dst_pte, entry);
 			pte_val(entry) += PAGE_SIZE;
 			dst_pte++;
+			addr += PAGE_SIZE;
 		}
 		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
 	}
 	return 0;
 
@@ -192,6 +196,8 @@
 	BUG_ON(end & (HPAGE_SIZE - 1));
 
 	for (address = start; address < end; address += HPAGE_SIZE) {
+		unsigned long addr = address;
+
 		pte = huge_pte_offset(mm, address);
 		BUG_ON(!pte);
 		if (pte_none(*pte))
@@ -199,8 +205,9 @@
 		page = pte_page(*pte);
 		put_page(page);
 		for (i = 0; i < (1 << HUGETLB_PAGE_ORDER); i++) {
-			pte_clear(pte);
+			pte_clear(mm, addr, pte);
 			pte++;
+			addr += PAGE_SIZE;
 		}
 	}
 	mm->rss -= (end - start) >> PAGE_SHIFT;
@@ -253,7 +260,8 @@
 				goto out;
 			}
 		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		set_huge_pte(mm, addr, vma, page, pte,
+			     vma->vm_flags & VM_WRITE);
 	}
 out:
 	spin_unlock(&mm->page_table_lock);
diff -Nru a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
--- a/arch/sparc64/mm/init.c	2004-08-18 15:30:39 -07:00
+++ b/arch/sparc64/mm/init.c	2004-08-18 15:30:39 -07:00
@@ -430,7 +430,8 @@
 				if (tlb_type == spitfire)
 					val &= ~0x0003fe0000000000UL;
 
-				set_pte (ptep, __pte(val | _PAGE_MODIFIED));
+				set_pte(&init_mm, vaddr,
+					ptep, __pte(val | _PAGE_MODIFIED));
 				trans[i].data += BASE_PAGE_SIZE;
 			}
 		}
diff -Nru a/arch/sparc64/mm/tlb.c b/arch/sparc64/mm/tlb.c
--- a/arch/sparc64/mm/tlb.c	2004-08-18 15:30:39 -07:00
+++ b/arch/sparc64/mm/tlb.c	2004-08-18 15:30:39 -07:00
@@ -41,15 +41,11 @@
 	}
 }
 
-void tlb_batch_add(pte_t *ptep, pte_t orig)
+void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
+		   pte_t *ptep, pte_t orig)
 {
-	struct mmu_gather *mp = &__get_cpu_var(mmu_gathers);
-	struct page *ptepage;
-	struct mm_struct *mm;
-	unsigned long vaddr, nr;
-
-	ptepage = virt_to_page(ptep);
-	mm = (struct mm_struct *) ptepage->mapping;
+	struct mmu_gather *mp;
+	unsigned long nr;
 
 	/* It is more efficient to let flush_tlb_kernel_range()
 	 * handle these cases.
@@ -57,8 +53,9 @@
 	if (mm == &init_mm)
 		return;
 
-	vaddr = ptepage->index +
-		(((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE);
+	mp = &__get_cpu_var(mmu_gathers);
+
+	vaddr &= PAGE_MASK;
 	if (pte_exec(orig))
 		vaddr |= 0x1UL;
 
diff -Nru a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	2004-08-18 15:30:39 -07:00
+++ b/fs/exec.c	2004-08-18 15:30:39 -07:00
@@ -321,7 +321,7 @@
 	}
 	mm->rss++;
 	lru_cache_add_active(page);
-	set_pte(pte, pte_mkdirty(pte_mkwrite(mk_pte(
+	set_pte(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
 	page_add_anon_rmap(page, vma, address);
 	pte_unmap(pte);
diff -Nru a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
--- a/include/asm-generic/pgtable.h	2004-08-18 15:30:39 -07:00
+++ b/include/asm-generic/pgtable.h	2004-08-18 15:30:39 -07:00
@@ -15,7 +15,7 @@
  */
 #define ptep_establish(__vma, __address, __ptep, __entry)		\
 do {				  					\
-	set_pte(__ptep, __entry);					\
+	set_pte((__vma)->vm_mm, (__address), __ptep, __entry);		\
 	flush_tlb_page(__vma, __address);				\
 } while (0)
 #endif
@@ -29,26 +29,30 @@
  */
 #define ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
 do {				  					  \
-	set_pte(__ptep, __entry);					  \
+	set_pte((__vma)->vm_mm, (__address), __ptep, __entry);		  \
 	flush_tlb_page(__vma, __address);				  \
 } while (0)
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int ptep_test_and_clear_young(pte_t *ptep)
-{
-	pte_t pte = *ptep;
-	if (!pte_young(pte))
-		return 0;
-	set_pte(ptep, pte_mkold(pte));
-	return 1;
-}
+#define ptep_test_and_clear_young(__vma, __address, __ptep)		\
+({									\
+	pte_t __pte = *(__ptep);					\
+	int r = 1;							\
+	if (!pte_young(__pte))						\
+		r = 0;							\
+	else								\
+		set_pte((__vma)->vm_mm, (__address),			\
+			(__ptep), pte_mkold(__pte));			\
+	r;								\
+})
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young(__vma, __address, __ptep)		\
 ({									\
-	int __young = ptep_test_and_clear_young(__ptep);		\
+	int __young;							\
+	__young = ptep_test_and_clear_young(__vma, __address, __ptep);	\
 	if (__young)							\
 		flush_tlb_page(__vma, __address);			\
 	__young;							\
@@ -56,20 +60,24 @@
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
-static inline int ptep_test_and_clear_dirty(pte_t *ptep)
-{
-	pte_t pte = *ptep;
-	if (!pte_dirty(pte))
-		return 0;
-	set_pte(ptep, pte_mkclean(pte));
-	return 1;
-}
+#define ptep_test_and_clear_dirty(__vma, __address, __ptep)		\
+({									\
+	pte_t __pte = *ptep;						\
+	int r = 1;							\
+	if (!pte_dirty(__pte))						\
+		r = 0;							\
+	else								\
+		set_pte((__vma)->vm_mm, (__address), (__ptep),		\
+			pte_mkclean(__pte));				\
+	r;								\
+})
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_DIRTY_FLUSH
 #define ptep_clear_flush_dirty(__vma, __address, __ptep)		\
 ({									\
-	int __dirty = ptep_test_and_clear_dirty(__ptep);		\
+	int __dirty;							\
+	__dirty = ptep_test_and_clear_dirty(__vma, __address, __ptep);	\
 	if (__dirty)							\
 		flush_tlb_page(__vma, __address);			\
 	__dirty;							\
@@ -77,36 +85,29 @@
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(pte_t *ptep)
-{
-	pte_t pte = *ptep;
-	pte_clear(ptep);
-	return pte;
-}
+#define ptep_get_and_clear(__mm, __address, __ptep)			\
+({									\
+	pte_t __pte = *(__ptep);					\
+	pte_clear((__mm), (__address), (__ptep));			\
+	__pte;								\
+})
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 #define ptep_clear_flush(__vma, __address, __ptep)			\
 ({									\
-	pte_t __pte = ptep_get_and_clear(__ptep);			\
+	pte_t __pte;							\
+	__pte = ptep_get_and_clear((__vma)->vm_mm, __address, __ptep);	\
 	flush_tlb_page(__vma, __address);				\
 	__pte;								\
 })
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(pte_t *ptep)
-{
-	pte_t old_pte = *ptep;
-	set_pte(ptep, pte_wrprotect(old_pte));
-}
-#endif
-
-#ifndef __HAVE_ARCH_PTEP_MKDIRTY
-static inline void ptep_mkdirty(pte_t *ptep)
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 {
 	pte_t old_pte = *ptep;
-	set_pte(ptep, pte_mkdirty(old_pte));
+	set_pte(mm, address, ptep, pte_wrprotect(old_pte));
 }
 #endif
 
diff -Nru a/include/asm-sparc64/pgalloc.h b/include/asm-sparc64/pgalloc.h
--- a/include/asm-sparc64/pgalloc.h	2004-08-18 15:30:39 -07:00
+++ b/include/asm-sparc64/pgalloc.h	2004-08-18 15:30:39 -07:00
@@ -192,25 +192,17 @@
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
-	pte_t *pte = __pte_alloc_one_kernel(mm, address);
-	if (pte) {
-		struct page *page = virt_to_page(pte);
-		page->mapping = (void *) mm;
-		page->index = address & PMD_MASK;
-	}
-	return pte;
+	return __pte_alloc_one_kernel(mm, address);
 }
 
 static inline struct page *
 pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	pte_t *pte = __pte_alloc_one_kernel(mm, addr);
-	if (pte) {
-		struct page *page = virt_to_page(pte);
-		page->mapping = (void *) mm;
-		page->index = addr & PMD_MASK;
-		return page;
-	}
+
+	if (pte)
+		return virt_to_page(pte);
+
 	return NULL;
 }
 
@@ -247,13 +239,11 @@
 
 static inline void pte_free_kernel(pte_t *pte)
 {
-	virt_to_page(pte)->mapping = NULL;
 	free_pte_fast(pte);
 }
 
 static inline void pte_free(struct page *ptepage)
 {
-	ptepage->mapping = NULL;
 	free_pte_fast(page_address(ptepage));
 }
 
diff -Nru a/include/asm-sparc64/pgtable.h b/include/asm-sparc64/pgtable.h
--- a/include/asm-sparc64/pgtable.h	2004-08-18 15:30:39 -07:00
+++ b/include/asm-sparc64/pgtable.h	2004-08-18 15:30:39 -07:00
@@ -326,18 +326,20 @@
 #define pte_unmap_nested(pte)		do { } while (0)
 
 /* Actual page table PTE updates.  */
-extern void tlb_batch_add(pte_t *ptep, pte_t orig);
+extern void tlb_batch_add(struct mm_struct *mm, unsigned long addr,
+			  pte_t *ptep, pte_t orig);
 
-static inline void set_pte(pte_t *ptep, pte_t pte)
+static inline void set_pte(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, pte_t pte)
 {
 	pte_t orig = *ptep;
 
 	*ptep = pte;
 	if (pte_present(orig))
-		tlb_batch_add(ptep, orig);
+		tlb_batch_add(mm, addr, ptep, orig);
 }
 
-#define pte_clear(ptep)		set_pte((ptep), __pte(0UL))
+#define pte_clear(mm,addr,ptep)		set_pte((mm),(addr),(ptep), __pte(0UL))
 
 extern pgd_t swapper_pg_dir[1];
 
diff -Nru a/mm/fremap.c b/mm/fremap.c
--- a/mm/fremap.c	2004-08-18 15:30:39 -07:00
+++ b/mm/fremap.c	2004-08-18 15:30:39 -07:00
@@ -44,7 +44,7 @@
 	} else {
 		if (!pte_file(pte))
 			free_swap_and_cache(pte_to_swp_entry(pte));
-		pte_clear(ptep);
+		pte_clear(mm, addr, ptep);
 	}
 }
 
@@ -88,7 +88,7 @@
 
 	mm->rss++;
 	flush_icache_page(vma, page);
-	set_pte(pte, mk_pte(page, prot));
+	set_pte(mm, addr, pte, mk_pte(page, prot));
 	page_add_file_rmap(page);
 	pte_val = *pte;
 	pte_unmap(pte);
@@ -128,7 +128,7 @@
 
 	zap_pte(mm, vma, addr, pte);
 
-	set_pte(pte, pgoff_to_pte(pgoff));
+	set_pte(mm, addr, pte, pgoff_to_pte(pgoff));
 	pte_val = *pte;
 	pte_unmap(pte);
 	update_mmu_cache(vma, addr, pte_val);
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	2004-08-18 15:30:39 -07:00
+++ b/mm/memory.c	2004-08-18 15:30:39 -07:00
@@ -290,7 +290,7 @@
 				if (!pte_present(pte)) {
 					if (!pte_file(pte))
 						swap_duplicate(pte_to_swp_entry(pte));
-					set_pte(dst_pte, pte);
+					set_pte(dst, address, dst_pte, pte);
 					goto cont_copy_pte_range_noset;
 				}
 				pfn = pte_pfn(pte);
@@ -304,7 +304,7 @@
 					page = pfn_to_page(pfn); 
 
 				if (!page || PageReserved(page)) {
-					set_pte(dst_pte, pte);
+					set_pte(dst, address, dst_pte, pte);
 					goto cont_copy_pte_range_noset;
 				}
 
@@ -313,7 +313,7 @@
 				 * in the parent and the child
 				 */
 				if (cow) {
-					ptep_set_wrprotect(src_pte);
+					ptep_set_wrprotect(src, address, src_pte);
 					pte = *src_pte;
 				}
 
@@ -326,7 +326,7 @@
 				pte = pte_mkold(pte);
 				get_page(page);
 				dst->rss++;
-				set_pte(dst_pte, pte);
+				set_pte(dst, address, dst_pte, pte);
 				page_dup_rmap(page);
 cont_copy_pte_range_noset:
 				address += PAGE_SIZE;
@@ -406,14 +406,15 @@
 				     page->index > details->last_index))
 					continue;
 			}
-			pte = ptep_get_and_clear(ptep);
+			pte = ptep_get_and_clear(tlb->mm, address+offset, ptep);
 			tlb_remove_tlb_entry(tlb, ptep, address+offset);
 			if (unlikely(!page))
 				continue;
 			if (unlikely(details) && details->nonlinear_vma
 			    && linear_page_index(details->nonlinear_vma,
 					address+offset) != page->index)
-				set_pte(ptep, pgoff_to_pte(page->index));
+				set_pte(tlb->mm, address+offset,
+					ptep, pgoff_to_pte(page->index));
 			if (pte_dirty(pte))
 				set_page_dirty(page);
 			if (pte_young(pte) && !PageAnon(page))
@@ -431,7 +432,7 @@
 			continue;
 		if (!pte_file(pte))
 			free_swap_and_cache(pte_to_swp_entry(pte));
-		pte_clear(ptep);
+		pte_clear(tlb->mm, address+offset, ptep);
 	}
 	pte_unmap(ptep-1);
 }
@@ -831,8 +832,9 @@
 
 EXPORT_SYMBOL(get_user_pages);
 
-static void zeromap_pte_range(pte_t * pte, unsigned long address,
-                                     unsigned long size, pgprot_t prot)
+static void zeromap_pte_range(struct mm_struct *mm, pte_t * pte,
+			      unsigned long address,
+			      unsigned long size, pgprot_t prot)
 {
 	unsigned long end;
 
@@ -843,7 +845,7 @@
 	do {
 		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(address), prot));
 		BUG_ON(!pte_none(*pte));
-		set_pte(pte, zero_pte);
+		set_pte(mm, address, pte, zero_pte);
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
@@ -863,7 +865,7 @@
 		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
-		zeromap_pte_range(pte, base + address, end - address, prot);
+		zeromap_pte_range(mm, pte, base + address, end - address, prot);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -909,8 +911,9 @@
  * mappings are removed. any references to nonexistent pages results
  * in null mappings (currently treated as "copy-on-access")
  */
-static inline void remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
+static inline void remap_pte_range(struct mm_struct *mm, pte_t * pte,
+				   unsigned long address, unsigned long size,
+				   unsigned long phys_addr, pgprot_t prot)
 {
 	unsigned long end;
 	unsigned long pfn;
@@ -923,7 +926,7 @@
 	do {
 		BUG_ON(!pte_none(*pte));
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
- 			set_pte(pte, pfn_pte(pfn, prot));
+ 			set_pte(mm, address, pte, pfn_pte(pfn, prot));
 		address += PAGE_SIZE;
 		pfn++;
 		pte++;
@@ -945,7 +948,7 @@
 		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
-		remap_pte_range(pte, base + address, end - address, address + phys_addr, prot);
+		remap_pte_range(mm, pte, base + address, end - address, address + phys_addr, prot);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -1386,7 +1389,7 @@
 	unlock_page(page);
 
 	flush_icache_page(vma, page);
-	set_pte(page_table, pte);
+	set_pte(mm, address, page_table, pte);
 	page_add_anon_rmap(page, vma, address);
 
 	if (write_access) {
@@ -1451,7 +1454,7 @@
 		page_add_anon_rmap(page, vma, addr);
 	}
 
-	set_pte(page_table, entry);
+	set_pte(mm, addr, page_table, entry);
 	pte_unmap(page_table);
 
 	/* No need to invalidate - it was non-present before */
@@ -1556,7 +1559,7 @@
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-		set_pte(page_table, entry);
+		set_pte(mm, address, page_table, entry);
 		if (anon) {
 			lru_cache_add_active(new_page);
 			page_add_anon_rmap(new_page, vma, address);
@@ -1600,7 +1603,7 @@
 	 */
 	if (!vma->vm_ops || !vma->vm_ops->populate || 
 			(write_access && !(vma->vm_flags & VM_SHARED))) {
-		pte_clear(pte);
+		pte_clear(mm, address, pte);
 		return do_no_page(mm, vma, address, write_access, pte, pmd);
 	}
 
diff -Nru a/mm/mprotect.c b/mm/mprotect.c
--- a/mm/mprotect.c	2004-08-18 15:30:39 -07:00
+++ b/mm/mprotect.c	2004-08-18 15:30:39 -07:00
@@ -25,8 +25,8 @@
 #include <asm/tlbflush.h>
 
 static inline void
-change_pte_range(pmd_t *pmd, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+change_pte_range(struct mm_struct *mm, pmd_t *pmd, unsigned long address,
+		 unsigned long size, pgprot_t newprot)
 {
 	pte_t * pte;
 	unsigned long end;
@@ -51,8 +51,8 @@
 			 * bits by wiping the pte and then setting the new pte
 			 * into place.
 			 */
-			entry = ptep_get_and_clear(pte);
-			set_pte(pte, pte_modify(entry, newprot));
+			entry = ptep_get_and_clear(mm, address, pte);
+			set_pte(mm, address, pte, pte_modify(entry, newprot));
 		}
 		address += PAGE_SIZE;
 		pte++;
@@ -61,8 +61,8 @@
 }
 
 static inline void
-change_pmd_range(pgd_t *pgd, unsigned long address,
-		unsigned long size, pgprot_t newprot)
+change_pmd_range(struct mm_struct *mm, pgd_t *pgd, unsigned long address,
+		 unsigned long size, pgprot_t newprot)
 {
 	pmd_t * pmd;
 	unsigned long end;
@@ -80,7 +80,7 @@
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		change_pte_range(pmd, address, end - address, newprot);
+		change_pte_range(mm, pmd, address, end - address, newprot);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -99,7 +99,7 @@
 		BUG();
 	spin_lock(&current->mm->page_table_lock);
 	do {
-		change_pmd_range(dir, start, end - start, newprot);
+		change_pmd_range(current->mm, dir, start, end - start, newprot);
 		start = (start + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 	} while (start && (start < end));
diff -Nru a/mm/mremap.c b/mm/mremap.c
--- a/mm/mremap.c	2004-08-18 15:30:39 -07:00
+++ b/mm/mremap.c	2004-08-18 15:30:39 -07:00
@@ -128,7 +128,7 @@
 			if (dst) {
 				pte_t pte;
 				pte = ptep_clear_flush(vma, old_addr, src);
-				set_pte(dst, pte);
+				set_pte(mm, new_addr, dst, pte);
 			} else
 				error = -ENOMEM;
 			pte_unmap_nested(src);
diff -Nru a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c	2004-08-18 15:30:39 -07:00
+++ b/mm/rmap.c	2004-08-18 15:30:39 -07:00
@@ -508,7 +508,7 @@
 		 */
 		BUG_ON(!PageSwapCache(page));
 		swap_duplicate(entry);
-		set_pte(pte, swp_entry_to_pte(entry));
+		set_pte(mm, address, pte, swp_entry_to_pte(entry));
 		BUG_ON(pte_file(*pte));
 	}
 
@@ -606,7 +606,7 @@
 
 		/* If nonlinear, store the file page offset in the pte. */
 		if (page->index != linear_page_index(vma, address))
-			set_pte(pte, pgoff_to_pte(page->index));
+			set_pte(mm, address, pte, pgoff_to_pte(page->index));
 
 		/* Move the dirty bit to the physical page now the pte is gone. */
 		if (pte_dirty(pteval))
diff -Nru a/mm/swapfile.c b/mm/swapfile.c
--- a/mm/swapfile.c	2004-08-18 15:30:39 -07:00
+++ b/mm/swapfile.c	2004-08-18 15:30:39 -07:00
@@ -432,7 +432,8 @@
 {
 	vma->vm_mm->rss++;
 	get_page(page);
-	set_pte(dir, pte_mkold(mk_pte(page, vma->vm_page_prot)));
+	set_pte(vma->vm_mm, address, dir,
+		pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	page_add_anon_rmap(page, vma, address);
 	swap_free(entry);
 }
diff -Nru a/mm/vmalloc.c b/mm/vmalloc.c
--- a/mm/vmalloc.c	2004-08-18 15:30:39 -07:00
+++ b/mm/vmalloc.c	2004-08-18 15:30:39 -07:00
@@ -45,7 +45,7 @@
 
 	do {
 		pte_t page;
-		page = ptep_get_and_clear(pte);
+		page = ptep_get_and_clear(&init_mm, address, pte);
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
@@ -101,7 +101,7 @@
 		if (!page)
 			return -ENOMEM;
 
-		set_pte(pte, mk_pte(page, prot));
+		set_pte(&init_mm, address, pte, mk_pte(page, prot));
 		address += PAGE_SIZE;
 		pte++;
 		(*pages)++;
