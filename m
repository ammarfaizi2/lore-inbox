Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbWJYR0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbWJYR0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 13:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWJYR0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 13:26:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:21194 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965220AbWJYR0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 13:26:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:message-id;
        b=myvuzBYM+dFE5zBzfL+F6fU0fPRTlVDpEjhLVBuonYjhsp2C/gIofqJUOa3jfVUJYMPDiqvM3SN3PuIlEPdVl/NTHmeNZyt3Hts/0f+c4K+bOu4FHJyLzJZwevtrxN5AIVNMmNuy3JlV8MEzO+zr/0uf2TFbG1lpIjoj8P5GID0=
From: Luming Yu <luming.yu@gmail.com>
Organization: gmail
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Sat, 28 Oct 2006 01:24:54 +0800
User-Agent: KMail/1.9.1
Cc: Matt Domsch <Matt_Domsch@dell.com>, len.brown@intel.com,
       Richard Hughes <hughsient@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <200610170145.03779.luming.yu@gmail.com> <20061025070713.GF5851@elf.ucw.cz>
In-Reply-To: <20061025070713.GF5851@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pDkQFV03sk2Y5qE"
Message-Id: <200610280124.57212.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_pDkQFV03sk2Y5qE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 25 October 2006 15:07, Pavel Machek wrote:
> Hi!
>
> > > > a generic ACPI driver that exports the _BCL and _BCM method
> > > > implementations via that same interface, so that systems providing
> > > > that will "just work".  drivers/acpi/video.c currently exports this
> > > > via /proc/acpi/video/$DEVICE/brightness, which isn't the same as
> > > > /sys/class/backlight. :-(
> > >
> > > Yes, I'm working on acpi video driver transition , and have posted a
> > > patch to user backlight for acpi video driver.
> > > http://marc.theaimsgroup.com/?l=linux-acpi&m=115574087203605&w=2
> >
> > Just updated the backlight and output sysfs support for ACPI Video driver
> > on bugzilla. If you are interested this, please take a look at
> > http://bugzilla.kernel.org/show_bug.cgi?id=5749#c18
> >
> > [patch 1/3] vidoe sysfs support: Add dev argument for baclight sys dev
>
> Two typos in one line :-).
>
> > [patch 2/3] Add display output class support
>
> I guess this needs Documentation/ so we can tell if user<->kernel
> interface is sane..
>
> > [patch 3/3] backlight and output sysfs support for acpi video driver
>
> Some whitespace is not okay there...
> 									Pavel

updated version.
[patch 1/4] video sysfs support: Add dev argument for backlight sys dev
 drivers/video/backlight/backlight.c |    3 ++-
 include/linux/backlight.h           |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

[patch 2/4] Add display output class support
 drivers/video/output.c |  110 
+++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/output.h |   23 ++++++++++
 2 files changed, 133 insertions(+)

[patch 3/4] backlight and output sysfs support for acpi video driver
 acpi/Kconfig   |    2
 acpi/video.c   |  257 
+++++++++++++++++++++++++++++++++++++++++++++++++++++----
 video/Kconfig  |    8 +
 video/Makefile |    1
 4 files changed, 252 insertions(+), 16 deletions(-)

[patch 4/4] Add output class document
 video-output.txt |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

Thanks,
Luming


