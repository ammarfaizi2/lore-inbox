Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWHMKRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWHMKRB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 06:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWHMKRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 06:17:01 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:42081 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750919AbWHMKRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 06:17:00 -0400
Date: Sun, 13 Aug 2006 18:16:54 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [PATCH] check return value of kmalloc() in setup_cpu_cache()
Message-ID: <20060813101654.GB8703@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes crash happen when allocation of cpucache data fails
in setup_cpu_cache(). It is a bit better than getting kernel NULL
pointer dereference later.

CC: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 mm/slab.c |    1 +
 1 file changed, 1 insertion(+)

Index: work-failmalloc/mm/slab.c
===================================================================
--- work-failmalloc.orig/mm/slab.c
+++ work-failmalloc/mm/slab.c
@@ -1932,6 +1932,7 @@ static void setup_cpu_cache(struct kmem_
 	} else {
 		cachep->array[smp_processor_id()] =
 			kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+		BUG_ON(!cachep->array[smp_processor_id()]);
 
 		if (g_cpucache_up == PARTIAL_AC) {
 			set_up_list3s(cachep, SIZE_L3);
