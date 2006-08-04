Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWHDNOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWHDNOe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWHDNOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:14:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:7632 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030337AbWHDNOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:14:21 -0400
Date: Fri, 4 Aug 2006 07:13:57 -0600
From: Keith Mannthey <kmannth@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, discuss@x86-64.org, Keith Mannthey <kmannth@us.ibm.com>,
       ak@suse.de, lhms-devel@lists.sourceforge.net,
       kamezawa.hiroyu@jp.fujitsu.com
Message-Id: <20060804131357.21401.99062.sendpatchset@localhost.localdomain>
In-Reply-To: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
References: <20060804131351.21401.4877.sendpatchset@localhost.localdomain>
Subject: [PATCH 2/10] hot-add-mem x86_64: fixup externs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Mannthey <kmannth@us.ibm.com>

fixup externs in memory_hotplug.c.  Cleanup. 

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
---
 include/linux/memory_hotplug.h |    2 ++
 include/linux/mm.h             |    2 ++
 mm/memory_hotplug.c            |    4 ----
 3 files changed, 4 insertions(+), 4 deletions(-)

diff -urN orig/include/linux/memory_hotplug.h current/include/linux/memory_hotplug.h
--- orig/include/linux/memory_hotplug.h	2006-08-04 00:41:19.000000000 -0400
+++ current/include/linux/memory_hotplug.h	2006-08-04 00:50:34.000000000 -0400
@@ -172,5 +172,7 @@
 extern int add_memory(int nid, u64 start, u64 size);
 extern int arch_add_memory(int nid, u64 start, u64 size);
 extern int remove_memory(u64 start, u64 size);
+extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
+								int nr_pages);
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff -urN orig/include/linux/mm.h current/include/linux/mm.h
--- orig/include/linux/mm.h	2006-08-04 00:41:19.000000000 -0400
+++ current/include/linux/mm.h	2006-08-04 00:47:49.000000000 -0400
@@ -884,6 +884,8 @@
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
+extern void zonetable_add(struct zone *zone, int nid, int zid, 
+					unsigned long pfn, unsigned long size);
 
 #ifdef CONFIG_NUMA
 extern void setup_per_cpu_pageset(void);
diff -urN orig/mm/memory_hotplug.c current/mm/memory_hotplug.c
--- orig/mm/memory_hotplug.c	2006-08-04 00:42:02.000000000 -0400
+++ current/mm/memory_hotplug.c	2006-08-04 00:47:49.000000000 -0400
@@ -24,8 +24,6 @@
 
 #include <asm/tlbflush.h>
 
-extern void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
-			  unsigned long size);
 static int __add_zone(struct zone *zone, unsigned long phys_start_pfn)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
@@ -45,8 +43,6 @@
 	return 0;
 }
 
-extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
-				  int nr_pages);
 static int __add_section(struct zone *zone, unsigned long phys_start_pfn)
 {
 	int nr_pages = PAGES_PER_SECTION;
