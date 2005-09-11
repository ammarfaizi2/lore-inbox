Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVIKRL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVIKRL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVIKRL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:11:27 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:35973 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751107AbVIKRL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:11:27 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove unnecessary check_region references in comments
From: Peter Osterlund <petero2@telia.com>
Date: 11 Sep 2005 19:11:09 +0200
Message-ID: <m3wtlnttqq.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove check_region references from comments and printk statements so
that searching for real users of this deprecated function gets
easier.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/char/amiserial.c             |    4 ----
 drivers/isdn/sc/init.c               |    4 ++--
 drivers/media/radio/radio-aimslab.c  |    2 +-
 drivers/media/radio/radio-aztech.c   |    2 +-
 drivers/media/radio/radio-cadet.c    |    2 +-
 drivers/media/radio/radio-gemtek.c   |    2 +-
 drivers/media/radio/radio-rtrack2.c  |    2 +-
 drivers/media/radio/radio-sf16fmi.c  |    2 +-
 drivers/media/radio/radio-sf16fmr2.c |    2 +-
 drivers/media/radio/radio-terratec.c |    2 +-
 drivers/media/radio/radio-typhoon.c  |    2 +-
 drivers/media/radio/radio-zoltrix.c  |    2 +-
 drivers/net/arcnet/com90io.c         |    4 ++--
 drivers/sbus/char/display7seg.c      |    2 +-
 drivers/tc/zs.c                      |    2 +-
 15 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/char/amiserial.c b/drivers/char/amiserial.c
--- a/drivers/char/amiserial.c
+++ b/drivers/char/amiserial.c
@@ -2053,10 +2053,6 @@ static int __init rs_init(void)
 	state->icount.rx = state->icount.tx = 0;
 	state->icount.frame = state->icount.parity = 0;
 	state->icount.overrun = state->icount.brk = 0;
-	/*
-	if(state->port && check_region(state->port,REGION_LENGTH(state)))
-	  continue;
-	*/
 
 	printk(KERN_INFO "ttyS%d is the amiga builtin serial port\n",
 		       state->line);
