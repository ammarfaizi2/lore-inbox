Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752241AbVHGQDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbVHGQDI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbVHGQDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:03:08 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34564 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752240AbVHGQDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:03:07 -0400
Date: Sun, 7 Aug 2005 18:03:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] drivers/net/phy/phy_device.c: fix compilation
Message-ID: <20050807160304.GD3513@stusta.de>
References: <20050807014214.45968af3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050807014214.45968af3.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 01:42:14AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc4-mm1:
>...
>  git-netdev-upstream.patch
>...
>  Subsystem trees
>...

gcc 4.0 correctly rejects this code:

<--  snip  -->

...
  CC      drivers/net/phy/phy_device.o
drivers/net/phy/phy_device.c:659: error: static declaration of 'genphy_driver' follows non-static declaration
include/linux/phy.h:377: error: previous declaration of 'genphy_driver' was here
make[3]: *** [drivers/net/phy/phy_device.o] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc5-mm1-full/include/linux/phy.h.old	2005-08-07 15:34:01.000000000 +0200
+++ linux-2.6.13-rc5-mm1-full/include/linux/phy.h	2005-08-07 15:34:08.000000000 +0200
@@ -374,5 +374,4 @@
 void phy_print_status(struct phy_device *phydev);
 
 extern struct bus_type mdio_bus_type;
-extern struct phy_driver genphy_driver;
 #endif /* __PHY_H */
--- linux-2.6.13-rc5-mm1-full/drivers/net/phy/phy_device.c.old	2005-08-07 15:34:15.000000000 +0200
+++ linux-2.6.13-rc5-mm1-full/drivers/net/phy/phy_device.c	2005-08-07 15:39:34.000000000 +0200
@@ -39,6 +39,8 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
+static struct phy_driver genphy_driver;
+
 /* get_phy_device
  *
  * description: Reads the ID registers of the PHY at addr on the

