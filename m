Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUEDW27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUEDW27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUEDW27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:28:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:9199 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261244AbUEDW2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:28:45 -0400
Date: Tue, 4 May 2004 23:28:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, <rth@twiddle.net>, <spyro@f2s.com>,
       <bjornw@axis.com>, <ysato@users.sourceforge.jp>, <davidm@hpl.hp.com>,
       <jes@trained-monkey.org>, <gerg@snapgear.com>, <ralf@linux-mips.org>,
       <paulus@samba.org>, <anton@samba.org>, <schwidefsky@de.ibm.com>,
       <lethal@linux-sh.org>, <wesolows@foobazco.org>, <davem@redhat.com>,
       <miles@lsi.nec.co.jp>, <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 23 empty flush_dcache_mmap_lock
In-Reply-To: <Pine.LNX.4.44.0405042315160.2156-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405042322200.2156-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures (like i386) do nothing in flush_dcache_page, or don't
scan i_mmap in flush_dcache_page, so don't need flush_dcache_mmap_lock
to do anything: define it and flush_dcache_mmap_unlock away.  Noticed
arm26, cris, h8300 still defining flush_page_to_ram: delete it again.

 include/asm-alpha/cacheflush.h      |    2 ++
 include/asm-arm26/cacheflush.h      |    3 ++-
 include/asm-cris/cacheflush.h       |    3 ++-
 include/asm-h8300/cacheflush.h      |    3 ++-
 include/asm-ia64/cacheflush.h       |    3 +++
 include/asm-m68k/cacheflush.h       |    2 ++
 include/asm-m68knommu/cacheflush.h  |    2 ++
 include/asm-mips/cacheflush.h       |    3 +++
 include/asm-ppc/cacheflush.h        |    3 +++
 include/asm-ppc64/cacheflush.h      |    3 +++
 include/asm-s390/cacheflush.h       |    2 ++
 include/asm-sh/cpu-sh2/cacheflush.h |    2 ++
 include/asm-sh/cpu-sh3/cacheflush.h |    2 ++
 include/asm-sh/cpu-sh4/cacheflush.h |    4 ++++
 include/asm-sparc/cacheflush.h      |    2 ++
 include/asm-sparc64/cacheflush.h    |    2 ++
 include/asm-v850/cacheflush.h       |    2 ++
 include/asm-x86_64/cacheflush.h     |    2 ++
 18 files changed, 42 insertions(+), 3 deletions(-)

--- rmap22/include/asm-alpha/cacheflush.h	2003-10-08 20:24:57.000000000 +0100
+++ rmap23/include/asm-alpha/cacheflush.h	2004-05-04 21:22:02.003416832 +0100
@@ -10,6 +10,8 @@
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_cache_vmap(start, end)		do { } while (0)
 #define flush_cache_vunmap(start, end)		do { } while (0)
 
--- rmap22/include/asm-arm26/cacheflush.h	2003-10-08 20:24:57.000000000 +0100
+++ rmap23/include/asm-arm26/cacheflush.h	2004-05-04 21:22:02.004416680 +0100
@@ -24,7 +24,6 @@
 #define flush_cache_mm(mm)                      do { } while (0)
 #define flush_cache_range(vma,start,end)        do { } while (0)
 #define flush_cache_page(vma,vmaddr)            do { } while (0)
-#define flush_page_to_ram(page)                 do { } while (0)
 #define flush_cache_vmap(start, end)		do { } while (0)
 #define flush_cache_vunmap(start, end)		do { } while (0)
 
@@ -32,6 +31,8 @@
 #define clean_dcache_range(start,end)           do { } while (0)
 #define flush_dcache_range(start,end)           do { } while (0)
 #define flush_dcache_page(page)                 do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define clean_dcache_entry(_s)                  do { } while (0)
 #define clean_cache_entry(_start)               do { } while (0)
 
