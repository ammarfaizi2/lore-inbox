Return-Path: <linux-kernel-owner+w=401wt.eu-S936698AbWLIJqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936698AbWLIJqe (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936704AbWLIJqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:46:34 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:55940 "EHLO
	astra.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936698AbWLIJqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:46:33 -0500
Date: Sat, 9 Dec 2006 10:46:30 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/Atari: 2.6.18 Atari IDE interrupt needs SA_SHIRQ
Message-ID: <Pine.LNX.4.64.0612091045580.15950@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>

Atari IDE: The interrupt needs SA_SHIRQ now to get registered.

Signed-off-by: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---
 arch/m68k/atari/stdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-m68k-2.6.19.orig/arch/m68k/atari/stdma.c
+++ linux-m68k-2.6.19/arch/m68k/atari/stdma.c
@@ -174,7 +174,7 @@ int stdma_islocked(void)
 void __init stdma_init(void)
 {
 	stdma_isr = NULL;
-	request_irq(IRQ_MFP_FDC, stdma_int, IRQ_TYPE_SLOW,
+	request_irq(IRQ_MFP_FDC, stdma_int, IRQ_TYPE_SLOW | SA_SHIRQ,
 	            "ST-DMA: floppy/ACSI/IDE/Falcon-SCSI", stdma_int);
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
