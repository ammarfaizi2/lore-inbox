Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVGFCWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVGFCWD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVGFCVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:21:51 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:58520 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262048AbVGFCTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:16 -0400
Subject: [PATCH] [7/48] Suspend2 2.1.9.8 for 2.6.12: 352-disable-pdflush-during-suspend.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:40 +1000
Message-Id: <11206164401583@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 353-disable-highmem-tlb-flush-for-copyback.patch-old/mm/highmem.c 353-disable-highmem-tlb-flush-for-copyback.patch-new/mm/highmem.c
--- 353-disable-highmem-tlb-flush-for-copyback.patch-old/mm/highmem.c	2005-06-20 11:47:32.000000000 +1000
+++ 353-disable-highmem-tlb-flush-for-copyback.patch-new/mm/highmem.c	2005-07-04 23:14:20.000000000 +1000
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/hash.h>
 #include <linux/highmem.h>
+#include <linux/suspend.h>
 #include <asm/tlbflush.h>
 
 static mempool_t *page_pool, *isa_page_pool;
@@ -95,7 +96,10 @@ static void flush_all_zero_pkmaps(void)
 
 		set_page_address(page, NULL);
 	}
-	flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
+	if (test_suspend_state(SUSPEND_FREEZE_SMP))
+		__flush_tlb();
+	else
+		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
 }
 
 static inline unsigned long map_new_virtual(struct page *page)

