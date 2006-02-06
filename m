Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWBFKzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWBFKzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWBFKzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:55:09 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:13455 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751077AbWBFKzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:55:07 -0500
Message-ID: <43E72B5D.5030402@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 19:56:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [7/25] h8300  pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks complicated..
original page_to_pfn() was
(((page - mem_map) << PAGE_SHIFT) + PAGE_OFFSET) >> PAGE_SHIFT.
This is same to
(unsigned long) (page - mem_map) + (PAGE_OFFSET >> PAGE_SHIFT).

h8300 can use generic ones.
Signed-Off-By: KAMEZAWA Hiruyoki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-h8300/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-h8300/page.h
+++ cleanup_pfn_page/include/asm-h8300/page.h
@@ -71,8 +71,7 @@ extern unsigned long memory_end;
  #define page_to_virt(page)	((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
  #define pfn_valid(page)	        (page < max_mapnr)

-#define pfn_to_page(pfn)	virt_to_page(pfn_to_virt(pfn))
-#define page_to_pfn(page)	virt_to_pfn(page_to_virt(page))
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)

  #define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
  				((void *)(kaddr) < (void *)memory_end))

