Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbTFZAh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbTFZAgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:36:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:21911 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265253AbTFZAfG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:35:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10565884931018@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.73
In-Reply-To: <10565884933148@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Jun 2003 17:48:13 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1429.2.3, 2003/06/24 15:40:24-07:00, willy@debian.org

[PATCH] PCI documentation

Update the PCI Documentation to reflect some of the functions which have
recently been added and removed.

Index: Documentation/pci.txt
===================================================================
RCS file: /var/cvs/linux-2.5/Documentation/pci.txt,v
retrieving revision 1.4


 Documentation/pci.txt |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)


diff -Nru a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt	Wed Jun 25 17:38:17 2003
+++ b/Documentation/pci.txt	Wed Jun 25 17:38:17 2003
@@ -155,17 +155,11 @@
 VENDOR_ID or DEVICE_ID.  This allows searching for any device from a
 specific vendor, for example.
 
-   In case you need to decide according to some more complex criteria,
-you can walk the list of all known PCI devices yourself:
-
-	struct pci_dev *dev;
-	pci_for_each_dev(dev) {
-		... do anything you want with dev ...
-	}
-
-For compatibility with device ordering in older kernels, you can also
-use pci_for_each_dev_reverse(dev) for walking the list in the opposite
-direction.
+Note that these functions are not hotplug-safe.  Their hotplug-safe
+replacements are pci_get_device(), pci_get_class() and pci_get_subsys().
+They increment the reference count on the pci_dev that they return.
+You must eventually (possibly at module unload) decrement the reference
+count on these devices by calling pci_dev_put().
 
 
 3. Enabling devices
@@ -193,6 +187,10 @@
 string by pcibios_strerror. Most drivers expect that accesses to valid PCI
 devices don't fail.
 
+   If you don't have a struct pci_dev available, you can call
+pci_bus_(read|write)_config_(byte|word|dword) to access a given device
+and function on that bus.
+
    If you access fields in the standard portion of the config header, please
 use symbolic names of locations and bits declared in <linux/pci.h>.
 
@@ -253,14 +251,23 @@
 
 8. Obsolete functions
 ~~~~~~~~~~~~~~~~~~~~~
-There are several functions kept only for compatibility with old drivers
-not updated to the new PCI interface. Please don't use them in new code.
+There are several functions which you might come across when trying to
+port an old driver to the new PCI interface.  They are no longer present
+in the kernel as they aren't compatible with hotplug or PCI domains or
+having sane locking.
 
-pcibios_present()		Since ages, you don't need to test presence
-				of PCI subsystem when trying to talk with it.
+pcibios_present() and		Since ages, you don't need to test presence
+pci_present()			of PCI subsystem when trying to talk to it.
 				If it's not there, the list of PCI devices
 				is empty and all functions for searching for
 				devices just return NULL.
 pcibios_(read|write)_*		Superseded by their pci_(read|write)_*
 				counterparts.
 pcibios_find_*			Superseded by their pci_find_* counterparts.
+pci_for_each_dev()		Superseded by pci_find_device()
+pci_for_each_dev_reverse()	Superseded by pci_find_device_reverse()
+pci_for_each_bus()		Superseded by pci_find_next_bus()
+pci_find_device()		Superseded by pci_get_device()
+pci_find_subsys()		Superseded by pci_get_subsys()
+pcibios_find_class()		Superseded by pci_find_class()
+pci_(read|write)_*_nodev()	Superseded by pci_bus_(read|write)_*()

