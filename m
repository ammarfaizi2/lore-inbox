Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbUEHWJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUEHWJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264194AbUEHWHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:07:21 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:61960 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264195AbUEHWGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:06:49 -0400
Date: Sat, 8 May 2004 23:06:36 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 32 zap_pmd_range wrap
In-Reply-To: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405082305440.26569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <andrea@suse.de>

zap_pmd_range, alone of all those page_range loops, lacks the check for
whether address wrapped.  Hugh is in doubt as to whether this makes any
difference to any config on any arch, but eager to fix the odd one out.

 memory.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- rmap31/mm/memory.c	2004-05-08 20:55:49.588839808 +0100
+++ rmap32/mm/memory.c	2004-05-08 20:56:00.578169176 +0100
@@ -449,7 +449,7 @@ static void zap_pmd_range(struct mmu_gat
 		zap_pte_range(tlb, pmd, address, end - address, details);
 		address = (address + PMD_SIZE) & PMD_MASK; 
 		pmd++;
-	} while (address < end);
+	} while (address && (address < end));
 }
 
 static void unmap_page_range(struct mmu_gather *tlb,

