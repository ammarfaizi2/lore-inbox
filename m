Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbTI2Iqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbTI2IjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:39:17 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:64075 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262894AbTI2Ihw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:37:52 -0400
Date: Mon, 29 Sep 2003 10:39:08 +0200
Message-Id: <200309290839.h8T8d8lX003676@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 314] 53c7xx SCSI core is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

53c7xx SCSI core is broken (needs SCSI updates (has_cmdblocks and device
lists)), breaking the following drivers:
  - Amiga A4000T SCSI
  - Amiga A4091 SCSI
  - Amiga WarpEngine SCSI
  - Amiga Blizzard PowerUP 603e+ SCSI
  - MVME16x NCR53C710 SCSI
  - BVME6000 NCR53C710 SCSI

--- linux-2.6.0-test6/drivers/scsi/Kconfig	Tue Sep  9 10:13:04 2003
+++ linux-m68k-2.6.0-test6/drivers/scsi/Kconfig	Thu Sep 18 04:51:38 2003
@@ -1546,7 +1546,7 @@
 
 config A4000T_SCSI
 	bool "A4000T SCSI support (EXPERIMENTAL)"
-	depends on AMIGA && SCSI && EXPERIMENTAL
+	depends on AMIGA && SCSI && EXPERIMENTAL && BROKEN
 	help
 	  Support for the NCR53C710 SCSI controller on the Amiga 4000T.
 
@@ -1616,7 +1616,7 @@
 
 config A4091_SCSI
 	bool "A4091 SCSI support (EXPERIMENTAL)"
-	depends on ZORRO && SCSI && EXPERIMENTAL
+	depends on ZORRO && SCSI && EXPERIMENTAL && BROKEN
 	help
 	  Support for the NCR53C710 chip on the Amiga 4091 Z3 SCSI2 controller
 	  (1993).  Very obscure -- the 4091 was part of an Amiga 4000 upgrade
@@ -1624,7 +1624,7 @@
 
 config WARPENGINE_SCSI
 	bool "WarpEngine SCSI support (EXPERIMENTAL)"
-	depends on ZORRO && SCSI && EXPERIMENTAL
+	depends on ZORRO && SCSI && EXPERIMENTAL && BROKEN
 	help
 	  Support for MacroSystem Development's WarpEngine Amiga SCSI-2
 	  controller. Info at
@@ -1632,7 +1632,7 @@
 
 config BLZ603EPLUS_SCSI
 	bool "Blizzard PowerUP 603e+ SCSI (EXPERIMENTAL)"
-	depends on ZORRO && SCSI && EXPERIMENTAL
+	depends on ZORRO && SCSI && EXPERIMENTAL && BROKEN
 	help
 	  If you have an Amiga 1200 with a Phase5 Blizzard PowerUP 603e+
 	  accelerator, say Y. Otherwise, say N.
@@ -1718,7 +1718,7 @@
 
 config MVME16x_SCSI
 	bool "NCR53C710 SCSI driver for MVME16x"
-	depends on MVME16x && SCSI
+	depends on MVME16x && SCSI && BROKEN
 	help
 	  The Motorola MVME162, 166, 167, 172 and 177 boards use the NCR53C710
 	  SCSI controller chip.  Almost everyone using one of these boards
@@ -1726,7 +1726,7 @@
 
 config BVME6000_SCSI
 	bool "NCR53C710 SCSI driver for BVME6000"
-	depends on BVME6000 && SCSI
+	depends on BVME6000 && SCSI && BROKEN
 	help
 	  The BVME4000 and BVME6000 boards from BVM Ltd use the NCR53C710
 	  SCSI controller chip.  Almost everyone using one of these boards

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
