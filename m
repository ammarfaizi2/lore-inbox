Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVBUOxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVBUOxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVBUOuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:50:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44556 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261998AbVBUOs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:48:26 -0500
Date: Mon, 21 Feb 2005 15:48:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/seeq8005.c: cleanups
Message-ID: <20050221144823.GE3187@stusta.de>
References: <20050219000543.GJ4337@stusta.de> <42193B34.3000106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42193B34.3000106@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 08:36:52PM -0500, Jeff Garzik wrote:
> this patch needlessly eats formfeeds

Sorry, updated patch:


<--  snip  -->


This patch contains the following cleanups:
- make the needlessly global function seeq8005_init static
- kill an ancient version variable
- remove some outdated Emacs settings

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

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

