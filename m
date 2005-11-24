Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030600AbVKXFOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030600AbVKXFOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030601AbVKXFOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:14:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23302 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030600AbVKXFOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:14:05 -0500
Date: Thu, 24 Nov 2005 06:14:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: [-mm patch] dummy mark_rodata_ro() should be static
Message-ID: <20051124051405.GO3963@stusta.de>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123223505.GF3963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123223505.GF3963@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:35:05PM +0100, Adrian Bunk wrote:

> Every inline dummy function should be static.
>...

Sorry, the patch was incomplete.

Updated patch below.

cu
Adrian


<--  snip  -->


Every inline dummy function should be static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-i386/cacheflush.h   |    2 ++
 include/asm-x86_64/cacheflush.h |    3 +++
 init/main.c                     |    2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.15-rc2-mm1/include/asm-i386/cacheflush.h.old	2005-11-24 05:55:28.000000000 +0100
+++ linux-2.6.15-rc2-mm1/include/asm-i386/cacheflush.h	2005-11-24 06:09:24.000000000 +0100
@@ -31,6 +31,8 @@
 void kernel_map_pages(struct page *page, int numpages, int enable);
 #endif
 
+#ifdef CONFIG_DEBUG_RODATA
 void mark_rodata_ro(void);
+#endif
 
 #endif /* _I386_CACHEFLUSH_H */
--- linux-2.6.15-rc2-mm1/include/asm-x86_64/cacheflush.h.old	2005-11-24 06:12:03.000000000 +0100
+++ linux-2.6.15-rc2-mm1/include/asm-x86_64/cacheflush.h	2005-11-24 06:11:01.000000000 +0100
@@ -26,6 +26,9 @@
 void global_flush_tlb(void); 
 int change_page_attr(struct page *page, int numpages, pgprot_t prot);
 int change_page_attr_addr(unsigned long addr, int numpages, pgprot_t prot);
+
+#ifdef CONFIG_DEBUG_RODATA
 void mark_rodata_ro(void);
+#endif
 
 #endif /* _X8664_CACHEFLUSH_H */
--- linux-2.6.15-rc2-mm1/init/main.c.old	2005-11-24 05:56:17.000000000 +0100
+++ linux-2.6.15-rc2-mm1/init/main.c	2005-11-24 06:09:54.000000000 +0100
@@ -101,7 +101,7 @@
 static inline void acpi_early_init(void) { }
 #endif
 #ifndef CONFIG_DEBUG_RODATA
-inline void mark_rodata_ro(void) { }
+static inline void mark_rodata_ro(void) { }
 #endif
 
 #ifdef CONFIG_TC


