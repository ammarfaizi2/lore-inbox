Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWEITxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWEITxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWEITw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:52:26 -0400
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:29859
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S1751057AbWEITvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:51:49 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk
Message-Id: <2.628477917@selenic.com>
Subject: [PATCH 1/6] random: Remove SA_SAMPLE_RANDOM from floppy driver
Date: Tue, 09 May 2006 14:50:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SA_SAMPLE_RANDOM from floppy driver

The floppy driver is already calling add_disk_randomness as it should,
so this was redundant.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/include/asm-alpha/floppy.h
===================================================================
--- 2.6.orig/include/asm-alpha/floppy.h	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/include/asm-alpha/floppy.h	2006-05-03 11:18:46.000000000 -0500
@@ -26,9 +26,8 @@
 #define fd_enable_irq()         enable_irq(FLOPPY_IRQ)
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
 #define fd_cacheflush(addr,size) /* nothing */
-#define fd_request_irq()        request_irq(FLOPPY_IRQ, floppy_interrupt, \
-					    SA_INTERRUPT|SA_SAMPLE_RANDOM, \
-				            "floppy", NULL)
+#define fd_request_irq()        request_irq(FLOPPY_IRQ, floppy_interrupt,\
+					    SA_INTERRUPT, "floppy", NULL)
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL);
 
 #ifdef CONFIG_PCI
Index: 2.6/include/asm-arm/floppy.h
===================================================================
--- 2.6.orig/include/asm-arm/floppy.h	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/include/asm-arm/floppy.h	2006-05-03 11:19:14.000000000 -0500
@@ -25,7 +25,7 @@
 
 #define fd_inb(port)		inb((port))
 #define fd_request_irq()	request_irq(IRQ_FLOPPYDISK,floppy_interrupt,\
-					SA_INTERRUPT|SA_SAMPLE_RANDOM,"floppy",NULL)
+					    SA_INTERRUPT,"floppy",NULL)
 #define fd_free_irq()		free_irq(IRQ_FLOPPYDISK,NULL)
 #define fd_disable_irq()	disable_irq(IRQ_FLOPPYDISK)
 #define fd_enable_irq()		enable_irq(IRQ_FLOPPYDISK)
Index: 2.6/include/asm-arm26/floppy.h
===================================================================
--- 2.6.orig/include/asm-arm26/floppy.h	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/include/asm-arm26/floppy.h	2006-05-03 11:13:31.000000000 -0500
@@ -22,7 +22,7 @@
 
 #define fd_inb(port)		inb((port))
 #define fd_request_irq()	request_irq(IRQ_FLOPPYDISK,floppy_interrupt,\
-					SA_INTERRUPT|SA_SAMPLE_RANDOM,"floppy",NULL)
+					SA_INTERRUPT,"floppy",NULL)
 #define fd_free_irq()		free_irq(IRQ_FLOPPYDISK,NULL)
 #define fd_disable_irq()	disable_irq(IRQ_FLOPPYDISK)
 #define fd_enable_irq()		enable_irq(IRQ_FLOPPYDISK)
Index: 2.6/include/asm-i386/floppy.h
===================================================================
--- 2.6.orig/include/asm-i386/floppy.h	2006-05-02 17:28:46.000000000 -0500
+++ 2.6/include/asm-i386/floppy.h	2006-05-03 11:03:21.000000000 -0500
@@ -147,9 +147,8 @@ static int fd_request_irq(void)
 		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
 						   "floppy", NULL);
 	else
-		return request_irq(FLOPPY_IRQ, floppy_interrupt,
-						   SA_INTERRUPT|SA_SAMPLE_RANDOM,
-						   "floppy", NULL);	
+		return request_irq(FLOPPY_IRQ, floppy_interrupt, SA_INTERRUPT,
+				   "floppy", NULL);
 
 }
 
Index: 2.6/include/asm-mips/mach-generic/floppy.h
===================================================================
--- 2.6.orig/include/asm-mips/mach-generic/floppy.h	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/include/asm-mips/mach-generic/floppy.h	2006-05-03 11:11:14.000000000 -0500
@@ -98,7 +98,7 @@ static inline void fd_disable_irq(void)
 static inline int fd_request_irq(void)
 {
 	return request_irq(FLOPPY_IRQ, floppy_interrupt,
-	                   SA_INTERRUPT | SA_SAMPLE_RANDOM, "floppy", NULL);
+	                   SA_INTERRUPT, "floppy", NULL);
 }
 
 static inline void fd_free_irq(void)
