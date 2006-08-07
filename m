Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWHGVM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWHGVM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWHGVLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:11:51 -0400
Received: from xenotime.net ([66.160.160.81]:15579 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932382AbWHGVLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:11:12 -0400
Date: Mon, 7 Aug 2006 14:10:08 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>, matthew@wil.cx,
       kyle@parisc-linux.org
Subject: [PATCH 5/9] Replace ARCH_HAS_FLUSH_ANON_PAGE with
 CONFIG_ARCH_FLUSH_ANON_PAGE
Message-Id: <20060807141008.de9c9c5c.rdunlap@xenotime.net>
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

Replace ARCH_HAS_FLUSH_ANON_PAGE with CONFIG_ARCH_FLUSH_ANON_PAGE.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/parisc/Kconfig             |    3 +++
 include/asm-parisc/cacheflush.h |    1 -
 include/linux/highmem.h         |    2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2618-rc4-arch.orig/include/asm-parisc/cacheflush.h
+++ linux-2618-rc4-arch/include/asm-parisc/cacheflush.h
@@ -189,7 +189,6 @@ flush_anon_page(struct page *page, unsig
 	if (PageAnon(page))
 		flush_user_dcache_page(vmaddr);
 }
-#define ARCH_HAS_FLUSH_ANON_PAGE
 
 static inline void
 flush_kernel_dcache_page(struct page *page)
--- linux-2618-rc4-arch.orig/include/linux/highmem.h
+++ linux-2618-rc4-arch/include/linux/highmem.h
@@ -6,7 +6,7 @@
 
 #include <asm/cacheflush.h>
 
-#ifndef ARCH_HAS_FLUSH_ANON_PAGE
+#ifndef CONFIG_ARCH_FLUSH_ANON_PAGE
 static inline void flush_anon_page(struct page *page, unsigned long vmaddr)
 {
 }
--- linux-2618-rc4-arch.orig/arch/parisc/Kconfig
+++ linux-2618-rc4-arch/arch/parisc/Kconfig
@@ -16,6 +16,9 @@ config PARISC
 config MMU
 	def_bool y
 
+config ARCH_FLUSH_ANON_PAGE
+	def_bool y
+
 config STACK_GROWSUP
 	def_bool y
 


---
