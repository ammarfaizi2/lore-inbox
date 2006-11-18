Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753952AbWKRFpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbWKRFpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbWKRFog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:44:36 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:37508 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1755886AbWKRFoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:44:18 -0500
Date: Fri, 17 Nov 2006 21:44:08 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <clameter@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20061118054408.8884.53656.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 5/7] Use external declaration for filep_cachep
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use external declaration for filep_cachep.

filp_cachep is used in fs/file_table.c. Its defined in fs/dcache.c.
The easiest solution here is to add an external declaration to
fs/file_table.c.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm2/include/linux/slab.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/slab.h	2006-11-17 23:03:59.268512148 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/slab.h	2006-11-17 23:04:05.859898302 -0600
@@ -298,7 +298,6 @@ static inline void kmem_set_shrinker(kme
 
 /* System wide caches */
 extern kmem_cache_t	*names_cachep;
-extern kmem_cache_t	*filp_cachep;
 extern kmem_cache_t	*fs_cachep;
 
 #endif	/* __KERNEL__ */
Index: linux-2.6.19-rc5-mm2/fs/file_table.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/fs/file_table.c	2006-11-15 16:47:59.622264626 -0600
+++ linux-2.6.19-rc5-mm2/fs/file_table.c	2006-11-17 23:04:05.885291107 -0600
@@ -35,6 +35,8 @@ __cacheline_aligned_in_smp DEFINE_SPINLO
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
+extern kmem_cache_t *filp_cachep;
+
 static inline void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f =  container_of(head, struct file, f_u.fu_rcuhead);
