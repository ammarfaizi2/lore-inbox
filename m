Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWJXPxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWJXPxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWJXPxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:53:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:7903 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965163AbWJXPxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:53:09 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix building pcie portdrv_pci.c without CONFIG_PM
Date: Tue, 24 Oct 2006 17:53:05 +0200
User-Agent: KMail/1.9.5
Cc: Zhang Yanmin <yanmin.zhang@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-pci@atrey.karlin.mff.cuni.cz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610241753.06444.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pcie_portdrv_restore_config is now also used outside of
CONFIG_PM.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -37,7 +37,6 @@ static int pcie_portdrv_save_config(stru
 	return pci_save_state(dev);
 }
 
-#ifdef CONFIG_PM
 static int pcie_portdrv_restore_config(struct pci_dev *dev)
 {
 	int retval;
@@ -50,6 +49,7 @@ static int pcie_portdrv_restore_config(s
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int pcie_portdrv_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	int ret = pcie_port_device_suspend(dev, state);
