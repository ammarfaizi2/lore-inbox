Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWJPPca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWJPPca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWJPPca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:32:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35782 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422655AbWJPPc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:32:29 -0400
Subject: [PATCH] intel fb: switch to pci_get API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:59:12 +0100
Message-Id: <1161014353.24237.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/video/intelfb/intelfbhw.c linux-2.6.19-rc1-mm1/drivers/video/intelfb/intelfbhw.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/video/intelfb/intelfbhw.c	2006-10-13 15:10:07.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/video/intelfb/intelfbhw.c	2006-10-13 17:21:18.000000000 +0100
@@ -161,7 +161,7 @@
 		return 1;
 
 	/* Find the bridge device.  It is always 0:0.0 */
-	if (!(bridge_dev = pci_find_slot(0, PCI_DEVFN(0, 0)))) {
+	if (!(bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0)))) {
 		ERR_MSG("cannot find bridge device\n");
 		return 1;
 	}
@@ -169,6 +169,8 @@
 	/* Get the fb aperture size and "stolen" memory amount. */
 	tmp = 0;
 	pci_read_config_word(bridge_dev, INTEL_GMCH_CTRL, &tmp);
+	pci_dev_put(bridge_dev);
+	
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_INTEL_915G:
 	case PCI_DEVICE_ID_INTEL_915GM:

