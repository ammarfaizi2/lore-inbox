Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWC3CRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWC3CRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWC3CQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:16:57 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:463 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751450AbWC3CQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:16:25 -0500
Date: Thu, 30 Mar 2006 11:15:55 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:008/011] Configureable NODES_SHIFT (for arm)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330111009.DCB3.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is form arm.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/asm-arm/numnodes.h            |   26 --------------------------
 arch/arm/Kconfig                      |    6 ++++++
 include/asm-arm/arch-lh7a40x/memory.h |    2 --
 3 files changed, 6 insertions(+), 28 deletions(-)

Index: pxm_ver4/arch/arm/Kconfig
===================================================================
--- pxm_ver4.orig/arch/arm/Kconfig	2006-03-29 20:12:40.436504739 +0900
+++ pxm_ver4/arch/arm/Kconfig	2006-03-29 20:35:07.255824178 +0900
@@ -496,6 +496,12 @@ config ARCH_DISCONTIGMEM_ENABLE
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/vm/numa> for more.
 
+config NODES_SHIFT
+	int
+	default "4" if ARCH_LH7A40X
+	default "2"
+	depends on NEED_MULTIPLE_NODES
+
 source "mm/Kconfig"
 
 config LEDS
Index: pxm_ver4/include/asm-arm/arch-lh7a40x/memory.h
===================================================================
--- pxm_ver4.orig/include/asm-arm/arch-lh7a40x/memory.h	2006-03-29 20:12:40.436504739 +0900
+++ pxm_ver4/include/asm-arm/arch-lh7a40x/memory.h	2006-03-29 20:34:39.445277644 +0900
@@ -31,8 +31,6 @@
 
 #ifdef CONFIG_DISCONTIGMEM
 
-#define NODES_SHIFT	4	/* Up to 16 nodes */
-
 /*
  * Given a kernel address, find the home node of the underlying memory.
  */
Index: pxm_ver4/include/asm-arm/numnodes.h
===================================================================
--- pxm_ver4.orig/include/asm-arm/numnodes.h	2006-03-29 20:12:40.436504739 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,26 +0,0 @@
-/*
- *  linux/include/asm-arm/numnodes.h
- *
- *  Copyright (C) 2002 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-/* This declaration for the size of the NUMA (CONFIG_DISCONTIGMEM)
- * memory node table is the default.
- *
- * A good place to override this value is include/asm/arch/memory.h.
- */
-
-#ifndef __ASM_ARM_NUMNODES_H
-#define __ASM_ARM_NUMNODES_H
-
-#include <asm/memory.h>
-
-#ifndef NODES_SHIFT
-# define NODES_SHIFT	2	/* Normally, Max 4 Nodes */
-#endif
-
-#endif

-- 
Yasunori Goto 


