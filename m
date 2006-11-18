Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753932AbWKRFoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbWKRFoF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbWKRFoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:44:05 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36331 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1753932AbWKRFoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:44:02 -0500
Date: Fri, 17 Nov 2006 21:43:47 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <clameter@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Message-Id: <20061118054347.8884.36259.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 1/7] Remove declaration of sighand_cachep from slab.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove declaration of sighand_cachep from slab.h

The sighand cache is only used in fs/exec.c and kernel/fork.c. It is defined
in kernel/fork.c but also used in fs/exec.c. So add an extern declaration to
fs/exec.c and remove the definition from slab.h.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm2/fs/exec.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/fs/exec.c	2006-11-15 16:47:59.065579813 -0600
+++ linux-2.6.19-rc5-mm2/fs/exec.c	2006-11-17 23:03:46.049603927 -0600
@@ -62,6 +62,8 @@ int core_uses_pid;
 char core_pattern[128] = "core";
 int suid_dumpable = 0;
 
+extern kmem_cache_t	*sighand_cachep;
+
 EXPORT_SYMBOL(suid_dumpable);
 /* The maximal length of core_pattern is also specified in sysctl.c */
 
Index: linux-2.6.19-rc5-mm2/include/linux/slab.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/slab.h	2006-11-17 23:02:21.371436329 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/slab.h	2006-11-17 23:03:46.114062585 -0600
@@ -302,7 +302,6 @@ extern kmem_cache_t	*names_cachep;
 extern kmem_cache_t	*files_cachep;
 extern kmem_cache_t	*filp_cachep;
 extern kmem_cache_t	*fs_cachep;
-extern kmem_cache_t	*sighand_cachep;
 extern kmem_cache_t	*bio_cachep;
 
 #endif	/* __KERNEL__ */
