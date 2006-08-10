Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWHJUBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWHJUBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWHJT7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:59:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:63467 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932648AbWHJTgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:52 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [94/145] x86_64: Clean up acpi_numa variable
Message-Id: <20060810193651.B948113C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:51 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Move it into srat.c No need to clutter up setup.c for it

And remove use in setup.c completely - it only guarded a printk
which can be done unconditionally.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/setup.c |    5 +----
 arch/x86_64/mm/srat.c      |    2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -74,8 +74,6 @@ EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned long mmu_cr4_features;
 
-int acpi_numa __initdata;
-
 /* Boot loader ID as an integer, for the benefit of proc_dointvec */
 int bootloader_type;
 
@@ -814,8 +812,7 @@ static void srat_detect_node(void)
 		node = first_node(node_online_map);
 	numa_set_node(cpu, node);
 
-	if (acpi_numa > 0)
-		printk(KERN_INFO "CPU %d/%x -> Node %d\n", cpu, apicid, node);
+	printk(KERN_INFO "CPU %d/%x -> Node %d\n", cpu, apicid, node);
 #endif
 }
 
Index: linux/arch/x86_64/mm/srat.c
===================================================================
--- linux.orig/arch/x86_64/mm/srat.c
+++ linux/arch/x86_64/mm/srat.c
@@ -21,6 +21,8 @@
 #include <asm/numa.h>
 #include <asm/e820.h>
 
+int acpi_numa __initdata;
+
 #if (defined(CONFIG_ACPI_HOTPLUG_MEMORY) || \
 	defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)) \
 		&& !defined(CONFIG_MEMORY_HOTPLUG)
