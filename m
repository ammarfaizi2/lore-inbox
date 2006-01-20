Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWATTG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWATTG1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWATTF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:33488 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751171AbWATTFD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:03 -0500
Cc: pavel@ucw.cz
Subject: [PATCH] PCI Hotplug: fix up coding style issues
In-Reply-To: <11377838771056@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:38 -0800
Message-Id: <1137783878475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug: fix up coding style issues

Signed-off-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 4153374c18ee71fa8bdaa6a7e88ec42f8ec633f4
tree 9357f0c6a5eafe316803b3151c013bcac3c99bf4
parent 705f309deedc7b2c5c00d89f78336f1e68fe504b
author Pavel Machek <pavel@ucw.cz> Sun, 08 Jan 2006 20:11:59 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:34 -0800

 drivers/pci/hotplug/acpiphp_ibm.c |   21 +++++++++------------
 drivers/pci/hotplug/ibmphp_core.c |    4 ++--
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 7e7f913..317457d 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -302,7 +302,7 @@ static int ibm_get_table_from_acpi(char 
 	}
 
 	package = (union acpi_object *) buffer.pointer;
-	if(!(package) ||
+	if (!(package) ||
 			(package->type != ACPI_TYPE_PACKAGE) ||
 			!(package->package.elements)) {
 		err("%s:  Invalid APCI object\n", __FUNCTION__);
@@ -405,7 +405,7 @@ static acpi_status __init ibm_find_acpi_
 	}
 	info.hardware_id.value[sizeof(info.hardware_id.value) - 1] = '\0';
 
-	if(info.current_status && (info.valid & ACPI_VALID_HID) &&
+	if (info.current_status && (info.valid & ACPI_VALID_HID) &&
 			(!strcmp(info.hardware_id.value, IBM_HARDWARE_ID1) ||
 			!strcmp(info.hardware_id.value, IBM_HARDWARE_ID2))) {
 		dbg("found hardware: %s, handle: %p\n", info.hardware_id.value,
@@ -449,13 +449,11 @@ static int __init ibm_acpiphp_init(void)
 	}
 
 	ibm_note.device = device;
-	status = acpi_install_notify_handler(
-			ibm_acpi_handle,
-			ACPI_DEVICE_NOTIFY,
-			ibm_handle_events,
+	status = acpi_install_notify_handler(ibm_acpi_handle,
+			ACPI_DEVICE_NOTIFY, ibm_handle_events,
 			&ibm_note);
 	if (ACPI_FAILURE(status)) {
-		err("%s:  Failed to register notification handler\n",
+		err("%s: Failed to register notification handler\n",
 				__FUNCTION__);
 		retval = -EBUSY;
 		goto init_cleanup;
@@ -482,14 +480,13 @@ static void __exit ibm_acpiphp_exit(void
 	if (acpiphp_unregister_attention(&ibm_attention_info))
 		err("%s: attention info deregistration failed", __FUNCTION__);
 
-	   status = acpi_remove_notify_handler(
+	status = acpi_remove_notify_handler(
 			   ibm_acpi_handle,
 			   ACPI_DEVICE_NOTIFY,
 			   ibm_handle_events);
-	   if (ACPI_FAILURE(status))
-		   err("%s:  Notification handler removal failed\n",
-				   __FUNCTION__);
-	// remove the /sys entries
+	if (ACPI_FAILURE(status))
+		err("%s: Notification handler removal failed\n", __FUNCTION__);
+	/* remove the /sys entries */
 	if (sysfs_remove_bin_file(sysdir, &ibm_apci_table_attr))
 		err("%s: removal of sysfs file apci_table failed\n",
 				__FUNCTION__);
diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index aabf1e7..dc59da6 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -235,12 +235,12 @@ static int set_attention_status(struct h
 {
 	int rc = 0;
 	struct slot *pslot;
-	u8 cmd;
+	u8 cmd = 0x00;     /* avoid compiler warning */
 
 	debug("set_attention_status - Entry hotplug_slot[%lx] value[%x]\n",
 			(ulong) hotplug_slot, value);
 	ibmphp_lock_operations();
-	cmd = 0x00;     // avoid compiler warning
+
 
 	if (hotplug_slot) {
 		switch (value) {

