Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVAKEVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVAKEVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 23:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVAJRoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:44:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:17115 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262356AbVAJRVE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:04 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776582977@kroah.com>
Date: Mon, 10 Jan 2005 09:20:58 -0800
Message-Id: <11053776581385@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.11, 2004/12/17 14:03:28-08:00, pavel@ucw.cz

[PATCH] PCI: add pci_choose_state()

Could this go to "after 2.6.10 tree", too? It is a helper that
converts system state into PCI state. We really do not want to have
this copied into every driver, because it will need to change when
system state gets type-checked / expanded to struct.


From: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	2005-01-10 09:01:09 -08:00
+++ b/drivers/pci/pci.c	2005-01-10 09:01:09 -08:00
@@ -306,6 +306,30 @@
 }
 
 /**
+ * pci_choose_state - Choose the power state of a PCI device
+ * @dev: PCI device to be suspended
+ * @state: target sleep state for the whole system
+ *
+ * Returns PCI power state suitable for given device and given system
+ * message.
+ */
+
+pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
+{
+	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+		return PCI_D0;
+
+	switch (state) {
+	case 0:	return PCI_D0;
+	case 2: return PCI_D2;
+	case 3: return PCI_D3hot;
+	default: BUG();
+	}
+}
+
+EXPORT_SYMBOL(pci_choose_state);
+
+/**
  * pci_save_state - save the PCI configuration space of a device before suspending
  * @dev: - PCI device that we're dealing with
  * @buffer: - buffer to hold config space context

