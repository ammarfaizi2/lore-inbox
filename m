Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263871AbUECTTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbUECTTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUECTTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 15:19:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24994 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263871AbUECTTM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 15:19:12 -0400
Date: Mon, 3 May 2004 16:17:04 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cyclades cleanups
Message-ID: <20040503191704.GB6434@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

The following patch against 2.6.6-rc3-bk5:

- cleanups for cyclades Kconfig entry	(Adrian Bunk/me)
- janitors project: remove dead function	(Don Koch)

Please apply

diff -Nur linux-2.6.5.orig/drivers/char/Kconfig linux-2.6.5/drivers/char/Kconfig
--- linux-2.6.5.orig/drivers/char/Kconfig	2004-05-03 15:38:58.972659880 -0300
+++ linux-2.6.5/drivers/char/Kconfig	2004-05-03 15:45:44.365030872 -0300
@@ -112,15 +112,13 @@
 	tristate "Cyclades async mux support"
 	depends on SERIAL_NONSTANDARD
 	---help---
-	  This is a driver for a card that gives you many serial ports. You
-	  would need something like this to connect more than two modems to
+	  This driver supports Cyclades Z and Y multiserial boards. 
+	  You would need something like this to connect more than two modems to
 	  your Linux box, for instance in order to become a dial-in server.
+
 	  For information about the Cyclades-Z card, read
 	  <file:drivers/char/README.cycladesZ>.
 
-	  As of 1.3.9x kernels, this driver's minor numbers start at 0 instead
-	  of 32.
-
 	  To compile this driver as a module, choose M here: the
 	  module will be called cyclades.
 
diff -Nur linux-2.6.5.orig/drivers/char/cyclades.c linux-2.6.5/drivers/char/cyclades.c
--- linux-2.6.5.orig/drivers/char/cyclades.c	2004-05-03 15:38:58.977659120 -0300
+++ linux-2.6.5/drivers/char/cyclades.c	2004-05-03 15:48:27.348253656 -0300
@@ -681,16 +681,6 @@
 static void cy_throttle (struct tty_struct *tty);
 static void cy_send_xchar (struct tty_struct *tty, char ch);
 
-static unsigned long 
-cy_get_user(unsigned long *addr)
-{
-	unsigned long result = 0;
-	int error = get_user (result, addr);
-	if (error)
-		printk ("cyclades: cy_get_user: error == %d\n", error);
-	return result;
-}
-
 #ifndef MIN
 #define MIN(a,b)        ((a) < (b) ? (a) : (b))
 #endif
