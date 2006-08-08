Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWHHTer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWHHTer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWHHTeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:34:46 -0400
Received: from [213.46.243.16] ([213.46.243.16]:62078 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030240AbWHHTeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:34:12 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 08 Aug 2006 21:33:35 +0200
Message-Id: <20060808193335.1396.67083.sendpatchset@lappy>
In-Reply-To: <20060808193325.1396.58813.sendpatchset@lappy>
References: <20060808193325.1396.58813.sendpatchset@lappy>
Subject: [RFC][PATCH 1/9] pfn_to_kaddr() for UML
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update UML with a proper 'pfn_to_kaddr()' definition, the VM deadlock
avoidance framework uses it.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Daniel Phillips <phillips@google.com>

---
 include/asm-um/page.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/include/asm-um/page.h
===================================================================
--- linux-2.6.orig/include/asm-um/page.h
+++ linux-2.6/include/asm-um/page.h
@@ -111,6 +111,8 @@ extern unsigned long uml_physmem;
 #define pfn_valid(pfn) ((pfn) < max_mapnr)
 #define virt_addr_valid(v) pfn_valid(phys_to_pfn(__pa(v)))
 
+#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+
 extern struct page *arch_validate(struct page *page, gfp_t mask, int order);
 #define HAVE_ARCH_VALIDATE
 
