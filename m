Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264840AbUDWPMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264840AbUDWPMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbUDWPKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:10:51 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:14874 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264837AbUDWPKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:10:37 -0400
Date: Fri, 23 Apr 2004 17:10:33 +0200
Message-Id: <200404231510.i3NFAXD1022615@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       macro@ds2.pg.gda.pl, Ralf Baechle <ralf@linux-mips.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 070] NCR53C9x unused SCp.have_data_in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NCR53C9x: Remove unused initialization of SCp.have_data_in (from Maciej W.
Rozycki). This affects the following drivers:
  - Amiga Oktagon SCSI
  - DECstation SCSI

The change for DECstation SCSI sneaked in through a MIPS update.

--- linux-2.4.26-pre5/drivers/scsi/NCR53C9x.c	Sat Aug 17 14:10:41 2002
+++ linux-m68k-2.4.26-pre5/drivers/scsi/NCR53C9x.c	Wed Jan 22 12:07:13 2003
@@ -917,7 +917,7 @@
 		if (esp->dma_mmu_get_scsi_one)
 			esp->dma_mmu_get_scsi_one(esp, sp);
 		else
-			sp->SCp.have_data_in = (int) sp->SCp.ptr =
+			sp->SCp.ptr =
 				(char *) virt_to_phys(sp->request_buffer);
 	} else {
 		sp->SCp.buffer = (struct scatterlist *) sp->buffer;
--- linux-2.4.26-pre5/drivers/scsi/oktagon_esp.c	Mon Apr  1 13:02:02 2002
+++ linux-m68k-2.4.26-pre5/drivers/scsi/oktagon_esp.c	Wed Jan 22 12:07:17 2003
@@ -548,7 +548,7 @@
 
 void dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd *sp)
 {
-        sp->SCp.have_data_in = (int) sp->SCp.ptr =
+        sp->SCp.ptr =
                 sp->request_buffer;
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
