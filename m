Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVJAG2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVJAG2k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 02:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVJAG2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 02:28:40 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:974 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750743AbVJAG2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 02:28:39 -0400
Date: Fri, 30 Sep 2005 23:28:41 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] [ACPI] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001062841.GA24250@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -227,10 +227,9 @@ static int acpi_ac_add(struct acpi_devic
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	ac = kmalloc(sizeof(struct acpi_ac), GFP_KERNEL);
+	ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
 	if (!ac)
 		return_VALUE(-ENOMEM);
-	memset(ac, 0, sizeof(struct acpi_ac));
 
 	ac->handle = device->handle;
 	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -355,10 +355,9 @@ static int acpi_memory_device_add(struct
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	mem_device = kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
+	mem_device = kzalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
 	if (!mem_device)
 		return_VALUE(-ENOMEM);
-	memset(mem_device, 0, sizeof(struct acpi_memory_device));
 
 	mem_device->handle = device->handle;
 	sprintf(acpi_device_name(device), "%s", ACPI_MEMORY_DEVICE_NAME);
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1120,10 +1120,9 @@ static int __init asus_hotk_add(struct a
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
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -156,12 +156,11 @@ acpi_battery_get_info(struct acpi_batter
 		goto end;
 	}
 
-	data.pointer = kmalloc(data.length, GFP_KERNEL);
+	data.pointer = kzalloc(data.length, GFP_KERNEL);
 	if (!data.pointer) {
 		result = -ENOMEM;
 		goto end;
 	}
-	memset(data.pointer, 0, data.length);
 
 	status = acpi_extract_package(package, &format, &data);
 	if (ACPI_FAILURE(status)) {
@@ -217,12 +216,11 @@ acpi_battery_get_status(struct acpi_batt
 		goto end;
 	}
 
-	data.pointer = kmalloc(data.length, GFP_KERNEL);
+	data.pointer = kzalloc(data.length, GFP_KERNEL);
 	if (!data.pointer) {
 		result = -ENOMEM;
 		goto end;
 	}
-	memset(data.pointer, 0, data.length);
 
 	status = acpi_extract_package(package, &format, &data);
 	if (ACPI_FAILURE(status)) {
@@ -710,10 +708,9 @@ static int acpi_battery_add(struct acpi_
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	battery = kmalloc(sizeof(struct acpi_battery), GFP_KERNEL);
+	battery = kzalloc(sizeof(struct acpi_battery), GFP_KERNEL);
 	if (!battery)
 		return_VALUE(-ENOMEM);
-	memset(battery, 0, sizeof(struct acpi_battery));
 
 	battery->handle = device->handle;
 	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -308,10 +308,9 @@ static int acpi_button_add(struct acpi_d
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	button = kmalloc(sizeof(struct acpi_button), GFP_KERNEL);
+	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
 	if (!button)
 		return_VALUE(-ENOMEM);
-	memset(button, 0, sizeof(struct acpi_button));
 
 	button->device = device;
 	button->handle = device->handle;
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -98,11 +98,10 @@ static int acpi_container_add(struct acp
 		return_VALUE(-EINVAL);
 	}
 
-	container = kmalloc(sizeof(struct acpi_container), GFP_KERNEL);
+	container = kzalloc(sizeof(struct acpi_container), GFP_KERNEL);
 	if (!container)
 		return_VALUE(-ENOMEM);
 
-	memset(container, 0, sizeof(struct acpi_container));
 	container->handle = device->handle;
 	strcpy(acpi_device_name(device), ACPI_CONTAINER_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_CONTAINER_CLASS);
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -992,10 +992,9 @@ static int acpi_ec_polling_add(struct ac
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	ec = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec = kzalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec)
 		return_VALUE(-ENOMEM);
-	memset(ec, 0, sizeof(union acpi_ec));
 
 	ec->common.handle = device->handle;
 	ec->common.uid = -1;
@@ -1063,10 +1062,9 @@ static int acpi_ec_burst_add(struct acpi
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	ec = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec = kzalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec)
 		return_VALUE(-ENOMEM);
-	memset(ec, 0, sizeof(union acpi_ec));
 
 	ec->common.handle = device->handle;
 	ec->common.uid = -1;
@@ -1357,12 +1355,11 @@ static int __init acpi_ec_fake_ecdt(void
 
 	printk(KERN_INFO PREFIX "Try to make an fake ECDT\n");
 
-	ec_ecdt = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec_ecdt = kzalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec_ecdt) {
 		ret = -ENOMEM;
 		goto error;
 	}
-	memset(ec_ecdt, 0, sizeof(union acpi_ec));
 
 	status = acpi_get_devices(ACPI_EC_HID,
 				  acpi_fake_ecdt_callback, NULL, NULL);
@@ -1402,10 +1399,9 @@ static int __init acpi_ec_polling_get_re
 	/*
 	 * Generate a temporary ec context to use until the namespace is scanned
 	 */
-	ec_ecdt = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec_ecdt = kzalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec_ecdt)
 		return -ENOMEM;
-	memset(ec_ecdt, 0, sizeof(union acpi_ec));
 
 	ec_ecdt->common.command_addr = ecdt_ptr->ec_control;
 	ec_ecdt->common.status_addr = ecdt_ptr->ec_control;
@@ -1447,10 +1443,9 @@ static int __init acpi_ec_burst_get_real
 	/*
 	 * Generate a temporary ec context to use until the namespace is scanned
 	 */
-	ec_ecdt = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec_ecdt = kzalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec_ecdt)
 		return -ENOMEM;
-	memset(ec_ecdt, 0, sizeof(union acpi_ec));
 
 	init_MUTEX(&ec_ecdt->burst.sem);
 	init_waitqueue_head(&ec_ecdt->burst.wait);
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -189,10 +189,9 @@ static int acpi_fan_add(struct acpi_devi
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	fan = kmalloc(sizeof(struct acpi_fan), GFP_KERNEL);
+	fan = kzalloc(sizeof(struct acpi_fan), GFP_KERNEL);
 	if (!fan)
 		return_VALUE(-ENOMEM);
-	memset(fan, 0, sizeof(struct acpi_fan));
 
 	fan->handle = device->handle;
 	strcpy(acpi_device_name(device), "Fan");
diff --git a/drivers/acpi/hotkey.c b/drivers/acpi/hotkey.c
--- a/drivers/acpi/hotkey.c
+++ b/drivers/acpi/hotkey.c
@@ -247,10 +247,8 @@ static char *format_result(union acpi_ob
 {
 	char *buf = NULL;
 
-	buf = (char *)kmalloc(RESULT_STR_LEN, GFP_KERNEL);
-	if (buf)
-		memset(buf, 0, RESULT_STR_LEN);
-	else
+	buf = (char *)kzalloc(RESULT_STR_LEN, GFP_KERNEL);
+	if (!buf)
 		goto do_fail;
 
 	/* Now, just support integer type */
@@ -795,10 +793,9 @@ static ssize_t hotkey_write_config(struc
 		return_VALUE(-EINVAL);
 	}
 
-	key = kmalloc(sizeof(union acpi_hotkey), GFP_KERNEL);
+	key = kzalloc(sizeof(union acpi_hotkey), GFP_KERNEL);
 	if (!key)
 		goto do_fail;
-	memset(key, 0, sizeof(union acpi_hotkey));
 	if (cmd == 1) {
 		union acpi_hotkey *tmp = NULL;
 		tmp = get_hotkey_by_event(&global_hotkey_list,
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1747,13 +1747,12 @@ static int __init register_driver(struct
 {
 	int ret;
 
-	ibm->driver = kmalloc(sizeof(struct acpi_driver), GFP_KERNEL);
+	ibm->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
 	if (!ibm->driver) {
 		printk(IBM_ERR "kmalloc(ibm->driver) failed\n");
 		return -1;
 	}
 
-	memset(ibm->driver, 0, sizeof(struct acpi_driver));
 	sprintf(ibm->driver->name, "%s/%s", IBM_NAME, ibm->name);
 	ibm->driver->ids = ibm->hid;
 	ibm->driver->ops.add = &ibm_device_add;
diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -125,19 +125,17 @@ int acpi_pci_bind(struct acpi_device *de
 	if (!device || !device->parent)
 		return_VALUE(-EINVAL);
 
-	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return_VALUE(-ENOMEM);
-	memset(pathname, 0, ACPI_PATHNAME_MAX);
 	buffer.length = ACPI_PATHNAME_MAX;
 	buffer.pointer = pathname;
 
-	data = kmalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
+	data = kzalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
 	if (!data) {
 		kfree(pathname);
 		return_VALUE(-ENOMEM);
 	}
-	memset(data, 0, sizeof(struct acpi_pci_data));
 
 	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Binding PCI device [%s]...\n",
@@ -285,10 +283,9 @@ int acpi_pci_unbind(struct acpi_device *
 	if (!device || !device->parent)
 		return_VALUE(-EINVAL);
 
-	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = (char *)kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return_VALUE(-ENOMEM);
-	memset(pathname, 0, ACPI_PATHNAME_MAX);
 
 	buffer.length = ACPI_PATHNAME_MAX;
 	buffer.pointer = pathname;
@@ -337,10 +334,9 @@ acpi_pci_bind_root(struct acpi_device *d
 
 	ACPI_FUNCTION_TRACE("acpi_pci_bind_root");
 
-	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = (char *)kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return_VALUE(-ENOMEM);
-	memset(pathname, 0, ACPI_PATHNAME_MAX);
 
 	buffer.length = ACPI_PATHNAME_MAX;
 	buffer.pointer = pathname;
@@ -350,12 +346,11 @@ acpi_pci_bind_root(struct acpi_device *d
 		return_VALUE(-EINVAL);
 	}
 
-	data = kmalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
+	data = kzalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
 	if (!data) {
 		kfree(pathname);
 		return_VALUE(-ENOMEM);
 	}
-	memset(data, 0, sizeof(struct acpi_pci_data));
 
 	data->id = *id;
 	data->bus = bus;
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -92,10 +92,9 @@ acpi_pci_irq_add_entry(acpi_handle handl
 	if (!prt)
 		return_VALUE(-EINVAL);
 
-	entry = kmalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
+	entry = kzalloc(sizeof(struct acpi_prt_entry), GFP_KERNEL);
 	if (!entry)
 		return_VALUE(-ENOMEM);
-	memset(entry, 0, sizeof(struct acpi_prt_entry));
 
 	entry->id.segment = segment;
 	entry->id.bus = bus;
@@ -165,10 +164,9 @@ int acpi_pci_irq_add_prt(acpi_handle han
 
 	ACPI_FUNCTION_TRACE("acpi_pci_irq_add_prt");
 
-	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	pathname = (char *)kzalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
 		return_VALUE(-ENOMEM);
-	memset(pathname, 0, ACPI_PATHNAME_MAX);
 
 	if (first_time) {
 		acpi_prt.count = 0;
@@ -202,11 +200,10 @@ int acpi_pci_irq_add_prt(acpi_handle han
 		return_VALUE(-ENODEV);
 	}
 
-	prt = kmalloc(buffer.length, GFP_KERNEL);
+	prt = kzalloc(buffer.length, GFP_KERNEL);
 	if (!prt) {
 		return_VALUE(-ENOMEM);
 	}
-	memset(prt, 0, buffer.length);
 	buffer.pointer = prt;
 
 	status = acpi_get_irq_routing_table(handle, &buffer);
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -316,11 +316,10 @@ static int acpi_pci_link_set(struct acpi
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
-	resource = kmalloc(sizeof(*resource) + 1, GFP_KERNEL);
+	resource = kzalloc(sizeof(*resource) + 1, GFP_KERNEL);
 	if (!resource)
 		return_VALUE(-ENOMEM);
 
-	memset(resource, 0, sizeof(*resource) + 1);
 	buffer.length = sizeof(*resource) + 1;
 	buffer.pointer = resource;
 
@@ -734,10 +733,9 @@ static int acpi_pci_link_add(struct acpi
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	link = kmalloc(sizeof(struct acpi_pci_link), GFP_KERNEL);
+	link = kzalloc(sizeof(struct acpi_pci_link), GFP_KERNEL);
 	if (!link)
 		return_VALUE(-ENOMEM);
-	memset(link, 0, sizeof(struct acpi_pci_link));
 
 	link->device = device;
 	link->handle = device->handle;
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -558,10 +558,9 @@ static int acpi_power_add(struct acpi_de
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	resource = kmalloc(sizeof(struct acpi_power_resource), GFP_KERNEL);
+	resource = kzalloc(sizeof(struct acpi_power_resource), GFP_KERNEL);
 	if (!resource)
 		return_VALUE(-ENOMEM);
-	memset(resource, 0, sizeof(struct acpi_power_resource));
 
 	resource->handle = device->handle;
 	strcpy(resource->name, device->pnp.bus_id);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -993,12 +993,11 @@ acpi_add_single_object(struct acpi_devic
 	if (!child)
 		return_VALUE(-EINVAL);
 
-	device = kmalloc(sizeof(struct acpi_device), GFP_KERNEL);
+	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
 	if (!device) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Memory allocation error\n"));
 		return_VALUE(-ENOMEM);
 	}
-	memset(device, 0, sizeof(struct acpi_device));
 
 	device->handle = handle;
 	device->parent = parent;
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -928,12 +928,10 @@ acpi_thermal_write_trip_points(struct fi
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_write_trip_points");
 
-	limit_string = kmalloc(ACPI_THERMAL_MAX_LIMIT_STR_LEN, GFP_KERNEL);
+	limit_string = kzalloc(ACPI_THERMAL_MAX_LIMIT_STR_LEN, GFP_KERNEL);
 	if (!limit_string)
 		return_VALUE(-ENOMEM);
 
-	memset(limit_string, 0, ACPI_THERMAL_MAX_LIMIT_STR_LEN);
-
 	active = kmalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
 	if (!active)
 		return_VALUE(-ENOMEM);
@@ -1318,10 +1316,9 @@ static int acpi_thermal_add(struct acpi_
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	tz = kmalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
+	tz = kzalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
 	if (!tz)
 		return_VALUE(-ENOMEM);
-	memset(tz, 0, sizeof(struct acpi_thermal));
 
 	tz->handle = device->handle;
 	strcpy(tz->name, device->pnp.bus_id);
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -263,11 +263,10 @@ acpi_evaluate_integer(acpi_handle handle
 	if (!data)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 
-	element = kmalloc(sizeof(union acpi_object), GFP_KERNEL);
+	element = kzalloc(sizeof(union acpi_object), GFP_KERNEL);
 	if (!element)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 
-	memset(element, 0, sizeof(union acpi_object));
 	buffer.length = sizeof(union acpi_object);
 	buffer.pointer = element;
 	status = acpi_evaluate_object(handle, pathname, arguments, &buffer);
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -547,11 +547,10 @@ static void acpi_video_device_find_cap(s
 		int count = 0;
 		union acpi_object *o;
 
-		br = kmalloc(sizeof(*br), GFP_KERNEL);
+		br = kzalloc(sizeof(*br), GFP_KERNEL);
 		if (!br) {
 			printk(KERN_ERR "can't allocate memory\n");
 		} else {
-			memset(br, 0, sizeof(*br));
 			br->levels = kmalloc(obj->package.count *
 					     sizeof *(br->levels), GFP_KERNEL);
 			if (!br->levels)
@@ -1307,12 +1306,10 @@ acpi_video_bus_get_one_device(struct acp
 	    acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
 	if (ACPI_SUCCESS(status)) {
 
-		data = kmalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
+		data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
 		if (!data)
 			return_VALUE(-ENOMEM);
 
-		memset(data, 0, sizeof(struct acpi_video_device));
-
 		data->handle = device->handle;
 		strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
 		strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
@@ -1757,10 +1754,9 @@ static int acpi_video_bus_add(struct acp
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	video = kmalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
+	video = kzalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
 	if (!video)
 		return_VALUE(-ENOMEM);
-	memset(video, 0, sizeof(struct acpi_video_bus));
 
 	video->handle = device->handle;
 	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
