Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWHTUSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWHTUSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWHTUSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:18:16 -0400
Received: from aun.it.uu.se ([130.238.12.36]:41900 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751205AbWHTUSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:18:16 -0400
Date: Sun, 20 Aug 2006 22:18:10 +0200 (MEST)
Message-Id: <200608202018.k7KKIAl4006428@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: w@1wt.eu
Subject: [PATCH 2.4.34-pre1] gcc4 fix for UP sparc64
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an invalid-lvalue error when compiling a
2.4.34-pre1 kernel on sparc64 with gcc-4.1.1. The kernel
must be configured with CONFIG_SMP=n for the error to trigger.
(I didn't save the error message, sorry.)

A kernel compiled with gcc-4.1.1 boots fine on my Ultra5
and can rebuild itself, and generally seems no less solid
than the 2.4.33 I compiled with gcc-3.4.6.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.4.34-pre1/arch/sparc64/mm/init.c.~1~	2004-11-17 18:36:41.000000000 +0100
+++ linux-2.4.34-pre1/arch/sparc64/mm/init.c	2006-08-20 20:52:20.000000000 +0200
@@ -95,7 +95,7 @@ int do_check_pgt_cache(int low, int high
                                 if (page2)
                                         page2->next_hash = page->next_hash;
                                 else
-                                        (struct page *)pgd_quicklist = page->next_hash;
+                                        pgd_quicklist = (unsigned long *)page->next_hash;
                                 page->next_hash = NULL;
                                 page->pprev_hash = NULL;
                                 pgd_cache_size -= 2;
