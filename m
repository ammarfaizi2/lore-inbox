Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422850AbWJUU4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422850AbWJUU4e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 16:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWJUU4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 16:56:34 -0400
Received: from mx3.cs.washington.edu ([128.208.3.132]:46566 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1422850AbWJUU4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 16:56:33 -0400
Date: Sat, 21 Oct 2006 13:56:30 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386 mm: substitute __va lookup with pfn_to_kaddr
Message-ID: <Pine.LNX.4.64N.0610211355010.29548@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Substitutes allocate_pgdat virtual address lookup with pfn_to_kaddr macro.

Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 arch/i386/mm/discontig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/i386/mm/discontig.c b/arch/i386/mm/discontig.c
index ddbdb03..103b76e 100644
--- a/arch/i386/mm/discontig.c
+++ b/arch/i386/mm/discontig.c
@@ -168,7 +168,7 @@ static void __init allocate_pgdat(int ni
 	if (nid && node_has_online_mem(nid))
 		NODE_DATA(nid) = (pg_data_t *)node_remap_start_vaddr[nid];
 	else {
-		NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
+		NODE_DATA(nid) = (pg_data_t *)(pfn_to_kaddr(min_low_pfn));
 		min_low_pfn += PFN_UP(sizeof(pg_data_t));
 	}
 }
