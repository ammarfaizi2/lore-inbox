Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWA3VYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWA3VYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWA3VYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:24:11 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:20204 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965012AbWA3VYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:24:07 -0500
Subject: [patch 7/8] mempool - Add mempool_create_slab_pool()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: penberg@cs.helsinki.fi, akpm@osdl.org
References: <20060130211951.225129000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 30 Jan 2006 13:24:05 -0800
Message-Id: <1138656245.20704.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment
(mempool-add_mempool_create_slab_pool.patch)
Create a simple wrapper function for the common case of creating a slab-based
mempool.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/mempool.h |    5 +++++
 1 files changed, 5 insertions(+)

Index: linux-2.6.16-rc1-mm4+mempool_work/include/linux/mempool.h
===================================================================
--- linux-2.6.16-rc1-mm4+mempool_work.orig/include/linux/mempool.h
+++ linux-2.6.16-rc1-mm4+mempool_work/include/linux/mempool.h
@@ -37,6 +37,11 @@ extern void mempool_free(void *element, 
  */
 void *mempool_alloc_slab(gfp_t gfp_mask, void *pool_data);
 void mempool_free_slab(void *element, void *pool_data);
+static inline mempool_t *mempool_create_slab_pool(int min_nr, kmem_cache_t *kc)
+{
+	return mempool_create(min_nr, mempool_alloc_slab, mempool_free_slab,
+			      (void *) kc);
+}
 
 /*
  * 2 mempool_alloc_t's and a mempool_free_t to kmalloc/kzalloc and kfree

--