diff --git a/drivers/isdn/sc/init.c b/drivers/isdn/sc/init.c
--- a/drivers/isdn/sc/init.c
+++ b/drivers/isdn/sc/init.c
@@ -87,7 +87,7 @@ static int __init sc_init(void)
 			 */
 			for (i = 0 ; i < MAX_IO_REGS - 1 ; i++) {
 				if(!request_region(io[b] + i * 0x400, 1, "sc test")) {
-					pr_debug("check_region for 0x%x failed\n", io[b] + i * 0x400);
+					pr_debug("request_region for 0x%x failed\n", io[b] + i * 0x400);
 					io[b] = 0;
 					break;
 				} else
@@ -181,7 +181,7 @@ static int __init sc_init(void)
 			for (i = SRAM_MIN ; i < SRAM_MAX ; i += SRAM_PAGESIZE) {
 				pr_debug("Checking RAM address 0x%x...\n", i);
 				if(request_region(i, SRAM_PAGESIZE, "sc test")) {
-					pr_debug("  check_region succeeded\n");
+					pr_debug("  request_region succeeded\n");
 					model = identify_board(i, io[b]);
 					release_region(i, SRAM_PAGESIZE);
 					if (model >= 0) {
diff --git a/drivers/media/radio/radio-aimslab.c b/drivers/media/radio/radio-aimslab.c
--- a/drivers/media/radio/radio-aimslab.c
+++ b/drivers/media/radio/radio-aimslab.c
@@ -29,7 +29,7 @@
 
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
diff --git a/drivers/media/radio/radio-aztech.c b/drivers/media/radio/radio-aztech.c
--- a/drivers/media/radio/radio-aztech.c
+++ b/drivers/media/radio/radio-aztech.c
@@ -26,7 +26,7 @@
 
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
diff --git a/drivers/media/radio/radio-cadet.c b/drivers/media/radio/radio-cadet.c
--- a/drivers/media/radio/radio-cadet.c
+++ b/drivers/media/radio/radio-cadet.c
@@ -29,7 +29,7 @@
 
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
diff --git a/drivers/media/radio/radio-gemtek.c b/drivers/media/radio/radio-gemtek.c
--- a/drivers/media/radio/radio-gemtek.c
+++ b/drivers/media/radio/radio-gemtek.c
@@ -17,7 +17,7 @@
 
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
diff --git a/drivers/media/radio/radio-rtrack2.c b/drivers/media/radio/radio-rtrack2.c
--- a/drivers/media/radio/radio-rtrack2.c
+++ b/drivers/media/radio/radio-rtrack2.c
@@ -10,7 +10,7 @@
 
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
diff --git a/drivers/media/radio/radio-sf16fmi.c b/drivers/media/radio/radio-sf16fmi.c
--- a/drivers/media/radio/radio-sf16fmi.c
+++ b/drivers/media/radio/radio-sf16fmi.c
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>	/* __setup			*/
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <linux/videodev.h>	/* kernel radio structs		*/
 #include <linux/isapnp.h>
diff --git a/drivers/media/radio/radio-sf16fmr2.c b/drivers/media/radio/radio-sf16fmr2.c
--- a/drivers/media/radio/radio-sf16fmr2.c
+++ b/drivers/media/radio/radio-sf16fmr2.c
@@ -14,7 +14,7 @@
 
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
diff --git a/drivers/media/radio/radio-terratec.c b/drivers/media/radio/radio-terratec.c
--- a/drivers/media/radio/radio-terratec.c
+++ b/drivers/media/radio/radio-terratec.c
@@ -25,7 +25,7 @@
 
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
-#include <linux/ioport.h>	/* check_region, request_region	*/
+#include <linux/ioport.h>	/* request_region		*/
 #include <linux/delay.h>	/* udelay			*/
 #include <asm/io.h>		/* outb, outb_p			*/
 #include <asm/uaccess.h>	/* copy to/from user		*/
diff --git a/drivers/media/radio/radio-typhoon.c b/drivers/media/radio/radio-typhoon.c
--- a/drivers/media/radio/radio-typhoon.c
+++ b/drivers/media/radio/radio-typhoon.c
@@ -31,7 +31,7 @@
 
 #include <linux/module.h>	/* Modules                        */
 #include <linux/init.h>		/* Initdata                       */
-#include <linux/ioport.h>	/* check_region, request_region   */
+#include <linux/ioport.h>	/* request_region		  */
 #include <linux/proc_fs.h>	/* radio card status report	  */
 #include <asm/io.h>		/* outb, outb_p                   */
 #include <asm/uaccess.h>	/* copy to/from user              */
diff --git a/drivers/media/radio/radio-zoltrix.c b/drivers/media/radio/radio-zoltrix.c
--- a/drivers/media/radio/radio-zoltrix.c
+++ b/drivers/media/radio/radio-zoltrix.c
@@ -28,7 +28,7 @@
 
 #include <linux/module.h>	/* Modules                        */
 #include <linux/init.h>		/* Initdata                       */
-#include <linux/ioport.h>	/* check_region, request_region   */
+#include <linux/ioport.h>	/* request_region		  */
 #include <linux/delay.h>	/* udelay, msleep                 */
 #include <asm/io.h>		/* outb, outb_p                   */
 #include <asm/uaccess.h>	/* copy to/from user              */
diff --git a/drivers/net/arcnet/com90io.c b/drivers/net/arcnet/com90io.c
--- a/drivers/net/arcnet/com90io.c
+++ b/drivers/net/arcnet/com90io.c
@@ -160,7 +160,7 @@ static int __init com90io_probe(struct n
 		return -ENODEV;
 	}
 	if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "com90io probe")) {
-		BUGMSG(D_INIT_REASONS, "IO check_region %x-%x failed.\n",
+		BUGMSG(D_INIT_REASONS, "IO request_region %x-%x failed.\n",
 		       ioaddr, ioaddr + ARCNET_TOTAL_SIZE - 1);
 		return -ENXIO;
 	}
@@ -242,7 +242,7 @@ static int __init com90io_found(struct n
 		BUGMSG(D_NORMAL, "Can't get IRQ %d!\n", dev->irq);
 		return -ENODEV;
 	}
-	/* Reserve the I/O region - guaranteed to work by check_region */
+	/* Reserve the I/O region */
 	if (!request_region(dev->base_addr, ARCNET_TOTAL_SIZE, "arcnet (COM90xx-IO)")) {
 		free_irq(dev->irq, dev);
 		return -EBUSY;
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -14,7 +14,7 @@
 #include <linux/major.h>
 #include <linux/init.h>
 #include <linux/miscdevice.h>
-#include <linux/ioport.h>		/* request_region, check_region */
+#include <linux/ioport.h>		/* request_region */
 #include <asm/atomic.h>
 #include <asm/ebus.h>			/* EBus device					*/
 #include <asm/oplib.h>			/* OpenProm Library 			*/
diff --git a/drivers/tc/zs.c b/drivers/tc/zs.c
--- a/drivers/tc/zs.c
+++ b/drivers/tc/zs.c
@@ -1683,7 +1683,7 @@ static void __init probe_sccs(void)
 #ifndef CONFIG_SERIAL_DEC_CONSOLE
 			/*
 			 * We're called early and memory managment isn't up, yet.
-			 * Thus check_region would fail.
+			 * Thus request_region would fail.
 			 */
 			if (!request_region((unsigned long)
 					 zs_channels[n_channels].control,

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
