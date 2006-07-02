Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWGBXEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWGBXEY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWGBXEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:04:24 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:61909 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751479AbWGBXEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:04:23 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:04:03 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 07/19] ieee1394: update #include directives in midlayer header
 files
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.16d7e27023821622@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.904) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary includes, add missing includes.
Use forward type declarations for some structs.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/csr.h                   |    6 ++----
 drivers/ieee1394/dma.c                   |    7 +++++--
 drivers/ieee1394/dma.h                   |    7 +++++--
 drivers/ieee1394/dv1394.c                |   12 ++++++------
 drivers/ieee1394/eth1394.c               |   11 ++++++-----
 drivers/ieee1394/highlevel.h             |   10 ++++++++++
 drivers/ieee1394/hosts.h                 |   10 ++++++----
 drivers/ieee1394/ieee1394_core.h         |   10 +++++++---
 drivers/ieee1394/ieee1394_hotplug.h      |    3 +--
 drivers/ieee1394/ieee1394_transactions.h |    7 ++++++-
 drivers/ieee1394/ieee1394_types.h        |    7 ++-----
 drivers/ieee1394/iso.c                   |    5 ++++-
 drivers/ieee1394/iso.h                   |    7 ++++++-
 drivers/ieee1394/nodemgr.c               |    9 +++++----
 drivers/ieee1394/nodemgr.h               |   10 ++++++++--
 drivers/ieee1394/raw1394.c               |   11 ++++++-----
 drivers/ieee1394/video1394.c             |   12 ++++++------
 17 files changed, 91 insertions(+), 53 deletions(-)

Index: linux/drivers/ieee1394/ieee1394_core.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_core.h	2006-07-01 17:27:31.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_core.h	2006-07-01 17:42:38.000000000 +0200
@@ -1,12 +1,16 @@
-
 #ifndef _IEEE1394_CORE_H
 #define _IEEE1394_CORE_H
 
-#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
-#include "hosts.h"
 
