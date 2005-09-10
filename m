Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVIJMVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVIJMVe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVIJMVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:21:17 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:39303 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750778AbVIJMVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:21:13 -0400
Date: Sat, 10 Sep 2005 14:21:10 +0200
Message-Id: <200509101221.j8ACLAOV017267@localhost.localdomain>
In-reply-to: <200509101219.j8ACJHeb017063@localhost.localdomain>
Subject: [PATCH 10/10] drivers/char: pci_find_device remove (drivers/char/watchdog/i8xx_tco.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 i8xx_tco.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/watchdog/i8xx_tco.c b/drivers/char/watchdog/i8xx_tco.c
--- a/drivers/char/watchdog/i8xx_tco.c
+++ b/drivers/char/watchdog/i8xx_tco.c
@@ -414,12 +414,11 @@ static unsigned char __init i8xx_tco_get
 	 *      Find the PCI device
 	 */
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev)
 		if (pci_match_id(i8xx_tco_pci_tbl, dev)) {
 			i8xx_tco_pci = dev;
 			break;
 		}
-	}
 
 	if (i8xx_tco_pci) {
 		/*
@@ -535,6 +534,8 @@ static void __exit watchdog_cleanup (voi
 	misc_deregister (&i8xx_tco_miscdev);
 	unregister_reboot_notifier(&i8xx_tco_notifier);
 	release_region (TCOBASE, 0x10);
+
+	pci_dev_put(i8xx_tco_pci);
 }
 
 module_init(watchdog_init);
