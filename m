Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVGNJS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVGNJS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVGNJGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:06:51 -0400
Received: from peabody.ximian.com ([130.57.169.10]:11913 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262973AbVGNJFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:05:36 -0400
Subject: [RFC][PATCH] don't bind to PCI express links [8/9]
From: Adam Belay <abelay@novell.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Date: Thu, 14 Jul 2005 04:55:48 -0400
Message-Id: <1121331349.3398.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents the PCI<->PCI bridge driver from binding to PCI
express devices.  This is needed to coexist with the PCI express root
port driver.  Eventually we may want to rework and better integrate
linux PCI express link support, but for now this should work.

Signed-off-by: Adam Belay <abelay@novell.com>

--- a/drivers/pci/bus/pci-bridge.c	2005-07-14 02:30:09.000000000 -0400
+++ b/drivers/pci/bus/pci-bridge.c	2005-07-14 02:46:12.000000000 -0400
@@ -132,6 +132,10 @@
 	if (dev->subordinate)
 		return -ENODEV;
 
+	/* don't bind to pci express links */
+	if (pci_find_capability(dev, PCI_CAP_ID_EXP))
+		return -ENODEV;
+
 	bus = ppb_detect_bus(dev);
 	if (!bus)
 		return -ENODEV;


