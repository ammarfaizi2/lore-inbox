Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291059AbSBLN6e>; Tue, 12 Feb 2002 08:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291054AbSBLN6Y>; Tue, 12 Feb 2002 08:58:24 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:5526 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S291061AbSBLN6L>;
	Tue, 12 Feb 2002 08:58:11 -0500
Date: Tue, 12 Feb 2002 14:58:07 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200202121358.OAA10937@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.4 ftape virt_to_bus() fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the ftape driver in 2.5.4 for the virt_to_bus() et
al changes. Since this is ISA-only code, I used the new isa_-prefixed
functions. Tested on a Seagate TST3200 TR-3 unit.

/Mikael

--- linux-2.5.4/drivers/char/ftape/lowlevel/fdc-io.c.~1~	Mon Feb 11 12:21:45 2002
+++ linux-2.5.4/drivers/char/ftape/lowlevel/fdc-io.c	Mon Feb 11 16:55:18 2002
@@ -926,7 +926,7 @@
 	disable_dma(fdc.dma);
 	clear_dma_ff(fdc.dma);
 	set_dma_mode(fdc.dma, mode);
-	set_dma_addr(fdc.dma, virt_to_bus((void*)addr));
+	set_dma_addr(fdc.dma, isa_virt_to_bus((void*)addr));
 	set_dma_count(fdc.dma, count);
 	enable_dma(fdc.dma);
 }
@@ -945,7 +945,7 @@
 	/* Program the DMA controller.
 	 */
         TRACE(ft_t_fdc_dma,
-	      "phys. addr. = %lx", virt_to_bus((void*) buff->ptr));
+	      "phys. addr. = %lx", isa_virt_to_bus((void*) buff->ptr));
 	save_flags(flags);
 	cli();			/* could be called from ISR ! */
 	fdc_setup_dma(DMA_MODE_WRITE, buff->ptr, FT_SECTORS_PER_SEGMENT * 4);
@@ -997,7 +997,7 @@
 		TRACE_ABORT(-EIO,
 			    ft_t_bug, "bug: illegal operation parameter");
 	}
-	TRACE(ft_t_fdc_dma, "phys. addr. = %lx",virt_to_bus((void*)buff->ptr));
+	TRACE(ft_t_fdc_dma, "phys. addr. = %lx", isa_virt_to_bus((void*)buff->ptr));
 	save_flags(flags);
 	cli();			/* could be called from ISR ! */
 	if (operation != FDC_VERIFY) {
