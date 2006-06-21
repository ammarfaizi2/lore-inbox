Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWFUBCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWFUBCK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWFUBCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:02:10 -0400
Received: from xenotime.net ([66.160.160.81]:13985 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932343AbWFUBCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:02:09 -0400
Date: Tue, 20 Jun 2006 18:04:55 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] DMI: cleanup kernel-doc, add to DocBook
Message-Id: <20060620180455.4ba2d710.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add DMI interface functions to a new Firmware Interfaces
chapter in the kernel-api DocBook.
Clean up kernel-doc in drivers/firmware/dmi_scan.c.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |   10 +++++++++-
 drivers/firmware/dmi_scan.c           |   13 +++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

--- linux-2617-work.orig/drivers/firmware/dmi_scan.c
+++ linux-2617-work/drivers/firmware/dmi_scan.c
@@ -255,10 +255,15 @@ void __init dmi_scan_machine(void)
 /**
  *	dmi_check_system - check system DMI data
  *	@list: array of dmi_system_id structures to match against
+ *		All non-null elements of the list must match
+ *		their slot's (field index's) data (i.e., each
+ *		list string must be a substring of the specified
+ *		DMI slot's string data) to be considered a
+ *		successful match.
  *
  *	Walk the blacklist table running matching functions until someone
  *	returns non zero or we hit the end. Callback function is called for
- *	each successfull match. Returns the number of matches.
+ *	each successful match. Returns the number of matches.
  */
 int dmi_check_system(struct dmi_system_id *list)
 {
@@ -287,7 +292,7 @@ EXPORT_SYMBOL(dmi_check_system);
 
 /**
  *	dmi_get_system_info - return DMI data value
- *	@field: data index (see enum dmi_filed)
+ *	@field: data index (see enum dmi_field)
  *
  *	Returns one DMI data value, can be used to perform
  *	complex DMI data checks.
@@ -301,13 +306,13 @@ EXPORT_SYMBOL(dmi_get_system_info);
 /**
  *	dmi_find_device - find onboard device by type/name
  *	@type: device type or %DMI_DEV_TYPE_ANY to match all device types
- *	@desc: device name string or %NULL to match all
+ *	@name: device name string or %NULL to match all
  *	@from: previous device found in search, or %NULL for new search.
  *
  *	Iterates through the list of known onboard devices. If a device is
  *	found with a matching @vendor and @device, a pointer to its device
  *	structure is returned.  Otherwise, %NULL is returned.
- *	A new search is initiated by passing %NULL to the @from argument.
+ *	A new search is initiated by passing %NULL as the @from argument.
  *	If @from is not %NULL, searches continue from next device.
  */
 struct dmi_device * dmi_find_device(int type, const char *name,
--- linux-2617-work.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2617-work/Documentation/DocBook/kernel-api.tmpl
@@ -280,12 +280,13 @@ X!Ekernel/module.c
      <sect1><title>MTRR Handling</title>
 !Earch/i386/kernel/cpu/mtrr/main.c
      </sect1>
+
      <sect1><title>PCI Support Library</title>
 !Edrivers/pci/pci.c
 !Edrivers/pci/pci-driver.c
 !Edrivers/pci/remove.c
 !Edrivers/pci/pci-acpi.c
-<!-- kerneldoc does not understand to __devinit
+<!-- kerneldoc does not understand __devinit
 X!Edrivers/pci/search.c
  -->
 !Edrivers/pci/msi.c
@@ -314,6 +315,13 @@ X!Earch/i386/kernel/mca.c
      </sect1>
   </chapter>
 
+  <chapter id="firmware">
+     <title>Firmware Interfaces</title>
+     <sect1><title>DMI Interfaces</title>
+!Edrivers/firmware/dmi_scan.c
+     </sect1>
+  </chapter>
+
   <chapter id="devfs">
      <title>The Device File System</title>
 !Efs/devfs/base.c


---