--- rmap22/include/asm-cris/cacheflush.h	2003-10-08 20:24:55.000000000 +0100
+++ rmap23/include/asm-cris/cacheflush.h	2004-05-04 21:22:02.004416680 +0100
@@ -11,8 +11,9 @@
 #define flush_cache_mm(mm)			do { } while (0)
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
-#define flush_page_to_ram(page)			do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
--- rmap22/include/asm-h8300/cacheflush.h	2003-10-08 20:24:56.000000000 +0100
+++ rmap23/include/asm-h8300/cacheflush.h	2004-05-04 21:22:02.005416528 +0100
@@ -14,8 +14,9 @@
 #define	flush_cache_mm(mm)
 #define	flush_cache_range(vma,a,b)
 #define	flush_cache_page(vma,p)
-#define	flush_page_to_ram(page)
 #define	flush_dcache_page(page)
+#define	flush_dcache_mmap_lock(mapping)
+#define	flush_dcache_mmap_unlock(mapping)
 #define	flush_icache()
 #define	flush_icache_page(vma,page)
 #define	flush_icache_range(start,len)
--- rmap22/include/asm-ia64/cacheflush.h	2003-10-08 20:24:56.000000000 +0100
+++ rmap23/include/asm-ia64/cacheflush.h	2004-05-04 21:22:02.006416376 +0100
@@ -29,6 +29,9 @@ do {						\
 	clear_bit(PG_arch_1, &(page)->flags);	\
 } while (0)
 
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
+
 extern void flush_icache_range (unsigned long start, unsigned long end);
 
 #define flush_icache_user_range(vma, page, user_addr, len)					\
--- rmap22/include/asm-m68k/cacheflush.h	2004-02-04 02:45:30.000000000 +0000
+++ rmap23/include/asm-m68k/cacheflush.h	2004-05-04 21:22:02.007416224 +0100
@@ -128,6 +128,8 @@ static inline void __flush_page_to_ram(v
 }
 
 #define flush_dcache_page(page)		__flush_page_to_ram(page_address(page))
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_page(vma, page)	__flush_page_to_ram(page_address(page))
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
--- rmap22/include/asm-m68knommu/cacheflush.h	2003-10-08 20:24:57.000000000 +0100
+++ rmap23/include/asm-m68knommu/cacheflush.h	2004-05-04 21:22:02.007416224 +0100
@@ -12,6 +12,8 @@
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
 #define flush_dcache_range(start,len)		do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_range(start,len)		__flush_cache_all()
 #define flush_icache_page(vma,pg)		do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
--- rmap22/include/asm-mips/cacheflush.h	2004-04-28 07:07:12.000000000 +0100
+++ rmap23/include/asm-mips/cacheflush.h	2004-05-04 21:22:02.008416072 +0100
@@ -45,6 +45,9 @@ static inline void flush_dcache_page(str
 
 }
 
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
+
 extern void (*flush_icache_page)(struct vm_area_struct *vma,
 	struct page *page);
 extern void (*flush_icache_range)(unsigned long start, unsigned long end);
--- rmap22/include/asm-ppc/cacheflush.h	2003-10-08 20:24:57.000000000 +0100
+++ rmap23/include/asm-ppc/cacheflush.h	2004-05-04 21:22:02.009415920 +0100
@@ -28,6 +28,9 @@
 #define flush_cache_vunmap(start, end)	do { } while (0)
 
 extern void flush_dcache_page(struct page *page);
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
+
 extern void flush_icache_range(unsigned long, unsigned long);
 extern void flush_icache_user_range(struct vm_area_struct *vma,
 		struct page *page, unsigned long addr, int len);
