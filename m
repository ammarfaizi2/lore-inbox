Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTIVO0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTIVO0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:26:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38901 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263162AbTIVO0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:26:08 -0400
Date: Mon, 22 Sep 2003 16:26:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: [2.5 patch] remove CONFIG_SERIAL_21285_OLD (fwd)
Message-ID: <20030922142602.GA6325@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below (already approved by Russell King) still applies (with a 
few lines offset) against current 2.6 kernels.

Please apply
Adrian


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Mon, 14 Jul 2003 00:41:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] remove CONFIG_SERIAL_21285_OLD

CONFIG_SERIAL_21285_OLD depends on the non-existent option
CONFIG_OBSOLETE, IOW it's not selectable, and the help text says "This
is obsolete and will be removed during later 2.5 development.".

Is the patch below to remove this option OK?

cu
Adrian

--- linux-2.5.75-mm1/drivers/serial/Kconfig.old	2003-07-14 00:35:38.000000000 +0200
+++ linux-2.5.75-mm1/drivers/serial/Kconfig	2003-07-14 00:36:26.000000000 +0200
@@ -249,13 +249,6 @@
 	  PCI bridge you can enable its onboard serial port by enabling this
 	  option.
 
-config SERIAL_21285_OLD
-	bool "Use /dev/ttyS0 device (OBSOLETE)"
-	depends on SERIAL_21285=y && OBSOLETE
-	help
-	  Use the old /dev/ttyS name, major 4 minor 64.  This is obsolete
-	  and will be removed during later 2.5 development.
-
 config SERIAL_21285_CONSOLE
 	bool "Console on DC21285 serial port"
 	depends on SERIAL_21285=y
--- linux-2.5.75-mm1/drivers/serial/21285.c.old	2003-07-14 00:37:07.000000000 +0200
+++ linux-2.5.75-mm1/drivers/serial/21285.c	2003-07-14 00:38:16.000000000 +0200
@@ -481,18 +481,6 @@
 }
 
 extern struct uart_driver serial21285_reg;
-#ifdef CONFIG_SERIAL_21285_OLD
-static struct console serial21285_old_cons =
-{
-	.name		= SERIAL_21285_OLD_NAME,
-	.write		= serial21285_console_write,
-	.device		= uart_console_device,
-	.setup		= serial21285_console_setup,
-	.flags		= CON_PRINTBUFFER,
-	.index		= -1,
-	.data		= &serial21285_reg,
-};
-#endif
 
 static struct console serial21285_console =
 {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----
