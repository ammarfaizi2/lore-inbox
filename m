Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWCQIYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWCQIYs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWCQIYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:24:23 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53996 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964944AbWCQIXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:23:43 -0500
Date: Fri, 17 Mar 2006 17:23:09 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 017/017]Memory hotplug for new nodes v.4.(arch_register_node() for ia64)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060317163911.C659.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is to create sysfs file for new node.
It adds arch specific functions 'arch_register_node()'
and 'arch_unregister_node()' to IA64 to call the generic
function 'register_node()' and 'unregister_node()' respectively.


Signed-off-by: Keiichiro Tokunaga <tokuanga.keiich@jp.fujitsu.com>
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 arch/ia64/kernel/topology.c |   15 +++++++++++++++
 include/linux/node.h        |    2 ++
 2 files changed, 17 insertions(+)

Index: pgdat8/arch/ia64/kernel/topology.c
===================================================================
--- pgdat8.orig/arch/ia64/kernel/topology.c	2006-03-16 16:04:54.000000000 +0900
+++ pgdat8/arch/ia64/kernel/topology.c	2006-03-16 16:06:27.000000000 +0900
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
Index: pgdat8/include/linux/node.h
===================================================================
--- pgdat8.orig/include/linux/node.h	2006-03-16 16:04:54.000000000 +0900
+++ pgdat8/include/linux/node.h	2006-03-16 16:06:27.000000000 +0900
@@ -28,6 +28,8 @@ struct node {
 
 extern int register_node(struct node *, int, struct node *);
 extern void unregister_node(struct node *node);
+extern int arch_register_node(int num);
+extern void arch_unregister_node(int num);
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 

-- 
Yasunori Goto 


