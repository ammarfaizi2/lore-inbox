Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755983AbWKRFpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983AbWKRFpB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755886AbWKRFoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:44:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39812 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1755992AbWKRFo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:44:28 -0500
Date: Fri, 17 Nov 2006 21:44:18 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <clameter@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20061118054418.8884.30021.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 7/7] Move names_cachep to fs.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move names_cachep to fs.h

The names_cachep is used for getname() and putname(). So lets
put it into fs.h.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm2/include/linux/slab.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/slab.h	2006-11-17 23:04:09.679562142 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/slab.h	2006-11-17 23:04:13.548058299 -0600
@@ -296,9 +296,6 @@ static inline void kmem_set_shrinker(kme
 
 #endif /* CONFIG_SLOB */
 
-/* System wide caches */
-extern kmem_cache_t	*names_cachep;
-
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
Index: linux-2.6.19-rc5-mm2/include/linux/fs.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/fs.h	2006-11-15 16:48:08.629815618 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/fs.h	2006-11-17 23:04:13.586147506 -0600
@@ -1558,6 +1558,8 @@ extern char * getname(const char __user 
 extern void __init vfs_caches_init_early(void);
 extern void __init vfs_caches_init(unsigned long);
 
+extern kmem_cache_t	*names_cachep;
+
 #define __getname()	kmem_cache_alloc(names_cachep, SLAB_KERNEL)
 #define __putname(name) kmem_cache_free(names_cachep, (void *)(name))
 #ifndef CONFIG_AUDITSYSCALL
