Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUBDUwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUBDUtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:49:49 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:31493
	"EHLO muru.com") by vger.kernel.org with ESMTP id S266588AbUBDUp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:45:58 -0500
Date: Wed, 4 Feb 2004 12:46:01 -0800
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [PATCH] Update ohci-omap to compile
Message-ID: <20040204204601.GD8007@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

Following is a trivial patch to update the ohci-omap.c in 2.6.2 to be in 
sync with the OMAP tree. Basically the IRQ name was changed, which keeps 
the driver from compiling.

It also includes a cosmetic change to replace inl/outl with readl/writel. 
Can you please apply?

Regards,

Tony


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.2-ohci-omap-update"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1551  -> 1.1552 
#	drivers/usb/host/ohci-omap.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/04	tmlind@kaakku.muru.com	1.1552
# Patch to update the mainline ohci-omap.c with the current version
# - Changed irq name from INT_OHCI to INT_USB_HHC_1
# - Cosmetic fix to replace inl/outl with readl/writel
# --------------------------------------------
#
diff -Nru a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
--- a/drivers/usb/host/ohci-omap.c	Wed Feb  4 12:34:34 2004
+++ b/drivers/usb/host/ohci-omap.c	Wed Feb  4 12:34:34 2004
@@ -134,7 +134,7 @@
 			writel(readl(ULPD_SOFT_REQ_REG) | SOFT_USB_REQ,
 				ULPD_SOFT_REQ_REG);
 
-			outl(inl(ULPD_STATUS_REQ_REG) | USB_HOST_DPLL_REQ,
+			writel(readl(ULPD_STATUS_REQ_REG) | USB_HOST_DPLL_REQ,
 			     ULPD_STATUS_REQ_REG);
 		}
 
@@ -248,7 +248,7 @@
 	val |= (1 << 2); /* Disable pulldown on integrated transceiver DM */
 	val |= (1 << 1); /* Disable pulldown on integraded transceiver DP */
 
-	outl(val, USB_TRANSCEIVER_CTRL);
+	writel(val, USB_TRANSCEIVER_CTRL);
 
 	/* Set the USB0_TRX_MODE */
 	val = 0;
@@ -256,7 +256,7 @@
 	val &= ~DEV_IDLE_EN;
 	val &= ~(7 << 16);	/* Clear USB0_TRX_MODE */
 	val |= (3 << 16);	/* 0 or 3, 6-wire DAT/SE0, TRM p 15-159 */
-	outl(val, OTG_SYSCON_1);
+	writel(val, OTG_SYSCON_1);
 
 	/* 
 	 * Control via OTG, see TRM p 15-163
@@ -275,10 +275,10 @@
 	val |= (4 << 16);	/* Must be 4 */
 	val |= USBX_SYNCHRO;	/* Must be set */
 	val |= SRP_VBUS;
-	outl(val, OTG_SYSCON_2);
+	writel(val, OTG_SYSCON_2);
 
 	/* Enable OTG idle */
-	//outl(inl(OTG_SYSCON_1) | OTG_IDLE_EN, OTG_SYSCON_1);
+	//writel(readl(OTG_SYSCON_1) | OTG_IDLE_EN, OTG_SYSCON_1);
 
 	return 0;
 }
@@ -631,7 +631,7 @@
 		.end	= OMAP_OHCI_BASE + OMAP_OHCI_SIZE,
 	},
 	.irq = {
-		INT_OHCI,
+		INT_USB_HHC_1,
 	},
 };
 

--XsQoSWH+UP9D9v3l--
