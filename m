Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUI2TgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUI2TgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268854AbUI2Tfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:35:40 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40164 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267502AbUI2TeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:34:23 -0400
Date: Wed, 29 Sep 2004 12:35:23 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, greg@kroah.com, hannal@us.ibm.com,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH 2.6.9-rc2-mm4 ide.c] [2/8] Patch to replace pci_find_device with pci_dev_present
Message-ID: <12260000.1096486523@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away it needs to be replaced. In this case the dev
returned from pci_find_device was not being used so pci_dev_present was the
appropriate replacement.

This has been compile and boot tested on a T22.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc2-mm4cln/drivers/ide/ide.c linux-2.6.9-rc2-mm4patch/drivers/ide/ide.c
--- linux-2.6.9-rc2-mm4cln/drivers/ide/ide.c	2004-09-28 14:58:25.000000000 -0700
+++ linux-2.6.9-rc2-mm4patch/drivers/ide/ide.c	2004-09-29 11:29:53.592066584 -0700
@@ -335,11 +335,16 @@ static void __init init_ide_data (void)
 
 int ide_system_bus_speed (void)
 {
+	static struct pci_device_id pci_default[] = {
+		{ PCI_DEVICE(PCI_ANY_ID, PCI_ANY_ID) },
+		{ }
+	};
+
 	if (!system_bus_speed) {
 		if (idebus_parameter) {
 			/* user supplied value */
 			system_bus_speed = idebus_parameter;
-		} else if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) != NULL) {
+		} else if (pci_dev_present(pci_default)) {
 			/* safe default value for PCI */
 			system_bus_speed = 33;
 		} else {



