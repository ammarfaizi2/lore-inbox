Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267642AbTAHBra>; Tue, 7 Jan 2003 20:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbTAHBra>; Tue, 7 Jan 2003 20:47:30 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:18185 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267642AbTAHBr2>;
	Tue, 7 Jan 2003 20:47:28 -0500
Date: Tue, 7 Jan 2003 17:55:51 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] PCI hotplug changes for 2.5.54
Message-ID: <20030108015551.GB30924@kroah.com>
References: <20030108015500.GA30924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108015500.GA30924@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.894, 2003/01/07 16:24:14-08:00, greg@kroah.com

IBM PCI Hotplug: fix compile time error due to find_bus() function name.


diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Tue Jan  7 16:45:11 2003
+++ b/drivers/hotplug/ibmphp_core.c	Tue Jan  7 16:45:11 2003
@@ -769,11 +769,11 @@
  * Parameters: bus number
  * Returns : pci_bus *  or NULL if not found
  */
-static struct pci_bus *find_bus (u8 busno)
+static struct pci_bus *ibmphp_find_bus (u8 busno)
 {
 	const struct list_head *tmp;
 	struct pci_bus *bus;
-	debug ("inside find_bus, busno = %x \n", busno);
+	debug ("inside %s, busno = %x \n", __FUNCTION__, busno);
 
 	list_for_each (tmp, &pci_root_buses) {
 		bus = (struct pci_bus *) pci_bus_b (tmp);
@@ -1002,7 +1002,7 @@
 	struct pci_dev *dev;
 	u16 l;
 
-	if (find_bus (busno) || !(ibmphp_find_same_bus_num (busno)))
+	if (ibmphp_find_bus (busno) || !(ibmphp_find_same_bus_num (busno)))
 		return 1;
 
 	bus = kmalloc (sizeof (*bus), GFP_KERNEL);
@@ -1056,7 +1056,7 @@
 		func->dev = pci_find_slot (func->busno, (func->device << 3) | (func->function & 0x7));
 
 	if (func->dev == NULL) {
-		dev0.bus = find_bus (func->busno);
+		dev0.bus = ibmphp_find_bus (func->busno);
 		dev0.devfn = ((func->device << 3) + (func->function & 0x7));
 		dev0.sysdata = dev0.bus->sysdata;
 
@@ -1636,7 +1636,7 @@
 		return -ENOMEM;
 	}
 
-	bus = find_bus (0);
+	bus = ibmphp_find_bus (0);
 	if (!bus) {
 		err ("Can't find the root pci bus, can not continue\n");
 		return -ENODEV;
