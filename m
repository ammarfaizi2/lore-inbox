Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWC3COh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWC3COh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWC3COh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:14:37 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:49290 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751289AbWC3COg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:14:36 -0500
Date: Thu, 30 Mar 2006 11:14:21 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:002/011] Configureable NODES_SHIFT (for ia64)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330110410.DCA3.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for ia64.
The number of nodes can be already configured in generic ia64 and SN2 config.
But, NODES_SHIFT is defined for DIG64 and HP'S machine too.
So, I changed that all platform can be configured by CONFIG_NODES_SHIFT.
It would be simpler.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/asm-ia64/numnodes.h |   20 --------------------
 arch/ia64/Kconfig           |   19 ++++++++++---------
 2 files changed, 10 insertions(+), 29 deletions(-)

Index: pxm_ver4/arch/ia64/Kconfig
===================================================================
--- pxm_ver4.orig/arch/ia64/Kconfig	2006-03-29 19:18:55.461934870 +0900
+++ pxm_ver4/arch/ia64/Kconfig	2006-03-29 20:50:14.802688060 +0900
@@ -260,15 +260,6 @@ config NR_CPUS
 	  than 64 will cause the use of a CPU mask array, causing a small
 	  performance hit.
 
-config IA64_NR_NODES
-	int "Maximum number of NODEs (256-1024)" if (IA64_SGI_SN2 || IA64_GENERIC)
-	range 256 1024
-	depends on IA64_SGI_SN2 || IA64_GENERIC
-	default "256"
-	help
-	  This option specifies the maximum number of nodes in your SSI system.
-	  If in doubt, use the default.
-
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
 	depends on SMP && EXPERIMENTAL
@@ -352,6 +343,16 @@ config NUMA
 	  Access).  This option is for configuring high-end multiprocessor
 	  server systems.  If in doubt, say N.
 
+config NODES_SHIFT
+	int "Max num nodes shift(3-10)"
+	range 3 10
+	default "8"
+	depends on NEED_MULTIPLE_NODES
+	help
+	  This option specifies the maximum number of nodes in your SSI system.
+	  MAX_NUMNODES will be 2^(This value).
+	  If in doubt, use the default.
+
 # VIRTUAL_MEM_MAP and FLAT_NODE_MEM_MAP are functionally equivalent.
 # VIRTUAL_MEM_MAP has been retained for historical reasons.
 config VIRTUAL_MEM_MAP
Index: pxm_ver4/include/asm-ia64/numnodes.h
===================================================================
--- pxm_ver4.orig/include/asm-ia64/numnodes.h	2006-03-29 19:18:55.462911432 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,20 +0,0 @@
-#ifndef _ASM_MAX_NUMNODES_H
-#define _ASM_MAX_NUMNODES_H
-
-#ifdef CONFIG_IA64_DIG
-/* Max 8 Nodes */
-#  define NODES_SHIFT	3
-#elif defined(CONFIG_IA64_HP_ZX1) || defined(CONFIG_IA64_HP_ZX1_SWIOTLB)
-/* Max 32 Nodes */
-#  define NODES_SHIFT	5
-#elif defined(CONFIG_IA64_SGI_SN2) || defined(CONFIG_IA64_GENERIC)
-#  if CONFIG_IA64_NR_NODES == 256
-#    define NODES_SHIFT	8
-#  elif CONFIG_IA64_NR_NODES <= 512
-#    define NODES_SHIFT    9
-#  elif CONFIG_IA64_NR_NODES <= 1024
-#    define NODES_SHIFT    10
-#  endif
-#endif
-
-#endif /* _ASM_MAX_NUMNODES_H */

-- 
Yasunori Goto 