--Boundary-00=_pDkQFV03sk2Y5qE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="1-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="1-fix.patch"

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 27597c5..1a18cdb 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -190,7 +190,7 @@ static int fb_notifier_callback(struct n
  * Creates and registers new backlight class_device. Returns either an
  * ERR_PTR() or a pointer to the newly allocated device.
  */
-struct backlight_device *backlight_device_register(const char *name, void *devdata,
+struct backlight_device *backlight_device_register(const char *name,struct device *dev,  void *devdata,
 						   struct backlight_properties *bp)
 {
 	int i, rc;
@@ -206,6 +206,7 @@ struct backlight_device *backlight_devic
 	new_bd->props = bp;
 	memset(&new_bd->class_dev, 0, sizeof(new_bd->class_dev));
 	new_bd->class_dev.class = &backlight_class;
+	new_bd->class_dev.dev = dev;
 	strlcpy(new_bd->class_dev.class_id, name, KOBJ_NAME_LEN);
 	class_set_devdata(&new_bd->class_dev, devdata);
 
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 75e91f5..de8e056 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -54,7 +54,7 @@ struct backlight_device {
 };
 
 extern struct backlight_device *backlight_device_register(const char *name,
-	void *devdata, struct backlight_properties *bp);
+	struct device *dev, void *devdata, struct backlight_properties *bp);
 extern void backlight_device_unregister(struct backlight_device *bd);
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, class_dev)

--Boundary-00=_pDkQFV03sk2Y5qE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2-fix.patch"

diff --git a/drivers/video/output.c b/drivers/video/output.c
new file mode 100644
index 0000000..bcb2c53
--- /dev/null
+++ b/drivers/video/output.c
@@ -0,0 +1,110 @@
+/*
+ * Video output switch support
+ */
+
+#include <linux/module.h>
+#include <linux/output.h>
+#include <linux/err.h>
+#include <linux/ctype.h>
+
+
+MODULE_DESCRIPTION("Output Lowlevel Control Abstraction");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Luming Yu <luming.yu@intel.com>");
+
+static ssize_t video_output_show_state (struct class_device *dev, char *buf)
+{
+	ssize_t ret_size = 0;
+	struct output_device *od = to_output_device(dev);
+
+	if(od->props)
+		ret_size = sprintf(buf, "%.8x\n", od->props->get_status(od));
+
+	return ret_size;
+}
+
+static ssize_t video_output_store_state (struct class_device *dev, const char *buf, size_t count)
+{
+	char *endp;
+	struct output_device *od = to_output_device(dev);
+	int request_state = simple_strtoul(buf, &endp, 0);
+	size_t size = endp -buf;
+
+        if (*endp && isspace(*endp))
+                size++;
+        if (size != count)
+                return -EINVAL;
+
+	if(od->props){
+		od->request_state = request_state;
+		od->props->set_state(od);
+	}
+	return count;
+}
+
+static void video_output_class_release(struct class_device *dev)
+{
+        struct output_device *od = to_output_device(dev);
+        kfree(od);
+}
+
+static struct class_device_attribute video_output_attributes[] = {
+	__ATTR(state, 0644, video_output_show_state, video_output_store_state),
+	__ATTR_NULL,
+};
+
+static struct class video_output_class = {
+	.name = "video_output",
+	.release = video_output_class_release,
+	.class_dev_attrs = video_output_attributes,
+};
+
+
+struct output_device *video_output_register(const char *name,struct device *dev,
+				void *devdata, struct output_properties *op)
+{
+	struct output_device *new_dev;
+	int	ret_code = 0;
+
+	new_dev = (struct output_device *) kzalloc( sizeof(struct output_device), GFP_KERNEL);
+	if (!new_dev) {
+		ret_code = -ENOMEM;
+		goto error_return;
+	}
+	new_dev->props = op;
+	new_dev->class_dev.class = &video_output_class;
+	new_dev->class_dev.dev = dev;
+	strlcpy(new_dev->class_dev.class_id, name, KOBJ_NAME_LEN);
+	class_set_devdata(&new_dev->class_dev, devdata);
+	ret_code = class_device_register(&new_dev->class_dev);
+	if (ret_code){
+		kfree (new_dev);
+		goto error_return;
+	}
+	return new_dev;
+
+error_return:
+	return ERR_PTR(ret_code);
+}
+EXPORT_SYMBOL(video_output_register);
+
+void video_output_unregister(struct output_device *dev)
+{
+	if (!dev)
+		return;
+	class_device_unregister(&dev->class_dev);
+}
+EXPORT_SYMBOL(video_output_unregister);
+
+static void __exit video_output_class_exit(void)
+{
+	class_unregister(&video_output_class);
+}
+
+static int __init video_output_class_init(void)
+{
+	return class_register(&video_output_class);
+}
+
+postcore_initcall(video_output_class_init);
+module_exit(video_output_class_exit);
diff --git a/include/linux/output.h b/include/linux/output.h
new file mode 100644
index 0000000..f4eb12c
--- /dev/null
+++ b/include/linux/output.h
@@ -0,0 +1,23 @@
+#ifndef _LINUX_OUTPUT_H
+#define _LINUX_OUTPUT_H
+
+#include <linux/device.h>
+
+struct output_device;
+
+struct output_properties {
+	int (*set_state)(struct output_device *);
+	int (*get_status)(struct output_device *);
+};
+
+struct output_device {
+	int request_state;
+	struct output_properties *props;
+	struct class_device class_dev;
+};
+
+#define to_output_device(obj) container_of(obj, struct output_device, class_dev)
+
+struct output_device *video_output_register(const char *, struct device *dev, void *, struct output_properties *);
+void video_output_unregister(struct output_device *);
+#endif

--Boundary-00=_pDkQFV03sk2Y5qE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="4-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="4-fix.patch"

diff --git a/Documentation/video-output.txt b/Documentation/video-output.txt
new file mode 100644
index 0000000..43cc0e2
--- /dev/null
+++ b/Documentation/video-output.txt
@@ -0,0 +1,27 @@
+The output sysfs class driver is to provide video output abstract layer that can be used to hook platform specific methods to enable/disable video output device through common sysfs interface.
+
+For example, on my IBM Thinkpad T42 laptop, acpi video driver registered its output devices and read/write method for state with output sysfs class. The user interface under sysfs is :
+
+linux:/sys/class/video_output # tree .
+.
+|-- CRT0
+|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+|   |-- state
+|   |-- subsystem -> ../../../class/video_output
+|   `-- uevent
+|-- DVI0
+|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+|   |-- state
+|   |-- subsystem -> ../../../class/video_output
+|   `-- uevent
+|-- LCD0
+|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+|   |-- state
+|   |-- subsystem -> ../../../class/video_output
+|   `-- uevent
+`-- TV0
+   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+   |-- state
+   |-- subsystem -> ../../../class/video_output
+   `-- uevent
+

--Boundary-00=_pDkQFV03sk2Y5qE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="3-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="3-fix.patch"

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0f9d4be..a7671f7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -106,7 +106,7 @@ config ACPI_BUTTON
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86
+	depends on X86 && (BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL)
 	help
 	  This driver implement the ACPI Extensions For Display Adapters
 	  for integrated graphics devices on motherboard, as specified in
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 56666a9..0fcc68c 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -30,6 +30,9 @@ #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/pci.h>
+#include <linux/backlight.h>
+#include <linux/output.h>
 
 #include <asm/uaccess.h>
 
@@ -141,11 +144,11 @@ struct acpi_video_device_cap {
 	u8 _ADR:1;		/*Return the unique ID */
 	u8 _BCL:1;		/*Query list of brightness control levels supported */
 	u8 _BCM:1;		/*Set the brightness level */
+	u8 _BQC:1;		/*Get current brightness level */
 	u8 _DDC:1;		/*Return the EDID for this device */
 	u8 _DCS:1;		/*Return status of output device */
 	u8 _DGS:1;		/*Query graphics state */
 	u8 _DSS:1;		/*Device state set */
-	u8 _reserved:1;
 };
 
 struct acpi_video_device_brightness {
@@ -162,6 +165,7 @@ struct acpi_video_device {
 	struct acpi_video_bus *video;
 	struct acpi_device *dev;
 	struct acpi_video_device_brightness *brightness;
+	struct output_device *output_dev;
 };
 
 /* bus */
@@ -260,6 +264,56 @@ static int acpi_video_get_next_level(str
 				     u32 level_current, u32 event);
 static void acpi_video_switch_brightness(struct acpi_video_device *device,
 					 int event);
+static int acpi_video_device_lcd_set_level(struct acpi_video_device *, int);
+static int acpi_video_device_lcd_get_level_current(struct acpi_video_device *,unsigned long *);
+/*backlight device sysfs support*/
+static int acpi_video_get_brightness(struct backlight_device *bd);
+static int acpi_video_set_brightness(struct backlight_device *bd);
+static int acpi_video_output_get(struct output_device *);
+static int acpi_video_output_set(struct output_device *);
+static int acpi_video_device_get_state(struct acpi_video_device *, unsigned long *);
+static int acpi_video_device_set_state(struct acpi_video_device *, int);
+
+static struct backlight_device *acpi_video_backlight;
+static struct acpi_video_device *backlight_acpi_device;
+static struct backlight_properties acpi_video_data = {
+	.owner		= THIS_MODULE,
+	.max_brightness = 0,
+	.get_brightness = acpi_video_get_brightness,
+	.update_status  = acpi_video_set_brightness,
+};
+static struct output_properties acpi_output_properties = {
+	.set_state = acpi_video_output_set,
+	.get_status = acpi_video_output_get,
+};
+static int acpi_video_get_brightness(struct backlight_device *bd)
+{
+	unsigned long cur_level;
+	acpi_video_device_lcd_get_level_current(backlight_acpi_device, &cur_level);
+	return (int) cur_level;
+}
+
+static int acpi_video_set_brightness(struct backlight_device *bd)
+{
+	int request_level = bd->props->brightness;
+	acpi_video_device_lcd_set_level(backlight_acpi_device, request_level);
+	return 0;
+}
+
+static int acpi_video_output_get(struct output_device *od)
+{
+	unsigned long state;
+	struct acpi_video_device *vd = (struct acpi_video_device *)class_get_devdata(&od->class_dev);
+	acpi_video_device_get_state(vd, &state);
+	return (int)state;
+}
+
+static int acpi_video_output_set(struct output_device *od)
+{
+	unsigned long state = od->request_state;
+	struct acpi_video_device *vd = (struct acpi_video_device *)class_get_devdata(&od->class_dev);
+	return acpi_video_device_set_state(vd, state);
+}
 
 /* --------------------------------------------------------------------------
                                Video Management
@@ -345,7 +399,7 @@ acpi_video_device_lcd_set_level(struct a
 	arg0.integer.value = level;
 	status = acpi_evaluate_object(device->dev->handle, "_BCM", &args, NULL);
 
-	printk(KERN_DEBUG "set_level status: %x\n", status);
+	printk(KERN_DEBUG PREFIX "set_level status: %x\n", status);
 	return status;
 }
 
@@ -482,6 +536,134 @@ acpi_video_bus_DOS(struct acpi_video_bus
 	return status;
 }
 
+
+/*
+ * copy & paste some code for acpi_pci_data, acpi_pci_data_handler,acpi_pci_data
+ * from pci_bind.c
+ * To-do: write a new API: acpi_pci_get.
+ */
+
+struct acpi_pci_data {
+        struct acpi_pci_id id;
+        struct pci_bus *bus;
+        struct pci_dev *dev;
+};
+
+static void acpi_pci_data_handler(acpi_handle handle, u32 function,
+				  void *context)
+{
+
+	/* TBD: Anything we need to do here? */
+
+	return;
+}
+
+static struct acpi_pci_data * acpi_pci_get (struct acpi_device *device)
+{
+	int result = 0;
+	acpi_status status = AE_OK;
+	struct acpi_pci_data *data = NULL;
+	struct acpi_pci_data *pdata = NULL;
+	char *pathname = NULL;
+	struct acpi_buffer buffer = { 0, NULL };
+	acpi_handle handle = NULL;
+	struct pci_dev *dev;
+	struct pci_bus *bus;
+
+
+	if (!device || !device->parent)
+		return NULL;
+
+	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
+	if (!pathname)
+		return -ENOMEM;
+	memset(pathname, 0, ACPI_PATHNAME_MAX);
+	buffer.length = ACPI_PATHNAME_MAX;
+	buffer.pointer = pathname;
+
+	data = kmalloc(sizeof(struct acpi_pci_data), GFP_KERNEL);
+	if (!data) {
+		kfree(pathname);
+		return NULL;
+	}
+	memset(data, 0, sizeof(struct acpi_pci_data));
+
+	acpi_get_name(device->handle, ACPI_FULL_PATHNAME, &buffer);
+	printk(KERN_INFO PREFIX "finding PCI device [%s]...\n", pathname);
+
+	/*
+	 * Segment & Bus
+	 * -------------
+	 * These are obtained via the parent device's ACPI-PCI context.
+	 */
+go_up:
+	status = acpi_get_data(device->parent->handle, acpi_pci_data_handler,
+			       (void **)&pdata);
+	if (ACPI_FAILURE(status) || !pdata || !pdata->bus) {
+		struct acpi_device *tmp_dev;
+
+		tmp_dev = device->parent;
+		if (tmp_dev->parent && (tmp_dev->parent->handle != ACPI_ROOT_OBJECT)) {
+			device = tmp_dev;
+			goto go_up;
+		}
+
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Invalid ACPI-PCI context for parent device %s",
+				acpi_device_bid(device->parent)));
+		return NULL;
+	}
+	data->id.segment = pdata->id.segment;
+	data->id.bus = pdata->bus->number;
+
+	/*
+	 * Device & Function
+	 * -----------------
+	 * These are simply obtained from the device's _ADR method.  Note
+	 * that a value of zero is valid.
+	 */
+	data->id.device = device->pnp.bus_address >> 16;
+	data->id.function = device->pnp.bus_address & 0xFFFF;
+
+	printk(KERN_INFO PREFIX "...to %02x:%02x:%02x.%02x\n",
+			  data->id.segment, data->id.bus, data->id.device,
+			  data->id.function);
+
+	/*
+	 * TBD: Support slot devices (e.g. function=0xFFFF).
+	 */
+
+	/*
+	 * Locate PCI Device
+	 * -----------------
+	 * Locate matching device in PCI namespace.  If it doesn't exist
+	 * this typically means that the device isn't currently inserted
+	 * (e.g. docking station, port replicator, etc.).
+	 * We cannot simply search the global pci device list, since
+	 * PCI devices are added to the global pci list when the root
+	 * bridge start ops are run, which may not have happened yet.
+	 */
+	bus = pci_find_bus(data->id.segment, data->id.bus);
+	if (bus) {
+		list_for_each_entry(dev, &bus->devices, bus_list) {
+			if (dev->devfn == PCI_DEVFN(data->id.device,
+						    data->id.function)) {
+				data->dev = dev;
+				break;
+			}
+		}
+	}
+	printk(KERN_INFO PREFIX "data->dev =%p", &data->dev);
+	printk(KERN_INFO PREFIX "data->dev->dev =%p\n", &data->dev->dev);
+	if (!data->dev) {
+		printk(KERN_ERR PREFIX "Device %02x:%02x:%02x.%02x not present in PCI namespace\n",
+				  data->id.segment, data->id.bus,
+				  data->id.device, data->id.function);
+		return NULL;
+	}
+	return data;
+}
+
 /*
  *  Arg:	
  *  	device	: video output device (LCD, CRT, ..)
@@ -498,12 +680,18 @@ static void acpi_video_device_find_cap(s
 	acpi_integer status;
 	acpi_handle h_dummy1;
 	int i;
+	u32 max_level = 0;
 	union acpi_object *obj = NULL;
 	struct acpi_video_device_brightness *br = NULL;
+	struct acpi_pci_data *data;
 
 
+	data = acpi_pci_get (device->video->device);
+        if (!data || !(data->dev)) {
+		printk(KERN_ERR PREFIX "acpi_video_device:no valid data from acpi_pci_get\n");
+		return ;
+	}
 	memset(&device->cap, 0, 4);
-
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_ADR", &h_dummy1))) {
 		device->cap._ADR = 1;
 	}
@@ -513,6 +701,9 @@ static void acpi_video_device_find_cap(s
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BCM", &h_dummy1))) {
 		device->cap._BCM = 1;
 	}
+	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_BQC", &h_dummy1))) {
+		device->cap._BQC = 1;
+	}
 	if (ACPI_SUCCESS(acpi_get_handle(device->dev->handle, "_DDC", &h_dummy1))) {
 		device->cap._DDC = 1;
 	}
@@ -526,6 +717,7 @@ static void acpi_video_device_find_cap(s
 		device->cap._DSS = 1;
 	}
 
+
 	status = acpi_video_device_lcd_query_levels(device, &obj);
 
 	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count >= 2) {
@@ -534,7 +726,7 @@ static void acpi_video_device_find_cap(s
 
 		br = kmalloc(sizeof(*br), GFP_KERNEL);
 		if (!br) {
-			printk(KERN_ERR "can't allocate memory\n");
+			printk(KERN_ERR PREFIX "can't allocate memory\n");
 		} else {
 			memset(br, 0, sizeof(*br));
 			br->levels = kmalloc(obj->package.count *
@@ -550,6 +742,8 @@ static void acpi_video_device_find_cap(s
 					continue;
 				}
 				br->levels[count] = (u32) o->integer.value;
+				if (br->levels[count] > max_level)
+					max_level = br->levels[count];
 				count++;
 			}
 		      out:
@@ -568,6 +762,26 @@ static void acpi_video_device_find_cap(s
 
 	kfree(obj);
 
+	if (device->cap._BCL && device->cap._BCM && device->cap._BQC){
+		unsigned long tmp;
+		acpi_video_data.max_brightness = max_level;
+		acpi_video_device_lcd_get_level_current(device, &tmp);
+		acpi_video_data.brightness = tmp;
+		acpi_video_backlight = backlight_device_register("acpi-video",
+			&(data->dev->dev), NULL, &acpi_video_data);
+		backlight_acpi_device = device;
+	}
+
+	if (device->cap._DCS && device->cap._DSS){
+		char name[16];
+		memset(name, 0, 16);
+		strcat(name, acpi_device_bid(device->dev->parent));
+		strcat(name, "_");
+		strcpy(name, acpi_device_bid(device->dev));
+		device->output_dev = video_output_register(name,
+					 &(data->dev->dev),
+						device, &acpi_output_properties);
+	}
 	return;
 }
 
@@ -1011,7 +1225,6 @@ static int acpi_video_bus_POST_info_seq_
 			printk(KERN_WARNING PREFIX
 			       "This indicate a BIOS bug.  Please contact the manufacturer.\n");
 		}
-		printk("%lx\n", options);
 		seq_printf(seq, "can POST: <intgrated video>");
 		if (options & 2)
 			seq_printf(seq, " <PCI video>");
@@ -1148,11 +1361,15 @@ static int acpi_video_bus_add_fs(struct 
 {
 	struct proc_dir_entry *entry = NULL;
 	struct acpi_video_bus *video;
+        char proc_dir_name[32];
 
-
+	memset(proc_dir_name, 0, 32);
 	video = (struct acpi_video_bus *)acpi_driver_data(device);
 
 	if (!acpi_device_dir(device)) {
+              	strcpy(proc_dir_name, acpi_device_bid(device));
+               	strcat(proc_dir_name, "_");
+               	strcat(proc_dir_name, acpi_device_bid(device->parent));
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_video_dir);
 		if (!acpi_device_dir(device))
@@ -1224,17 +1441,21 @@ static int acpi_video_bus_add_fs(struct 
 static int acpi_video_bus_remove_fs(struct acpi_device *device)
 {
 	struct acpi_video_bus *video;
+        char proc_dir_name[32];
 
-
+	memset(proc_dir_name, 0, 32);
 	video = (struct acpi_video_bus *)acpi_driver_data(device);
-
 	if (acpi_device_dir(device)) {
 		remove_proc_entry("info", acpi_device_dir(device));
 		remove_proc_entry("ROM", acpi_device_dir(device));
 		remove_proc_entry("POST_info", acpi_device_dir(device));
 		remove_proc_entry("POST", acpi_device_dir(device));
 		remove_proc_entry("DOS", acpi_device_dir(device));
-		remove_proc_entry(acpi_device_bid(device), acpi_video_dir);
+
+                strcpy(proc_dir_name, acpi_device_bid(device));
+                strcat(proc_dir_name, "_");
+                strcat(proc_dir_name, acpi_device_bid(device->parent));
+                remove_proc_entry(proc_dir_name, acpi_video_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
@@ -1268,7 +1489,6 @@ acpi_video_bus_get_one_device(struct acp
 			return -ENOMEM;
 
 		memset(data, 0, sizeof(struct acpi_video_device));
-
 		strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
 		strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 		acpi_driver_data(device) = data;
@@ -1568,6 +1788,10 @@ static int acpi_video_bus_put_one_device
 	status = acpi_remove_notify_handler(device->dev->handle,
 					    ACPI_DEVICE_NOTIFY,
 					    acpi_video_device_notify);
+	if (device == backlight_acpi_device)
+		backlight_device_unregister(acpi_video_backlight);
+
+	video_output_unregister(device->output_dev);
 
 	return 0;
 }
@@ -1615,7 +1839,7 @@ static void acpi_video_bus_notify(acpi_h
 	struct acpi_video_bus *video = (struct acpi_video_bus *)data;
 	struct acpi_device *device = NULL;
 
-	printk("video bus notify\n");
+	printk(KERN_INFO PREFIX "video bus notify\n");
 
 	if (!video)
 		return;
@@ -1658,8 +1882,6 @@ static void acpi_video_device_notify(acp
 	    (struct acpi_video_device *)data;
 	struct acpi_device *device = NULL;
 
-
-	printk("video device notify\n");
 	if (!video_device)
 		return;
 
@@ -1691,8 +1913,9 @@ static int acpi_video_bus_add(struct acp
 	int result = 0;
 	acpi_status status = 0;
 	struct acpi_video_bus *video = NULL;
+        char proc_dir_name[32];
 
-
+	memset(proc_dir_name, 0, 32);
 	if (!device)
 		return -EINVAL;
 
@@ -1735,8 +1958,12 @@ static int acpi_video_bus_add(struct acp
 		goto end;
 	}
 
+        strcpy(proc_dir_name, acpi_device_bid(device));
+        strcat(proc_dir_name, "_");
+        strcat(proc_dir_name, acpi_device_bid(device->parent));
+
 	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
-	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
+               ACPI_VIDEO_DEVICE_NAME, proc_dir_name,
 	       video->flags.multihead ? "yes" : "no",
 	       video->flags.rom ? "yes" : "no",
 	       video->flags.post ? "yes" : "no");
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7a43020..3b51742 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1644,5 +1644,13 @@ if SYSFS
 	source "drivers/video/backlight/Kconfig"
 endif
 
+
+config VIDEO_OUTPUT_CONTROL
+	tristate "video output device switch control"
+	depends on SYSFS
+	---help---
+	  sysfs support for video output device switching.
+
+
 endmenu
 
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index a6980e9..0f82eed 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_FB_OF)               += off
 
 # the test framebuffer is last
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
+obj-$(CONFIG_VIDEO_OUTPUT_CONTROL) += output.o

--Boundary-00=_pDkQFV03sk2Y5qE--
