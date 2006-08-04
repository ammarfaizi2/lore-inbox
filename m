Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161141AbWHDNPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbWHDNPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWHDNOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:14:44 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:55191 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161124AbWHDNOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:14:36 -0400
Date: Fri, 4 Aug 2006 07:14:33 -0600
From: Keith Mannthey <kmannth@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, discuss@x86-64.org, Keith Mannthey <kmannth@us.ibm.com>,
       ak@suse.de, lhms-devel@lists.sourceforge.net,
       kamezawa.hiroyu@jp.fujitsu.com
Message-Id: <20060804131433.21401.59101.sendpatchset@localhost.localdomain>
In-Reply-To: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
Subject: [PATCH 8/10] hot-add-mem x86_64: use CONFIG_MEMORY_HOTPLUG_SPARSE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Mannthey <kmannth@us.ibm.com>

  Migate CONFIG_MEMORY_HOTPLUG to CONFIG_MEMORY_HOTPLUG_SPARSE where needed.

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
---
 drivers/base/Makefile  |    2 +-
 include/linux/memory.h |    4 ++--
 mm/memory_hotplug.c    |    4 +++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff -urN orig/drivers/base/Makefile current/drivers/base/Makefile
--- orig/drivers/base/Makefile	2006-08-04 00:41:17.000000000 -0400
+++ current/drivers/base/Makefile	2006-08-04 01:41:04.000000000 -0400
@@ -8,7 +8,7 @@
 obj-$(CONFIG_ISA)	+= isa.o
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
-obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
+obj-$(CONFIG_MEMORY_HOTPLUG_SPARSE) += memory.o
 obj-$(CONFIG_SMP)	+= topology.o
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 
diff -urN orig/include/linux/memory.h current/include/linux/memory.h
--- orig/include/linux/memory.h	2006-06-17 21:49:35.000000000 -0400
+++ current/include/linux/memory.h	2006-08-04 01:42:24.000000000 -0400
@@ -57,7 +57,7 @@
 struct notifier_block;
 struct mem_section;
 
-#ifndef CONFIG_MEMORY_HOTPLUG
+#ifndef CONFIG_MEMORY_HOTPLUG_SPARSE
 static inline int memory_dev_init(void)
 {
 	return 0;
@@ -78,7 +78,7 @@
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 
 
-#endif /* CONFIG_MEMORY_HOTPLUG */
+#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
 
 #define hotplug_memory_notifier(fn, pri) {			\
 	static struct notifier_block fn##_mem_nb =		\
diff -urN orig/mm/memory_hotplug.c current/mm/memory_hotplug.c
--- orig/mm/memory_hotplug.c	2006-08-04 00:54:44.000000000 -0400
+++ current/mm/memory_hotplug.c	2006-08-04 01:46:56.000000000 -0400
@@ -24,6 +24,7 @@
 
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
 static int __add_zone(struct zone *zone, unsigned long phys_start_pfn)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
@@ -189,7 +190,8 @@
 	vm_total_pages = nr_free_pagecache_pages();
 	return 0;
 }
-
+#endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
+ 
 static pg_data_t *hotadd_new_pgdat(int nid, u64 start)
 {
 	struct pglist_data *pgdat;
