Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269013AbUIMWGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269013AbUIMWGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268998AbUIMWF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:05:59 -0400
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:15540
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S268993AbUIMWFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:05:35 -0400
Date: Mon, 13 Sep 2004 18:05:32 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] linux/dma-mapping.h needs linux/device.h
Message-ID: <Pine.LNX.4.61.0409131802280.12375@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that most architectures already include linux/device.h in their
own asm/dma-mapping.h.  Most but not all, and some drivers fail to
compile on those architectures that don't.  Since everybody needs it
let's include device.h from one place only and fix compilation for 
everybody.

--- linux-2.6/include/linux/dma-mapping.h	29 Aug 2004 04:59:03 -0000	1.7
+++ linux-2.6/include/linux/dma-mapping.h	10 Sep 2004 15:28:58 -0000
@@ -1,6 +1,7 @@
 #ifndef _ASM_LINUX_DMA_MAPPING_H
 #define _ASM_LINUX_DMA_MAPPING_H
 
+#include <linux/device.h>
 #include <linux/err.h>
 
 /* These definitions mirror those in pci.h, so they can be used
--- linux-2.6/include/asm-i386/dma-mapping.h	29 Aug 2004 04:59:03 -0000	1.10
+++ linux-2.6/include/asm-i386/dma-mapping.h	10 Sep 2004 15:30:26 -0000
@@ -1,7 +1,6 @@
 #ifndef _ASM_I386_DMA_MAPPING_H
 #define _ASM_I386_DMA_MAPPING_H
 
-#include <linux/device.h>
 #include <linux/mm.h>
 
 #include <asm/cache.h>
--- linux-2.6/include/asm-ia64/dma-mapping.h	24 Aug 2004 18:23:25 -0000	1.7
+++ linux-2.6/include/asm-ia64/dma-mapping.h	10 Sep 2004 15:32:59 -0000
@@ -6,7 +6,6 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
 #include <linux/config.h>
-#include <linux/device.h>
 #include <asm/machvec.h>
 
 #define dma_alloc_coherent	platform_dma_alloc_coherent
--- linux-2.6/include/asm-mips/dma-mapping.h	20 Apr 2004 14:59:56 -0000	1.7
+++ linux-2.6/include/asm-mips/dma-mapping.h	10 Sep 2004 15:35:32 -0000
@@ -1,7 +1,6 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
-#include <linux/device.h>
 #include <asm/scatterlist.h>
 #include <asm/cache.h>
 
--- linux-2.6/include/asm-ppc/dma-mapping.h	29 May 2004 17:56:14 -0000	1.7
+++ linux-2.6/include/asm-ppc/dma-mapping.h	10 Sep 2004 15:35:12 -0000
@@ -8,7 +8,6 @@
 #include <linux/config.h>
 /* need struct page definitions */
 #include <linux/mm.h>
-#include <linux/device.h>
 #include <asm/scatterlist.h>
 #include <asm/io.h>
 
--- linux-2.6/include/asm-ppc64/dma-mapping.h	12 Apr 2004 19:50:11 -0000	1.5
+++ linux-2.6/include/asm-ppc64/dma-mapping.h	10 Sep 2004 15:34:51 -0000
@@ -8,7 +8,6 @@
 #define _ASM_DMA_MAPPING_H
 
 #include <linux/types.h>
-#include <linux/device.h>
 #include <linux/cache.h>
 /* need struct page definitions */
 #include <linux/mm.h>
--- linux-2.6/include/asm-sh/dma-mapping.h	24 Jun 2004 16:25:06 -0000	1.4
+++ linux-2.6/include/asm-sh/dma-mapping.h	10 Sep 2004 15:34:27 -0000
@@ -3,7 +3,6 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
-#include <linux/device.h>
 #include <asm/scatterlist.h>
 #include <asm/io.h>
 
--- linux-2.6/include/asm-sh64/dma-mapping.h	30 Jun 2004 02:18:58 -0000	1.2
+++ linux-2.6/include/asm-sh64/dma-mapping.h	10 Sep 2004 15:33:57 -0000
@@ -3,7 +3,6 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
-#include <linux/device.h>
 #include <asm/scatterlist.h>
 #include <asm/io.h>
 
--- linux-2.6/include/asm-sparc/dma-mapping.h	15 Jun 2004 05:28:00 -0000	1.5
+++ linux-2.6/include/asm-sparc/dma-mapping.h	10 Sep 2004 15:30:54 -0000
@@ -2,7 +2,6 @@
 #define _ASM_SPARC_DMA_MAPPING_H
 
 #include <linux/config.h>
-#include <linux/device.h>
 
 #ifdef CONFIG_PCI
 #include <asm-generic/dma-mapping.h>
--- linux-2.6/include/asm-x86_64/dma-mapping.h	24 Aug 2004 18:20:09 -0000	1.6
+++ linux-2.6/include/asm-x86_64/dma-mapping.h	10 Sep 2004 15:33:31 -0000
@@ -7,7 +7,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/device.h>
 
 #include <asm/scatterlist.h>
 #include <asm/io.h>