--- rmap22/include/asm-ppc64/cacheflush.h	2004-04-28 07:07:13.000000000 +0100
+++ rmap23/include/asm-ppc64/cacheflush.h	2004-05-04 21:22:02.010415768 +0100
@@ -18,6 +18,9 @@
 #define flush_cache_vunmap(start, end)		do { } while (0)
 
 extern void flush_dcache_page(struct page *page);
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
+
 extern void __flush_icache_range(unsigned long, unsigned long);
 extern void flush_icache_user_range(struct vm_area_struct *vma,
 				    struct page *page, unsigned long addr,
--- rmap22/include/asm-s390/cacheflush.h	2003-10-08 20:24:57.000000000 +0100
+++ rmap23/include/asm-s390/cacheflush.h	2004-05-04 21:22:02.010415768 +0100
@@ -10,6 +10,8 @@
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
--- rmap22/include/asm-sh/cpu-sh2/cacheflush.h	2003-07-02 22:00:48.000000000 +0100
+++ rmap23/include/asm-sh/cpu-sh2/cacheflush.h	2004-05-04 21:22:02.011415616 +0100
@@ -30,6 +30,8 @@
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
--- rmap22/include/asm-sh/cpu-sh3/cacheflush.h	2004-04-04 03:38:43.000000000 +0100
+++ rmap23/include/asm-sh/cpu-sh3/cacheflush.h	2004-05-04 21:22:02.012415464 +0100
@@ -30,6 +30,8 @@
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
--- rmap22/include/asm-sh/cpu-sh4/cacheflush.h	2003-07-02 22:00:46.000000000 +0100
+++ rmap23/include/asm-sh/cpu-sh4/cacheflush.h	2004-05-04 21:22:02.013415312 +0100
@@ -30,6 +30,10 @@ extern void flush_cache_range(struct vm_
 			      unsigned long end);
 extern void flush_cache_page(struct vm_area_struct *vma, unsigned long addr);
 extern void flush_dcache_page(struct page *pg);
+
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
+
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void flush_cache_sigtramp(unsigned long addr);
 extern void flush_icache_user_range(struct vm_area_struct *vma,
--- rmap22/include/asm-sparc/cacheflush.h	2003-10-08 20:24:56.000000000 +0100
+++ rmap23/include/asm-sparc/cacheflush.h	2004-05-04 21:22:02.013415312 +0100
@@ -70,6 +70,8 @@ BTFIXUPDEF_CALL(void, flush_sig_insns, s
 extern void sparc_flush_page_to_ram(struct page *page);
 
 #define flush_dcache_page(page)			sparc_flush_page_to_ram(page)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
 #define flush_cache_vmap(start, end)		flush_cache_all()
 #define flush_cache_vunmap(start, end)		flush_cache_all()
--- rmap22/include/asm-sparc64/cacheflush.h	2003-10-08 20:24:57.000000000 +0100
+++ rmap23/include/asm-sparc64/cacheflush.h	2004-05-04 21:22:02.014415160 +0100
@@ -42,6 +42,8 @@ extern void __flush_dcache_range(unsigne
 	memcpy(dst, src, len)
 
 extern void flush_dcache_page(struct page *page);
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
 #define flush_cache_vmap(start, end)		do { } while (0)
 #define flush_cache_vunmap(start, end)		do { } while (0)
--- rmap22/include/asm-v850/cacheflush.h	2003-10-08 20:24:56.000000000 +0100
+++ rmap23/include/asm-v850/cacheflush.h	2004-05-04 21:22:02.015415008 +0100
@@ -27,6 +27,8 @@
 #define flush_cache_range(vma, start, end)	((void)0)
 #define flush_cache_page(vma, vmaddr)		((void)0)
 #define flush_dcache_page(page)			((void)0)
+#define flush_dcache_mmap_lock(mapping)		((void)0)
+#define flush_dcache_mmap_unlock(mapping)	((void)0)
 #define flush_cache_vmap(start, end)		((void)0)
 #define flush_cache_vunmap(start, end)		((void)0)
 
--- rmap22/include/asm-x86_64/cacheflush.h	2003-10-08 20:24:56.000000000 +0100
+++ rmap23/include/asm-x86_64/cacheflush.h	2004-05-04 21:22:02.016414856 +0100
@@ -10,6 +10,8 @@
 #define flush_cache_range(vma, start, end)	do { } while (0)
 #define flush_cache_page(vma, vmaddr)		do { } while (0)
 #define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_range(start, end)		do { } while (0)
 #define flush_icache_page(vma,pg)		do { } while (0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)

