Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWBQNaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWBQNaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWBQNai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:30:38 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:9413 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964915AbWBQNaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:30:25 -0500
Date: Fri, 17 Feb 2006 22:29:12 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 006/012] Memory hotplug for new nodes v.2.(create sysfs for node (ia64))
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060217212032.4074.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


'register_node()' is to create sysfs file for node.
This is to add arch specific functions 'arch_register_node()'
and 'arch_unregister_node()' to IA64 to call the generic
function 'register_node()' and 'unregister_node()' respectively.

Signed-off-by: Keiichiro Tokunaga <tokuanga.keiich@jp.fujitsu.com>
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


Index: pgdat3/arch/ia64/kernel/topology.c
===================================================================
--- pgdat3.orig/arch/ia64/kernel/topology.c	2006-02-17 15:58:03.000000000 +0900
+++ pgdat3/arch/ia64/kernel/topology.c	2006-02-17 16:17:01.000000000 +0900
@@ -65,6 +65,21 @@ EXPORT_SYMBOL(arch_register_cpu);
 EXPORT_SYMBOL(arch_unregister_cpu);
 #endif /*CONFIG_HOTPLUG_CPU*/
 
+#ifdef CONFIG_NUMA
+int arch_register_node(int num)
+{
+	if (sysfs_nodes[num].sysdev.id == num)
+		return 0;
+
+	return register_node(&sysfs_nodes[num], num, 0);
+}
+
+void arch_unregister_node(int num)
+{
+	unregister_node(&sysfs_nodes[num]);
+	sysfs_nodes[num].sysdev.id = -1;
+}
+#endif
 
 static int __init topology_init(void)
 {
Index: pgdat3/include/asm-ia64/numa.h
===================================================================
--- pgdat3.orig/include/asm-ia64/numa.h	2005-03-02 16:37:55.000000000 +0900
+++ pgdat3/include/asm-ia64/numa.h	2006-02-17 16:17:01.000000000 +0900
@@ -23,6 +23,9 @@
 
 #include <asm/mmzone.h>
 
+extern int arch_register_node(int num);
+extern void arch_unregister_node(int num);
+
 extern u8 cpu_to_node_map[NR_CPUS] __cacheline_aligned;
 extern cpumask_t node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
 

-- 
Yasunori Goto 


