Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbTHWQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 12:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTHWQ52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:57:28 -0400
Received: from AMarseille-201-1-3-186.w193-253.abo.wanadoo.fr ([193.253.250.186]:31015
	"EHLO gaston") by vger.kernel.org with ESMTP id S262847AbTHWOkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 10:40:12 -0400
Subject: PCI PM & compatibility
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061649597.780.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 23 Aug 2003 16:39:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

What about this patch to stay compatible with existing drivers
implementing everything in save_state ?

Ideally, we should kill save_state and fix all drivers, oh well...

(This version of the patch has correct space/tabs)

Ben.

--- a/drivers/pci/pci-driver.c	Sat Aug 23 16:39:14 2003
+++ b/drivers/pci/pci-driver.c	Sat Aug 23 16:39:14 2003
@@ -163,6 +163,9 @@
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
+	/* Compatibility with drivers using obsolete save_state */
+	if (drv && drv->save_state)
+		return drv->save_state(pci_dev,state);
 	if (drv && drv->suspend)
 		return drv->suspend(pci_dev,state);
 	return 0;

