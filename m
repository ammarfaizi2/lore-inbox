Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTCEAbN>; Tue, 4 Mar 2003 19:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTCEAaJ>; Tue, 4 Mar 2003 19:30:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26898 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266810AbTCEA34>; Tue, 4 Mar 2003 19:29:56 -0500
Date: Wed, 5 Mar 2003 00:40:24 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] PCI probing for cardbus (4/5)
Message-ID: <20030305004024.E25251@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030305003635.A25251@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305003635.A25251@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 05, 2003 at 12:36:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u orig/drivers/pci/setup-bus.c linux/drivers/pci/setup-bus.c
--- orig/drivers/pci/setup-bus.c	Tue Feb 25 10:57:49 2003
+++ linux/drivers/pci/setup-bus.c	Tue Feb 25 11:17:33 2003
@@ -350,6 +350,7 @@
 {
 	struct pci_bus *b;
 	int found_vga = pbus_assign_resources_sorted(bus);
+	struct pci_dev *dev;
 
 	if (found_vga) {
 		/* Propagate presence of the VGA to upstream bridges */
@@ -357,9 +358,12 @@
			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
 		}
 	}
-	list_for_each_entry(b, &bus->children, node) {
-		pci_bus_assign_resources(b);
-		pci_setup_bridge(b);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		b = dev->subordinate;
+		if (b) {
+			pci_bus_assign_resources(b);
+			pci_setup_bridge(b);
+		}
 	}
 }
 EXPORT_SYMBOL(pci_bus_assign_resources);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

