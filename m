Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317277AbSFRCJr>; Mon, 17 Jun 2002 22:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSFRCJq>; Mon, 17 Jun 2002 22:09:46 -0400
Received: from pcp748332pcs.manass01.va.comcast.net ([68.49.120.123]:23994
	"EHLO pcp748332pcs.manass01.va.comcast.net") by vger.kernel.org
	with ESMTP id <S317277AbSFRCJm>; Mon, 17 Jun 2002 22:09:42 -0400
Date: Mon, 17 Jun 2002 22:09:37 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.22 fix for pci_hotplug
Message-ID: <20020618020937.GA2597@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.56
Reply-To: Matthew Harrell 
	  <mharrell-dated-1024798178.8a2594@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux/drivers/hotplug/pci_hotplug_core.c-ori	Mon Jun 17 22:01:17 2002
+++ linux/drivers/hotplug/pci_hotplug_core.c	Mon Jun 17 22:03:33 2002
@@ -183,13 +183,13 @@
 /* default file operations */
 static ssize_t default_read_file (struct file *file, char *buf, size_t count, loff_t *ppos)
 {
-	dbg ("\n");
+	dbg ("%s", "\n");
 	return 0;
 }
 
 static ssize_t default_write_file (struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
-	dbg ("\n");
+	dbg ("%s", "\n");
 	return count;
 }
 
@@ -417,7 +417,7 @@
 	}
 
 	if (!parent) {
-		dbg("Ah! can not find a parent!\n");
+		dbg("%s", "Ah! can not find a parent!\n");
 		return -EINVAL;
 	}
 
@@ -537,7 +537,7 @@
 		return 0;
 
 	if (slot == NULL) {
-		dbg("slot == NULL???\n");
+		dbg("%s", "slot == NULL???\n");
 		return -ENODEV;
 	}
 
@@ -578,7 +578,7 @@
 		return 0;
 
 	if (slot == NULL) {
-		dbg("slot == NULL???\n");
+		dbg("%s", "slot == NULL???\n");
 		return -ENODEV;
 	}
 
@@ -648,7 +648,7 @@
 		return 0;
 
 	if (slot == NULL) {
-		dbg("slot == NULL???\n");
+		dbg("%s", "slot == NULL???\n");
 		return -ENODEV;
 	}
 
@@ -689,7 +689,7 @@
 		return 0;
 
 	if (slot == NULL) {
-		dbg("slot == NULL???\n");
+		dbg("%s", "slot == NULL???\n");
 		return -ENODEV;
 	}
 
@@ -741,7 +741,7 @@
 		return 0;
 
 	if (slot == NULL) {
-		dbg("slot == NULL???\n");
+		dbg("%s", "slot == NULL???\n");
 		return -ENODEV;
 	}
 
@@ -785,7 +785,7 @@
 		return 0;
 
 	if (slot == NULL) {
-		dbg("slot == NULL???\n");
+		dbg("%s", "slot == NULL???\n");
 		return -ENODEV;
 	}
 
@@ -826,7 +826,7 @@
 		return 0;
 
 	if (slot == NULL) {
-		dbg("slot == NULL???\n");
+		dbg("%s", "slot == NULL???\n");
 		return -ENODEV;
 	}
 
@@ -1070,7 +1070,7 @@
 	spin_lock_init(&mount_lock);
 	spin_lock_init(&list_lock);
 
-	dbg("registering filesystem.\n");
+	dbg("%s", "registering filesystem.\n");
 	result = register_filesystem(&pcihpfs_type);
 	if (result) {
 		err("register_filesystem failed with %d\n", result);
--- linux/drivers/hotplug/pci_hotplug_util.c-ori	Mon Jun 17 22:04:58 2002
+++ linux/drivers/hotplug/pci_hotplug_util.c	Mon Jun 17 22:05:02 2002
@@ -103,7 +103,7 @@
 	dbg("%p, %d, %d, %d, %d, %p\n", ops, bus, slot, function, where, value);
 	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
 	if (dev) {
-		dbg("using native pci_dev\n");
+		dbg("%s", "using native pci_dev\n");
 		return pci_read_config_byte (dev, where, value);
 	}
 	
@@ -137,7 +137,7 @@
 	dbg("%p, %d, %d, %d, %d, %p\n", ops, bus, slot, function, where, value);
 	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
 	if (dev) {
-		dbg("using native pci_dev\n");
+		dbg("%s", "using native pci_dev\n");
 		return pci_read_config_word (dev, where, value);
 	}
 	
@@ -172,7 +172,7 @@
 	dbg("%p, %d, %d, %d, %d, %p\n", ops, bus, slot, function, where, value);
 	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
 	if (dev) {
-		dbg("using native pci_dev\n");
+		dbg("%s", "using native pci_dev\n");
 		return pci_read_config_dword (dev, where, value);
 	}
 	
@@ -207,7 +207,7 @@
 	dbg("%p, %d, %d, %d, %d, %d\n", ops, bus, slot, function, where, value);
 	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
 	if (dev) {
-		dbg("using native pci_dev\n");
+		dbg("%s", "using native pci_dev\n");
 		return pci_write_config_byte (dev, where, value);
 	}
 	
@@ -242,7 +242,7 @@
 	dbg("%p, %d, %d, %d, %d, %d\n", ops, bus, slot, function, where, value);
 	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
 	if (dev) {
-		dbg("using native pci_dev\n");
+		dbg("%s", "using native pci_dev\n");
 		return pci_write_config_word (dev, where, value);
 	}
 	
@@ -277,7 +277,7 @@
 	dbg("%p, %d, %d, %d, %d, %d\n", ops, bus, slot, function, where, value);
 	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
 	if (dev) {
-		dbg("using native pci_dev\n");
+		dbg("%s", "using native pci_dev\n");
 		return pci_write_config_dword (dev, where, value);
 	}
 	


-- 
  Matthew Harrell                          There are only 10 types of people in
  Bit Twiddlers, Inc.                       this world: those who understand
  mharrell@bittwiddlers.com                 binary and those who don't.
