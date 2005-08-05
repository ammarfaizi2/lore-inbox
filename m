Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263080AbVHETTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbVHETTS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbVHETRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:17:18 -0400
Received: from fmr20.intel.com ([134.134.136.19]:48304 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S263080AbVHETQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:16:15 -0400
Subject: [PATCH] use bus_slot number for name
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: greg@kroah.com, rajesh.shah@intel.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 12:16:06 -0700
Message-Id: <1123269366.8917.39.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 05 Aug 2005 19:16:07.0271 (UTC) FILETIME=[217A0F70:01C599F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For systems with multiple hotplug controllers, you need to use more than
just the slot number to uniquely name the slot.  Without a unique slot
name, the pci_hp_register() will fail.  This patch adds the bus number
to the name.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/hotplug/pciehp.h linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pciehp.h
--- linux-2.6.13-rc4/drivers/pci/hotplug/pciehp.h	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/pciehp.h	2005-08-04 17:57:18.000000000 -0700
@@ -302,7 +302,7 @@ static inline void return_resource(struc
 
 static inline void make_slot_name(char *buffer, int buffer_size, struct slot *slot)
 {
-	snprintf(buffer, buffer_size, "%d", slot->number);
+	snprintf(buffer, buffer_size, "%04d_%04d", slot->bus, slot->number);
 }
 
 enum php_ctlr_type {
diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/hotplug/shpchp.h linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/shpchp.h
--- linux-2.6.13-rc4/drivers/pci/hotplug/shpchp.h	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-shpchp-slot-name-fix/drivers/pci/hotplug/shpchp.h	2005-08-04 17:57:18.000000000 -0700
@@ -46,7 +46,7 @@ extern int shpchp_poll_mode;
 extern int shpchp_poll_time;
 extern int shpchp_debug;
 
-/*#define dbg(format, arg...) do { if (shpchp_debug) printk(KERN_DEBUG "%s: " format, MY_NAME , ## arg); } while (0)*/
+/* #define dbg(format, arg...) do { if (shpchp_debug) printk(KERN_DEBUG "%s: " format, MY_NAME , ## arg); } while (0) */
 #define dbg(format, arg...) do { if (shpchp_debug) printk("%s: " format, MY_NAME , ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
@@ -411,7 +411,7 @@ static inline void return_resource(struc
 
 static inline void make_slot_name(char *buffer, int buffer_size, struct slot *slot)
 {
-	snprintf(buffer, buffer_size, "%d", slot->number);
+	snprintf(buffer, buffer_size, "%04d_%04d", slot->bus, slot->number);
 }
 
 enum php_ctlr_type {

