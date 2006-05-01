Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWEAHMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWEAHMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 03:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWEAHLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 03:11:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47889 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751312AbWEAHLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 03:11:48 -0400
Date: Mon, 1 May 2006 09:11:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/arm/kernel/bios32.c: no need to set isa_bridge
Message-ID: <20060501071148.GO3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since this assignment was the only place on !alpha where isa_bridge was 
touched, it didn't have any effect.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc2-mm1-shark/arch/arm/kernel/bios32.c.old	2006-04-27 23:11:07.000000000 +0200
+++ linux-2.6.17-rc2-mm1-shark/arch/arm/kernel/bios32.c	2006-04-27 23:12:15.000000000 +0200
@@ -371,17 +371,6 @@
 			features &= ~(PCI_COMMAND_SERR | PCI_COMMAND_PARITY);
 
 		switch (dev->class >> 8) {
-#if defined(CONFIG_ISA) || defined(CONFIG_EISA)
-		case PCI_CLASS_BRIDGE_ISA:
-		case PCI_CLASS_BRIDGE_EISA:
-			/*
-			 * If this device is an ISA bridge, set isa_bridge
-			 * to point at this device.  We will then go looking
-			 * for things like keyboard, etc.
-			 */
-			isa_bridge = dev;
-			break;
-#endif
 		case PCI_CLASS_BRIDGE_PCI:
 			pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &status);
 			status |= PCI_BRIDGE_CTL_PARITY|PCI_BRIDGE_CTL_MASTER_ABORT;

