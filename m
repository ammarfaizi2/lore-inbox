Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269874AbUJHMGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269874AbUJHMGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 08:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269873AbUJHMGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 08:06:14 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53431 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269874AbUJHMGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 08:06:07 -0400
Date: Fri, 08 Oct 2004 21:11:38 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [PATCH] no buddy bitmap patch revist : for ia64 [2/2]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-mm <linux-mm@kvack.org>,
       LHMS <lhms-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       Tony Luck <tony.luck@intel.com>, Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <416683FA.5060406@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for ia64.
CONFIG_HOLES_IN_ZONE is added to Kconfig.
It is set automaically if CONFIG_VIRTUAL_MEMMAP=y.

Thanks.
Kame <kamezawa.hiroyu@jp.fujitsu.com>
=========== for ia64 stuff==========


This patch is for ia64 kernel.
This defines CONFIG_HOLES_IN_ZONE in arch/ia64/Kconfig.
IA64 has memory holes smaller than its MAX_ORDER and its virtual memmap
allows holes in a zone's memmap.

This patch makes vmemmap aligned with IA64_GRANULE_SIZE in
arch/ia64/mm/init.c.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


---

 test-kernel-kamezawa/arch/ia64/Kconfig   |    4 ++++
 test-kernel-kamezawa/arch/ia64/mm/init.c |    3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff -puN arch/ia64/mm/init.c~ia64_fix arch/ia64/mm/init.c
--- test-kernel/arch/ia64/mm/init.c~ia64_fix	2004-10-08 18:29:20.510992392 +0900
+++ test-kernel-kamezawa/arch/ia64/mm/init.c	2004-10-08 18:29:20.515991632 +0900
@@ -410,7 +410,8 @@ virtual_memmap_init (u64 start, u64 end,
 	struct page *map_start, *map_end;

 	args = (struct memmap_init_callback_data *) arg;
-
+	start = GRANULEROUNDDOWN(start);
+	end = GRANULEROUNDUP(end);
 	map_start = vmem_map + (__pa(start) >> PAGE_SHIFT);
 	map_end   = vmem_map + (__pa(end) >> PAGE_SHIFT);

diff -puN arch/ia64/Kconfig~ia64_fix arch/ia64/Kconfig
--- test-kernel/arch/ia64/Kconfig~ia64_fix	2004-10-08 18:29:20.513991936 +0900
+++ test-kernel-kamezawa/arch/ia64/Kconfig	2004-10-08 18:29:20.516991480 +0900
@@ -178,6 +178,10 @@ config VIRTUAL_MEM_MAP
 	  require the DISCONTIGMEM option for your machine. If you are
 	  unsure, say Y.

+config HOLES_IN_ZONE
+	bool
+	default y if VIRTUAL_MEM_MAP
+
 config DISCONTIGMEM
 	bool "Discontiguous memory support"
 	depends on (IA64_DIG || IA64_SGI_SN2 || IA64_GENERIC || IA64_HP_ZX1) && NUMA && VIRTUAL_MEM_MAP

_

