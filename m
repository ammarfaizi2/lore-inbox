Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVBSAKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVBSAKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVBSAKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:10:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5636 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261575AbVBSAFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:05:45 -0500
Date: Sat, 19 Feb 2005 01:05:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/seeq8005.c: cleanups
Message-ID: <20050219000543.GJ4337@stusta.de>
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

 drivers/net/seeq8005.c |   25 +++----------------------
 1 files changed, 3 insertions(+), 22 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/seeq8005.c.old	2005-02-16 18:18:56.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/seeq8005.c	2005-02-16 18:19:53.000000000 +0100
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
   	
@@ -91,10 +85,10 @@
 /* Example routines you must write ;->. */
 #define tx_done(dev)	(inw(SEEQ_STATUS) & SEEQSTAT_TX_ON)
 static void hardware_send_packet(struct net_device *dev, char *buf, int length);
-extern void seeq8005_init(struct net_device *dev, int startp);
+static  void seeq8005_init(struct net_device *dev, int startp);
 static inline void wait_for_buffer(struct net_device *dev);
 
-
+
 /* Check for a network adaptor of this type, and return '0' iff one exists.
    If dev->base_addr == 0, probe all likely locations.
    If dev->base_addr == 1, always return failure.
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

