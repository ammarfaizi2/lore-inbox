Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVCRW26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVCRW26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVCRW1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:27:01 -0500
Received: from fmr21.intel.com ([143.183.121.13]:52955 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262423AbVCRWUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:20:37 -0500
Date: Fri, 18 Mar 2005 14:20:17 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: [patch 11/12] Export the interface to get PCI id for an ACPI handle
Message-ID: <20050318142017.K1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export an acpi interface to get PCI domain/bus/devfn information
from the corresponding namespace handle. Used by acpiphp code
to transpate the device handle of the hot-plugged root bridge to
the corresponding pci location information.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/pci_bind.c     |   11 +++++------
 linux-2.6.11-mm4-iohp-rshah1/include/acpi/acpi_drivers.h |    1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -puN drivers/acpi/pci_bind.c~acpi-get-pci-id drivers/acpi/pci_bind.c
--- linux-2.6.11-mm4-iohp/drivers/acpi/pci_bind.c~acpi-get-pci-id	2005-03-16 13:07:39.028647689 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/acpi/pci_bind.c	2005-03-16 13:07:39.141928937 -0800
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
diff -puN include/acpi/acpi_drivers.h~acpi-get-pci-id include/acpi/acpi_drivers.h
--- linux-2.6.11-mm4-iohp/include/acpi/acpi_drivers.h~acpi-get-pci-id	2005-03-16 13:07:39.033530501 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/include/acpi/acpi_drivers.h	2005-03-16 13:07:39.142905500 -0800
@@ -68,6 +68,7 @@ void acpi_pci_irq_del_prt (int segment, 
 
 struct pci_bus;
 
+acpi_status acpi_get_pci_id (acpi_handle handle, struct acpi_pci_id *id);
 int acpi_pci_bind (struct acpi_device *device);
 int acpi_pci_unbind (struct acpi_device *device);
 int acpi_pci_bind_root (struct acpi_device *device, struct acpi_pci_id *id, struct pci_bus *bus);
_
