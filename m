Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVCCNWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVCCNWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVCCNWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:22:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33298 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261193AbVCCNWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:22:23 -0500
Date: Thu, 3 Mar 2005 14:22:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Timo Hoenig <thoenig@suse.de>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: [2.6.11-rc5-mm1 patch] drivers/acpi/pcc_acpi.c: section fixes
Message-ID: <20050303132220.GQ4608@stusta.de>
References: <20050301012741.1d791cd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301012741.1d791cd2.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following:
- acpi_pcc_hotkey_add: although the function prototype was marked
                       __devinit, the actual function wasn't
- acpi_pcc_proc_init is called by acpi_pcc_hotkey_remove and    
                     therefore has to be __devinit
- acpi_pcc_hotkey_remove: although the function prototype was marked
                          __devexit, the actual function wasn't
- acpi_pcc_remove_device is called by acpi_pcc_hotkey_remove and
                         therefore has to be __devexit

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/acpi/pcc_acpi.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

--- linux-2.6.11-rc5-mm1-full/drivers/acpi/pcc_acpi.c.old	2005-03-02 10:57:35.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/drivers/acpi/pcc_acpi.c	2005-03-02 11:04:11.000000000 +0100
@@ -643,9 +643,9 @@
 	{ NULL, NULL, 0 },
 };
 
-static int __init acpi_pcc_add_device(struct acpi_device *device,
-                                      ProcItem *proc_items,
-                                      int num)
+static int __devinit acpi_pcc_add_device(struct acpi_device *device,
+					 ProcItem *proc_items,
+					 int num)
 {
 	struct acpi_hotkey *hotkey = \
 		(struct acpi_hotkey*)acpi_driver_data(device);
@@ -675,7 +675,7 @@
 	return 0;
 }
 
-static int __init acpi_pcc_proc_init(struct acpi_device *device)
+static int __devinit acpi_pcc_proc_init(struct acpi_device *device)
 {
 	acpi_status status;
 	struct acpi_hotkey *hotkey = \
@@ -707,9 +707,9 @@
 	return status;
 }
 
-static void __exit acpi_pcc_remove_device(struct acpi_device *device,
-                                          ProcItem *proc_items,
-                                          int num)
+static void __devexit acpi_pcc_remove_device(struct acpi_device *device,
+					     ProcItem *proc_items,
+					     int num)
 {
 	struct acpi_hotkey *hotkey =
 		(struct acpi_hotkey*)acpi_driver_data(device);
@@ -791,7 +791,7 @@
 }
 
 /* module init */
-static int acpi_pcc_hotkey_add (struct acpi_device *device)
+static int __devinit acpi_pcc_hotkey_add (struct acpi_device *device)
 {
 	acpi_status status;
 	struct acpi_hotkey *hotkey = NULL;
@@ -851,7 +851,8 @@
 	return acpi_pcc_proc_init(device);
 }
 
-static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
+static int __devexit acpi_pcc_hotkey_remove(struct acpi_device *device,
+					    int type)
 {
 	acpi_status status;
 	struct acpi_hotkey *hotkey = acpi_driver_data(device);

