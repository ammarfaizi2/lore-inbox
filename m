Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751935AbWFWTDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbWFWTDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbWFWTDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:03:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:43206 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751935AbWFWTDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:03:39 -0400
Message-Id: <20060623185825.013037000@klappe.arndb.de>
References: <20060623185746.037897000@klappe.arndb.de>
Date: Fri, 23 Jun 2006 20:57:50 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 4/5] spufs: fix class0 interrupt assignment
Content-Disposition: inline; filename=spufs-correct-dma-exceptions.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The class zero interrupt handling for spus
was confusing alignment and error interrupts,
so swap them.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linus-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linus-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -168,12 +168,12 @@ spu_irq_class_0_bottom(struct spu *spu)
 
 	stat &= mask;
 
-	if (stat & 1) /* invalid MFC DMA */
-		__spu_trap_invalid_dma(spu);
-
-	if (stat & 2) /* invalid DMA alignment */
+	if (stat & 1) /* invalid DMA alignment */
 		__spu_trap_dma_align(spu);
 
+	if (stat & 2) /* invalid MFC DMA */
+		__spu_trap_invalid_dma(spu);
+
 	if (stat & 4) /* error on SPU */
 		__spu_trap_error(spu);
 

--

