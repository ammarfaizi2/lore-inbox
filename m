Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWDCJRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWDCJRw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWDCJRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:17:52 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:30398 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751687AbWDCJRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:17:51 -0400
Date: Mon, 3 Apr 2006 18:19:26 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: rmk+lkml@arm.linux.org.uk, pavel@ucw.cz, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] arm's arch_local_page_offset() fix against 2.6.17-rc1
Message-Id: <20060403181926.38cb5abe.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes arch_local_page_offset(pfn,nid) in arm.
This new one (added by unify_pfn_to_page patches) is obviously buggy.

This macro calculate page offset in a node.

Note: about LOCAL_MAP_NR()
comment in arm's sub-archs says...

 /*
  * Given a kaddr, LOCAL_MAP_NR finds the owning node of the memory
  * and returns the index corresponding to the appropriate page in the
  * node's mem_map.
  */

but LOCAL_MAP_NR() is designed to be able to take both paddr and kaddr.
In this case, paddr is better.

Signed-Off-By:KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitu.com>

Index: linux-2.6.17-rc1/include/asm-arm/memory.h
===================================================================
--- linux-2.6.17-rc1.orig/include/asm-arm/memory.h
+++ linux-2.6.17-rc1/include/asm-arm/memory.h
@@ -188,7 +188,7 @@ static inline __deprecated void *bus_to_
  */
 #include <linux/numa.h>
 #define arch_pfn_to_nid(pfn)	(PFN_TO_NID(pfn))
-#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))
+#define arch_local_page_offset(pfn, nid) LOCAL_MAP_NR((pfn) << PAGE_SHIFT)
 
 #define pfn_valid(pfn)						\
 	({							\

