Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbUKOXDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbUKOXDN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUKOXDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:03:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56843 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261509AbUKOXBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:01:42 -0500
Date: Tue, 16 Nov 2004 00:01:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove unused drivers/pci/hotplug/pciehp_sysfs.c
Message-ID: <20041115230105.GA4946@stusta.de>
References: <20041113030203.GU2249@stusta.de> <20041115195148.GA12820@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115195148.GA12820@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 11:51:48AM -0800, Greg KH wrote:
> On Sat, Nov 13, 2004 at 04:02:03AM +0100, Adrian Bunk wrote:
> > The patch below does some cleanups in the PCI code:
> > - make OSC_UUID in drivers/pci/pci-acpi.c static
> > - remove the completely unused drivers/pci/hotplug/pciehp_sysfs.c
> > - remove other unused code
> > 
> > Please review which of these changes are correct and which conflict with 
> > pending changes.
> > 
> 
> >  drivers/pci/hotplug/Makefile       |    1 
> >  drivers/pci/hotplug/pciehp.h       |    3 
> >  drivers/pci/hotplug/pciehp_sysfs.c |  143 -------------
> 
> Yeah, this can be deleted.  Care to make a patch for just this?

It's below.

> >  drivers/pci/msi.c                  |  301 -----------------------------
> >  drivers/pci/msi.h                  |    1 
> 
> These changes are for when drivers want to start taking advantage of
> some MSI features.  I've heard rumors that those drivers will be public
> soon, but haven't seen them yet :(
> 
> >  drivers/pci/pci-acpi.c             |   97 ---------
> 
> This is needed for some upcoming PCI Express changes, and should not be
> dropped.  I've seen the code that needs this, but it is still under
> development and isn't ready for mainline yet.
> 
> >  drivers/pci/pci.c                  |   60 -----
> >  drivers/pci/rom.c                  |   52 -----
> 
> These changes are needed by upcoming video driver changes.
>...

OK, then these should clearly stay.

<--  snip  -->

Remove unused the drivers/pci/hotplug/pciehp_sysfs.c


diffstat output:
 drivers/pci/hotplug/Makefile       |    1 
 drivers/pci/hotplug/pciehp.h       |    3 
 drivers/pci/hotplug/pciehp_sysfs.c |  143 -----------------------------
 3 files changed, 147 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/pci/hotplug/Makefile.old	2004-11-13 02:09:16.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pci/hotplug/Makefile	2004-11-13 02:09:35.000000000 +0100
@@ -51,7 +51,6 @@
 pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
-				pciehp_sysfs.o	\
 				pciehp_hpc.o
 ifdef CONFIG_ACPI_BUS
 	pciehp-objs += pciehprm_acpi.o
--- linux-2.6.10-rc1-mm5-full/drivers/pci/hotplug/pciehp.h.old	2004-11-13 01:40:34.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pci/hotplug/pciehp.h	2004-11-13 01:40:42.000000000 +0100
@@ -207,9 +207,6 @@
 #define msg_button_cancel	"PCI slot #%d - action canceled due to button press.\n"
 #define msg_button_ignore	"PCI slot #%d - button press ignored.  (action in progress...)\n"
 
-/* sysfs function for the hotplug controller info */
-extern void pciehp_create_ctrl_files	(struct controller *ctrl);
-
 /* controller functions */
 extern int	pciehprm_find_available_resources	(struct controller *ctrl);
 extern int	pciehp_event_start_thread	(void);
--- linux-2.6.10-rc1-mm5-full/drivers/pci/hotplug/pciehp_sysfs.c	2004-11-13 02:08:54.000000000 +0100
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,143 +0,0 @@
-/*
- * PCI Express Hot Plug Controller Driver
- *
- * Copyright (C) 1995,2001 Compaq Computer Corporation
- * Copyright (C) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2001 IBM Corp.
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <greg@kroah.com>
- *
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/proc_fs.h>
-#include <linux/workqueue.h>
-#include <linux/pci.h>
-#include "pciehp.h"
-
-
-/* A few routines that create sysfs entries for the hot plug controller */
-
-static ssize_t show_ctrl (struct device *dev, char *buf)
-{
-	struct pci_dev *pci_dev;
-	struct controller *ctrl;
-	char * out = buf;
-	int index;
-	struct pci_resource *res;
-
-	pci_dev = container_of (dev, struct pci_dev, dev);
-	ctrl = pci_get_drvdata(pci_dev);
-
-	out += sprintf(buf, "Free resources: memory\n");
-	index = 11;
-	res = ctrl->mem_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-	out += sprintf(out, "Free resources: prefetchable memory\n");
-	index = 11;
-	res = ctrl->p_mem_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-	out += sprintf(out, "Free resources: IO\n");
-	index = 11;
-	res = ctrl->io_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-	out += sprintf(out, "Free resources: bus numbers\n");
-	index = 11;
-	res = ctrl->bus_head;
-	while (res && index--) {
-		out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-		res = res->next;
-	}
-
-	return out - buf;
-}
-static DEVICE_ATTR (ctrl, S_IRUGO, show_ctrl, NULL);
-
-static ssize_t show_dev (struct device *dev, char *buf)
-{
-	struct pci_dev *pci_dev;
-	struct controller *ctrl;
-	char * out = buf;
-	int index;
-	struct pci_resource *res;
-	struct pci_func *new_slot;
-	struct slot *slot;
-
-	pci_dev = container_of (dev, struct pci_dev, dev);
-	ctrl = pci_get_drvdata(pci_dev);
-
-	slot=ctrl->slot;
-
-	while (slot) {
-		new_slot = pciehp_slot_find(slot->bus, slot->device, 0);
-		if (!new_slot)
-			break;
-		out += sprintf(out, "assigned resources: memory\n");
-		index = 11;
-		res = new_slot->mem_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		out += sprintf(out, "assigned resources: prefetchable memory\n");
-		index = 11;
-		res = new_slot->p_mem_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		out += sprintf(out, "assigned resources: IO\n");
-		index = 11;
-		res = new_slot->io_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		out += sprintf(out, "assigned resources: bus numbers\n");
-		index = 11;
-		res = new_slot->bus_head;
-		while (res && index--) {
-			out += sprintf(out, "start = %8.8x, length = %8.8x\n", res->base, res->length);
-			res = res->next;
-		}
-		slot=slot->next;
-	}
-
-	return out - buf;
-}
-static DEVICE_ATTR (dev, S_IRUGO, show_dev, NULL);
-
-void pciehp_create_ctrl_files (struct controller *ctrl)
-{
-	device_create_file (&ctrl->pci_dev->dev, &dev_attr_ctrl);
-	device_create_file (&ctrl->pci_dev->dev, &dev_attr_dev);
-}


