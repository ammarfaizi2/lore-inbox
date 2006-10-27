Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946452AbWJ0MET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946452AbWJ0MET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 08:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946450AbWJ0MET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 08:04:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46289 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946447AbWJ0MES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 08:04:18 -0400
Subject: [PATCH]: JMB 368 PATA detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Oct 2006 13:07:41 +0100
Message-Id: <1161950862.16839.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Jmicron JMB368 is PATA only so has the PATA on function zero. Don't
therefore skip function zero on this device when probing

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/drivers/ide/pci/generic.c linux-2.6.19-rc2-mm1/drivers/ide/pci/generic.c
--- linux.vanilla-2.6.19-rc2-mm1/drivers/ide/pci/generic.c	2006-10-18 13:50:13.000000000 +0100
+++ linux-2.6.19-rc2-mm1/drivers/ide/pci/generic.c	2006-10-27 12:31:46.000000000 +0100
@@ -234,8 +234,10 @@
 	    (!(PCI_FUNC(dev->devfn) & 1)))
 		goto out;
 
-	if (dev->vendor == PCI_VENDOR_ID_JMICRON && PCI_FUNC(dev->devfn) != 1)
-		goto out;
+	if (dev->vendor == PCI_VENDOR_ID_JMICRON) {
+		if (dev->device != PCI_DEVICE_ID_JMICRON_JMB368 && PCI_FUNC(dev->devfn) != 1)
+			goto out;
+	}
 
 	if (dev->vendor != PCI_VENDOR_ID_JMICRON) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);

