Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965287AbWJZCTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbWJZCTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWJZCTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:19:33 -0400
Received: from isilmar.linta.de ([213.239.214.66]:38623 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965287AbWJZCTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:14 -0400
Date: Wed, 25 Oct 2006 22:14:32 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [RFC PATCH 5/11] CONFIG_PM=n slim: drivers/pcmcia/*
Message-ID: <20061026021432.GF20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, adobriyan@gmail.com
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Fri, 20 Oct 2006 14:44:13 -0700
Subject: [PATCH] CONFIG_PM=n slim: drivers/pcmcia/*

Remove some code which is unneeded if CONFIG_PM=n.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/i82092.c       |    4 ++++
 drivers/pcmcia/pd6729.c       |    4 ++++
 drivers/pcmcia/yenta_socket.c |    6 ++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 82715f4..d316d95 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -41,6 +41,7 @@ static struct pci_device_id i82092aa_pci
 };
 MODULE_DEVICE_TABLE(pci, i82092aa_pci_ids);
 
+#ifdef CONFIG_PM
 static int i82092aa_socket_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
@@ -50,14 +51,17 @@ static int i82092aa_socket_resume (struc
 {
 	return pcmcia_socket_dev_resume(&dev->dev);
 }
+#endif
 
 static struct pci_driver i82092aa_pci_drv = {
 	.name           = "i82092aa",
 	.id_table       = i82092aa_pci_ids,
 	.probe          = i82092aa_pci_probe,
 	.remove         = __devexit_p(i82092aa_pci_remove),
+#ifdef CONFIG_PM
 	.suspend        = i82092aa_socket_suspend,
 	.resume         = i82092aa_socket_resume,
+#endif
 };
 
 
diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
index c83a0a6..a70f97f 100644
--- a/drivers/pcmcia/pd6729.c
+++ b/drivers/pcmcia/pd6729.c
@@ -755,6 +755,7 @@ static void __devexit pd6729_pci_remove(
 	kfree(socket);
 }
 
+#ifdef CONFIG_PM
 static int pd6729_socket_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
@@ -764,6 +765,7 @@ static int pd6729_socket_resume(struct p
 {
 	return pcmcia_socket_dev_resume(&dev->dev);
 }
+#endif
 
 static struct pci_device_id pd6729_pci_ids[] = {
 	{
@@ -781,8 +783,10 @@ static struct pci_driver pd6729_pci_drv 
 	.id_table	= pd6729_pci_ids,
 	.probe		= pd6729_pci_probe,
 	.remove		= __devexit_p(pd6729_pci_remove),
+#ifdef CONFIG_PM
 	.suspend	= pd6729_socket_suspend,
 	.resume		= pd6729_socket_resume,
+#endif
 };
 
 static int pd6729_module_init(void)
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 26229d9..9ced52a 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -1213,7 +1213,7 @@ static int __devinit yenta_probe (struct
 	return ret;
 }
 
-
+#ifdef CONFIG_PM
 static int yenta_dev_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	struct yenta_socket *socket = pci_get_drvdata(dev);
@@ -1262,7 +1262,7 @@ static int yenta_dev_resume (struct pci_
 
 	return pcmcia_socket_dev_resume(&dev->dev);
 }
-
+#endif
 
 #define CB_ID(vend,dev,type)				\
 	{						\
@@ -1359,8 +1359,10 @@ static struct pci_driver yenta_cardbus_d
 	.id_table	= yenta_table,
 	.probe		= yenta_probe,
 	.remove		= __devexit_p(yenta_close),
+#ifdef CONFIG_PM
 	.suspend	= yenta_dev_suspend,
 	.resume		= yenta_dev_resume,
+#endif
 };
 
 
-- 
1.4.3

