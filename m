Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVAPCDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVAPCDp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 21:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVAPCDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 21:03:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24078 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262389AbVAPCBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 21:01:36 -0500
Date: Sun, 16 Jan 2005 03:01:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       paulus@samba.org, linuxppc-dev@ozlabs.org, jdike@karaya.com,
       user-mode-linux-devel@lists.sourceforge.net, dhowells@redhat.com
Subject: [2.6 patch] (mostly i386) mm cleanup (fwd)
Message-ID: <20050116020133.GI4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below (already ACK'ed by David Howells) still 
applies and compiles against 2.6.11-rc1-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 12 Dec 2004 03:10:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org, jdike@karaya.com,
	user-mode-linux-devel@lists.sourceforge.net, dhowells@redhat.com
Subject: [2.6 patch] (mostly i386) mm cleanup

The patch below contains the following fixes:
- arch/i386/mm/boot_ioremap.c: make a variable static
- frv/ppc highmem.c: remove stale kmap_init prototypes
- arch/um/kernel/mem.c: make kmap_init static
- arch/i386/mm/init.c: make five functions static


diffstat output:
 arch/i386/mm/boot_ioremap.c |    4 ++--
 arch/i386/mm/init.c         |   10 +++++-----
 arch/um/kernel/mem.c        |    2 +-
 include/asm-frv/highmem.h   |    2 --
 include/asm-i386/highmem.h  |    2 --
 include/asm-ppc/highmem.h   |    2 --
 6 files changed, 8 insertions(+), 14 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/mm/boot_ioremap.c.old	2004-12-11 23:55:28.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/mm/boot_ioremap.c	2004-12-11 23:55:49.000000000 +0100
@@ -61,8 +61,8 @@
 /* the virtual space we're going to remap comes from this array */
 #define BOOT_IOREMAP_PAGES 4
 #define BOOT_IOREMAP_SIZE (BOOT_IOREMAP_PAGES*PAGE_SIZE)
-__initdata char boot_ioremap_space[BOOT_IOREMAP_SIZE] 
-		__attribute__ ((aligned (PAGE_SIZE)));
+static __initdata char boot_ioremap_space[BOOT_IOREMAP_SIZE] 
+		       __attribute__ ((aligned (PAGE_SIZE)));
 
 /*
  * This only applies to things which need to ioremap before paging_init()
--- linux-2.6.10-rc2-mm4-full/include/asm-frv/highmem.h.old	2004-12-11 23:57:40.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-frv/highmem.h	2004-12-11 23:57:51.000000000 +0100
@@ -44,8 +44,6 @@
 #define kmap_pte ______kmap_pte_in_TLB
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void);
-
 #define flush_cache_kmaps()  do { } while (0)
 
 /*
--- linux-2.6.10-rc2-mm4-full/include/asm-ppc/highmem.h.old	2004-12-11 23:58:00.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-ppc/highmem.h	2004-12-11 23:58:03.000000000 +0100
@@ -35,8 +35,6 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void) __init;
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
--- linux-2.6.10-rc2-mm4-full/arch/um/kernel/mem.c.old	2004-12-11 23:58:14.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/um/kernel/mem.c	2004-12-11 23:58:21.000000000 +0100
@@ -141,7 +141,7 @@
 	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr), \
 						     vaddr), (vaddr)), (vaddr))
 
-void __init kmap_init(void)
+static void __init kmap_init(void)
 {
 	unsigned long kmap_vstart;
 
--- linux-2.6.10-rc2-mm4-full/include/asm-i386/highmem.h.old	2004-12-11 23:58:54.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-i386/highmem.h	2004-12-11 23:58:57.000000000 +0100
@@ -33,8 +33,6 @@
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
 
-extern void kmap_init(void);
-
 /*
  * Right now we initialize only a single pte table. It can be extended
  * easily, subsequent pte tables have to be allocated in one physical
--- linux-2.6.10-rc2-mm4-full/arch/i386/mm/init.c.old	2004-12-11 23:58:29.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/mm/init.c	2004-12-12 00:15:07.000000000 +0100
@@ -254,7 +254,7 @@
 #define kmap_get_fixmap_pte(vaddr)					\
 	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr), vaddr), (vaddr)), (vaddr))
 
-void __init kmap_init(void)
+static void __init kmap_init(void)
 {
 	unsigned long kmap_vstart;
 
@@ -265,7 +265,7 @@
 	kmap_prot = PAGE_KERNEL;
 }
 
-void __init permanent_kmaps_init(pgd_t *pgd_base)
+static void __init permanent_kmaps_init(pgd_t *pgd_base)
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
@@ -294,7 +294,7 @@
 }
 
 #ifndef CONFIG_DISCONTIGMEM
-void __init set_highmem_pages_init(int bad_ppro) 
+static void __init set_highmem_pages_init(int bad_ppro) 
 {
 	int pfn;
 	for (pfn = highstart_pfn; pfn < highend_pfn; pfn++)
@@ -408,7 +408,7 @@
 }
 
 #ifndef CONFIG_DISCONTIGMEM
-void __init zone_sizes_init(void)
+static void __init zone_sizes_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
 	unsigned int max_dma, high, low;
@@ -545,7 +545,7 @@
  * but fortunately the switch to using exceptions got rid of all that.
  */
 
-void __init test_wp_bit(void)
+static void __init test_wp_bit(void)
 {
 	printk("Checking if this processor honours the WP bit even in supervisor mode... ");
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----
