Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263912AbVBDXTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263912AbVBDXTc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266035AbVBDWwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:52:08 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:7943 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S264479AbVBDWNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:13:09 -0500
Message-ID: <4203F43A.1010504@gentoo.org>
Date: Fri, 04 Feb 2005 22:16:26 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: [-mm PATCH] driver model: PM type conversions in drivers/pcmcia
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070301000400000203090001"
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CxBhH-000MbF-Nd*TU2GtztTm5U*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070301000400000203090001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes PM driver model type checking for drivers/pcmcia.
Acked by Pavel Machek.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------070301000400000203090001
Content-Type: text/x-patch;
 name="pcmcia-pm-type-safety.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcmcia-pm-type-safety.patch"

diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/pcmcia/au1000_generic.c linux-dsd/drivers/pcmcia/au1000_generic.c
--- linux-2.6.11-rc2-mm2/drivers/pcmcia/au1000_generic.c	2005-02-02 21:55:26.000000000 +0000
+++ linux-dsd/drivers/pcmcia/au1000_generic.c	2005-02-02 20:43:45.000000000 +0000
@@ -521,7 +521,7 @@ static int au1x00_drv_pcmcia_probe(struc
 }
 
 
-static int au1x00_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
+static int au1x00_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/pcmcia/hd64465_ss.c linux-dsd/drivers/pcmcia/hd64465_ss.c
--- linux-2.6.11-rc2-mm2/drivers/pcmcia/hd64465_ss.c	2005-02-02 21:55:26.000000000 +0000
+++ linux-dsd/drivers/pcmcia/hd64465_ss.c	2005-02-02 20:44:51.000000000 +0000
@@ -860,7 +860,7 @@ static void hs_exit_socket(hs_socket_t *
 	local_irq_restore(flags);
 }
 
-static int hd64465_suspend(struct device *dev, u32 state, u32 level)
+static int hd64465_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/pcmcia/m32r_cfc.c linux-dsd/drivers/pcmcia/m32r_cfc.c
--- linux-2.6.11-rc2-mm2/drivers/pcmcia/m32r_cfc.c	2005-02-02 21:55:26.789107320 +0000
+++ linux-dsd/drivers/pcmcia/m32r_cfc.c	2005-02-02 20:46:32.000000000 +0000
@@ -749,7 +749,7 @@ static struct pccard_operations pcc_oper
 
 /*====================================================================*/
 
-static int m32r_pcc_suspend(struct device *dev, u32 state, u32 level)
+static int m32r_pcc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/pcmcia/m32r_pcc.c linux-dsd/drivers/pcmcia/m32r_pcc.c
--- linux-2.6.11-rc2-mm2/drivers/pcmcia/m32r_pcc.c	2005-02-02 21:55:26.790107168 +0000
+++ linux-dsd/drivers/pcmcia/m32r_pcc.c	2005-02-02 20:47:01.000000000 +0000
@@ -701,7 +701,7 @@ static struct pccard_operations pcc_oper
 
 /*====================================================================*/
 
-static int m32r_pcc_suspend(struct device *dev, u32 state, u32 level)
+static int m32r_pcc_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/pcmcia/pxa2xx_base.c linux-dsd/drivers/pcmcia/pxa2xx_base.c
--- linux-2.6.11-rc2-mm2/drivers/pcmcia/pxa2xx_base.c	2004-12-24 21:36:02.000000000 +0000
+++ linux-dsd/drivers/pcmcia/pxa2xx_base.c	2005-02-02 20:47:27.000000000 +0000
@@ -205,7 +205,7 @@ int pxa2xx_drv_pcmcia_probe(struct devic
 }
 EXPORT_SYMBOL(pxa2xx_drv_pcmcia_probe);
 
-static int pxa2xx_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
+static int pxa2xx_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/pcmcia/sa1100_generic.c linux-dsd/drivers/pcmcia/sa1100_generic.c
--- linux-2.6.11-rc2-mm2/drivers/pcmcia/sa1100_generic.c	2004-12-24 21:35:00.000000000 +0000
+++ linux-dsd/drivers/pcmcia/sa1100_generic.c	2005-02-02 20:47:56.000000000 +0000
@@ -75,7 +75,7 @@ static int sa11x0_drv_pcmcia_probe(struc
 	return ret;
 }
 
-static int sa11x0_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
+static int sa11x0_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/pcmcia/sa1111_generic.c linux-dsd/drivers/pcmcia/sa1111_generic.c
--- linux-2.6.11-rc2-mm2/drivers/pcmcia/sa1111_generic.c	2004-12-24 21:34:29.000000000 +0000
+++ linux-dsd/drivers/pcmcia/sa1111_generic.c	2005-02-02 20:48:21.000000000 +0000
@@ -158,7 +158,7 @@ static int __devexit pcmcia_remove(struc
 	return 0;
 }
 
-static int pcmcia_suspend(struct sa1111_dev *dev, u32 state)
+static int pcmcia_suspend(struct sa1111_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/pcmcia/yenta_socket.c linux-dsd/drivers/pcmcia/yenta_socket.c
--- linux-2.6.11-rc2-mm2/drivers/pcmcia/yenta_socket.c	2005-02-02 21:55:26.797106104 +0000
+++ linux-dsd/drivers/pcmcia/yenta_socket.c	2005-02-02 20:49:58.000000000 +0000
@@ -873,7 +873,7 @@ static void yenta_config_init(struct yen
 	u16 bridge;
 	struct pci_dev *dev = socket->dev;
 
-	pci_set_power_state(socket->dev, 0);
+	pci_set_power_state(socket->dev, PCI_D0);
 
 	config_writel(socket, CB_LEGACY_MODE_BASE, 0);
 	config_writel(socket, PCI_BASE_ADDRESS_0, dev->resource[0].start);
@@ -1052,7 +1052,7 @@ static int yenta_dev_resume (struct pci_
 	struct yenta_socket *socket = pci_get_drvdata(dev);
 
 	if (socket) {
-		pci_set_power_state(dev, 0);
+		pci_set_power_state(dev, PCI_D0);
 		/* FIXME: pci_restore_state needs to have a better interface */
 		pci_restore_state(dev);
 		pci_write_config_dword(dev, 16*4, socket->saved_state[0]);

--------------070301000400000203090001--
