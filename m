Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUFHVZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUFHVZB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUFHVZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:25:01 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51938 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S264305AbUFHVY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:24:56 -0400
Date: Wed, 9 Jun 2004 00:24:56 +0300
From: Pekka J Enberg <penberg@cs.helsinki.fi>
Message-Id: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi>
Subject: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
To: linux-kernel@vger.kernel.org, tiwai@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce kcalloc() in linux/slab.h that is used to replace snd_calloc() and
snd_magic_calloc().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

 include/linux/slab.h |    1 +
 mm/slab.c            |   15 +++++++++++++++
 2 files changed, 16 insertions(+)

--- linux-2.6.6/include/linux/slab.h	2004-06-08 23:54:41.382519192 +0300
+++ alsa-2.6.6/include/linux/slab.h	2004-06-08 21:36:12.951592680 +0300
@@ -95,6 +95,7 @@ found:
 	return __kmalloc(size, flags);
 }
 
+extern void *kcalloc(size_t, int);
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
--- linux-2.6.6/mm/slab.c	2004-06-08 23:57:30.713776928 +0300
+++ alsa-2.6.6/mm/slab.c	2004-06-08 21:42:18.000000000 +0300
@@ -2332,6 +2332,21 @@ void kmem_cache_free (kmem_cache_t *cach
 EXPORT_SYMBOL(kmem_cache_free);
 
 /**
+ * kcalloc - allocate memory. The memory is set to zero.
+ * @size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate.
+ */
+void *kcalloc(size_t size, int flags)
+{
+	void *ret = kmalloc(size, flags);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
+}
+
+EXPORT_SYMBOL(kcalloc);
+
+/**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
