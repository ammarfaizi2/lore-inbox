Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263192AbVCDXVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbVCDXVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbVCDXTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:19:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:44450 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263192AbVCDUy7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:59 -0500
Cc: dlsy@snoqualmie.dp.intel.com
Subject: [PATCH] PCI Hotplug: Fix OSHP calls in shpchp and pciehp drivers
In-Reply-To: <11099696372884@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:57 -0800
Message-Id: <1109969637954@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.17, 2005/02/17 15:05:32-08:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI Hotplug: Fix OSHP calls in shpchp and pciehp drivers

Here is a patch to fix a problem in OSHP calls in shpchp and pciehp
drivers that was detected in 2.6.11-rc3. In this kernel, calls to
acpi_evaluate_object() to evaluate OSHP returned AE_BUFFER_OVERFLOW
with the existing code.  Earlier kernels didn't return this error
code.  The correct fix should be making return_buffer pointer NULL
for no value is returned from this method.

Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/hotplug/pciehprm_acpi.c |    3 +--
 drivers/pci/hotplug/shpchprm_acpi.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/hotplug/pciehprm_acpi.c b/drivers/pci/hotplug/pciehprm_acpi.c
--- a/drivers/pci/hotplug/pciehprm_acpi.c	2005-03-04 12:42:18 -08:00
+++ b/drivers/pci/hotplug/pciehprm_acpi.c	2005-03-04 12:42:18 -08:00
@@ -254,10 +254,9 @@
 {
 	acpi_status		status;
 	u8			*path_name = acpi_path_name(ab->handle);
-	struct acpi_buffer	ret_buf = { 0, NULL};
 
 	/* run OSHP */
-	status = acpi_evaluate_object(ab->handle, METHOD_NAME_OSHP, NULL, &ret_buf);
+	status = acpi_evaluate_object(ab->handle, METHOD_NAME_OSHP, NULL, NULL);
 	if (ACPI_FAILURE(status)) {
 		err("acpi_pciehprm:%s OSHP fails=0x%x\n", path_name, status);
 		oshp_run_status = (status == AE_NOT_FOUND) ? OSHP_NOT_EXIST : OSHP_RUN_FAILED;
diff -Nru a/drivers/pci/hotplug/shpchprm_acpi.c b/drivers/pci/hotplug/shpchprm_acpi.c
--- a/drivers/pci/hotplug/shpchprm_acpi.c	2005-03-04 12:42:18 -08:00
+++ b/drivers/pci/hotplug/shpchprm_acpi.c	2005-03-04 12:42:18 -08:00
@@ -242,10 +242,9 @@
 {
 	acpi_status		status;
 	u8			*path_name = acpi_path_name(ab->handle);
-	struct acpi_buffer	ret_buf = { 0, NULL};
 
 	/* run OSHP */
-	status = acpi_evaluate_object(ab->handle, METHOD_NAME_OSHP, NULL, &ret_buf);
+	status = acpi_evaluate_object(ab->handle, METHOD_NAME_OSHP, NULL, NULL);
 	if (ACPI_FAILURE(status)) {
 		err("acpi_pciehprm:%s OSHP fails=0x%x\n", path_name, status);
 	} else

