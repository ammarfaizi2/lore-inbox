Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWC3CPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWC3CPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWC3CPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:15:16 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:15054 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751442AbWC3CPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:15:13 -0500
Date: Thu, 30 Mar 2006 11:14:33 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:003/011] Configureable NODES_SHIFT (for i386)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330110500.DCA5.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is for i386.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/asm-i386/numnodes.h |   18 ------------------
 arch/i386/Kconfig           |    6 ++++++
 2 files changed, 6 insertions(+), 18 deletions(-)

Index: pxm_ver4/include/asm-i386/numnodes.h
===================================================================
--- pxm_ver4.orig/include/asm-i386/numnodes.h	2006-03-29 20:19:32.024390322 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,18 +0,0 @@
-#ifndef _ASM_MAX_NUMNODES_H
-#define _ASM_MAX_NUMNODES_H
-
-#include <linux/config.h>
-
-#ifdef CONFIG_X86_NUMAQ
-
-/* Max 16 Nodes */
-#define NODES_SHIFT	4
-
-#elif defined(CONFIG_ACPI_SRAT)
-
-/* Max 8 Nodes */
-#define NODES_SHIFT	3
-
-#endif /* CONFIG_X86_NUMAQ */
-
-#endif /* _ASM_MAX_NUMNODES_H */
Index: pxm_ver4/arch/i386/Kconfig
===================================================================
--- pxm_ver4.orig/arch/i386/Kconfig	2006-03-29 20:19:32.025366884 +0900
+++ pxm_ver4/arch/i386/Kconfig	2006-03-29 20:28:03.707977804 +0900
@@ -522,6 +522,12 @@ config NUMA
 comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
 	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)
 
+config NODES_SHIFT
+	int
+	default "4" if X86_NUMAQ
+	default "3"
+	depends on NEED_MULTIPLE_NODES
+
 config HAVE_ARCH_BOOTMEM_NODE
 	bool
 	depends on NUMA

-- 
Yasunori Goto 


