Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUDPVTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbUDPVTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:19:47 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:5279 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263815AbUDPVTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:19:46 -0400
Date: Fri, 16 Apr 2004 22:18:26 +0100
From: Dave Jones <davej@redhat.com>
To: jgarzik@pobox.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: orinoco potentially dereferencing before check
Message-ID: <20040416211826.GN20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, jgarzik@pobox.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.5/drivers/net/wireless/orinoco_pci.c~	2004-04-16 22:16:57.000000000 +0100
+++ linux-2.6.5/drivers/net/wireless/orinoco_pci.c	2004-04-16 22:17:30.000000000 +0100
@@ -275,14 +275,16 @@
 static void __devexit orinoco_pci_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	struct orinoco_private *priv = dev->priv;
+	struct orinoco_private *priv;
 
 	if (! dev)
 		BUG();
 
+	priv = dev->priv;
+
 	unregister_netdev(dev);
 
-        if (dev->irq)
+	if (dev->irq)
 		free_irq(dev->irq, dev);
 
 	if (priv->hw.iobase)
