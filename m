Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbWHJTj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbWHJTj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWHJTi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:39313 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932688AbWHJThk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:40 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [130/145] i386: clean up topology.c
Message-Id: <20060810193729.EC90B13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:29 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Magnus Damm <magnus@valinux.co.jp>

There is no need to duplicate the topology_init() function.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/i386/kernel/topology.c |   21 +++------------------
 1 files changed, 3 insertions(+), 18 deletions(-)

Index: linux/arch/i386/kernel/topology.c
===================================================================
--- linux.orig/arch/i386/kernel/topology.c
+++ linux/arch/i386/kernel/topology.c
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
