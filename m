Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWAYVh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWAYVh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWAYVhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:37:54 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:19651 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932153AbWAYVhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:37:40 -0500
Subject: [patch 4/9] mempool - Update mempool page allocator user
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
References: <20060125161321.647368000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 25 Jan 2006 11:40:05 -0800
Message-Id: <1138218005.2092.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (critical_mempools)
Fixup existing mempool users to use the new mempool API, part 1.

Fix the sole "indirect" user of mempool_alloc_pages to be aware of its new
'node_id' argument.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 highmem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc1+critical_mempools/mm/highmem.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/mm/highmem.c
+++ linux-2.6.16-rc1+critical_mempools/mm/highmem.c
@@ -30,9 +30,9 @@
 
 static mempool_t *page_pool, *isa_page_pool;
 
-static void *mempool_alloc_pages_isa(gfp_t gfp_mask, void *data)
+static void *mempool_alloc_pages_isa(gfp_t gfp_mask, int node_id, void *data)
 {
-	return mempool_alloc_pages(gfp_mask | GFP_DMA, data);
+	return mempool_alloc_pages(gfp_mask | GFP_DMA, node_id, data);
 }
 


--

