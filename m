Return-Path: <linux-kernel-owner+w=401wt.eu-S937495AbWLKSlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937495AbWLKSlD (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937471AbWLKSlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:41:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3924 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1763015AbWLKSkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:40:40 -0500
Date: Mon, 11 Dec 2006 19:40:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [-mm patch] ACPI: make code static
Message-ID: <20061211184048.GB28443@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 12:58:07AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc6-mm2:
>...
>  git-acpi.patch
>...
>  git trees.
>...

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/acpi/bus.c          |    2 +-
 drivers/acpi/dock.c         |    4 ++--
 drivers/acpi/pci_bind.c     |    4 ++--
 include/acpi/acpi_bus.h     |    2 --
 include/acpi/acpi_drivers.h |    2 --
 5 files changed, 5 insertions(+), 9 deletions(-)

--- linux-2.6.19-mm1/include/acpi/acpi_bus.h.old	2006-12-11 17:59:03.000000000 +0100
+++ linux-2.6.19-mm1/include/acpi/acpi_bus.h	2006-12-11 17:59:08.000000000 +0100
@@ -317,8 +317,6 @@
 	u32 data;
 };
 
-extern struct subsystem acpi_subsys;
-
 /*
  * External Functions
  */
--- linux-2.6.19-mm1/drivers/acpi/bus.c.old	2006-12-11 16:44:31.000000000 +0100
+++ linux-2.6.19-mm1/drivers/acpi/bus.c	2006-12-11 16:44:56.000000000 +0100
@@ -728,7 +728,7 @@
 	return -ENODEV;
 }
 
-decl_subsys(acpi, NULL, NULL);
+static decl_subsys(acpi, NULL, NULL);
 
 static int __init acpi_init(void)
 {
--- linux-2.6.19-mm1/include/acpi/acpi_drivers.h.old	2006-12-11 16:45:46.000000000 +0100
+++ linux-2.6.19-mm1/include/acpi/acpi_drivers.h	2006-12-11 16:46:09.000000000 +0100
@@ -68,8 +68,6 @@
 struct pci_bus;
 
 acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id);
-int acpi_pci_bind(struct acpi_device *device);
-int acpi_pci_unbind(struct acpi_device *device);
 int acpi_pci_bind_root(struct acpi_device *device, struct acpi_pci_id *id,
 		       struct pci_bus *bus);
 
--- linux-2.6.19-mm1/drivers/acpi/pci_bind.c.old	2006-12-11 16:46:17.000000000 +0100
+++ linux-2.6.19-mm1/drivers/acpi/pci_bind.c	2006-12-11 16:46:35.000000000 +0100
@@ -106,7 +106,7 @@
 
 EXPORT_SYMBOL(acpi_get_pci_id);
 
-int acpi_pci_bind(struct acpi_device *device)
+static int acpi_pci_bind(struct acpi_device *device)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
@@ -265,7 +265,7 @@
 	return result;
 }
 
-int acpi_pci_unbind(struct acpi_device *device)
+static int acpi_pci_unbind(struct acpi_device *device)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
--- linux-2.6.19-mm1/drivers/acpi/dock.c.old	2006-12-11 16:47:24.000000000 +0100
+++ linux-2.6.19-mm1/drivers/acpi/dock.c	2006-12-11 16:47:55.000000000 +0100
@@ -639,7 +639,7 @@
 	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
 
 }
-DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
+static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 
 /*
  * write_undock - write method for "undock" file in sysfs
@@ -655,7 +655,7 @@
 	ret = handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST);
 	return ret ? ret: count;
 }
-DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
+static DEVICE_ATTR(undock, S_IWUSR, NULL, write_undock);
 
 /**
  * dock_add - add a new dock station

