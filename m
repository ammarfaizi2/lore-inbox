Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265472AbSKFBgV>; Tue, 5 Nov 2002 20:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbSKFBgS>; Tue, 5 Nov 2002 20:36:18 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:16144 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265469AbSKFBf7>;
	Tue, 5 Nov 2002 20:35:59 -0500
Date: Tue, 5 Nov 2002 17:38:35 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] PCI hotplug changes for 2.5.46
Message-ID: <20021106013835.GT18627@kroah.com>
References: <20021106013615.GQ18627@kroah.com> <20021106013708.GR18627@kroah.com> <20021106013741.GS18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106013741.GS18627@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[oops, forgot to change the Subject: for the first two patches, sorry]

ChangeSet 1.875.1.3, 2002/11/02 22:57:45-08:00, greg@kroah.com

PCI: move EXPORT_SYMBOL for the pbus functions to the setup-bus.c file.

This fixes a linking error if setup-bus.c isn't compiled into the kernel.


diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Tue Nov  5 17:26:20 2002
+++ b/drivers/pci/Makefile	Tue Nov  5 17:26:20 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs	:= access.o hotplug.o pci-driver.o pci.o pool.o \
-			probe.o proc.o search.o compat.o
+			probe.o proc.o search.o compat.o setup-bus.o
 
 obj-y		+= access.o probe.o pci.o pool.o quirks.o \
 			compat.o names.o pci-driver.o search.o hotplug.o
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Tue Nov  5 17:26:20 2002
+++ b/drivers/pci/pci.c	Tue Nov  5 17:26:20 2002
@@ -745,8 +745,6 @@
 EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
-EXPORT_SYMBOL(pbus_size_bridges);
-EXPORT_SYMBOL(pbus_assign_resources);
 
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	Tue Nov  5 17:26:20 2002
+++ b/drivers/pci/setup-bus.c	Tue Nov  5 17:26:20 2002
@@ -19,6 +19,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
@@ -357,6 +358,7 @@
 	}
 	pbus_size_mem(bus, mask, type);
 }
+EXPORT_SYMBOL(pbus_size_bridges);
 
 void __devinit
 pbus_assign_resources(struct pci_bus *bus)
@@ -379,6 +381,7 @@
 		pci_setup_bridge(b);
 	}
 }
+EXPORT_SYMBOL(pbus_assign_resources);
 
 void __init
 pci_assign_unassigned_resources(void)
