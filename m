Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSIAOYk>; Sun, 1 Sep 2002 10:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSIAOYk>; Sun, 1 Sep 2002 10:24:40 -0400
Received: from www.sgg.ru ([217.23.135.2]:48397 "EHLO mail.sgg.ru")
	by vger.kernel.org with ESMTP id <S315988AbSIAOYj>;
	Sun, 1 Sep 2002 10:24:39 -0400
Message-ID: <3D722542.94ABBDDB@tv-sign.ru>
Date: Sun, 01 Sep 2002 18:33:38 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] batched freeing of anon pages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Now nr variable is unused in tlb_flush_mmu().

--- 2.5.33/include/asm-generic/tlb.h~	Sun Sep  1 15:16:08 2002
+++ 2.5.33/include/asm-generic/tlb.h	Sun Sep  1 18:18:38 2002
@@ -67,8 +67,6 @@
 
 static inline void tlb_flush_mmu(mmu_gather_t *tlb, unsigned long start, unsigned long end)
 {
-	unsigned long nr;
-
 	if (!tlb->need_flush) {
 		tlb->avoided_flushes++;
 		return;
@@ -77,7 +75,6 @@
 	tlb->flushes++;
 
 	tlb_flush(tlb);
-	nr = tlb->nr;
 	if (!tlb_fast_mode(tlb)) {
 		free_pages_and_swap_cache(tlb->pages, tlb->nr);
 		tlb->nr = 0;


Oleg.
