Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbRE3ApS>; Tue, 29 May 2001 20:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262530AbRE3ApI>; Tue, 29 May 2001 20:45:08 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:2831 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262526AbRE3ApF>; Tue, 29 May 2001 20:45:05 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300046.CAA04557@green.mif.pg.gda.pl>
Subject: [PATCH] net #7
To: alan@lxorguk.ukuu.org.uk (Alan Cox), erik@vt.edu
Date: Wed, 30 May 2001 02:46:08 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch validates smc9194 module parameter (needed for array
access)

Andrzej

*********************** PATCH 7 *****************************************
diff -uNr linux-2.4.5-ac4/drivers/net/smc9194.c linux/drivers/net/smc9194.c
--- linux-2.4.5-ac4/drivers/net/smc9194.c	Wed May 30 01:09:53 2001
+++ linux/drivers/net/smc9194.c	Wed May 30 01:14:26 2001
@@ -1581,7 +1581,9 @@
 	/* copy the parameters from insmod into the device structure */
 	devSMC9194.base_addr = io;
 	devSMC9194.irq       = irq;
-	devSMC9194.if_port	= ifport;
+	devSMC9194.if_port	= 
+		(ifport >= 0 && ifport <= sizeof(interfaces)/sizeof(*interfaces)) ?
+		ifport : 0;
 	devSMC9194.init   	= smc_init;
 	if ((result = register_netdev(&devSMC9194)) != 0)
 		return result;


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
