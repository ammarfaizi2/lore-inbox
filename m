Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVFLJZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVFLJZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 05:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVFLJZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 05:25:57 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:38178 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261921AbVFLJZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 05:25:46 -0400
Date: Sun, 12 Jun 2005 11:25:42 +0200
Message-Id: <200506120925.j5C9Pgnm004328@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James.Bottomley@SteelEye.com
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 550] M68k: Mark Sun-3 NCR5380 SCSI broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Mark Sun-3 NCR5380 SCSI broken until NCR5380_abort() and
NCR5380_bus_reset() are replaced with real new-style EH routines (the old EH
SCSI constants were removed in 2.6.12-rc3).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---
 arch/m68k/configs/sun3_defconfig |    1 -
 drivers/scsi/Kconfig             |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.12-rc6/arch/m68k/configs/sun3_defconfig	2005-04-21 07:39:24.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/sun3_defconfig	2005-06-07 20:35:02.000000000 +0200
@@ -171,7 +171,6 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # CONFIG_SCSI_SATA is not set
 # CONFIG_SCSI_DEBUG is not set
-CONFIG_SUN3_SCSI=y
 
 #
 # Multi-device support (RAID and LVM)
--- linux-2.6.12-rc6/drivers/scsi/Kconfig	2005-05-07 10:56:52.000000000 +0200
+++ linux-m68k-2.6.12-rc6/drivers/scsi/Kconfig	2005-05-07 16:33:02.000000000 +0200
@@ -1752,7 +1752,7 @@ config SCSI_NCR53C7xx_FAST
 
 config SUN3_SCSI
 	tristate "Sun3 NCR5380 SCSI"
-	depends on SUN3 && SCSI
+	depends on SUN3 && SCSI && BROKEN
 	help
 	  This option will enable support for the OBIO (onboard io) NCR5380
 	  SCSI controller found in the Sun 3/50 and 3/60, as well as for

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
