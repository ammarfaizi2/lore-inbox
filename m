Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWIDREq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWIDREq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWIDREp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:04:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12301 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964940AbWIDREh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:04:37 -0400
Date: Mon, 4 Sep 2006 19:04:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] lib/ioremap.c must #include <linux/mm.h>
Message-ID: <20060904170434.GW4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

generic-ioremap_page_range-implementation.patch causes the following 
compile error with -Werror-implicit-function-declaration on ia64:

<--  snip  -->

  CC      lib/ioremap.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/lib/ioremap.c: In function 'ioremap_pte_range':
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/lib/ioremap.c:21: error: implicit declaration of function 'pte_alloc_kernel'
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/lib/ioremap.c:21: warning: assignment makes pointer from integer without a cast
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/lib/ioremap.c: In function 'ioremap_pmd_range':
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/lib/ioremap.c:39: error: implicit declaration of function 'pmd_alloc'
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/lib/ioremap.c:39: warning: assignment makes pointer from integer without a cast
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/lib/ioremap.c: In function 'ioremap_pud_range':
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/lib/ioremap.c:57: error: implicit declaration of function 'pud_alloc'
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc5-mm1/lib/ioremap.c:57: warning: assignment makes pointer from integer without a cast
make[2]: *** [lib/ioremap.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc5-mm1/lib/ioremap.c.old	2006-09-04 02:01:22.000000000 +0200
+++ linux-2.6.18-rc5-mm1/lib/ioremap.c	2006-09-04 02:01:32.000000000 +0200
@@ -7,6 +7,7 @@
  */
 #include <linux/io.h>
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>

