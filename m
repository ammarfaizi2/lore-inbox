Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030550AbWBHF7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbWBHF7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWBHF7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:59:19 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:52368 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030550AbWBHF7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:59:18 -0500
Message-ID: <43E988E4.70409@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:00:04 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: ysato@users.sourceforge.jp
Subject: [PATCH] unify pfn_to_page take 2 [10/25] h8300 funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks complicated..
ex) page_to_pfn()
(((page - mem_map) << PAGE_SHIFT) + PAGE_OFFSET) >> PAGE_SHIFT
is same to
(page - mem_map) + (PAGE_OFFSET >> PAGE_SHIFT)

H8300 can use generic ones.
Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-h8300/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-h8300/page.h
+++ test-layout-free-zone/include/asm-h8300/page.h
@@ -71,8 +71,7 @@ extern unsigned long memory_end;
  #define page_to_virt(page)	((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
  #define pfn_valid(page)	        (page < max_mapnr)

-#define pfn_to_page(pfn)	virt_to_page(pfn_to_virt(pfn))
-#define page_to_pfn(page)	virt_to_pfn(page_to_virt(page))
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)

  #define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
  				((void *)(kaddr) < (void *)memory_end))

