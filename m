Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVLPTJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVLPTJp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVLPTJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:09:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:63894 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932338AbVLPTJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:09:43 -0500
Date: Fri, 16 Dec 2005 11:08:48 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       miltonm@bga.com, anton@samba.org
Subject: [patch 2/4] PCI express must be initialized before PCI hotplug
Message-ID: <20051216190848.GC4594@kroah.com>
References: <20051216185442.633779000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-express-must-be-initialized-before-pci-hotplug.patch"
In-Reply-To: <20051216190828.GA4594@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milton Miller <miltonm@bga.com>

PCI express hotplug uses the pcieportbus driver so pcie must be
initialized before hotplug/.  This patch changes the link order.

Signed-Off-By: Milton Miller <miltonm@bga.com>
Acked-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/pci/Makefile |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- gregkh-2.6.orig/drivers/pci/Makefile
+++ gregkh-2.6/drivers/pci/Makefile
@@ -6,6 +6,9 @@ obj-y		+= access.o bus.o probe.o remove.
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
+# Build PCI Express stuff if needed
+obj-$(CONFIG_PCIEPORTBUS) += pcie/
+
 obj-$(CONFIG_HOTPLUG) += hotplug.o
 
 # Build the PCI Hotplug drivers if we were asked to
@@ -40,7 +43,3 @@ endif
 ifeq ($(CONFIG_PCI_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
-
-# Build PCI Express stuff if needed
-obj-$(CONFIG_PCIEPORTBUS) += pcie/
-

--
