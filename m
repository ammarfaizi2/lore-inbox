Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWEZHHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWEZHHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWEZHHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:07:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:62143 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751326AbWEZHHX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:07:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eQduaKgaTSrYnrREqfEXB9et+ezsWMMnozo4k8O8ncXb/FqSNVqwmRdWV1RGjbD0Q4TY496+ytgCtih8dsBuzy4Uq/BNn9b7SYN8EJau7Rr+7nR95//x5xg+TXmFRBicMYIORSGy0QutxND+mS6GOtG9dThOCqud9ILmlk3iKDs=
Message-ID: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com>
Date: Fri, 26 May 2006 11:07:23 +0400
From: "Paul Drynoff" <pauldrynoff@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: [PATCH] kmalloc man page before 2.6.17
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Currently I with my colleague dispute about quality of code
Linux vs other. And he fairly point me that linux kernel even
have no manual entry for "kmalloc".

So please consider include this or similar patch before 2.6.17.
With this patch
scripts/kernel-doc -man -function kmalloc mm/slob.c  | nroff -man | less
create man page for "kmalloc"

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
Index: linux-2.6.17-rc4/mm/slob.c
===================================================================
--- linux-2.6.17-rc4.orig/mm/slob.c
+++ linux-2.6.17-rc4/mm/slob.c
@@ -158,6 +158,27 @@ static int fastcall find_order(int size)
 	return order;
 }

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
 void *kmalloc(size_t size, gfp_t gfp)
 {
 	slob_t *m;
