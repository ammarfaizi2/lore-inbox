Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290793AbSBLGfE>; Tue, 12 Feb 2002 01:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290796AbSBLGeu>; Tue, 12 Feb 2002 01:34:50 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:50875 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290793AbSBLGeg>; Tue, 12 Feb 2002 01:34:36 -0500
Date: Tue, 12 Feb 2002 08:26:15 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Kernel Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] printk prefix cleanups.
Message-ID: <Pine.LNX.4.44.0202120823200.27768-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a simple patch which reduces resultant binary size by 1.2k for 
this particular module (opl3sa2). Perhaps we should consider adding this 
on the janitor TODO list for cleaning up other printks.

Regards,
	Zwane Mwaikambo

--- linux-2.4.18-pre8-zm1/drivers/sound/opl3sa2.c.orig	Mon Feb 11 02:25:50 2002
+++ linux-2.4.18-pre8-zm1/drivers/sound/opl3sa2.c	Mon Feb 11 02:40:59 2002
@@ -71,6 +71,7 @@
 #include "mpu401.h"
 
 #define OPL3SA2_MODULE_NAME	"opl3sa2"
+#define OPL3SA2_PFX		OPL3SA2_MODULE_NAME ": "
 
 /* Useful control port indexes: */
 #define OPL3SA2_PM	     0x01
@@ -616,7 +617,7 @@
 			AD1848_REROUTE(SOUND_MIXER_LINE3, SOUND_MIXER_LINE);
 		}
 		else {
-			printk(KERN_ERR "opl3sa2: MSS mixer not installed?\n");
+			printk(KERN_ERR OPL3SA2_PFX "MSS mixer not installed?\n");
 		}
 	}
 }
@@ -639,7 +640,7 @@
 	 * Try and allocate our I/O port range.
 	 */
 	if(!request_region(hw_config->io_base, 2, OPL3SA2_MODULE_NAME)) {
-		printk(KERN_ERR "opl3sa2: Control I/O port %#x not free\n",
+		printk(KERN_ERR OPL3SA2_PFX "Control I/O port %#x not free\n",
 		       hw_config->io_base);
 		return 0;
 	}
@@ -652,7 +653,7 @@
 	opl3sa2_write(hw_config->io_base, OPL3SA2_MISC, misc ^ 0x07);
 	opl3sa2_read(hw_config->io_base, OPL3SA2_MISC, &tmp);
 	if(tmp != misc) {
-		printk(KERN_ERR "opl3sa2: Control I/O port %#x is not a YMF7xx chipset!\n",
+		printk(KERN_ERR OPL3SA2_PFX "Control I/O port %#x is not a YMF7xx chipset!\n",
 		       hw_config->io_base);
 		return 0;
 	}
@@ -665,7 +666,7 @@
 	opl3sa2_read(hw_config->io_base, OPL3SA2_MIC, &tmp);
 	if((tmp & 0x9f) != 0x8a) {
 		printk(KERN_ERR
-		       "opl3sa2: Control I/O port %#x is not a YMF7xx chipset!\n",
+		       OPL3SA2_PFX "Control I/O port %#x is not a YMF7xx chipset!\n",
 		       hw_config->io_base);
 		return 0;
 	}
@@ -678,33 +679,33 @@
 	 * of the miscellaneous register.
 	 */
 	version = misc & 0x07;
-	printk(KERN_DEBUG "opl3sa2: chipset version = %#x\n", version);
+	printk(KERN_DEBUG OPL3SA2_PFX "chipset version = %#x\n", version);
 	switch(version) {
 		case 0:
 			chipset[card] = CHIPSET_UNKNOWN;
 			tag = '?'; /* silence compiler warning */
 			printk(KERN_ERR
-			       "opl3sa2: Unknown Yamaha audio controller version\n");
+			       OPL3SA2_PFX "Unknown Yamaha audio controller version\n");
 			break;
 
 		case VERSION_YMF711:
 			chipset[card] = CHIPSET_OPL3SA2;
 			tag = '2';
-			printk(KERN_INFO "opl3sa2: Found OPL3-SA2 (YMF711)\n");
+			printk(KERN_INFO OPL3SA2_PFX "Found OPL3-SA2 (YMF711)\n");
 			break;
 
 		case VERSION_YMF715:
 			chipset[card] = CHIPSET_OPL3SA3;
 			tag = '3';
 			printk(KERN_INFO
-			       "opl3sa2: Found OPL3-SA3 (YMF715 or YMF719)\n");
+			       OPL3SA2_PFX "Found OPL3-SA3 (YMF715 or YMF719)\n");
 			break;
 
 		case VERSION_YMF715B:
 			chipset[card] = CHIPSET_OPL3SA3;
 			tag = '3';
 			printk(KERN_INFO
-			       "opl3sa2: Found OPL3-SA3 (YMF715B or YMF719B)\n");
+			       OPL3SA2_PFX "Found OPL3-SA3 (YMF715B or YMF719B)\n");
 			break;
 
 		case VERSION_YMF715E:
