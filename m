Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273534AbRJDSKh>; Thu, 4 Oct 2001 14:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273724AbRJDSKa>; Thu, 4 Oct 2001 14:10:30 -0400
Received: from gw1-mail.cict.fr ([195.220.59.20]:37388 "EHLO gw1-mail.cict.fr")
	by vger.kernel.org with ESMTP id <S273534AbRJDSKK>;
	Thu, 4 Oct 2001 14:10:10 -0400
Message-ID: <3BBCA5B7.F4DC8594@irit.fr>
Date: Thu, 04 Oct 2001 20:08:55 +0200
From: Jerome AUGE <auge@irit.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] opl3sa2.c: DMA timeout when recording
Content-Type: multipart/mixed;
 boundary="------------03E06DDFBD4A878CB69AD7F6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------03E06DDFBD4A878CB69AD7F6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Here is a patch that fix a problem with the opl3sa2 driver. The problem
is that if you use two distinct DMA channels, then you can play but
can't record OR record and can't play, you get the message "DMA timeout
(...)"
The dma and dma2 are not initialized with the real DMA channels and they
remain at -1.

--
--------------03E06DDFBD4A878CB69AD7F6
Content-Type: text/plain; charset=us-ascii;
 name="patch-opl3sa2-dma-init"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-opl3sa2-dma-init"

diff -ur linux.orig/drivers/sound/opl3sa2.c linux/drivers/sound/opl3sa2.c
--- linux.orig/drivers/sound/opl3sa2.c	Wed Oct  3 09:36:16 2001
+++ linux/drivers/sound/opl3sa2.c	Wed Oct  3 09:41:28 2001
@@ -862,9 +862,9 @@
 
 	/* Our own config: */
 	hw_cfg->io_base = dev->resource[4].start;
-	hw_cfg->irq     = 0;
-	hw_cfg->dma     = -1;
-	hw_cfg->dma2    = -1;
+	hw_cfg->irq     = dev->irq_resource[0].start;
+	hw_cfg->dma     = dev->dma_resource[0].start;
+	hw_cfg->dma2    = dev->dma_resource[1].start;
 	
 	/* The MSS config: */
 	mss_cfg->io_base      = dev->resource[1].start;
@@ -944,9 +944,9 @@
 			 *  give pretty output from conf_printf. :)
 			 */
 			cfg[card].io_base = io;
-			cfg[card].irq     = 0;
-			cfg[card].dma     = -1;
-			cfg[card].dma2    = -1;
+			cfg[card].irq     = irq;
+			cfg[card].dma     = dma;
+			cfg[card].dma2    = dma2;
 	
 			/* The MSS config: */
 			cfg_mss[card].io_base      = mss_io;

--------------03E06DDFBD4A878CB69AD7F6--

