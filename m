Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbULEPea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbULEPea (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 10:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbULEPea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 10:34:30 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:14738 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261179AbULEPeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 10:34:21 -0500
Date: Sun, 5 Dec 2004 16:33:42 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] Document kfree and vfree NULL usage (resend)
In-Reply-To: <1102103282.17778.9.camel@localhost>
Message-ID: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I think it's worth to explicitely mention that kfree(NULL) is valid - too
many users have/had their own (unnecessary) if(ptr) checks.

Pekka wrote:
>
> This patch adds comments for kfree() and vfree() stating that both
> accept NULL pointers.
>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
>
Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

---

 slab.c    |    2 ++
 vmalloc.c |    3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: 2.6.10-rc2/mm/slab.c
===================================================================
--- 2.6.10-rc2.orig/mm/slab.c	2004-11-27 14:33:14.000000000 +0200
+++ 2.6.10-rc2/mm/slab.c	2004-11-27 16:12:54.573387384 +0200
@@ -2535,6 +2535,8 @@
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
+ * If @objp is NULL, no operation is performed.
+ *
  * Don't free memory not originally allocated by kmalloc()
  * or you will run into trouble.
  */
Index: 2.6.10-rc2/mm/vmalloc.c
===================================================================
--- 2.6.10-rc2.orig/mm/vmalloc.c	2004-11-27 16:13:48.026261312 +0200
+++ 2.6.10-rc2/mm/vmalloc.c	2004-11-27 16:14:04.875699808 +0200
@@ -389,7 +389,8 @@
  *	@addr:		memory base address
  *
  *	Free the virtually contiguous memory area starting at @addr, as
- *	obtained from vmalloc(), vmalloc_32() or __vmalloc().
+ *	obtained from vmalloc(), vmalloc_32() or __vmalloc(). If @addr is
+ *	NULL, no operation is performed.
  *
  *	May not be called in interrupt context.
  */



