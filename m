Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTH2U5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTH2U5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:57:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:27123 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263584AbTH2U5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:57:03 -0400
Date: Fri, 29 Aug 2003 21:58:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] even number of kmap types
Message-ID: <Pine.LNX.4.44.0308292157040.1816-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the warning comment in kmap_types.h: if you add an odd number of
new kmaps, KM_VSTACK0 becomes misaligned on odd numbered cpus.  I've not
added a corresponding BUG_ON to entry_trampoline.c, having an aversion
to errors which trigger too early to be seen.  We should do better,
perhaps #error, or robustifying the layout; but for now just comment.

Hugh

--- 2.6.0-test4-mm3-1/include/asm-i386/kmap_types.h	Fri Aug 29 16:31:40 2003
+++ linux/include/asm-i386/kmap_types.h	Fri Aug 29 20:53:33 2003
@@ -5,8 +5,8 @@
 
 enum km_type {
 	/*
-	 * IMPORTANT: dont move these 3 entries, the virtual stack
-	 * must be 8K aligned.
+	 * IMPORTANT: don't move these 3 entries, and only add entries in
+	 * pairs: the 4G/4G virtual stack must be 8K aligned on each cpu.
 	 */
 	KM_BOUNCE_READ,
 	KM_VSTACK1,
@@ -29,6 +29,10 @@
 	KM_IRQ1,
 	KM_SOFTIRQ0,
 	KM_SOFTIRQ1,
+	/*
+	 * Add new entries in pairs:
+	 * the 4G/4G virtual stack must be 8K aligned on each cpu.
+	 */
 	KM_TYPE_NR
 };
 #endif

