Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265902AbUFIUK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUFIUK4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbUFIUK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:10:56 -0400
Received: from smtp1.pp.htv.fi ([213.243.153.34]:14814 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S265902AbUFIUKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:10:54 -0400
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de
In-Reply-To: <20040609113455.U22989@build.pdx.osdl.net>
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi>
	 <20040609113455.U22989@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1086812001.13026.63.camel@cherry>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 23:13:21 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 21:34, Chris Wright wrote:
> This looks more like the kzalloc() that pops up every now and then.
> Wouldn't it make more sense to give kcalloc() a true calloc() style
> interface?

I can go either way. Takashi, do you want me to update the ALSA patches
to use this version?

		Pekka

diff -urN linux-2.6.6/include/linux/slab.h kcalloc-2.6.6/include/linux/slab.h
--- linux-2.6.6/include/linux/slab.h	2004-06-09 22:56:11.874249056 +0300
+++ kcalloc-2.6.6/include/linux/slab.h	2004-06-09 23:03:10.597593432 +0300
@@ -95,6 +95,7 @@
 	return __kmalloc(size, flags);
 }
 
+extern void *kcalloc(size_t, size_t, int);
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
diff -urN linux-2.6.6/mm/slab.c kcalloc-2.6.6/mm/slab.c
--- linux-2.6.6/mm/slab.c	2004-06-09 22:59:13.081701336 +0300
+++ kcalloc-2.6.6/mm/slab.c	2004-06-09 23:07:51.262925816 +0300
@@ -2332,6 +2332,22 @@
 EXPORT_SYMBOL(kmem_cache_free);
 
 /**
+ * kcalloc - allocate memory for an array. The memory is set to zero.
+ * @n: number of elements.
+ * @size: element size.
+ * @flags: the type of memory to allocate.
+ */
+void *kcalloc(size_t n, size_t size, int flags)
+{
+	void *ret = kmalloc(n * size, flags);
+	if (ret)
+		memset(ret, 0, n * size);
+	return ret;
+}
+
+EXPORT_SYMBOL(kcalloc);
+
+/**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *


