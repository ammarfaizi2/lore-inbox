Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVEQB6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVEQB6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 21:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEQB6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 21:58:52 -0400
Received: from mail.renesas.com ([202.234.163.13]:4066 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261659AbVEQB6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 21:58:46 -0400
Date: Tue, 17 May 2005 10:58:41 +0900 (JST)
Message-Id: <20050517.105841.465766060.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc4-mm1] m32r: build fix for asm-m32r/topology.h
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

The 2.6.12-rc4-mm1 kernel has the following build problem for m32r.
This patch fixes the build error.
Please apply.

	* include/asm-m32r/topology.h: Use asm-generic/topology.h to fix
	  a build error.

--- build log ---
  :
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux
drivers/built-in.o(.text+0x4724c): In function `init_irq':
: undefined reference to `pcibus_to_node'
drivers/built-in.o(.text+0x4724c): In function `init_irq':
: relocation truncated to fit: R_M32R_26_PCREL_RELA pcibus_to_node
drivers/built-in.o(.text+0x47454): In function `init_irq':
: undefined reference to `pcibus_to_node'
drivers/built-in.o(.text+0x47454): In function `init_irq':
: relocation truncated to fit: R_M32R_26_PCREL_RELA pcibus_to_node
drivers/built-in.o(.text+0x4b358): In function `idedisk_attach':
: undefined reference to `pcibus_to_node'
drivers/built-in.o(.text+0x4b358): In function `idedisk_attach':
: relocation truncated to fit: R_M32R_26_PCREL_RELA pcibus_to_node
make[1]: *** [vmlinux] Error 1
make: *** [_all] Error 2
---

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/topology.h |   44 +-------------------------------------------
 1 files changed, 1 insertion(+), 43 deletions(-)

diff -ruNp a/include/asm-m32r/topology.h b/include/asm-m32r/topology.h
--- a/include/asm-m32r/topology.h	2004-12-25 06:33:48.000000000 +0900
+++ b/include/asm-m32r/topology.h	2005-05-16 21:06:09.000000000 +0900
@@ -1,48 +1,6 @@
-/*
- * linux/include/asm-generic/topology.h
- *
- * Written by: Matthew Dobson, IBM Corporation
- *
- * Copyright (C) 2002, IBM Corp.
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <colpatch@us.ibm.com>
- */
 #ifndef _ASM_M32R_TOPOLOGY_H
 #define _ASM_M32R_TOPOLOGY_H
 
-/* Other architectures wishing to use this simple topology API should fill
-   in the below functions as appropriate in their own <asm/topology.h> file. */
-
-#define cpu_to_node(cpu)	(0)
-
-#ifndef parent_node
-#define parent_node(node)	(0)
-#endif
-#ifndef node_to_cpumask
-#define node_to_cpumask(node)	(cpu_online_map)
-#endif
-#ifndef node_to_first_cpu
-#define node_to_first_cpu(node)	(0)
-#endif
-#ifndef pcibus_to_cpumask
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
-#endif
+#include <asm-generic/topology.h>
 
 #endif /* _ASM_M32R_TOPOLOGY_H */

 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
