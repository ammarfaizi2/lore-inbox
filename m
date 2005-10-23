Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVJWSGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVJWSGg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 14:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVJWSGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 14:06:36 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:49030 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1750783AbVJWSGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 14:06:35 -0400
Date: Sun, 23 Oct 2005 20:06:25 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] small trivial fixes + add .owner to driver struct's
Message-ID: <20051023180625.GB7795@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	git pull rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/mpcore_wdt.c   |    1 +
 drivers/char/watchdog/mv64x60_wdt.c  |    1 +
 drivers/char/watchdog/pcwd_pci.c     |    7 +++++--
 drivers/char/watchdog/s3c2410_wdt.c  |    1 +
 drivers/char/watchdog/w83627hf_wdt.c |    2 +-
 drivers/char/watchdog/wdt_pci.c      |    1 +
 6 files changed, 10 insertions(+), 3 deletions(-)

with these Changes:

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sun Oct 23 15:21:44 2005 +0200

    [WATCHDOG] adds device_driver .owner field
    
    Initialise the .owner field of the device driver
    with the module that owns it, for easier tracking
    of device driver ownership. (probably also better
    for sysfs...)
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Laurent Riffard <laurent.riffard@free.fr>
Date:   Sat Oct 22 21:41:26 2005 +0200

    [WATCHDOG] updates .owner field of struct pci_driver
    
    This patch updates .owner field of struct pci_driver.
    This allows SYSFS to create the symlink from the driver to the
    module which provides it.
    
    Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Wim Van Sebroeck <wim@iguana.be>
Date:   Sat Oct 22 16:27:19 2005 +0200

    [WATCHDOG] pcwd_pci.c update comments
    
    update copyright + update bells and whistles driver for v2.6
    
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Pozsar Balazs <pozsy@uhulinux.hu>
Date:   Fri Oct 21 10:52:01 2005 +0100

    [WATCHDOG] w83627hf_wdt trivial typo
    
    The most trivial typo fix in the world.
    
    Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>
    Signed-off-by: P�draig Brady <P@draigBrady.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Ben Dooks <ben-linux@fluff.org>
Date:   Mon Oct 10 01:28:30 2005 +0100

    [WATCHDOG] s3c2410 wdt - add .owner field
    
    Initialise the .owner field of the device driver
    with the module that owns it, for easier tracking
    of device driver ownership.
    
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>


The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/mpcore_wdt.c b/drivers/char/watchdog/mpcore_wdt.c
--- a/drivers/char/watchdog/mpcore_wdt.c
+++ b/drivers/char/watchdog/mpcore_wdt.c
@@ -396,6 +396,7 @@ static int __devexit mpcore_wdt_remove(s
 }
 
 static struct device_driver mpcore_wdt_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "mpcore_wdt",
 	.bus		= &platform_bus_type,
 	.probe		= mpcore_wdt_probe,
diff --git a/drivers/char/watchdog/mv64x60_wdt.c b/drivers/char/watchdog/mv64x60_wdt.c
--- a/drivers/char/watchdog/mv64x60_wdt.c
+++ b/drivers/char/watchdog/mv64x60_wdt.c
@@ -211,6 +211,7 @@ static int __devexit mv64x60_wdt_remove(
 }
 
 static struct device_driver mv64x60_wdt_driver = {
+	.owner = THIS_MODULE,
 	.name = MV64x60_WDT_NAME,
 	.bus = &platform_bus_type,
 	.probe = mv64x60_wdt_probe,
diff --git a/drivers/char/watchdog/pcwd_pci.c b/drivers/char/watchdog/pcwd_pci.c
--- a/drivers/char/watchdog/pcwd_pci.c
+++ b/drivers/char/watchdog/pcwd_pci.c
@@ -1,7 +1,7 @@
 /*
  *	Berkshire PCI-PC Watchdog Card Driver
  *
- *	(c) Copyright 2003 Wim Van Sebroeck <wim@iguana.be>.
+ *	(c) Copyright 2003-2005 Wim Van Sebroeck <wim@iguana.be>.
  *
  *	Based on source code of the following authors:
  *	  Ken Hollis <kenji@bitgate.com>,
@@ -21,7 +21,9 @@
  */
 
 /*
- *	A bells and whistles driver is available from http://www.pcwd.de/
+ *	A bells and whistles driver is available from: 
+ *	http://www.kernel.org/pub/linux/kernel/people/wim/pcwd/pcwd_pci/
+ *
  *	More info available at http://www.berkprod.com/ or http://www.pcwatchdog.com/
  */
 
@@ -753,6 +755,7 @@ static struct pci_device_id pcipcwd_pci_
 MODULE_DEVICE_TABLE(pci, pcipcwd_pci_tbl);
 
 static struct pci_driver pcipcwd_driver = {
+	.owner		= THIS_MODULE,
 	.name		= WATCHDOG_NAME,
 	.id_table	= pcipcwd_pci_tbl,
 	.probe		= pcipcwd_card_init,
diff --git a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
--- a/drivers/char/watchdog/s3c2410_wdt.c
+++ b/drivers/char/watchdog/s3c2410_wdt.c
@@ -501,6 +501,7 @@ static int s3c2410wdt_resume(struct devi
 
 
 static struct device_driver s3c2410wdt_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "s3c2410-wdt",
 	.bus		= &platform_bus_type,
 	.probe		= s3c2410wdt_probe,
diff --git a/drivers/char/watchdog/w83627hf_wdt.c b/drivers/char/watchdog/w83627hf_wdt.c
--- a/drivers/char/watchdog/w83627hf_wdt.c
+++ b/drivers/char/watchdog/w83627hf_wdt.c
@@ -359,5 +359,5 @@ module_exit(wdt_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("P�draig Brady <P@draigBrady.com>");
-MODULE_DESCRIPTION("w38627hf WDT driver");
+MODULE_DESCRIPTION("w83627hf WDT driver");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
diff --git a/drivers/char/watchdog/wdt_pci.c b/drivers/char/watchdog/wdt_pci.c
--- a/drivers/char/watchdog/wdt_pci.c
+++ b/drivers/char/watchdog/wdt_pci.c
@@ -711,6 +711,7 @@ MODULE_DEVICE_TABLE(pci, wdtpci_pci_tbl)
 
 
 static struct pci_driver wdtpci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "wdt_pci",
 	.id_table	= wdtpci_pci_tbl,
 	.probe		= wdtpci_init_one,
