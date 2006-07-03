Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWGCAvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWGCAvV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWGCAuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:50:51 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:24284 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750772AbWGCAu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:50:29 -0400
Message-Id: <20060703004056.530208000@myri.com>
References: <20060703003959.942374000@myri.com>
User-Agent: quilt/0.45-1
Date: Sun, 02 Jul 2006 20:40:06 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch 7/7] Drop pci bus_flags
Content-Disposition: inline; filename=07-drop_pci_bus_flags.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI_BUS_FLAGS_NO_MSI is not used anymore, and gcc does not like
empty enums. Drop the bus_flags field entirely.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/probe.c |    1 -
 include/linux/pci.h |    6 ------
 2 files changed, 7 deletions(-)

Index: linux-git/drivers/pci/probe.c
===================================================================
--- linux-git.orig/drivers/pci/probe.c	2006-07-02 11:58:18.000000000 -0400
+++ linux-git/drivers/pci/probe.c	2006-07-02 11:58:41.000000000 -0400
@@ -351,7 +351,6 @@
 	child->parent = parent;
 	child->ops = parent->ops;
 	child->sysdata = parent->sysdata;
-	child->bus_flags = parent->bus_flags;
 	child->bridge = get_device(&bridge->dev);
 
 	child->class_dev.class = &pcibus_class;
Index: linux-git/include/linux/pci.h
===================================================================
--- linux-git.orig/include/linux/pci.h	2006-07-02 11:58:18.000000000 -0400
+++ linux-git/include/linux/pci.h	2006-07-02 12:00:18.000000000 -0400
@@ -94,11 +94,6 @@
 	pci_channel_io_perm_failure = (__force pci_channel_state_t) 3,
 };
 
-typedef unsigned short __bitwise pci_bus_flags_t;
-enum pci_bus_flags {
-	PCI_BUS_FLAGS_NO_MSI = (__force pci_bus_flags_t) 1,
-};
-
 struct pci_cap_saved_state {
 	struct hlist_node next;
 	char cap_nr;
@@ -241,7 +236,6 @@
 	char		name[48];
 
 	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
-	pci_bus_flags_t bus_flags;	/* Inherited by child busses */
 	struct device		*bridge;
 	struct class_device	class_dev;
 	struct bin_attribute	*legacy_io; /* legacy I/O for this bus */

