Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbTEKKjX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTEKKXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:23:03 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:24087 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261227AbTEKKVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:35 -0400
Date: Sun, 11 May 2003 12:31:03 +0200
Message-Id: <200305111031.h4BAV3JA019706@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] IDE iops clean ups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IDE I/O operations clean ups:
  - Kill warning about void return type not being ignored
  - Fix comment: Q40/Q60 also has a byte-swapped IDE interface

--- linux-2.5.x/drivers/ide/ide-iops.c	Tue Mar 25 10:32:34 2003
+++ linux-m68k-2.5.x/drivers/ide/ide-iops.c	Tue Mar 25 11:56:05 2003
@@ -155,7 +155,7 @@
 
 static void ide_outsl (unsigned long port, void *addr, u32 count)
 {
-	return outsl(port, addr, count);
+	outsl(port, addr, count);
 }
 
 void default_hwif_iops (ide_hwif_t *hwif)
@@ -391,7 +391,7 @@
 		insw_swapw(IDE_DATA_REG, buffer, bytecount / 2);
 		return;
 	}
-#endif /* CONFIG_ATARI */
+#endif /* CONFIG_ATARI || CONFIG_Q40 */
 	hwif->ata_input_data(drive, buffer, bytecount / 4);
 	if ((bytecount & 0x03) >= 2)
 		hwif->INSW(IDE_DATA_REG, ((u8 *)buffer)+(bytecount & ~0x03), 1);
@@ -410,7 +410,7 @@
 		outsw_swapw(IDE_DATA_REG, buffer, bytecount / 2);
 		return;
 	}
-#endif /* CONFIG_ATARI */
+#endif /* CONFIG_ATARI || CONFIG_Q40 */
 	hwif->ata_output_data(drive, buffer, bytecount / 4);
 	if ((bytecount & 0x03) >= 2)
 		hwif->OUTSW(IDE_DATA_REG, ((u8*)buffer)+(bytecount & ~0x03), 1);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
