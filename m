Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268005AbTBRSVj>; Tue, 18 Feb 2003 13:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268006AbTBRSU1>; Tue, 18 Feb 2003 13:20:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52745 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268005AbTBRST3>; Tue, 18 Feb 2003 13:19:29 -0500
Subject: PATCH: clean up DMA reference, new style ONLYDISK
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:29:47 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCV1-0006DH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-cd.c linux-2.5.61-ac2/drivers/ide/ide-cd.c
--- linux-2.5.61/drivers/ide/ide-cd.c	2003-02-10 18:38:30.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-cd.c	2003-02-18 18:06:17.000000000 +0000
@@ -1276,9 +1274,7 @@
 			 * this condition is far too common, to bother
 			 * users about it
 			 */
-#if 0
-			printk("%s: disabled DSC seek overlap\n", drive->name);
-#endif
+			/* printk("%s: disabled DSC seek overlap\n", drive->name);*/ 
 			drive->dsc_overlap = 0;
 		}
 	}
@@ -2965,8 +2961,10 @@
 
 	printk(", %dkB Cache", be16_to_cpu(cap.buffer_size));
 
+#ifdef CONFIG_BLK_DEV_IDEDMA
 	if (drive->using_dma)
 		(void) HWIF(drive)->ide_dma_verbose(drive);
+#endif /* CONFIG_BLK_DEV_IDEDMA */
 	printk("\n");
 
 	return nslots;
@@ -3261,11 +3259,7 @@
 	.version		= IDECD_VERSION,
 	.media			= ide_cdrom,
 	.busy			= 0,
-#ifdef CONFIG_IDEDMA_ONLYDISK
-	.supports_dma		= 0,
-#else
 	.supports_dma		= 1,
-#endif
 	.supports_dsc_overlap	= 1,
 	.cleanup		= ide_cdrom_cleanup,
 	.do_request		= ide_do_rw_cdrom,
