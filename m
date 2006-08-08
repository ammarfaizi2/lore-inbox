Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWHHIEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWHHIEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWHHIEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:04:32 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:47012 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932133AbWHHIEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:04:31 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20060808080612.305.28017.sendpatchset@cherry.local>
Subject: [PATCH] i386: clean up topology.c
Date: Tue,  8 Aug 2006 17:05:16 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: clean up topology.c

There is no need to duplicate the topology_init() function.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 topology.c |   21 +++------------------
 1 files changed, 3 insertions(+), 18 deletions(-)

--- 0001/arch/i386/kernel/topology.c
+++ work/arch/i386/kernel/topology.c	2006-08-07 17:39:20.000000000 +0900
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/nodemask.h>
+#include <linux/mmzone.h>
 #include <asm/cpu.h>
 
 static struct i386_cpu cpu_devices[NR_CPUS];
@@ -55,34 +56,18 @@ EXPORT_SYMBOL(arch_register_cpu);
 EXPORT_SYMBOL(arch_unregister_cpu);
 #endif /*CONFIG_HOTPLUG_CPU*/
 
-
-
-#ifdef CONFIG_NUMA
-#include <linux/mmzone.h>
-
 static int __init topology_init(void)
 {
 	int i;
 
+#ifdef CONFIG_NUMA
 	for_each_online_node(i)
 		register_one_node(i);
+#endif /* CONFIG_NUMA */
 
 	for_each_present_cpu(i)
 		arch_register_cpu(i);
 	return 0;
 }
 
-#else /* !CONFIG_NUMA */
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for_each_present_cpu(i)
-		arch_register_cpu(i);
-	return 0;
-}
-
-#endif /* CONFIG_NUMA */
-
 subsys_initcall(topology_init);
