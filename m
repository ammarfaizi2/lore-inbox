Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755886AbWKRFpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbWKRFpD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbWKRFoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:44:32 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36740 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753952AbWKRFoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:44:13 -0500
Date: Fri, 17 Nov 2006 21:44:03 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Manfred Spraul <manfred@colorfullife.com>,
       Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Message-Id: <20061118054403.8884.32124.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 4/7] Move files_cachep to file.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move files_cachep to file.h

The proper place is in file.h since its related to file I/O.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm2/include/linux/file.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/file.h	2006-11-15 16:48:08.583913536 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/file.h	2006-11-17 23:03:59.254839099 -0600
@@ -101,4 +101,6 @@ struct files_struct *get_files_struct(st
 void FASTCALL(put_files_struct(struct files_struct *fs));
 void reset_files_struct(struct task_struct *, struct files_struct *);
 
+extern kmem_cache_t	*files_cachep;
+
 #endif /* __LINUX_FILE_H */
Index: linux-2.6.19-rc5-mm2/include/linux/slab.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/slab.h	2006-11-17 23:03:55.587532089 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/slab.h	2006-11-17 23:03:59.268512148 -0600
@@ -298,7 +298,6 @@ static inline void kmem_set_shrinker(kme
 
 /* System wide caches */
 extern kmem_cache_t	*names_cachep;
-extern kmem_cache_t	*files_cachep;
 extern kmem_cache_t	*filp_cachep;
 extern kmem_cache_t	*fs_cachep;
 
