Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWGFOGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWGFOGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWGFOGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:06:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:47326 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030279AbWGFOGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:06:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=HViuR7lO3HzxWriOtk8NhvByHenTZsZJrYfrAdS+H7jCxlABnHvtTuIc+DK2DdbSKMWxoWJQPZEENSmFRdAfuh71/tjJG0bBfCEoKhomzP9M88Scwe1HOdy/y/55XIMEOHtRwf8lzskrX3+9NJ+kt/+wNFqBtU1kdduJFedHjjI=
Date: Thu, 6 Jul 2006 18:05:51 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Henrik Kretzschmar <henne@nachtwindheim.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] pcie: fix warnings when CONFIG_PM=n
Message-ID: <20060706140551.GA7514@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/pci/pcie/portdrv_pci.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -30,23 +30,6 @@ MODULE_LICENSE("GPL");
 /* global data */
 static const char device_name[] = "pcieport-driver";
 
-static int pcie_portdrv_save_config(struct pci_dev *dev)
-{
-	return pci_save_state(dev);
-}
-
-static int pcie_portdrv_restore_config(struct pci_dev *dev)
-{
-	int retval;
-
-	pci_restore_state(dev);
-	retval = pci_enable_device(dev);
-	if (retval)
-		return retval;
-	pci_set_master(dev);
-	return 0;
-}
-
 /*
  * pcie_portdrv_probe - Probe PCI-Express port devices
  * @dev: PCI-Express port device being probed
@@ -86,6 +69,23 @@ static void pcie_portdrv_remove (struct 
 }
 
 #ifdef CONFIG_PM
+static int pcie_portdrv_save_config(struct pci_dev *dev)
+{
+	return pci_save_state(dev);
+}
+
+static int pcie_portdrv_restore_config(struct pci_dev *dev)
+{
+	int retval;
+
+	pci_restore_state(dev);
+	retval = pci_enable_device(dev);
+	if (retval)
+		return retval;
+	pci_set_master(dev);
+	return 0;
+}
+
 static int pcie_portdrv_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	int ret = pcie_port_device_suspend(dev, state);

