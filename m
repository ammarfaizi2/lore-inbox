Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWHGVNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWHGVNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWHGVLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:11:48 -0400
Received: from xenotime.net ([66.160.160.81]:14811 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932380AbWHGVLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:11:12 -0400
Date: Mon, 7 Aug 2006 14:05:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>, tony.luck@intel.com
Subject: [PATCH 7/9] Replace ARCH_HAS_VALID_PHYS_ADDR_RANGE with
 CONFIG_ARCH_VALID_PHYS_ADDR_RANGE
Message-Id: <20060807140538.c5dc216b.rdunlap@xenotime.net>
In-Reply-To: <20060807120928.c0fe7045.rdunlap@xenotime.net>
References: <20060807120928.c0fe7045.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Replace ARCH_HAS_VALID_PHYS_ADDR_RANGE with CONFIG_ARCH_VALID_PHYS_ADDR_RANGE.
Move it from header files to Kconfig space.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/ia64/Kconfig     |    3 +++
 drivers/char/mem.c    |    2 +-
 include/asm-ia64/io.h |    1 -
 3 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2618-rc4-arch.orig/drivers/char/mem.c
+++ linux-2618-rc4-arch/drivers/char/mem.c
@@ -86,7 +86,7 @@ static inline int uncached_access(struct
 #endif
 }
 
-#ifndef ARCH_HAS_VALID_PHYS_ADDR_RANGE
+#ifndef CONFIG_ARCH_VALID_PHYS_ADDR_RANGE
 static inline int valid_phys_addr_range(unsigned long addr, size_t count)
 {
 	if (addr + count > __pa(high_memory))
--- linux-2618-rc4-arch.orig/include/asm-ia64/io.h
+++ linux-2618-rc4-arch/include/asm-ia64/io.h
@@ -87,7 +87,6 @@ phys_to_virt (unsigned long address)
 	return (void *) (address + PAGE_OFFSET);
 }
 
-#define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern u64 kern_mem_attribute (unsigned long phys_addr, unsigned long size);
 extern int valid_phys_addr_range (unsigned long addr, size_t count); /* efi.c */
 extern int valid_mmap_phys_addr_range (unsigned long pfn, size_t count);
--- linux-2618-rc4-arch.orig/arch/ia64/Kconfig
+++ linux-2618-rc4-arch/arch/ia64/Kconfig
@@ -386,6 +386,9 @@ config HAVE_ARCH_NODEDATA_EXTENSION
 	def_bool y
 	depends on NUMA
 
+config ARCH_VALID_PHYS_ADDR_RANGE
+	def_bool y
+
 config IA32_SUPPORT
 	bool "Support for Linux/x86 binaries"
 	help


---
