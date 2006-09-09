Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWIILhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWIILhe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWIILhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:37:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30350 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932082AbWIILhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:37:34 -0400
Subject: [PATCH] [6/6] Fix userspace build of asm-mips/page.h
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org
In-Reply-To: <1157800733.2977.40.camel@pmac.infradead.org>
References: <1157800733.2977.40.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 12:36:51 +0100
Message-Id: <1157801811.2977.68.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS asm/page.h unconditionally includes <asm-generic/memory_model.h>,
which doesn't exist in userspace. Move an #endif /* __KERNEL__ */ down a
few lines to prevent that.

Also, remove the broken definition of PAGE_SIZE which is never going to
be correct -- in the absence of PAGE_SIZE, non-broken userspace will
fall back to using sysconf() or getpagesize() instead.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 6ed1151..219d359 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -14,8 +14,6 @@ #ifdef __KERNEL__
 
 #include <spaces.h>
 
-#endif
-
 /*
  * PAGE_SHIFT determines the page size
  */
@@ -34,8 +32,6 @@ #endif
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
 #define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))
 
-
-#ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
 extern void clear_page(void * page);
@@ -168,8 +164,6 @@ #define VM_DATA_DEFAULT_FLAGS	(VM_READ |
 #define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
 #define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
 
-#endif /* defined (__KERNEL__) */
-
 #ifdef CONFIG_LIMITED_DMA
 #define WANT_PAGE_VIRTUAL
 #endif
@@ -177,4 +171,6 @@ #endif
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#endif /* defined (__KERNEL__) */
+
 #endif /* _ASM_PAGE_H */

-- 
dwmw2

