Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWEZH6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWEZH6I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWEZH6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:58:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:49380 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750770AbWEZH6H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:58:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WsySnuXSOhQgYBgyoDnI9v4pVGb4R2yQkhc/g9F04jgM6FBD93W+JExHDvg+4LAQKYHzE3xS34xzGF/ku/gcki1RYvKeKKqw7gq+AIHAg+FpzVdCMsSFu19axG3FgTfWuuDH6C6DI1yC4yzsUaEiGZi4YvrGvMoxuheirkodWAY=
Message-ID: <36e6b2150605260058h5c1fbc0cla686a37d5bf3e34e@mail.gmail.com>
Date: Fri, 26 May 2006 11:58:06 +0400
From: "Paul Drynoff" <pauldrynoff@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] kmalloc man page before 2.6.17
Cc: "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com>
	 <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, this is not full duplication:
__do_kmalloc(size_t size, gfp_t flags,
                                          void *caller)
and
void *kmalloc(size_t size, gfp_t gfp)

they have different amount of arguments and different arguments names.

But as I see include/linux/slab.h is better place. See patch.

It will be great to create another entry for flags of "kmalloc* family
functions,
so we can avoid duplication of this in __do_kmalloc and kmalloc
comments, but I don't know is it possible with scripts/kernel-doc.

Signed-off-by: Paul Drynoff <pauldrynoff@gmail.com>

---

Index: linux-2.6.17-rc4/mm/slab.c
===================================================================
--- linux-2.6.17-rc4.orig/mm/slab.c
+++ linux-2.6.17-rc4/mm/slab.c
@@ -3244,7 +3244,7 @@ EXPORT_SYMBOL(kmalloc_node);
 #endif

 /**
- * kmalloc - allocate memory
+ * __do_kmalloc - allocate memory
  * @size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
  * @caller: function caller for debug tracking of the caller
Index: linux-2.6.17-rc4/include/linux/slab.h
===================================================================
--- linux-2.6.17-rc4.orig/include/linux/slab.h
+++ linux-2.6.17-rc4/include/linux/slab.h
@@ -87,6 +87,27 @@ extern void *__kmalloc_track_caller(size
     __kmalloc_track_caller(size, flags, __builtin_return_address(0))
 #endif

+/**
+ * kmalloc - allocate memory
+ * @size: how many bytes of memory are required.
+ * @gfp: the type of memory to allocate.
+ *
+ * kmalloc is the normal method of allocating memory
+ * in the kernel.
+ *
+ * The @gfp argument may be one of:
+ *
+ * %GFP_USER - Allocate memory on behalf of user.  May sleep.
+ *
+ * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
+ *
+ * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
+ *
+ * Additionally, the %GFP_DMA flag may be set to indicate the memory
+ * must be suitable for DMA.  This can mean different things on different
+ * platforms.  For example, on i386, it means that the memory must come
+ * from the first 16MB.
+ */
 static inline void *kmalloc(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size)) {
