Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWIRAzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWIRAzA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWIRAyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:54:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:57879 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965195AbWIRAyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:54:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aRRRaZN/fDv/x9Ythdwtr9EbJ75s6LDjLQGbhm56GKUyqP/XX+NTiliEz+jXUYhEe/g3yxLZ8A/uvGk+Nq9tb2lGUVKaDhqi6YEVgM1jX03V3+es0WOTbfGVri4CeB4gGCIKRPbYJz6Agb23rsa2NR5quz8NAtOns/rP/PGbJiE=
Message-ID: <6b4e42d10609171754m3361c805teda7fae032f8e756@mail.gmail.com>
Date: Sun, 17 Sep 2006 17:54:36 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: acpi kmalloc to kzalloc conversion and a memory leak fix.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I had submitted this patch sometime earlier. Submitting again after
fixing a bug in the patch.
I have not subscribed to linux-acpi. please CC me in replies.

Regards,
Om.

Signed Off by : Om Narasimhan <om.turyx@gmail.com>

--

 drivers/acpi/ac.c              |    4 +---
 drivers/acpi/acpi_memhotplug.c |   14 ++++----------
 drivers/acpi/asus_acpi.c       |    3 +--
 drivers/acpi/battery.c         |   13 +++----------
 drivers/acpi/bus.c             |    3 +--
 drivers/acpi/button.c          |    4 +---
 drivers/acpi/container.c       |    4 +---
 drivers/acpi/ec.c              |   20 +++++---------------
 drivers/acpi/fan.c             |    3 +--
 drivers/acpi/i2c_ec.c          |    8 ++------
 drivers/acpi/osl.c             |    2 +-
 drivers/acpi/pci_bind.c        |   21 +++++----------------
 drivers/acpi/pci_irq.c         |   16 +++-------------
 drivers/acpi/pci_link.c        |    6 ++----
 drivers/acpi/pci_root.c        |    3 +--
 drivers/acpi/power.c           |    4 +---
 drivers/acpi/processor_core.c  |    4 +---
 drivers/acpi/sbs.c             |    4 +---
 drivers/acpi/thermal.c         |   13 +++----------
 drivers/acpi/utils.c           |    2 --
 20 files changed, 38 insertions(+), 113 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 11abc7b..0d05d36 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -221,11 +221,9 @@ static int acpi_ac_add(struct acpi_devic
 	if (!device)
 		return -EINVAL;

-	ac = kmalloc(sizeof(struct acpi_ac), GFP_KERNEL);
+	ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
 	if (!ac)
 		return -ENOMEM;
-	memset(ac, 0, sizeof(struct acpi_ac));
-
 	ac->device = device;
 	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_AC_CLASS);
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 1dda370..4b1a77d 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -292,7 +292,6 @@ static int acpi_memory_disable_device(st
 	int result;
 	struct acpi_memory_info *info, *n;

-
 	/*
 	 * Ask the VM to offline this memory range.
 	 * Note: Assume that this function returns zero on success
@@ -323,7 +322,6 @@ static void acpi_memory_device_notify(ac
 	struct acpi_memory_device *mem_device;
 	struct acpi_device *device;

-
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -376,7 +374,6 @@ static void acpi_memory_device_notify(ac
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
-
 	return;
 }

@@ -385,15 +382,12 @@ static int acpi_memory_device_add(struct
 	int result;
 	struct acpi_memory_device *mem_device = NULL;

-
 	if (!device)
 		return -EINVAL;

-	mem_device = kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
+	mem_device = kzalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
 	if (!mem_device)
 		return -ENOMEM;
-	memset(mem_device, 0, sizeof(struct acpi_memory_device));
-
 	INIT_LIST_HEAD(&mem_device->res_list);
 	mem_device->device = device;
 	sprintf(acpi_device_name(device), "%s", ACPI_MEMORY_DEVICE_NAME);
@@ -418,14 +412,14 @@ static int acpi_memory_device_add(struct
 static int acpi_memory_device_remove(struct acpi_device *device, int type)
 {
 	struct acpi_memory_device *mem_device = NULL;
-
+	struct acpi_memory_info *info, *n;

 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
-
 	mem_device = (struct acpi_memory_device *)acpi_driver_data(device);
+	list_for_each_entry_safe(info, n, &mem_device->res_list, list)
+		kfree(info);
 	kfree(mem_device);
-
 	return 0;
 }

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index e9ee4c5..937d9a4 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1246,10 +1246,9 @@ static int asus_hotk_add(struct acpi_dev
 	       ASUS_ACPI_VERSION);

 	hotk =
-	    (struct asus_hotk *)kmalloc(sizeof(struct asus_hotk), GFP_KERNEL);
+	    (struct asus_hotk *)kzalloc(sizeof(struct asus_hotk), GFP_KERNEL);
 	if (!hotk)
 		return -ENOMEM;
-	memset(hotk, 0, sizeof(struct asus_hotk));

 	hotk->handle = device->handle;
 	strcpy(acpi_device_name(device), ACPI_HOTK_DEVICE_NAME);
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9810e2a..798413e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -158,13 +158,11 @@ acpi_battery_get_info(struct acpi_batter
 		goto end;
 	}

-	data.pointer = kmalloc(data.length, GFP_KERNEL);
+	data.pointer = kzalloc(data.length, GFP_KERNEL);
 	if (!data.pointer) {
 		result = -ENOMEM;
 		goto end;
 	}
-	memset(data.pointer, 0, data.length);
-
 	status = acpi_extract_package(package, &format, &data);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Extracting _BIF"));
@@ -218,13 +216,11 @@ acpi_battery_get_status(struct acpi_batt
 		goto end;
 	}

-	data.pointer = kmalloc(data.length, GFP_KERNEL);
+	data.pointer = kzalloc(data.length, GFP_KERNEL);
 	if (!data.pointer) {
 		result = -ENOMEM;
 		goto end;
 	}
-	memset(data.pointer, 0, data.length);
-
 	status = acpi_extract_package(package, &format, &data);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Extracting _BST"));
@@ -692,11 +688,9 @@ static int acpi_battery_add(struct acpi_
 	if (!device)
 		return -EINVAL;

-	battery = kmalloc(sizeof(struct acpi_battery), GFP_KERNEL);
+	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
-	memset(battery, 0, sizeof(struct acpi_battery));
-
 	battery->device = device;
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
@@ -727,7 +721,6 @@ static int acpi_battery_add(struct acpi_
 		acpi_battery_remove_fs(device);
 		kfree(battery);
 	}
-
 	return result;
 }

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 279c4ba..8a23498 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -290,7 +290,6 @@ int acpi_bus_generate_event(struct acpi_
 	struct acpi_bus_event *event = NULL;
 	unsigned long flags = 0;

-
 	if (!device)
 		return -EINVAL;

@@ -298,7 +297,7 @@ int acpi_bus_generate_event(struct acpi_
 	if (!event_is_open)
 		return 0;

-	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
+	event = kzalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
 	if (!event)
 		return -ENOMEM;

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 5ef885e..bec7520 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -296,11 +296,9 @@ static int acpi_button_add(struct acpi_d
 	if (!device)
 		return -EINVAL;

-	button = kmalloc(sizeof(struct acpi_button), GFP_KERNEL);
+	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
-	memset(button, 0, sizeof(struct acpi_button));
-
 	button->device = device;
 	acpi_driver_data(device) = button;

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 871aa52..322d60e 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -96,11 +96,9 @@ static int acpi_container_add(struct acp
 		return -EINVAL;
 	}

-	container = kmalloc(sizeof(struct acpi_container), GFP_KERNEL);
+	container = kzalloc(sizeof(struct acpi_container), GFP_KERNEL);
 	if (!container)
 		return -ENOMEM;
-
-	memset(container, 0, sizeof(struct acpi_container));
 	container->handle = device->handle;
 	strcpy(acpi_device_name(device), ACPI_CONTAINER_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_CONTAINER_CLASS);
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e5d7963..6c24b62 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -988,11 +988,9 @@ static int acpi_ec_poll_add(struct acpi_
 	if (!device)
 		return -EINVAL;

-	ec = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec = kzalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec)
 		return -ENOMEM;
-	memset(ec, 0, sizeof(union acpi_ec));
-
 	ec->common.handle = device->handle;
 	ec->common.uid = -1;
 	init_MUTEX(&ec->poll.sem);
@@ -1055,11 +1053,9 @@ static int acpi_ec_intr_add(struct acpi_
 	if (!device)
 		return -EINVAL;

-	ec = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec = kzalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec)
 		return -ENOMEM;
-	memset(ec, 0, sizeof(union acpi_ec));
-
 	ec->common.handle = device->handle;
 	ec->common.uid = -1;
 	atomic_set(&ec->intr.pending_gpe, 0);
@@ -1342,13 +1338,11 @@ static int __init acpi_ec_fake_ecdt(void

 	printk(KERN_INFO PREFIX "Try to make an fake ECDT\n");

-	ec_ecdt = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec_ecdt = kzalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec_ecdt) {
 		ret = -ENOMEM;
 		goto error;
 	}
-	memset(ec_ecdt, 0, sizeof(union acpi_ec));
-
 	status = acpi_get_devices(ACPI_EC_HID,
 				  acpi_fake_ecdt_callback, NULL, NULL);
 	if (ACPI_FAILURE(status)) {
@@ -1387,11 +1381,9 @@ static int __init acpi_ec_poll_get_real_
 	/*
 	 * Generate a temporary ec context to use until the namespace is scanned
 	 */
-	ec_ecdt = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec_ecdt = kzalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec_ecdt)
 		return -ENOMEM;