+#include "hosts.h"
+#include "ieee1394_types.h"
 
 struct hpsb_packet {
 	/* This struct is basically read-only for hosts with the exception of
Index: linux/drivers/ieee1394/ieee1394_transactions.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_transactions.h	2006-07-01 17:36:35.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_transactions.h	2006-07-01 17:45:25.000000000 +0200
@@ -1,7 +1,12 @@
 #ifndef _IEEE1394_TRANSACTIONS_H
 #define _IEEE1394_TRANSACTIONS_H
 
-#include "ieee1394_core.h"
+#include <linux/types.h>
+
+#include "ieee1394_types.h"
+
+struct hpsb_packet;
+struct hpsb_host;
 
 int hpsb_get_tlabel(struct hpsb_packet *packet);
 void hpsb_free_tlabel(struct hpsb_packet *packet);
Index: linux/drivers/ieee1394/ieee1394_types.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_types.h	2006-07-01 17:27:31.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_types.h	2006-07-01 21:04:08.000000000 +0200
@@ -1,17 +1,14 @@
-
 #ifndef _IEEE1394_TYPES_H
 #define _IEEE1394_TYPES_H
 
 #include <linux/kernel.h>
-#include <linux/types.h>
 #include <linux/list.h>
-#include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/types.h>
 
-#include <asm/semaphore.h>
 #include <asm/byteorder.h>
-
+#include <asm/semaphore.h>
 
 /* Transaction Label handling */
 struct hpsb_tlabel_pool {
Index: linux/drivers/ieee1394/csr.h
===================================================================
--- linux.orig/drivers/ieee1394/csr.h	2006-07-01 17:33:19.000000000 +0200
+++ linux/drivers/ieee1394/csr.h	2006-07-01 21:04:01.000000000 +0200
@@ -1,12 +1,10 @@
-
 #ifndef _IEEE1394_CSR_H
 #define _IEEE1394_CSR_H
 
-#ifdef CONFIG_PREEMPT
-#include <linux/sched.h>
-#endif
+#include <linux/spinlock_types.h>
 
 #include "csr1212.h"
+#include "ieee1394_types.h"
 
 #define CSR_REGISTER_BASE		0xfffff0000000ULL
 
Index: linux/drivers/ieee1394/dma.c
===================================================================
--- linux.orig/drivers/ieee1394/dma.c	2006-07-01 16:54:25.000000000 +0200
+++ linux/drivers/ieee1394/dma.c	2006-07-01 17:42:38.000000000 +0200
@@ -7,10 +7,13 @@
  * directory of the kernel sources for details.
  */
 
+#include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/vmalloc.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
-#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <asm/scatterlist.h>
+
 #include "dma.h"
 
 /* dma_prog_region */
Index: linux/drivers/ieee1394/dma.h
===================================================================
--- linux.orig/drivers/ieee1394/dma.h	2006-07-01 17:27:31.000000000 +0200
+++ linux/drivers/ieee1394/dma.h	2006-07-01 17:42:38.000000000 +0200
@@ -10,8 +10,11 @@
 #ifndef IEEE1394_DMA_H
 #define IEEE1394_DMA_H
 
-#include <linux/pci.h>
-#include <asm/scatterlist.h>
+#include <asm/types.h>
+
+struct pci_dev;
+struct scatterlist;
+struct vm_area_struct;
 
 /**
  * struct dma_prog_region - small contiguous DMA buffer
Index: linux/drivers/ieee1394/highlevel.h
===================================================================
--- linux.orig/drivers/ieee1394/highlevel.h	2006-07-01 17:41:41.000000000 +0200
+++ linux/drivers/ieee1394/highlevel.h	2006-07-01 17:44:52.000000000 +0200
@@ -1,6 +1,16 @@
 #ifndef IEEE1394_HIGHLEVEL_H
 #define IEEE1394_HIGHLEVEL_H
 
+#include <linux/list.h>
+#include <linux/spinlock_types.h>
+#include <linux/types.h>
+
+struct module;
+
+#include "ieee1394_types.h"
+
+struct hpsb_host;
+
 /* internal to ieee1394 core */
 struct hpsb_address_serve {
 	struct list_head host_list;	/* per host list */
Index: linux/drivers/ieee1394/hosts.h
===================================================================
--- linux.orig/drivers/ieee1394/hosts.h	2006-07-01 17:27:31.000000000 +0200
+++ linux/drivers/ieee1394/hosts.h	2006-07-01 21:04:01.000000000 +0200
@@ -2,17 +2,19 @@
 #define _IEEE1394_HOSTS_H
 
 #include <linux/device.h>
-#include <linux/wait.h>
 #include <linux/list.h>
-#include <linux/timer.h>
 #include <linux/skbuff.h>
+#include <linux/timer.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+#include <asm/atomic.h>
 
-#include <asm/semaphore.h>
+struct pci_dev;
+struct module;
 
 #include "ieee1394_types.h"
 #include "csr.h"
 
-
 struct hpsb_packet;
 struct hpsb_iso;
 
Index: linux/drivers/ieee1394/ieee1394_hotplug.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_hotplug.h	2006-07-01 16:54:25.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_hotplug.h	2006-07-01 21:04:11.000000000 +0200
@@ -1,9 +1,8 @@
 #ifndef _IEEE1394_HOTPLUG_H
 #define _IEEE1394_HOTPLUG_H
 
-#include <linux/kernel.h>
-#include <linux/types.h>
 #include <linux/mod_devicetable.h>
+#include <linux/types.h>
 
 /* Unit spec id and sw version entry for some protocols */
 #define AVC_UNIT_SPEC_ID_ENTRY		0x0000A02D
Index: linux/drivers/ieee1394/iso.c
===================================================================
--- linux.orig/drivers/ieee1394/iso.c	2006-07-01 16:54:25.000000000 +0200
+++ linux/drivers/ieee1394/iso.c	2006-07-01 17:42:38.000000000 +0200
@@ -9,8 +9,11 @@
  * directory of the kernel sources for details.
  */
 
-#include <linux/slab.h>
+#include <linux/pci.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
+
+#include "hosts.h"
 #include "iso.h"
 
 void hpsb_iso_stop(struct hpsb_iso *iso)
Index: linux/drivers/ieee1394/iso.h
===================================================================
--- linux.orig/drivers/ieee1394/iso.h	2006-07-01 17:30:04.000000000 +0200
+++ linux/drivers/ieee1394/iso.h	2006-07-01 17:42:38.000000000 +0200
@@ -12,9 +12,14 @@
 #ifndef IEEE1394_ISO_H
 #define IEEE1394_ISO_H
 
-#include "hosts.h"
+#include <linux/spinlock_types.h>
+#include <asm/atomic.h>
+#include <asm/types.h>
+
 #include "dma.h"
 
+struct hpsb_host;
+
 /* high-level ISO interface */
 
 /*
Index: linux/drivers/ieee1394/nodemgr.h
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.h	2006-07-01 17:27:31.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.h	2006-07-01 17:42:38.000000000 +0200
@@ -21,9 +21,15 @@
 #define _IEEE1394_NODEMGR_H
 
 #include <linux/device.h>
-#include "csr1212.h"
+#include <asm/types.h>
+
 #include "ieee1394_core.h"
-#include "ieee1394_hotplug.h"
+#include "ieee1394_types.h"
+
+struct csr1212_csr;
+struct csr1212_keyval;
+struct hpsb_host;
+struct ieee1394_device_id;
 
 /* '1' '3' '9' '4' in ASCII */
 #define IEEE1394_BUSID_MAGIC	__constant_cpu_to_be32(0x31333934)
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-07-01 21:03:56.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-07-01 21:07:32.000000000 +0200
@@ -21,13 +21,14 @@
 #include <linux/moduleparam.h>
 #include <asm/atomic.h>
 
-#include "ieee1394_types.h"
+#include "csr.h"
+#include "highlevel.h"
+#include "hosts.h"
 #include "ieee1394.h"
 #include "ieee1394_core.h"
-#include "hosts.h"
+#include "ieee1394_hotplug.h"
+#include "ieee1394_types.h"
 #include "ieee1394_transactions.h"
-#include "highlevel.h"
-#include "csr.h"
 #include "nodemgr.h"
 
 static int ignore_drivers;
Index: linux/drivers/ieee1394/video1394.c
===================================================================
--- linux.orig/drivers/ieee1394/video1394.c	2006-07-01 16:54:25.000000000 +0200
+++ linux/drivers/ieee1394/video1394.c	2006-07-01 17:42:38.000000000 +0200
@@ -49,16 +49,16 @@
 #include <linux/compat.h>
 #include <linux/cdev.h>
 
-#include "ieee1394.h"
-#include "ieee1394_types.h"
+#include "dma.h"
+#include "highlevel.h"
 #include "hosts.h"
+#include "ieee1394.h"
 #include "ieee1394_core.h"
-#include "highlevel.h"
-#include "video1394.h"
+#include "ieee1394_hotplug.h"
+#include "ieee1394_types.h"
 #include "nodemgr.h"
-#include "dma.h"
-
 #include "ohci1394.h"
+#include "video1394.h"
 
 #define ISO_CHANNELS 64
 
Index: linux/drivers/ieee1394/raw1394.c
===================================================================
--- linux.orig/drivers/ieee1394/raw1394.c	2006-07-01 16:54:25.000000000 +0200
+++ linux/drivers/ieee1394/raw1394.c	2006-07-01 21:03:57.000000000 +0200
@@ -44,14 +44,15 @@
 #include <linux/compat.h>
 
 #include "csr1212.h"
+#include "highlevel.h"
+#include "hosts.h"
 #include "ieee1394.h"
-#include "ieee1394_types.h"
 #include "ieee1394_core.h"
-#include "nodemgr.h"
-#include "hosts.h"
-#include "highlevel.h"
-#include "iso.h"
+#include "ieee1394_hotplug.h"
 #include "ieee1394_transactions.h"
+#include "ieee1394_types.h"
+#include "iso.h"
+#include "nodemgr.h"
 #include "raw1394.h"
 #include "raw1394-private.h"
 
Index: linux/drivers/ieee1394/dv1394.c
===================================================================
--- linux.orig/drivers/ieee1394/dv1394.c	2006-07-01 16:54:25.000000000 +0200
+++ linux/drivers/ieee1394/dv1394.c	2006-07-01 21:03:59.000000000 +0200
@@ -110,15 +110,15 @@
 #include <linux/compat.h>
 #include <linux/cdev.h>
 
+#include "dv1394.h"
+#include "dv1394-private.h"
+#include "highlevel.h"
+#include "hosts.h"
 #include "ieee1394.h"
+#include "ieee1394_core.h"
+#include "ieee1394_hotplug.h"
 #include "ieee1394_types.h"
 #include "nodemgr.h"
-#include "hosts.h"
-#include "ieee1394_core.h"
-#include "highlevel.h"
-#include "dv1394.h"
-#include "dv1394-private.h"
-
 #include "ohci1394.h"
 
 /* DEBUG LEVELS:
Index: linux/drivers/ieee1394/eth1394.c
===================================================================
--- linux.orig/drivers/ieee1394/eth1394.c	2006-07-01 16:54:25.000000000 +0200
+++ linux/drivers/ieee1394/eth1394.c	2006-07-01 17:42:38.000000000 +0200
@@ -67,16 +67,17 @@
 #include <asm/semaphore.h>
 #include <net/arp.h>
 
+#include "config_roms.h"
 #include "csr1212.h"
-#include "ieee1394_types.h"
+#include "eth1394.h"
+#include "highlevel.h"
+#include "ieee1394.h"
 #include "ieee1394_core.h"
+#include "ieee1394_hotplug.h"
 #include "ieee1394_transactions.h"
-#include "ieee1394.h"
-#include "highlevel.h"
+#include "ieee1394_types.h"
 #include "iso.h"
 #include "nodemgr.h"
-#include "eth1394.h"
-#include "config_roms.h"
 
 #define ETH1394_PRINT_G(level, fmt, args...) \
 	printk(level "%s: " fmt, driver_name, ## args)