@@ -712,7 +713,7 @@
 			chipset[card] = CHIPSET_OPL3SA3;
 			tag = '3';
 			printk(KERN_INFO
-			       "opl3sa2: Found OPL3-SA3 (YMF715E or YMF719E)\n");
+			       OPL3SA2_PFX "Found OPL3-SA3 (YMF715E or YMF719E)\n");
 			break;
 	}
 
@@ -765,7 +766,7 @@
 							  sizeof(struct mixer_operations),
 							  devc);
 		if(opl3sa2_mixer[card] < 0) {
-			printk(KERN_ERR "opl3sa2: Could not install %s master mixer\n",
+			printk(KERN_ERR OPL3SA2_PFX "Could not install %s master mixer\n",
 				 mixer_operations->name);
 		}
 		else
@@ -803,7 +804,7 @@
 		opl3sa2_write(hw_config->io_base, OPL3SA2_SYS_CTRL, sys_ctrl);
 	}
 	else {
-		printk(KERN_ERR "opl3sa2: not setting ymode, it must be one of 0,1,2,3\n");
+		printk(KERN_ERR OPL3SA2_PFX "not setting ymode, it must be one of 0,1,2,3\n");
 	}
 }
 
@@ -818,7 +819,7 @@
 		opl3sa2_write(hw_config->io_base, OPL3SA2_MISC, misc);
 	}
 	else {
-		printk(KERN_ERR "opl3sa2: not setting loopback, it must be either 0 or 1\n");
+		printk(KERN_ERR OPL3SA2_PFX "not setting loopback, it must be either 0 or 1\n");
 	}
 }
 
@@ -868,7 +869,7 @@
 	 */
 	ret = dev->prepare(dev);
 	if(ret && ret != -EBUSY) {
-		printk(KERN_ERR "opl3sa2: ISA PnP found device that could not be autoconfigured.\n");
+		printk(KERN_ERR OPL3SA2_PFX "ISA PnP found device that could not be autoconfigured.\n");
 		return -ENODEV;
 	}
 	if(ret == -EBUSY) {
@@ -876,13 +877,13 @@
 	}
 	else {
 		if(dev->activate(dev) < 0) {
-			printk(KERN_WARNING "opl3sa2: ISA PnP activate failed\n");
+			printk(KERN_WARNING OPL3SA2_PFX "ISA PnP activate failed\n");
 			opl3sa2_activated[card] = 0;
 			return -ENODEV;
 		}
 
 		printk(KERN_DEBUG
-		       "opl3sa2: Activated ISA PnP card %d (active=%d)\n",
+		       OPL3SA2_PFX "Activated ISA PnP card %d (active=%d)\n",
 		       card, dev->active);
 
 	}
@@ -1022,11 +1023,11 @@
 						  &cfg_mpu[card],
 						  card) < 0) {
 			if(!opl3sa2_cards_num)
-				printk(KERN_INFO "opl3sa2: No PnP cards found\n");
+				printk(KERN_INFO OPL3SA2_PFX "No PnP cards found\n");
 			if(io == -1)
 				break;
 			isapnp=0;
-			printk(KERN_INFO "opl3sa2: Search for a card at 0x%d.\n", io);
+			printk(KERN_INFO OPL3SA2_PFX "Search for a card at 0x%d.\n", io);
 			/* Fall through */
 		}
 #endif
@@ -1036,7 +1037,7 @@
 			if(io == -1 || irq == -1 || dma == -1 ||
 			   dma2 == -1 || mss_io == -1) {
 				printk(KERN_ERR
-				       "opl3sa2: io, mss_io, irq, dma, and dma2 must be set\n");
+				       OPL3SA2_PFX "io, mss_io, irq, dma, and dma2 must be set\n");
 				return -EINVAL;
 			}
 
@@ -1078,7 +1079,7 @@
 			 */
 			if(opl3sa2_cards_num) {
 				printk(KERN_WARNING
-				       "opl3sa2: There was a problem probing one "
+				       OPL3SA2_PFX "There was a problem probing one "
 				       " of the ISA PNP cards, continuing\n");
 				opl3sa2_cards_num--;
 				continue;
@@ -1104,7 +1105,7 @@
 		if(ymode != -1) {
 			if(chipset[card] == CHIPSET_OPL3SA2) {
 				printk(KERN_ERR
-				       "opl3sa2: ymode not supported on OPL3-SA2\n");
+				       OPL3SA2_PFX "ymode not supported on OPL3-SA2\n");
 			}
 			else {
 				opl3sa2_set_ymode(&cfg[card], ymode);
@@ -1126,7 +1127,7 @@
 	}
 
 	if(isapnp) {
-		printk(KERN_NOTICE "opl3sa2: %d PnP card(s) found.\n", opl3sa2_cards_num);
+		printk(KERN_NOTICE OPL3SA2_PFX "%d PnP card(s) found.\n", opl3sa2_cards_num);
 	}
 
 	return 0;
@@ -1155,7 +1156,7 @@
 			opl3sa2_dev[card]->deactivate(opl3sa2_dev[card]);
 
 			printk(KERN_DEBUG
-			       "opl3sa2: Deactivated ISA PnP card %d (active=%d)\n",
+			       OPL3SA2_PFX "Deactivated ISA PnP card %d (active=%d)\n",
 			       card, opl3sa2_dev[card]->active);
 		}
 #endif

