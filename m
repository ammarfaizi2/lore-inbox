Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLRVZG>; Mon, 18 Dec 2000 16:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQLRVYs>; Mon, 18 Dec 2000 16:24:48 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:63706 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129431AbQLRVYd>; Mon, 18 Dec 2000 16:24:33 -0500
Date: Mon, 18 Dec 2000 20:54:06 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test13pre3ac1
Message-ID: <20001218205406.O1039@redhat.com>
In-Reply-To: <E14868l-00064b-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14868l-00064b-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 18, 2000 at 07:40:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 07:40:03PM +0000, Alan Cox wrote:

> o	Add documentation to the PCI api		(Jani Monoses)

Needs this:

--- linux-2.4.0test13pre3-ac1/drivers/pci/pci.c.pcidoc	Mon Dec 18 20:46:08 2000
+++ linux-2.4.0test13pre3-ac1/drivers/pci/pci.c	Mon Dec 18 20:51:20 2000
@@ -73,7 +73,7 @@
  * found with a matching @vendor, @device, @ss_vendor and @ss_device, a pointer to its
  * device structure is returned.  Otherwise, %NULL is returned.
  * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not %NULL, searches continue from that point.
+ * Otherwise if @from is not %NULL, searches continue from next device on the global list.
  */
 struct pci_dev *
 pci_find_subsys(unsigned int vendor, unsigned int device,
@@ -105,7 +105,7 @@
  * found with a matching @vendor and @device, a pointer to its device structure is
  * returned.  Otherwise, %NULL is returned.
  * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not %NULL, searches continue from that point.
+ * Otherwise if @from is not %NULL, searches continue from next device on the global list.
  */
 struct pci_dev *
 pci_find_device(unsigned int vendor, unsigned int device, const struct pci_dev *from)
@@ -123,7 +123,7 @@
  * found with a matching @class, a pointer to its device structure is
  * returned.  Otherwise, %NULL is returned.
  * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not %NULL, searches continue from that point.
+ * Otherwise if @from is not %NULL, searches continue from next device on the global list.
  */
 struct pci_dev *
 pci_find_class(unsigned int class, const struct pci_dev *from)
@@ -370,7 +370,7 @@
  * 
  * Adds the driver structure to the list of registered drivers
  * Returns the number of pci devices which were claimed by the driver
- * during registration
+ * during registration.
  */
 int
 pci_register_driver(struct pci_driver *drv)
@@ -392,7 +392,7 @@
  * 
  * Deletes the driver structure from the list of registered PCI drivers,
  * gives it a chance to clean up and marks the devices for which it
- * was responsible as driverless 
+ * was responsible as driverless.
  */
 
 void
@@ -461,7 +461,7 @@
  * @dev: the device to insert
  * @bus: where to insert it
  *
- * Add a new device to the device lists and notify userspace (/sbin/hotplug)
+ * Add a new device to the device lists and notify userspace (/sbin/hotplug).
  */
 void
 pci_insert_device(struct pci_dev *dev, struct pci_bus *bus)
@@ -500,7 +500,7 @@
  * @dev: the device to remove
  *
  * Delete the device structure from the device lists and 
- * notify userspace (/sbin/hotplug)
+ * notify userspace (/sbin/hotplug).
  */
 void
 pci_remove_device(struct pci_dev *dev)
@@ -532,7 +532,7 @@
  * @dev: the device to query
  *
  * Returns the appropriate pci_driver structure or %NULL if there is no 
- * registered driver for the device
+ * registered driver for the device.
  */
 struct pci_driver *
 pci_dev_driver(const struct pci_dev *dev)
@@ -590,7 +590,7 @@
  * @dev: the PCI device to enable
  *
  * Enables bus-mastering on the device and calls pcibios_set_master()
- * to do the needed arch specific settings
+ * to do the needed arch specific settings.
  */
 void
 pci_set_master(struct pci_dev *dev)
@@ -940,7 +940,7 @@
  * vendor,class,memory and IO-space addresses,IRQ lines etc.
  * Called at initialisation of the PCI subsystem and by CardBus services.
  * Returns 0 on success and -1 if unknown type of device (not normal, bridge
- * or CardBus)
+ * or CardBus).
  */
 int pci_setup_device(struct pci_dev * dev)
 {

Tim.
*/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