-	memset(ec_ecdt, 0, sizeof(union acpi_ec));
-
 	ec_ecdt->common.command_addr = ecdt_ptr->ec_control;
 	ec_ecdt->common.status_addr = ecdt_ptr->ec_control;
 	ec_ecdt->common.data_addr = ecdt_ptr->ec_data;
@@ -1432,11 +1424,9 @@ static int __init acpi_ec_intr_get_real_
 	/*
 	 * Generate a temporary ec context to use until the namespace is scanned
 	 */
-	ec_ecdt = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec_ecdt = kzalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec_ecdt)
 		return -ENOMEM;
-	memset(ec_ecdt, 0, sizeof(union acpi_ec));
-
 	init_MUTEX(&ec_ecdt->intr.sem);
 	init_waitqueue_head(&ec_ecdt->intr.wait);
 	ec_ecdt->common.command_addr = ecdt_ptr->ec_control;
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 045c894..9e73c98 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -186,10 +186,9 @@ static int acpi_fan_add(struct acpi_devi
 	if (!device)
 		return -EINVAL;

-	fan = kmalloc(sizeof(struct acpi_fan), GFP_KERNEL);
+	fan = kzalloc(sizeof(struct acpi_fan), GFP_KERNEL);
 	if (!fan)
 		return -ENOMEM;
-	memset(fan, 0, sizeof(struct acpi_fan));

 	fan->device = device;
 	strcpy(acpi_device_name(device), "Fan");
diff --git a/drivers/acpi/i2c_ec.c b/drivers/acpi/i2c_ec.c
index 6809c28..f25d700 100644
--- a/drivers/acpi/i2c_ec.c
+++ b/drivers/acpi/i2c_ec.c
@@ -309,19 +309,15 @@ static int acpi_ec_hc_add(struct acpi_de
 		return -EINVAL;
 	}

-	ec_hc = kmalloc(sizeof(struct acpi_ec_hc), GFP_KERNEL);
+	ec_hc = kzalloc(sizeof(struct acpi_ec_hc), GFP_KERNEL);
 	if (!ec_hc) {
 		return -ENOMEM;
 	}
-	memset(ec_hc, 0, sizeof(struct acpi_ec_hc));
-
-	smbus = kmalloc(sizeof(struct acpi_ec_smbus), GFP_KERNEL);
+	smbus = kzalloc(sizeof(struct acpi_ec_smbus), GFP_KERNEL);
 	if (!smbus) {
 		kfree(ec_hc);
 		return -ENOMEM;
 	}
-	memset(smbus, 0, sizeof(struct acpi_ec_smbus));
-
 	ec_hc->handle = device->handle;
 	strcpy(acpi_device_name(device), ACPI_EC_HC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_HC_CLASS);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 507f051..544d9ae 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -625,7 +625,7 @@ acpi_status acpi_os_execute(acpi_execute
 	 */

 	dpc =
-	    kmalloc(sizeof(struct acpi_os_dpc) + sizeof(struct work_struct),
+	    kzalloc(sizeof(struct acpi_os_dpc) + sizeof(struct work_struct),
 		    GFP_ATOMIC);
 	if (!dpc)
 		return_ACPI_STATUS(AE_NO_MEMORY);
diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
index 1e2ae6e..ec55b3b 100644
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -122,20 +122,17 @@ int acpi_pci_bind(struct acpi_device *de
 	if (!device || !device->parent)
 		return -EINVAL;

-	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return -ENOMEM;
-	memset(pathname, 0, ACPI_PATHNAME_MAX);
 	buffer.length = ACPI_PATHNAME_MAX;
 	buffer.pointer = pathname;

-	data = kmalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
+	data = kzalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
 	if (!data) {
 		kfree(pathname);
 		return -ENOMEM;
 	}
-	memset(data, 0, sizeof(struct acpi_pci_data));
-
 	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Binding PCI device [%s]...\n",
 			  pathname));
@@ -277,15 +274,12 @@ int acpi_pci_unbind(struct acpi_device *
 	char *pathname = NULL;
 	struct acpi_buffer buffer = { 0, NULL };

-
 	if (!device || !device->parent)
 		return -EINVAL;

-	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = (char *)kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return -ENOMEM;
-	memset(pathname, 0, ACPI_PATHNAME_MAX);
-
 	buffer.length = ACPI_PATHNAME_MAX;
 	buffer.pointer = pathname;
 	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
@@ -332,11 +326,9 @@ acpi_pci_bind_root(struct acpi_device *d
 	struct acpi_buffer buffer = { 0, NULL };


-	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = (char *)kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return -ENOMEM;
-	memset(pathname, 0, ACPI_PATHNAME_MAX);
-
 	buffer.length = ACPI_PATHNAME_MAX;
 	buffer.pointer = pathname;

@@ -345,13 +337,11 @@ acpi_pci_bind_root(struct acpi_device *d
 		return -EINVAL;
 	}

-	data = kmalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
+	data = kzalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
 	if (!data) {
 		kfree(pathname);
 		return -ENOMEM;
 	}
-	memset(data, 0, sizeof(struct acpi_pci_data));
-
 	data->id = *id;
 	data->bus = bus;
 	device->ops.bind = acpi_pci_bind;
@@ -375,6 +365,5 @@ acpi_pci_bind_root(struct acpi_device *d
 	kfree(pathname);
 	if (result != 0)
 		kfree(data);
-
 	return result;
 }
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index feda034..b64c50a 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -85,21 +85,14 @@ acpi_pci_irq_add_entry(acpi_handle handl
 {
 	struct acpi_prt_entry *entry = NULL;

-
-	if (!prt)
-		return -EINVAL;
-
-	entry = kmalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
+	entry = kzalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
-	memset(entry, 0, sizeof(struct acpi_prt_entry));
-
 	entry->id.segment = segment;
 	entry->id.bus = bus;
 	entry->id.device = (prt->address >> 16) & 0xFFFF;
 	entry->id.function = prt->address & 0xFFFF;
 	entry->pin = prt->pin;
-
 	/*
 	 * Type 1: Dynamic
 	 * ---------------
@@ -161,11 +154,9 @@ int acpi_pci_irq_add_prt(acpi_handle han
 	static int first_time = 1;


-	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = (char *)kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return -ENOMEM;
-	memset(pathname, 0, ACPI_PATHNAME_MAX);
-
 	if (first_time) {
 		acpi_prt.count = 0;
 		INIT_LIST_HEAD(&acpi_prt.entries);
@@ -198,11 +189,10 @@ int acpi_pci_irq_add_prt(acpi_handle han
 		return -ENODEV;
 	}

-	prt = kmalloc(buffer.length, GFP_KERNEL);
+	prt = kzalloc(buffer.length, GFP_KERNEL);
 	if (!prt) {
 		return -ENOMEM;
 	}
-	memset(prt, 0, buffer.length);
 	buffer.pointer = prt;

 	status = acpi_get_irq_routing_table(handle, &buffer);
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 7f3e7e7..a67af5d 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -307,11 +307,10 @@ static int acpi_pci_link_set(struct acpi
 	if (!link || !irq)
 		return -EINVAL;

-	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
+	resource = kzalloc(sizeof(*resource) + 1, GFP_ATOMIC);
 	if (!resource)
 		return -ENOMEM;

-	memset(resource, 0, sizeof(*resource) + 1);
 	buffer.length = sizeof(*resource) + 1;
 	buffer.pointer = resource;

@@ -718,10 +717,9 @@ static int acpi_pci_link_add(struct acpi
 	if (!device)
 		return -EINVAL;

-	link = kmalloc(sizeof(struct acpi_pci_link), GFP_KERNEL);
+	link = kzalloc(sizeof(struct acpi_pci_link), GFP_KERNEL);
 	if (!link)
 		return -ENOMEM;
-	memset(link, 0, sizeof(struct acpi_pci_link));

 	link->device = device;
 	strcpy(acpi_device_name(device), ACPI_PCI_LINK_DEVICE_NAME);
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 0984a1e..6b55f43 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -164,10 +164,9 @@ static int acpi_pci_root_add(struct acpi
 	if (!device)
 		return -EINVAL;

-	root = kmalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
+	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
 		return -ENOMEM;
-	memset(root, 0, sizeof(struct acpi_pci_root));
 	INIT_LIST_HEAD(&root->node);

 	root->device = device;
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index fec225d..b73d9c3 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -535,11 +535,9 @@ static int acpi_power_add(struct acpi_de
 	if (!device)
 		return -EINVAL;

-	resource = kmalloc(sizeof(struct acpi_power_resource), GFP_KERNEL);
+	resource = kzalloc(sizeof(struct acpi_power_resource), GFP_KERNEL);
 	if (!resource)
 		return -ENOMEM;
-	memset(resource, 0, sizeof(struct acpi_power_resource));
-
 	resource->device = device;
 	strcpy(resource->name, device->pnp.bus_id);
 	strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b13d644..e3943f4 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -615,11 +615,9 @@ static int acpi_processor_add(struct acp
 	if (!device)
 		return -EINVAL;

-	pr = kmalloc(sizeof(struct acpi_processor), GFP_KERNEL);
+	pr = kzalloc(sizeof(struct acpi_processor), GFP_KERNEL);
 	if (!pr)
 		return -ENOMEM;
-	memset(pr, 0, sizeof(struct acpi_processor));
-
 	pr->handle = device->handle;
 	strcpy(acpi_device_name(device), ACPI_PROCESSOR_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 62bef0b..3cd77bc 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -1576,13 +1576,11 @@ static int acpi_sbs_add(struct acpi_devi
 	int id, cnt;
 	acpi_status status = AE_OK;

-	sbs = kmalloc(sizeof(struct acpi_sbs), GFP_KERNEL);
+	sbs = kzalloc(sizeof(struct acpi_sbs), GFP_KERNEL);
 	if (!sbs) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "kmalloc() failed\n"));
 		return -ENOMEM;
 	}
-	memset(sbs, 0, sizeof(struct acpi_sbs));
-
 	cnt = 0;
 	while (cnt < 10) {
 		cnt++;
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5753d06..bdb0353 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -902,13 +902,11 @@ acpi_thermal_write_trip_points(struct fi
 	int i = 0;


-	limit_string = kmalloc(ACPI_THERMAL_MAX_LIMIT_STR_LEN, GFP_KERNEL);
+	limit_string = kzalloc(ACPI_THERMAL_MAX_LIMIT_STR_LEN, GFP_KERNEL);
 	if (!limit_string)
 		return -ENOMEM;

-	memset(limit_string, 0, ACPI_THERMAL_MAX_LIMIT_STR_LEN);
-
-	active = kmalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
+	active = kzalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
 	if (!active) {
 		kfree(limit_string);
 		return -ENOMEM;
@@ -923,9 +921,6 @@ acpi_thermal_write_trip_points(struct fi
 		count = -EFAULT;
 		goto end;
 	}
-
-	limit_string[count] = '\0';
-
 	num = sscanf(limit_string, "%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d",
 		     &critical, &hot, &passive,
 		     &active[0], &active[1], &active[2], &active[3], &active[4],
@@ -1271,11 +1266,9 @@ static int acpi_thermal_add(struct acpi_
 	if (!device)
 		return -EINVAL;

-	tz = kmalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
+	tz = kzalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
 	if (!tz)
 		return -ENOMEM;
-	memset(tz, 0, sizeof(struct acpi_thermal));
-
 	tz->device = device;
 	strcpy(tz->name, device->pnp.bus_id);
 	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index d0d84c4..b27d8d0 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -265,8 +265,6 @@ acpi_evaluate_integer(acpi_handle handle
 	element = kmalloc(sizeof(union acpi_object), irqs_disabled() ?
GFP_ATOMIC: GFP_KERNEL);
 	if (!element)
 		return AE_NO_MEMORY;
-
-	memset(element, 0, sizeof(union acpi_object));
 	buffer.length = sizeof(union acpi_object);
 	buffer.pointer = element;
 	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
