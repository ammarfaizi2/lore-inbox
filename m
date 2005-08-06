Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263249AbVHFQ2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263249AbVHFQ2B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 12:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVHFQ2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 12:28:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:1731 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263247AbVHFQ17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 12:27:59 -0400
Date: Sat, 6 Aug 2005 18:27:56 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, bboissin@gmail.com
Subject: [PATCH] remove linux/pagemap.h from linux/swap.h
Message-ID: <20050806162756.GA10132@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sparc can not include linux/pagemap.h because of the following circular
dependency:

asm-sparc/pgtable include linux/swap.h
linux/swap.h include now linux/pagemap.h
linux/pagemap.h include linux/mm.h
linux/mm.h include asm/pgtable.h

It needs to have the swp_entry_t type fully visible in pgtable.h,
we can't work around this using macros.

Signed-off-by: Olaf Hering <olh@suse.de>

 include/linux/swap.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc5-git3.sparc/include/linux/swap.h
===================================================================
--- linux-2.6.13-rc5-git3.sparc.orig/include/linux/swap.h
+++ linux-2.6.13-rc5-git3.sparc/include/linux/swap.h
@@ -7,7 +7,6 @@
 #include <linux/mmzone.h>
 #include <linux/list.h>
 #include <linux/sched.h>
-#include <linux/pagemap.h>
 
 #include <asm/atomic.h>
 #include <asm/page.h>
@@ -255,6 +254,8 @@ static inline void put_swap_token(struct
 
 #define si_swapinfo(val) \
 	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
+/* only sparc can not include linux/pagemap.h in this file
+ * so leave page_cache_release and release_pages undeclared... */
 #define free_page_and_swap_cache(page) \
 	page_cache_release(page)
 #define free_pages_and_swap_cache(pages, nr) \
