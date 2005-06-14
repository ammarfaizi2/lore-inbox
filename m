Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVFNBqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVFNBqL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 21:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFNBqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 21:46:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32013 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261238AbVFNBp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 21:45:58 -0400
Date: Tue, 14 Jun 2005 03:45:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: [2.6 patch] drivers/char/rio/: kill rio_udelay
Message-ID: <20050614014553.GD3770@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need for a function that only calls udelays.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/rio/func.h      |    1 -
 drivers/char/rio/rio_linux.c |    5 -----
 drivers/char/rio/rioinit.c   |    7 ++++---
 3 files changed, 4 insertions(+), 9 deletions(-)

--- linux-2.6.12-rc6-mm1-full/drivers/char/rio/func.h.old	2005-06-14 02:45:06.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/drivers/char/rio/func.h	2005-06-14 02:45:12.000000000 +0200
@@ -147,7 +147,6 @@
 extern int    rio_pcicopy(char *src, char *dst, int n);
 extern int rio_minor (struct tty_struct *tty);
 extern int rio_ismodem (struct tty_struct *tty);
-extern void rio_udelay (int usecs);
 
 extern void rio_start_card_running (struct Host * HostP);
 
--- linux-2.6.12-rc6-mm1-full/drivers/char/rio/rio_linux.c.old	2005-06-14 02:45:19.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/drivers/char/rio/rio_linux.c	2005-06-14 02:45:27.000000000 +0200
@@ -354,11 +354,6 @@
 }
 
 
-void rio_udelay (int usecs)
-{
-  udelay (usecs);
-}
-
 static int rio_set_real_termios (void *ptr)
 {
   int rv, modem;
--- linux-2.6.12-rc6-mm1-full/drivers/char/rio/rioinit.c.old	2005-06-14 02:45:35.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/drivers/char/rio/rioinit.c	2005-06-14 02:55:17.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/string.h>
@@ -1560,14 +1561,14 @@
 					  INTERRUPT_DISABLE | BYTE_OPERATION |
 					  SLOW_LINKS | SLOW_AT_BUS);
 			WBYTE(DpRamP->DpResetTpu, 0xFF);
-			rio_udelay (3);
+			udelay(3);
 
 			rio_dprintk (RIO_DEBUG_INIT,  "RIOHostReset: Don't know if it worked. Try reset again\n");
 			WBYTE(DpRamP->DpControl,  BOOT_FROM_RAM | EXTERNAL_BUS_OFF |
 					  INTERRUPT_DISABLE | BYTE_OPERATION |
 					  SLOW_LINKS | SLOW_AT_BUS);
 			WBYTE(DpRamP->DpResetTpu, 0xFF);
-			rio_udelay (3);
+			udelay(3);
 			break;
 #ifdef FUTURE_RELEASE
 	case RIO_EISA:
@@ -1599,7 +1600,7 @@
 		DpRamP->DpControl  = RIO_PCI_BOOT_FROM_RAM;
 		DpRamP->DpResetInt = 0xFF;
 		DpRamP->DpResetTpu = 0xFF;
-		rio_udelay (100);
+		udelay(100);
 		/* for (i=0; i<6000; i++);  */
 		/* suspend( 3 ); */
 		break;

