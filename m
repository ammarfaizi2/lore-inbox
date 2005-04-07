Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVDGBYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVDGBYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVDGBX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:23:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:30361 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262380AbVDGBTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:19:43 -0400
Date: Thu, 7 Apr 2005 02:19:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] freepgt2: remove FIRST_USER_ADDRESS hack
In-Reply-To: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0504070218440.24723@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once all the MMU architectures define FIRST_USER_ADDRESS,
remove hack from mmap.c which derived it from FIRST_USER_PGD_NR.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mmap.c |    5 -----
 1 files changed, 5 deletions(-)

--- 2.6.12-rc2-mm1+/mm/mmap.c	2005-04-05 18:59:01.000000000 +0100
+++ linux/mm/mmap.c	2005-04-07 00:32:43.000000000 +0100
@@ -1608,11 +1608,6 @@ static void unmap_vma_list(struct mm_str
 	validate_mm(mm);
 }
 
-#ifndef FIRST_USER_ADDRESS	/* temporary hack */
-#define THIS_IS_ARM		FIRST_USER_PGD_NR
-#define FIRST_USER_ADDRESS	(THIS_IS_ARM * PAGE_SIZE)
-#endif
-
 /*
  * Get rid of page table information in the indicated region.
  *
