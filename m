Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286750AbSA1V5g>; Mon, 28 Jan 2002 16:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSA1V52>; Mon, 28 Jan 2002 16:57:28 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:49314 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S286750AbSA1V5R>;
	Mon, 28 Jan 2002 16:57:17 -0500
Date: Mon, 28 Jan 2002 22:57:15 +0100
From: Joerg Mayer <jmayer@loplof.de>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com
Subject: Linkbeat detection for eepro100
Message-ID: <20020128225715.D17469@thot.informatik.uni-kl.de>
Reply-To: Joerg Mayer <jmayer@loplof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

based on Stefans (srompf@isg.de) patch (Interface operative status detection)
to this list, here is support for the eepro100 driver.

  ciao
              Joerg
--
Joerg Mayer                                          <jmayer@loplof.de>
I found out that "pro" means "instead of" (as in proconsul). Now I know
what proactive means.


--- drivers/net/eepro100.c.distrib	Mon Jan 28 22:22:34 2002
+++ drivers/net/eepro100.c	Mon Jan 28 22:40:59 2002
@@ -1103,9 +1103,9 @@
 			mdio_read(ioaddr, phy_num, 1);
 			/* If link beat has returned... */
 			if (mdio_read(ioaddr, phy_num, 1) & 0x0004)
-				dev->flags |= IFF_RUNNING;
+				netif_carrier_on(dev);
 			else
-				dev->flags &= ~IFF_RUNNING;
+				netif_carrier_off(dev);
 		}
 	}
 	if (speedo_debug > 3) {
