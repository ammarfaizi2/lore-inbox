Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUDPVYl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUDPVYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:24:41 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:17055 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263761AbUDPVYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:24:35 -0400
Date: Fri, 16 Apr 2004 22:23:42 +0100
From: Dave Jones <davej@redhat.com>
To: jgarzik@pobox.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: rcpci45 dereference fix.
Message-ID: <20040416212342.GG25240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, jgarzik@pobox.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.5/drivers/net/rcpci45.c~	2004-04-16 22:22:22.000000000 +0100
+++ linux-2.6.5/drivers/net/rcpci45.c	2004-04-16 22:23:01.000000000 +0100
@@ -129,13 +129,14 @@
 rcpci45_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
-	PDPA pDpa = dev->priv;
+	PDPA pDpa;
 
 	if (!dev) {
 		printk (KERN_ERR "%s: remove non-existent device\n",
 				dev->name);
 		return;
 	}
+	pDpa = dev->priv;
 
 	RCResetIOP (dev);
 	unregister_netdev (dev);
