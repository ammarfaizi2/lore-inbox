Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753942AbWKRFpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbWKRFpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbWKRFoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:44:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:38635 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1755983AbWKRFoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:44:24 -0500
Date: Fri, 17 Nov 2006 21:44:13 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Manfred Spraul <manfred@colorfullife.com>,
       Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Message-Id: <20061118054413.8884.99940.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 6/7] Use an external declaration in exit.c for fs_cachep
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use an external declaration in exit.c for fs_cachep.

fs_cachep is only used in kernel/exit.c and in kernel/fork.c.
It is defined in kernel/fork.c so we need to add an external
declaration to kernel/exit.c to be able to avoid the
declaration.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm2/include/linux/slab.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/slab.h	2006-11-17 23:04:05.859898302 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/slab.h	2006-11-17 23:04:09.679562142 -0600
@@ -298,7 +298,6 @@ static inline void kmem_set_shrinker(kme
 
 /* System wide caches */
 extern kmem_cache_t	*names_cachep;
-extern kmem_cache_t	*fs_cachep;
 
 #endif	/* __KERNEL__ */
 
Index: linux-2.6.19-rc5-mm2/kernel/exit.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/exit.c	2006-11-15 16:48:11.485511089 -0600
+++ linux-2.6.19-rc5-mm2/kernel/exit.c	2006-11-17 23:04:09.764530373 -0600
@@ -48,6 +48,8 @@
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
 
+extern kmem_cache_t *fs_cachep;
+
 extern void sem_exit (void);
 
 static void exit_mm(struct task_struct * tsk);
