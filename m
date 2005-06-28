Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVF1FrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVF1FrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVF1FqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:46:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:13548 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261633AbVF1Fdg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:36 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: Export the interface to get PCI id for an ACPI handle
In-Reply-To: <11199367731756@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:53 -0700
Message-Id: <11199367733442@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: Export the interface to get PCI id for an ACPI handle

Export an acpi interface to get PCI domain/bus/devfn information from the
corresponding namespace handle.  Used by acpiphp code to transpate the device
handle of the hot-plugged root bridge to the corresponding pci location
information.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4ce448e5fae62689b06027b46f470b944e5c2193
tree 9edaa688203e649f63362f354d62d6a663da54b8
parent 3fb02738b0fd36f47710a2bf207129efd2f5daa2
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:53 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:42 -0700

 drivers/acpi/pci_bind.c     |   11 +++++------
 include/acpi/acpi_drivers.h |    1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -61,15 +61,14 @@ acpi_pci_data_handler (
 
 
 /**
- * acpi_os_get_pci_id
+ * acpi_get_pci_id
  * ------------------
  * This function is used by the ACPI Interpreter (a.k.a. Core Subsystem)
  * to resolve PCI information for ACPI-PCI devices defined in the namespace.
  * This typically occurs when resolving PCI operation region information.
  */
-#ifdef ACPI_FUTURE_USAGE
 acpi_status
-acpi_os_get_pci_id (
+acpi_get_pci_id (
 	acpi_handle		handle,
 	struct acpi_pci_id	*id)
 {
@@ -78,7 +77,7 @@ acpi_os_get_pci_id (
 	struct acpi_device	*device = NULL;
 	struct acpi_pci_data	*data = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_os_get_pci_id");
+	ACPI_FUNCTION_TRACE("acpi_get_pci_id");
 
 	if (!id)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
@@ -92,7 +91,7 @@ acpi_os_get_pci_id (
 	}
 
 	status = acpi_get_data(handle, acpi_pci_data_handler, (void**) &data);
-	if (ACPI_FAILURE(status) || !data || !data->dev) {
+	if (ACPI_FAILURE(status) || !data) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
 			"Invalid ACPI-PCI context for device %s\n",
 			acpi_device_bid(device)));
@@ -115,7 +114,7 @@ acpi_os_get_pci_id (
 
 	return_ACPI_STATUS(AE_OK);
 }
-#endif  /*  ACPI_FUTURE_USAGE  */
+EXPORT_SYMBOL(acpi_get_pci_id);
 
 	
 int
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -68,6 +68,7 @@ void acpi_pci_irq_del_prt (int segment, 
 
 struct pci_bus;
 
+acpi_status acpi_get_pci_id (acpi_handle handle, struct acpi_pci_id *id);
 int acpi_pci_bind (struct acpi_device *device);
 int acpi_pci_unbind (struct acpi_device *device);
 int acpi_pci_bind_root (struct acpi_device *device, struct acpi_pci_id *id, struct pci_bus *bus);