Index: 2.6/include/asm-mips/mach-jazz/floppy.h
===================================================================
--- 2.6.orig/include/asm-mips/mach-jazz/floppy.h	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/include/asm-mips/mach-jazz/floppy.h	2006-05-03 11:11:44.000000000 -0500
@@ -90,7 +90,7 @@ static inline void fd_disable_irq(void)
 static inline int fd_request_irq(void)
 {
 	return request_irq(FLOPPY_IRQ, floppy_interrupt,
-	                   SA_INTERRUPT | SA_SAMPLE_RANDOM, "floppy", NULL);
+	                   SA_INTERRUPT, "floppy", NULL);
 }
 
 static inline void fd_free_irq(void)
Index: 2.6/include/asm-parisc/floppy.h
===================================================================
--- 2.6.orig/include/asm-parisc/floppy.h	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/include/asm-parisc/floppy.h	2006-05-03 11:12:56.000000000 -0500
@@ -159,10 +159,8 @@ static int fd_request_irq(void)
 		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
 						   "floppy", NULL);
 	else
-		return request_irq(FLOPPY_IRQ, floppy_interrupt,
-						   SA_INTERRUPT|SA_SAMPLE_RANDOM,
-						   "floppy", NULL);	
-
+		return request_irq(FLOPPY_IRQ, floppy_interrupt, SA_INTERRUPT,
+				   "floppy", NULL);
 }
 
 static unsigned long dma_mem_alloc(unsigned long size)
Index: 2.6/include/asm-powerpc/floppy.h
===================================================================
--- 2.6.orig/include/asm-powerpc/floppy.h	2006-05-02 17:28:46.000000000 -0500
+++ 2.6/include/asm-powerpc/floppy.h	2006-05-03 11:15:32.000000000 -0500
@@ -28,8 +28,7 @@
 #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
 #define fd_cacheflush(addr,size) /* nothing */
 #define fd_request_irq()        request_irq(FLOPPY_IRQ, floppy_interrupt, \
-					    SA_INTERRUPT|SA_SAMPLE_RANDOM, \
-				            "floppy", NULL)
+					    SA_INTERRUPT, "floppy", NULL)
 #define fd_free_irq()           free_irq(FLOPPY_IRQ, NULL);
 
 #ifdef CONFIG_PCI
Index: 2.6/include/asm-ppc/floppy.h
===================================================================
--- 2.6.orig/include/asm-ppc/floppy.h	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/include/asm-ppc/floppy.h	2006-05-03 11:10:41.000000000 -0500
@@ -99,10 +99,8 @@ static int fd_request_irq(void)
 		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
 						   "floppy", NULL);
 	else
-		return request_irq(FLOPPY_IRQ, floppy_interrupt,
-						   SA_INTERRUPT|SA_SAMPLE_RANDOM,
-						   "floppy", NULL);
-
+		return request_irq(FLOPPY_IRQ, floppy_interrupt, SA_INTERRUPT,
+				   "floppy", NULL);
 }
 
 static int vdma_dma_setup(char *addr, unsigned long size, int mode, int io)
Index: 2.6/include/asm-sh/floppy.h
===================================================================
--- 2.6.orig/include/asm-sh/floppy.h	2005-10-27 19:02:08.000000000 -0500
+++ 2.6/include/asm-sh/floppy.h	2006-05-03 11:04:48.000000000 -0500
@@ -147,11 +147,10 @@ static int fd_request_irq(void)
 {
 	if(can_use_virtual_dma)
 		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
-						   "floppy", NULL);
+				   "floppy", NULL);
 	else
-		return request_irq(FLOPPY_IRQ, floppy_interrupt,
-						   SA_INTERRUPT|SA_SAMPLE_RANDOM,
-						   "floppy", NULL);	
+		return request_irq(FLOPPY_IRQ, floppy_interrupt, SA_INTERRUPT,
+				   "floppy", NULL);
 
 }
 
Index: 2.6/include/asm-x86_64/floppy.h
===================================================================
--- 2.6.orig/include/asm-x86_64/floppy.h	2006-05-02 17:28:46.000000000 -0500
+++ 2.6/include/asm-x86_64/floppy.h	2006-05-03 11:09:30.000000000 -0500
@@ -147,10 +147,8 @@ static int fd_request_irq(void)
 		return request_irq(FLOPPY_IRQ, floppy_hardint,SA_INTERRUPT,
 						   "floppy", NULL);
 	else
-		return request_irq(FLOPPY_IRQ, floppy_interrupt,
-						   SA_INTERRUPT|SA_SAMPLE_RANDOM,
-						   "floppy", NULL);	
-
+		return request_irq(FLOPPY_IRQ, floppy_interrupt, SA_INTERRUPT,
+				   "floppy", NULL);
 }
 
 static unsigned long dma_mem_alloc(unsigned long size)
