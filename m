Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbSLKWdb>; Wed, 11 Dec 2002 17:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbSLKWcH>; Wed, 11 Dec 2002 17:32:07 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6660 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267339AbSLKWcB>;
	Wed, 11 Dec 2002 17:32:01 -0500
Date: Tue, 10 Dec 2002 23:01:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: hp100: Detect coax cabling
Message-ID: <20021210220127.GA544@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is only non-trivial patch from this series. It prints coax
vs. 10baseT information to the user, and fixes indentation. Please apply,

								Pavel

--- clean/drivers/net/hp100.c	2002-11-23 19:55:22.000000000 +0100
+++ linux-swsusp/drivers/net/hp100.c	2002-12-09 21:19:48.000000000 +0100
@@ -356,8 +353,8 @@
  * address - Jean II */
 static inline dma_addr_t virt_to_whatever(struct net_device *dev, u32 * ptr)
 {
-  return ((u_long) ptr) +
-    ((struct hp100_private *) (dev->priv))->whatever_offset;
+	return ((u_long) ptr) +
+		((struct hp100_private *) (dev->priv))->whatever_offset;
 }
 
 /* TODO: This function should not really be needed in a good design... */
@@ -854,7 +849,10 @@
 		printk("100Mb/s Voice Grade AnyLAN network.\n");
 		break;
 	case HP100_LAN_10:
-		printk("10Mb/s network.\n");
+		printk("10Mb/s network (10baseT).\n");
+		break;
+	case HP100_LAN_COAX:
+		printk("10Mb/s network (coax).\n");
 		break;
 	default:
 		printk("Warning! Link down.\n");
@@ -2535,11 +2534,16 @@
 		return HP100_LAN_10;
 
 	if (val_10 & HP100_AUI_ST) {	/* have we BNC or AUI onboard? */
+		/*
+		 * This can be overriden by dos utility, so if this has no effect,
+		 * perhaps you need to download that utility from HP and set card
+		 * back to "auto detect".
+		 */
 		val_10 |= HP100_AUI_SEL | HP100_LOW_TH;
 		hp100_page(MAC_CTRL);
 		hp100_outb(val_10, 10_LAN_CFG_1);
 		hp100_page(PERFORMANCE);
-		return HP100_LAN_10;
+		return HP100_LAN_COAX;
 	}
 
 	if ((lp->id->id == 0x02019F022) ||
--- clean/drivers/net/hp100.h	2001-05-16 19:25:38.000000000 +0200
+++ linux-swsusp/drivers/net/hp100.h	2002-11-28 21:18:09.000000000 +0100
@@ -518,12 +518,13 @@
  */
 #define HP100_LAN_100		100	/* lan_type value for VG */
 #define HP100_LAN_10		10	/* lan_type value for 10BaseT */
+#define HP100_LAN_COAX		9	/* lan_type value for Coax */
 #define HP100_LAN_ERR		(-1)	/* lan_type value for link down */
 
 #define TRUE 1
 #define FALSE 0
 
 
 /* 
  * Bus Master Data Structures  ----------------------------------------------
  */


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
