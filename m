Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUCVU6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 15:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbUCVU6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 15:58:48 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:21894 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262953AbUCVU6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 15:58:43 -0500
Date: Mon, 22 Mar 2004 21:58:01 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.5-rc2 Kconfig-patch
Message-ID: <20040322215801.X30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/Kconfig |   32 +++++++++++++-------------------
 1 files changed, 13 insertions(+), 19 deletions(-)

through these ChangeSets:

<wim@iguana.be> (04/03/22 1.1833)
   [WATCHDOG] v2.6.5-rc2 Kconfig-patch
   
   Update Kconfig info to reflect the changes in wdt.c and wdt_pci.c


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

For completeness, I added the patches below.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	Mon Mar 22 21:55:55 2004
+++ b/drivers/char/watchdog/Kconfig	Mon Mar 22 21:55:55 2004
@@ -374,7 +374,7 @@
 	tristate "Berkshire Products ISA-PC Watchdog"
 	depends on WATCHDOG && ISA
 	---help---
-	  This is the driver for the Berkshire Products PC Watchdog card.
+	  This is the driver for the Berkshire Products ISA-PC Watchdog card.
 	  This card simply watches your kernel to make sure it doesn't freeze,
 	  and if it does, it reboots your computer after a certain amount of
 	  time. This driver is like the WDT501 driver but for different
@@ -406,10 +406,8 @@
 	---help---
 	  If you have a WDT500P or WDT501P watchdog board, say Y here,
 	  otherwise N. It is not possible to probe for this board, which means
-	  that you have to inform the kernel about the IO port and IRQ using
-	  the "wdt=" kernel option (try "man bootparam" or see the
-	  documentation of your boot loader (lilo or loadlin) about how to
-	  pass options to the kernel at boot time).
+	  that you have to inform the kernel about the IO port and IRQ that
+	  is needed (you can do this via the io and irq parameters)
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called wdt.
@@ -425,11 +423,8 @@
 	  Fahrenheit. This works only if you have a WDT501P watchdog board
 	  installed.
 
-config WDT_501_FAN
-	bool "Fan Tachometer"
-	depends on WDT_501
-	help
-	  Enable the Fan Tachometer on the WDT501. Only do this if you have a
+	  If you want to enable the Fan Tachometer on the WDT501P, then you
+	  can do this via the tachometer parameter. Only do this if you have a
 	  fan tachometer actually set up.
 
 #
@@ -455,29 +450,28 @@
 	  Most people will say N.
 
 config WDTPCI
-	tristate "WDT PCI Watchdog timer"
+	tristate "PCI-WDT500/501 Watchdog timer"
 	depends on WATCHDOG && PCI
 	---help---
-	  If you have a PCI WDT500/501 watchdog board, say Y here, otherwise
-	  N.  It is not possible to probe for this board, which means that you
-	  have to inform the kernel about the IO port and IRQ using the "wdt="
-	  kernel option (try "man bootparam" or see the documentation of your
-	  boot loader (lilo or loadlin) about how to pass options to the
-	  kernel at boot time).
+	  If you have a PCI-WDT500/501 watchdog board, say Y here, otherwise N.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called wdt_pci.
 
 config WDT_501_PCI
-	bool "WDT501-PCI features"
+	bool "PCI-WDT501 features"
 	depends on WDTPCI
 	help
 	  Saying Y here and creating a character special file /dev/temperature
 	  with major number 10 and minor number 131 ("man mknod") will give
 	  you a thermometer inside your computer: reading from
 	  /dev/temperature yields one byte, the temperature in degrees
-	  Fahrenheit. This works only if you have a WDT501P watchdog board
+	  Fahrenheit. This works only if you have a PCI-WDT501 watchdog board
 	  installed.
+
+	  If you want to enable the Fan Tachometer on the PCI-WDT501, then you
+	  can do this via the tachometer parameter. Only do this if you have a
+	  fan tachometer actually set up.
 
 #
 # USB-based Watchdog Cards
