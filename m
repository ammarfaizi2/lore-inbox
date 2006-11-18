Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755989AbWKRFoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbWKRFoa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbWKRFoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:44:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36228 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753942AbWKRFoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:44:10 -0500
Date: Fri, 17 Nov 2006 21:43:58 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <clameter@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20061118054358.8884.63823.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 3/7] Move vm_area_cachep to mm.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move vm_area_cachep to mm.h

vm_area_cachep is used to store vm_area_structs. So move to mm.h.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm2/include/linux/mm.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/mm.h	2006-11-15 16:48:09.197243479 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/mm.h	2006-11-17 23:03:55.571905748 -0600
@@ -114,6 +114,8 @@ struct vm_area_struct {
 #endif
 };
 
+extern kmem_cache_t	*vm_area_cachep;
+
 /*
  * This struct defines the per-mm list of VMAs for uClinux. If CONFIG_MMU is
  * disabled, then there's a single shared list of VMAs maintained by the
Index: linux-2.6.19-rc5-mm2/include/linux/slab.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/slab.h	2006-11-17 23:03:51.817677214 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/slab.h	2006-11-17 23:03:55.587532089 -0600
@@ -297,7 +297,6 @@ static inline void kmem_set_shrinker(kme
 #endif /* CONFIG_SLOB */
 
 /* System wide caches */
-extern kmem_cache_t	*vm_area_cachep;
 extern kmem_cache_t	*names_cachep;
 extern kmem_cache_t	*files_cachep;
 extern kmem_cache_t	*filp_cachep;
