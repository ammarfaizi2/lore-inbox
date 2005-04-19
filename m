Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVDSAg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVDSAg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 20:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVDSAg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 20:36:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26124 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261213AbVDSAgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 20:36:48 -0400
Date: Tue, 19 Apr 2005 02:36:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/seeq8005.c: cleanups
Message-ID: <20050419003646.GG5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make the needlessly global function seeq8005_init static
- kill an ancient version variable
- remove some outdated Emacs settings

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Feb 2005

 drivers/net/seeq8005.c |   23 ++---------------------
 1 files changed, 2 insertions(+), 21 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/seeq8005.c.old	2005-02-16 18:18:56.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/seeq8005.c	2005-02-21 15:19:11.000000000 +0100
@@ -12,12 +12,6 @@
 	This file is a network device driver for the SEEQ 8005 chipset and
 	the Linux operating system.
 
-*/
-
-static const char version[] =
-	"seeq8005.c:v1.00 8/07/95 Hamish Coleman (hamish@zot.apana.org.au)\n";
-
-/*
   Sources:
   	SEEQ 8005 databook
   	
@@ -91,7 +85,7 @@
 /* Example routines you must write ;->. */
 #define tx_done(dev)	(inw(SEEQ_STATUS) & SEEQSTAT_TX_ON)
 static void hardware_send_packet(struct net_device *dev, char *buf, int length);
-extern void seeq8005_init(struct net_device *dev, int startp);
+static  void seeq8005_init(struct net_device *dev, int startp);
 static inline void wait_for_buffer(struct net_device *dev);
 
 
@@ -150,7 +144,6 @@
 
 static int __init seeq8005_probe1(struct net_device *dev, int ioaddr)
 {
-	static unsigned version_printed;
 	int i,j;
 	unsigned char SA_prom[32];
 	int old_cfg1;
@@ -291,9 +284,6 @@
 	}
 #endif
 
-	if (net_debug  &&  version_printed++ == 0)
-		printk(version);
-
 	printk("%s: %s found at %#3x, ", dev->name, "seeq8005", ioaddr);
 
 	/* Fill in the 'dev' fields. */
@@ -637,7 +627,7 @@
 #endif
 }
 
-void seeq8005_init(struct net_device *dev, int startp)
+static void seeq8005_init(struct net_device *dev, int startp)
 {
 	struct net_local *lp = netdev_priv(dev);
 	int ioaddr = dev->base_addr;
@@ -758,12 +748,3 @@
 }
 
 #endif /* MODULE */
-
-/*
- * Local variables:
- *  compile-command: "gcc -D__KERNEL__ -I/usr/src/linux/net/inet -Wall -Wstrict-prototypes -O6 -m486 -c skeleton.c"
- *  version-control: t
- *  kept-new-versions: 5
- *  tab-width: 4
- * End:
- */

