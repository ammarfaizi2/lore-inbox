Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWDXIek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWDXIek (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbWDXIeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:34:21 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:39780 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751177AbWDXIeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:34:16 -0400
Message-Id: <20060424083342.743876000@localhost.localdomain>
References: <20060424083333.217677000@localhost.localdomain>
Date: Mon, 24 Apr 2006 16:33:37 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Akinobu Mita <mita@miraclelinux.com>,
       Matt Mackall <mpm@selenic.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: [patch 4/4] change slab poison pattern
Content-Disposition: inline; filename=poison-pattern.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kref debugging cannot detect kref_put() with unreferenced object,
when the structure including kref is allocated by slab
and slab debugging config is enabled.

Because use-after-free poisoning make kref counter signed value.
So this patch prevents it by changing poisoning pattern.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
CC: Matt Mackall <mpm@selenic.com>
CC: Manfred Spraul <manfred@colorfullife.com>
CC: Pekka J Enberg <penberg@cs.helsinki.fi>

 mm/slab.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: 2.6-git/mm/slab.c
===================================================================
--- 2.6-git.orig/mm/slab.c
+++ 2.6-git/mm/slab.c
@@ -503,9 +503,9 @@ struct kmem_cache {
 #define	RED_ACTIVE	0x170FC2A5UL	/* when obj is active */
 
 /* ...and for poisoning */
-#define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
-#define POISON_FREE	0x6b	/* for use-after-free poisoning */
-#define	POISON_END	0xa5	/* end-byte of poisoning */
+#define	POISON_INUSE	0xa5	/* for use-uninitialised poisoning */
+#define POISON_FREE	0xb6	/* for use-after-free poisoning */
+#define	POISON_END	0xab	/* end-byte of poisoning */
 
 /*
  * memory layout of objects:

--
