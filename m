Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269812AbUJGMig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269812AbUJGMig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUJGMhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:37:53 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:17036 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269714AbUJGMgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:36:37 -0400
Date: Thu, 07 Oct 2004 21:42:05 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [PATCH] no buddy bitmap patch : for ia64 [2/2]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>, Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <4165399D.7010600@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for ia64.
Add HOLES_IN_ZONE macro definition and align vmemmap with ia64's granule size.

Kame <kamezawa.hiroyu@jp.fujitsu.com>

=== for arch/ia64 ===============
This patch is for ia64 kernel.
This defines HOLES_IN_ZONE in asm-ia64/page.h
And makes vmemmap aligned with IA64_GRANULE_SIZE in arch/ia64/mm/init.c.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


---

 test-kernel-kamezawa/arch/ia64/mm/init.c     |    3 ++-
 test-kernel-kamezawa/include/asm-ia64/page.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -puN include/asm-ia64/page.h~ia64_fix include/asm-ia64/page.h
--- test-kernel/include/asm-ia64/page.h~ia64_fix	2004-10-07 19:40:30.953218680 +0900
+++ test-kernel-kamezawa/include/asm-ia64/page.h	2004-10-07 19:40:30.958217920 +0900
@@ -79,6 +79,7 @@ do {						\

 #ifdef CONFIG_VIRTUAL_MEM_MAP
 extern int ia64_pfn_valid (unsigned long pfn);
+#define HOLES_IN_ZONE 1
 #else
 # define ia64_pfn_valid(pfn) 1
 #endif
diff -puN arch/ia64/mm/init.c~ia64_fix arch/ia64/mm/init.c
--- test-kernel/arch/ia64/mm/init.c~ia64_fix	2004-10-07 19:40:30.955218376 +0900
+++ test-kernel-kamezawa/arch/ia64/mm/init.c	2004-10-07 19:40:30.959217768 +0900
@@ -410,7 +410,8 @@ virtual_memmap_init (u64 start, u64 end,
 	struct page *map_start, *map_end;

 	args = (struct memmap_init_callback_data *) arg;
-
+	start = GRANULEROUNDDOWN(start);
+	end = GRANULEROUNDUP(end);
 	map_start = vmem_map + (__pa(start) >> PAGE_SHIFT);
 	map_end   = vmem_map + (__pa(end) >> PAGE_SHIFT);


_

