Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSLZSwT>; Thu, 26 Dec 2002 13:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSLZSwT>; Thu, 26 Dec 2002 13:52:19 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3076 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262692AbSLZSvL>;
	Thu, 26 Dec 2002 13:51:11 -0500
Date: Thu, 26 Dec 2002 08:38:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: perex@suse.cz,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Tiny cleanup for hp100
Message-ID: <20021226073846.GA819@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Tiny cleanup and warning about dos utility (it took me 2 weeks to find
out whats going on there). Please apply,
								Pavel

--- clean/drivers/net/hp100.c	2002-12-25 23:59:19.000000000 +0100
+++ linux-swsusp/drivers/net/hp100.c	2002-12-09 21:19:48.000000000 +0100
@@ -2091,12 +2091,10 @@
 
 static void hp100_misc_interrupt(struct net_device *dev)
 {
-#ifdef HP100_DEBUG_B
-	int ioaddr = dev->base_addr;
-#endif
 	struct hp100_private *lp = (struct hp100_private *) dev->priv;
 
 #ifdef HP100_DEBUG_B
+	int ioaddr = dev->base_addr;
 	hp100_outw(0x4216, TRACE);
 	printk("hp100: %s: misc_interrupt\n", dev->name);
 #endif
@@ -2536,6 +2534,11 @@
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

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
