Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTAZXFX>; Sun, 26 Jan 2003 18:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbTAZXFX>; Sun, 26 Jan 2003 18:05:23 -0500
Received: from hera.cwi.nl ([192.16.191.8]:54524 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267048AbTAZXFW>;
	Sun, 26 Jan 2003 18:05:22 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 27 Jan 2003 00:14:32 +0100 (MET)
Message-Id: <UTC200301262314.h0QNEWm00231.aeb@smtp.cwi.nl>
To: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH?] slab.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In slab.c the routine check_poison_obj() is called.
That routine does nothing except return 0 or 1.
Thus it looks like the present call in slab_destroy()
is meaningless. Perhaps something like this was meant?

--- slab.c~	Sat Jan 18 23:54:30 2003
+++ slab.c	Mon Jan 27 00:05:47 2003
@@ -796,7 +796,8 @@
 		void *objp = slabp->s_mem + cachep->objsize * i;
 
 		if (cachep->flags & SLAB_POISON)
-			check_poison_obj(cachep, objp);
+			if (check_poison_obj(cachep, objp))
+				BUG();
 
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*((unsigned long*)(objp)) != RED_INACTIVE)

A BUG() was lost in patch 2.5.45.

Andries
