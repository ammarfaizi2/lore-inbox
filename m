Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWEAVFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWEAVFH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWEAVFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:05:07 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:8303 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932264AbWEAVFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:05:06 -0400
From: David Brownell <david-b@pacbell.net>
To: jt@hpl.hp.com
Subject: [patch 2.6.17-rc3] smsc-ircc2, minimal PNP hotplug support
Date: Mon, 1 May 2006 13:13:43 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3vmVExnxc/CjIFz"
Message-Id: <200605011313.43625.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_3vmVExnxc/CjIFz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

An old laptop now behaves more sanely.

--Boundary-00=_3vmVExnxc/CjIFz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ir-smsc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ir-smsc.patch"

Minimal PNP hotplug support for the smsc-ircc2 driver.  A modular driver
will be modprobed via hotplug, but still bypasses driver model probing.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: linux/drivers/net/irda/smsc-ircc2.c
===================================================================
--- linux.orig/drivers/net/irda/smsc-ircc2.c	2006-04-23 23:23:38.000000000 -0700
+++ linux/drivers/net/irda/smsc-ircc2.c	2006-04-28 21:42:14.000000000 -0700
@@ -54,6 +54,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/serial_reg.h>
 #include <linux/dma-mapping.h>
+#include <linux/pnp.h>
 #include <linux/platform_device.h>
 
 #include <asm/io.h>
@@ -358,6 +360,16 @@
                iobase + IRCC_MASTER);
 }
 
+#ifdef	CONFIG_PNP
+/* PNP hotplug support */
+static const struct pnp_device_id smsc_ircc_pnp_table[] = {
+	{ .id = "SMCf010", .driver_data = 0 },
+	/* and presumably others */
+	{ }
+};
+MODULE_DEVICE_TABLE(pnp, smsc_ircc_pnp_table);
+#endif
+
 
 /*******************************************************************************
  *
@@ -2072,7 +2084,8 @@
 
 /* PROBING
  *
- *
+ * REVISIT we can be told about the device by PNP, and should use that info
+ * instead of probing hardware and creating a platform_device ...
  */
 
 static int __init smsc_ircc_look_for_chips(void)

--Boundary-00=_3vmVExnxc/CjIFz--
