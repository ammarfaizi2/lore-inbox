Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbUKLXlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbUKLXlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbUKLXj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:39:59 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40854 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262664AbUKLXWd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:33 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017171930@kroah.com>
Date: Fri, 12 Nov 2004 15:21:57 -0800
Message-Id: <1100301717158@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.20, 2004/11/10 16:44:40-08:00, hannal@us.ibm.com

[PATCH] ide.c: replace pci_find_device with pci_dev_present

As pci_find_device is going away it needs to be replaced. In this case the dev
returned from pci_find_device was not being used so pci_dev_present was the
appropriate replacement.

This has been compile and boot tested on a T22.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/ide/ide.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)


diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2004-11-12 15:12:26 -08:00
+++ b/drivers/ide/ide.c	2004-11-12 15:12:26 -08:00
@@ -335,11 +335,16 @@
 
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

