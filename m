Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVIJMVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVIJMVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVIJMVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:21:13 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:40071 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750773AbVIJMVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:21:13 -0400
Date: Sat, 10 Sep 2005 14:21:09 +0200
Message-Id: <200509101221.j8ACL9wY017263@localhost.localdomain>
In-reply-to: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 9/10] drivers/char: pci_find_device remove (drivers/char/watchdog/alim7101_wdt.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 alim7101_wdt.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/watchdog/alim7101_wdt.c b/drivers/char/watchdog/alim7101_wdt.c
--- a/drivers/char/watchdog/alim7101_wdt.c
+++ b/drivers/char/watchdog/alim7101_wdt.c
@@ -333,6 +333,8 @@ static void __exit alim7101_wdt_unload(v
 	/* Deregister */
 	misc_deregister(&wdt_miscdev);
 	unregister_reboot_notifier(&wdt_notifier);
+
+	pci_dev_put(alim7101_pmu);
 }
 
 static int __init alim7101_wdt_init(void)
@@ -342,7 +344,8 @@ static int __init alim7101_wdt_init(void
 	char tmp;
 
 	printk(KERN_INFO PFX "Steve Hill <steve@navaho.co.uk>.\n");
-	alim7101_pmu = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,NULL);
+	alim7101_pmu = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
+		NULL);
 	if (!alim7101_pmu) {
 		printk(KERN_INFO PFX "ALi M7101 PMU not present - WDT not set\n");
 		return -EBUSY;
@@ -351,12 +354,14 @@ static int __init alim7101_wdt_init(void
 	/* Set the WDT in the PMU to 1 second */
 	pci_write_config_byte(alim7101_pmu, ALI_7101_WDT, 0x02);
 
-	ali1543_south = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
+	ali1543_south = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+		NULL);
 	if (!ali1543_south) {
 		printk(KERN_INFO PFX "ALi 1543 South-Bridge not present - WDT not set\n");
 		return -EBUSY;
 	}
 	pci_read_config_byte(ali1543_south, 0x5e, &tmp);
+	pci_dev_put(ali1543_south);
 	if ((tmp & 0x1e) == 0x00) {
 		if (!use_gpio) {
 			printk(KERN_INFO PFX "Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.\n");
