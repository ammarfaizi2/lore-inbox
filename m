Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313549AbSDLLfI>; Fri, 12 Apr 2002 07:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313550AbSDLLfH>; Fri, 12 Apr 2002 07:35:07 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:52097 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S313549AbSDLLfG>;
	Fri, 12 Apr 2002 07:35:06 -0400
Date: Fri, 12 Apr 2002 13:34:38 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: rjd@xyzzy.clara.co.uk, jgarzik@mandrakesoft.com
Subject: [patch] 2.5.8-pre3 - drivers/net/wan/farsync.c
Message-ID: <20020412133438.A5627@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Problem:
compilation fails due to removal of rmem_{start/end} in struct net_device.

Fix:
Simple removal. I haven't found any other use of these fields in the driver.

--- linux-2.5.8-pre3.orig/drivers/net/wan/farsync.c	Thu Apr 11 23:51:52 2002
+++ linux-2.5.8-pre3/drivers/net/wan/farsync.c	Thu Apr 11 23:55:24 2002
@@ -1469,10 +1469,6 @@ fst_init_card ( struct fst_card_info *ca
                                  + BUF_OFFSET ( txBuffer[i][0][0]);
                 dev->mem_end     = card->phys_mem
                                  + BUF_OFFSET ( txBuffer[i][NUM_TX_BUFFER][0]);
-                dev->rmem_start  = card->phys_mem
-                                 + BUF_OFFSET ( rxBuffer[i][0][0]);
-                dev->rmem_end    = card->phys_mem
-                                 + BUF_OFFSET ( rxBuffer[i][NUM_RX_BUFFER][0]);
                 dev->base_addr   = card->pci_conf;
                 dev->irq         = card->irq;
 
-- 
Ueimor
