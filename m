Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbTFZLN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 07:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265605AbTFZLN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 07:13:26 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:42669 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265572AbTFZLNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 07:13:23 -0400
Date: Thu, 26 Jun 2003 13:27:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bob Frey <linux@advansys.com>
cc: linux-scsi@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Advansys SCSI compile problems in 2.5.73
Message-ID: <Pine.GSO.4.21.0306261326160.20587-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Bob,

If CONFIG_PCI is not set, the advansys driver doesn't compile. Below are a few
required changes, but some more are needed. Since I don't have the hardware, I
gave up.

--- linux-2.5.73/drivers/scsi/advansys.c.orig	Sun Jun 15 09:38:35 2003
+++ linux-2.5.73/drivers/scsi/advansys.c	Mon Jun 23 15:51:12 2003
@@ -4765,7 +4765,10 @@
                 continue;
             }
 
+#ifdef CONFIG_PCI
+	    /* FIXME */
 	    scsi_set_device(shp, &pci_devp->dev);
+#endif
 
             /* Save a pointer to the Scsi_Host of each board found. */
             asc_host[asc_board_count++] = shp;
@@ -9146,8 +9149,6 @@
 {
 #ifdef CONFIG_PCI
     pci_write_config_byte(asc_dvc->cfg->pci_dev, offset, byte_data);
-#else /* CONFIG_PCI */
-    return 0;
 #endif /* CONFIG_PCI */
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

