Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWEZIU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWEZIU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 04:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWEZIU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 04:20:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:16886 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750829AbWEZIU5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 04:20:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GfG5hpDgM/kNSXyfgRDqlm7/Gb1XhWWE3f9RjXaQpl81dvoPIoalt7+74f6zfiJvgRpZOLGFR4ZCVSHeLEOIgwuOHaYvBhp7PNOvkYtFbrXgEGPhYoDr6PAtKvl2DoIhqLDBGGF49dzV84yKAds/g4l3W12I323e42W7Jv76/gA=
Message-ID: <36e6b2150605260120s2fb692fegf4fef1eecf7c4674@mail.gmail.com>
Date: Fri, 26 May 2006 12:20:56 +0400
From: "Paul Drynoff" <pauldrynoff@gmail.com>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>, akpm@osdl.org
Subject: Re: [PATCH] kmalloc man page before 2.6.17
Cc: "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0605261059360.30386@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com>
	 <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com>
	 <36e6b2150605260058h5c1fbc0cla686a37d5bf3e34e@mail.gmail.com>
	 <Pine.LNX.4.58.0605261059360.30386@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kernel-doc doesn't produce the man page for "kmalloc",
I think that is a big lack of documentation. This patch should help.
Now
scripts/kernel-doc -man -function kmalloc include/linux/slab.h  |
nroff -man | less
creates suitable "man page".

Signed-off-by: Paul Drynoff <pauldrynoff@gmail.com>

---

Index: linux-2.6.17-rc4/mm/slab.c
===================================================================
--- linux-2.6.17-rc4.orig/mm/slab.c
+++ linux-2.6.17-rc4/mm/slab.c
@@ -3244,26 +3244,10 @@ EXPORT_SYMBOL(kmalloc_node);
 #endif

 /**
- * kmalloc - allocate memory
+ * __do_kmalloc - allocate memory
  * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate.
+ * @flags: the type of memory to allocate(see kmalloc).
  * @caller: function caller for debug tracking of the caller
- *
- * kmalloc is the normal method of allocating memory
- * in the kernel.
- *
- * The @flags argument may be one of:
- *
- * %GFP_USER - Allocate memory on behalf of user.  May sleep.
- *
- * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
- *
- * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handlers.
- *
- * Additionally, the %GFP_DMA flag may be set to indicate the memory
- * must be suitable for DMA.  This can mean different things on different
- * platforms.  For example, on i386, it means that the memory must come
- * from the first 16MB.
  */
 static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 					  void *caller)
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
