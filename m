Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030531AbVIOQmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030531AbVIOQmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030534AbVIOQmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:42:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27800 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030531AbVIOQmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:42:23 -0400
Subject: [PATCH 2/2] memory hotplug: make more things static
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 15 Sep 2005 09:42:19 -0700
References: <20050915164218.AD02EDC0@kernel.beaverton.ibm.com>
In-Reply-To: <20050915164218.AD02EDC0@kernel.beaverton.ibm.com>
Message-Id: <20050915164219.324FF3C1@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a result of reviewing all of the memory hotplug
functions for what can be made static with findstatic.pl.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/drivers/base/memory.c |   20 ++++++++++----------
 memhotplug-dave/mm/memory_hotplug.c   |    2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff -puN drivers/base/memory.c~A2-memory-hotplug-make-things-static drivers/base/memory.c
--- memhotplug/drivers/base/memory.c~A2-memory-hotplug-make-things-static	2005-09-15 09:41:38.000000000 -0700
+++ memhotplug-dave/drivers/base/memory.c	2005-09-15 09:41:38.000000000 -0700
@@ -25,7 +25,7 @@
 
 #define MEMORY_CLASS_NAME	"memory"
 
-struct sysdev_class memory_sysdev_class = {
+static struct sysdev_class memory_sysdev_class = {
 	set_kset_name(MEMORY_CLASS_NAME),
 };
 EXPORT_SYMBOL(memory_sysdev_class);
@@ -50,12 +50,12 @@ static struct kset_hotplug_ops memory_ho
 
 static struct notifier_block *memory_chain;
 
-int register_memory_notifier(struct notifier_block *nb)
+static int register_memory_notifier(struct notifier_block *nb)
 {
         return notifier_chain_register(&memory_chain, nb);
 }
 
-void unregister_memory_notifier(struct notifier_block *nb)
+static void unregister_memory_notifier(struct notifier_block *nb)
 {
         notifier_chain_unregister(&memory_chain, nb);
 }
@@ -63,7 +63,7 @@ void unregister_memory_notifier(struct n
 /*
  * register_memory - Setup a sysfs device for a memory block
  */
-int
+static int
 register_memory(struct memory_block *memory, struct mem_section *section,
 		struct node *root)
 {
@@ -82,7 +82,7 @@ register_memory(struct memory_block *mem
 	return error;
 }
 
-void
+static void
 unregister_memory(struct memory_block *memory, struct mem_section *section,
 		struct node *root)
 {
@@ -270,9 +270,9 @@ static ssize_t show_phys_device(struct s
 	return sprintf(buf, "%d\n", mem->phys_device);
 }
 
-SYSDEV_ATTR(phys_index, 0444, show_mem_phys_index, NULL);
-SYSDEV_ATTR(state, 0644, show_mem_state, store_mem_state);
-SYSDEV_ATTR(phys_device, 0444, show_phys_device, NULL);
+static SYSDEV_ATTR(phys_index, 0444, show_mem_phys_index, NULL);
+static SYSDEV_ATTR(state, 0644, show_mem_state, store_mem_state);
+static SYSDEV_ATTR(phys_device, 0444, show_phys_device, NULL);
 
 #define mem_create_simple_file(mem, attr_name)	\
 	sysdev_create_file(&mem->sysdev, &attr_##attr_name)
@@ -337,7 +337,7 @@ static int memory_probe_init(void)
  * section belongs to...
  */
 
-int add_memory_block(unsigned long node_id, struct mem_section *section,
+static int add_memory_block(unsigned long node_id, struct mem_section *section,
 		     unsigned long state, int phys_device)
 {
 	size_t size = sizeof(struct memory_block);
@@ -373,7 +373,7 @@ int add_memory_block(unsigned long node_
  *
  * This could be made generic for all sysdev classes.
  */
-struct memory_block *find_memory_block(struct mem_section *section)
+static struct memory_block *find_memory_block(struct mem_section *section)
 {
 	struct kobject *kobj;
 	struct sys_device *sysdev;
diff -puN mm/memory_hotplug.c~A2-memory-hotplug-make-things-static mm/memory_hotplug.c
--- memhotplug/mm/memory_hotplug.c~A2-memory-hotplug-make-things-static	2005-09-15 09:41:38.000000000 -0700
+++ memhotplug-dave/mm/memory_hotplug.c	2005-09-15 09:41:38.000000000 -0700
@@ -40,7 +40,7 @@ static void __add_zone(struct zone *zone
 
 extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
 				  struct page *mem_map);
-int __add_section(struct zone *zone, unsigned long phys_start_pfn)
+static int __add_section(struct zone *zone, unsigned long phys_start_pfn)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	int nr_pages = PAGES_PER_SECTION;
_
