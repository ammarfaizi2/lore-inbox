Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVBZAD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVBZAD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVBZABu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:01:50 -0500
Received: from lumumba.luc.ac.be ([193.190.9.252]:23303 "EHLO
	lumumba.luc.ac.be") by vger.kernel.org with ESMTP id S262809AbVBZABb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:01:31 -0500
Date: Sat, 26 Feb 2005 01:01:26 +0100
From: Panagiotis Issaris <takis@lumumba.luc.ac.be>
To: prism54-devel@prism54.org
Cc: linux-kernel@vger.kernel.org
Subject: prism54 not releasing region
Message-ID: <20050226010126.A28793@lumumba.luc.ac.be>
Reply-To: panagiotis.issaris@mech.kuleuven.ac.be
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To my newbie eye it looked as if the region requested at line 154
weren't released in case of the line 166 failure handling. Is
my assumption right?

With friendly regards,
Takis

diff -uprN linux-2.6.11-rc5-orig/drivers/net/wireless/prism54/islpci_hotplug.c linux-2.6.11-rc5-pi/drivers/net/wireless/prism54/islpci_hotplug.c
--- linux-2.6.11-rc5-orig/drivers/net/wireless/prism54/islpci_hotplug.c	2005-02-26 00:33:19.000000000 +0100
+++ linux-2.6.11-rc5-pi/drivers/net/wireless/prism54/islpci_hotplug.c	2005-02-26 00:34:13.000000000 +0100
@@ -163,7 +163,7 @@ prism54_probe(struct pci_dev *pdev, cons
 	if (rvalue || !mem_addr) {
 		printk(KERN_ERR "%s: PCI device memory region not configured; fix your BIOS or CardBus bridge/drivers\n",
 		       DRV_NAME);
-		goto do_pci_disable_device;
+		goto do_pci_release_regions;
 	}
 
 	/* enable PCI bus-mastering */

-- 
OpenPGP key: http://lumumba.luc.ac.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
