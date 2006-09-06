Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWIFGkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWIFGkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWIFGkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:40:18 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:16132 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S932557AbWIFFyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 01:54:52 -0400
Subject: Re: [patch 2/6] fault-injection capability for kmalloc. [bug fix]
From: Don Mullis <dwm@meer.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 22:50:58 -0700
Message-Id: <1157521858.9460.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilation when CONFIG_FAILSLAB=n .

Signed-off-by: Don Mullis <dwm@meer.net>

---
 mm/slab.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.17/mm/slab.c
===================================================================
--- linux-2.6.17.orig/mm/slab.c
+++ linux-2.6.17/mm/slab.c
@@ -2985,9 +2985,11 @@ static inline void *____cache_alloc(stru
 	void *objp;
 	struct array_cache *ac;
 
+#ifdef CONFIG_FAILSLAB
 	if (!(flags & __GFP_NOFAIL) && cachep != &cache_cache &&
 	    should_fail(failslab, obj_size(cachep)))
 		return NULL;
+#endif
 
 #ifdef CONFIG_NUMA
 	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {


