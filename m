Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVEDHEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVEDHEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVEDHED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:04:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:1253 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262048AbVEDHCX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:23 -0400
Cc: gregkh@suse.de
Subject: [PATCH] PCI: Clean up a lot of sparse "Should it be static?" warnings.
In-Reply-To: <11151901373923@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:17 -0700
Message-Id: <11151901371766@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: Clean up a lot of sparse "Should it be static?" warnings.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit bc56b9e01190b9f1ad6b7c5c694b61bfe34c7aa5
tree 9979aed502d987538c51d9820be9c288462f9996
parent 92df516e6264f9caff4be49718926d6884fa50ed
author Greg KH <gregkh@suse.de> 1112939611 +0900
committer Greg KH <gregkh@suse.de> 1115189114 -0700

Index: drivers/pci/pci-acpi.c
===================================================================
--- 1b09131f91db847c9f3d6de98ed5cc1ebd0e9325/drivers/pci/pci-acpi.c  (mode:100644 sha1:968eb32f292d7e075bb982359d9d7332a5f93f15)
+++ 9979aed502d987538c51d9820be9c288462f9996/drivers/pci/pci-acpi.c  (mode:100644 sha1:bc01d34e2634ca12b582e8b42c8dab7aee01da79)
@@ -19,7 +19,7 @@
 
 static u32 ctrlset_buf[3] = {0, 0, 0};
 static u32 global_ctrlsets = 0;
-u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
+static u8 OSC_UUID[16] = {0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40, 0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66};
 
 static acpi_status  
 acpi_query_osc (
Index: drivers/pci/pci.c
===================================================================
--- 1b09131f91db847c9f3d6de98ed5cc1ebd0e9325/drivers/pci/pci.c  (mode:100644 sha1:fc8cc6c53778b6336e26ef23b1ac3e78eb16c7a2)
+++ 9979aed502d987538c51d9820be9c288462f9996/drivers/pci/pci.c  (mode:100644 sha1:88cbe5b5b3f3f60fbee7915ba3339d2f2f4dc5cf)
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
+#include "pci.h"
 
 
 /**
Index: drivers/pci/probe.c
===================================================================
--- 1b09131f91db847c9f3d6de98ed5cc1ebd0e9325/drivers/pci/probe.c  (mode:100644 sha1:6f0edadd132cfeee9f8327a4af8d178b7ad16353)
+++ 9979aed502d987538c51d9820be9c288462f9996/drivers/pci/probe.c  (mode:100644 sha1:b7ae87823c69777f772717947b6911ffdeac6b2b)
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
+#include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
 #define CARDBUS_RESERVE_BUSNR	3
Index: drivers/pci/proc.c
===================================================================
--- 1b09131f91db847c9f3d6de98ed5cc1ebd0e9325/drivers/pci/proc.c  (mode:100644 sha1:84cc4f620d8d4807db5830d4aa37f376bfa74463)
+++ 9979aed502d987538c51d9820be9c288462f9996/drivers/pci/proc.c  (mode:100644 sha1:e68bbfb1e7c318d0c34c11e3c76774ae17f3c60a)
@@ -15,6 +15,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
+#include "pci.h"
 
 static int proc_initialized;	/* = 0 */
 
Index: drivers/pci/quirks.c
===================================================================
--- 1b09131f91db847c9f3d6de98ed5cc1ebd0e9325/drivers/pci/quirks.c  (mode:100644 sha1:15a398051682ae19334a358600ecee9b85f1a434)
+++ 9979aed502d987538c51d9820be9c288462f9996/drivers/pci/quirks.c  (mode:100644 sha1:00388a14a3c61693ac734dee4c4cef172b2a0acc)
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include "pci.h"
 
 /* Deal with broken BIOS'es that neglect to enable passive release,
    which can cause problems in combination with the 82441FX/PPro MTRRs */

