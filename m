Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422895AbWAMTzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422895AbWAMTzw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422898AbWAMTvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:405 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422894AbWAMTuh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:37 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add pci_bus_type probe and remove methods
In-Reply-To: <11371818083867@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:08 -0800
Message-Id: <11371818082670@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add pci_bus_type probe and remove methods

Move the PCI bus device probe/remove methods to the bus_type
structure.  We leave the shutdown method alone since there
are compatibility issues with that.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b15d686a2b589c9e4f1ea116553e9c3c3d030dae
tree a4412435d021a65c38a4e91b2ec6e94aaba76ce2
parent 594c8281f90560faf9632d91bb9d402cbe560e63
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:30:22 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:04 -0800

 drivers/pci/pci-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 7146b69..0aa14c9 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -380,8 +380,6 @@ int __pci_register_driver(struct pci_dri
 	/* initialize common driver fields */
 	drv->driver.name = drv->name;
 	drv->driver.bus = &pci_bus_type;
-	drv->driver.probe = pci_device_probe;
-	drv->driver.remove = pci_device_remove;
 	/* FIXME, once all of the existing PCI drivers have been fixed to set
 	 * the pci shutdown function, this test can go away. */
 	if (!drv->driver.shutdown)
@@ -513,6 +511,8 @@ struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
 	.uevent		= pci_uevent,
+	.probe		= pci_device_probe,
+	.remove		= pci_device_remove,
 	.suspend	= pci_device_suspend,
 	.resume		= pci_device_resume,
 	.dev_attrs	= pci_dev_attrs,

