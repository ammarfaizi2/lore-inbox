Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUACXpL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 18:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbUACXpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 18:45:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48392 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264358AbUACXpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 18:45:05 -0500
Date: Sat, 3 Jan 2004 23:45:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Serial updates
Message-ID: <20040103234501.A11953@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of changes to the 8250 serial driver; these changes are
queued against 2.6.0 and will probably be sent upstream in about
12 hours time.

# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/02	rene.herman@nl.rmk.(none)	1.1569
# [SERIAL] add PnP ID to 8250_pnp.c
# 
# Patch from: Rene Herman
# 
# This patch adds the PnP ID for the E-Tech CyberBULLET PC56RVP.
# --------------------------------------------
# 04/01/02	rmk@flint.arm.linux.org.uk	1.1570
# [SERIAL] Remove old RSA resource handlign.
# 
# The resource handling left in autoconfig() is plainly wrong, since
# we've already claimed the necessary resources prior to calling
# autoconfig().  Therefore, we remove the superfluous code from
# autoconfig().
# --------------------------------------------
#
diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	Sat Jan  3 23:35:52 2004
+++ b/drivers/serial/8250.c	Sat Jan  3 23:35:52 2004
@@ -726,13 +726,6 @@
  out:	
 	spin_unlock_irqrestore(&up->port.lock, flags);
 //	restore_flags(flags);
-#ifdef CONFIG_SERIAL_8250_RSA
-	if (up->port.iobase && up->port.type == PORT_RSA) {
-		release_region(up->port.iobase, 8);
-		request_region(up->port.iobase + UART_RSA_BASE, 16,
-			       "serial_rsa");
-	}
-#endif
 	DEBUG_AUTOCONF("type=%s\n", uart_config[up->port.type].name);
 }
 
diff -Nru a/drivers/serial/8250_pnp.c b/drivers/serial/8250_pnp.c
--- a/drivers/serial/8250_pnp.c	Sat Jan  3 23:35:52 2004
+++ b/drivers/serial/8250_pnp.c	Sat Jan  3 23:35:52 2004
@@ -74,6 +74,9 @@
 	{	"DMB1032",		0	},
 	/* Creative Modem Blaster V.90 DI5660 */
 	{	"DMB2001",		0	},
+	/* E-Tech */
+	/* E-Tech CyberBULLET PC56RVP */
+	{	"ETT0002",		0	},
 	/* FUJITSU */
 	/* Fujitsu 33600 PnP-I2 R Plug & Play */
 	{	"FUJ0202",		0	},

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
