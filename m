Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVA3Rdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVA3Rdn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 12:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVA3Rdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 12:33:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32271 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261745AbVA3Rcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 12:32:54 -0500
Date: Sun, 30 Jan 2005 18:32:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Len Brown <len.brown@intel.com>
Cc: Alexey Y Starikovskiy <alexey.y.starikovskiy@intel.com>,
       Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: [2.6 patch] drivers/acpi/: make some code static
Message-ID: <20050130173251.GP3185@stusta.de>
References: <20050127110125.GE28047@stusta.de> <1106867060.2400.2297.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106867060.2400.2297.camel@d845pe>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 06:04:20PM -0500, Len Brown wrote:
>...
> At the same time, the non "R. Byron Moore" files, such as those in
> drivers/acpi, but not in the lower sub-directories, are straight GPL and
> I'll be happy to accept patches to those files immediately.  Note that
> there are 4 straight GPL files in include/acpi as well -- so like the
> drivers/acpi/* files, we can modify them any time when cleanups are
> appropriate in the Linux release cycle.

Is the patch below OK?

> thanks,
> -Len

cu
Adrian


<--  snip  -->


This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/acpi/ac.c                   |   18 +++++++++---------
 drivers/acpi/battery.c              |    2 +-
 drivers/acpi/button.c               |    4 ++--
 drivers/acpi/container.c            |    4 ++--
 drivers/acpi/debug.c                |    4 ++--
 drivers/acpi/ec.c                   |    2 +-
 drivers/acpi/fan.c                  |   14 +++++++-------
 drivers/acpi/ibm_acpi.c             |    4 ++--
 drivers/acpi/osl.c                  |   10 +++++-----
 drivers/acpi/pci_irq.c              |    4 ++--
 drivers/acpi/power.c                |   10 +++++-----
 drivers/acpi/processor_core.c       |    6 +++---
 drivers/acpi/processor_thermal.c    |    2 +-
 drivers/acpi/processor_throttling.c |    2 +-
 drivers/acpi/scan.c                 |   12 ++++++++----
 drivers/acpi/thermal.c              |    2 +-
 drivers/acpi/toshiba_acpi.c         |    2 +-
 drivers/acpi/video.c                |    2 +-
 include/acpi/acpi_bus.h             |    1 -
 include/acpi/processor.h            |    2 --
 include/linux/acpi.h                |    2 --
 21 files changed, 54 insertions(+), 55 deletions(-)

--- linux-2.6.11-rc2-mm1-full/drivers/acpi/ac.c.old	2005-01-26 19:55:44.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/ac.c	2005-01-26 19:57:37.000000000 +0100
@@ -51,8 +51,8 @@
 MODULE_DESCRIPTION(ACPI_AC_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-int acpi_ac_add (struct acpi_device *device);
-int acpi_ac_remove (struct acpi_device *device, int type);
+static int acpi_ac_add (struct acpi_device *device);
+static int acpi_ac_remove (struct acpi_device *device, int type);
 static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_ac_driver = {
@@ -108,9 +108,9 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_ac_dir;
+static struct proc_dir_entry	*acpi_ac_dir;
 
-int acpi_ac_seq_show(struct seq_file *seq, void *offset)
+static int acpi_ac_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_ac		*ac = (struct acpi_ac *) seq->private;
 
@@ -200,7 +200,7 @@
                                    Driver Model
    -------------------------------------------------------------------------- */
 
-void
+static void
 acpi_ac_notify (
 	acpi_handle		handle,
 	u32			event,
@@ -232,7 +232,7 @@
 }
 
 
-int
+static int
 acpi_ac_add (
 	struct acpi_device	*device)
 {
@@ -286,7 +286,7 @@
 }
 
 
-int
+static int
 acpi_ac_remove (
 	struct acpi_device	*device,
 	int			type)
@@ -315,7 +315,7 @@
 }
 
 
-int __init
+static int __init
 acpi_ac_init (void)
 {
 	int			result = 0;
@@ -337,7 +337,7 @@
 }
 
 
-void __exit
+static void __exit
 acpi_ac_exit (void)
 {
 	ACPI_FUNCTION_TRACE("acpi_ac_exit");
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/battery.c.old	2005-01-26 19:57:52.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/battery.c	2005-01-26 19:58:07.000000000 +0100
@@ -341,7 +341,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_battery_dir;
+static struct proc_dir_entry	*acpi_battery_dir;
 static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 {
 	int			result = 0;
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/button.c.old	2005-01-26 19:58:24.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/button.c	2005-01-26 19:58:34.000000000 +0100
@@ -275,7 +275,7 @@
                                 Driver Interface
    -------------------------------------------------------------------------- */
 
-void
+static void
 acpi_button_notify (
 	acpi_handle		handle,
 	u32			event,
@@ -302,7 +302,7 @@
 }
 
 
-acpi_status
+static acpi_status
 acpi_button_notify_fixed (
 	void			*data)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/container.c.old	2005-01-26 19:58:51.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/container.c	2005-01-26 19:59:05.000000000 +0100
@@ -255,7 +255,7 @@
 }
 
 
-int __init
+static int __init
 acpi_container_init(void)
 {
 	int	result = 0;
@@ -276,7 +276,7 @@
 	return(0);
 }
 
-void __exit
+static void __exit
 acpi_container_exit(void)
 {
 	int			action = UNINSTALL_NOTIFY_HANDLER;
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/debug.c.old	2005-01-26 19:59:19.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/debug.c	2005-01-26 19:59:33.000000000 +0100
@@ -35,7 +35,7 @@
 };
 #define ACPI_DEBUG_INIT(v)	{ .name = #v, .value = v }
 
-const struct acpi_dlayer acpi_debug_layers[] =
+static const struct acpi_dlayer acpi_debug_layers[] =
 {
 	ACPI_DEBUG_INIT(ACPI_UTILITIES),
 	ACPI_DEBUG_INIT(ACPI_HARDWARE),
@@ -53,7 +53,7 @@
 	ACPI_DEBUG_INIT(ACPI_TOOLS),
 };
 
-const struct acpi_dlevel acpi_debug_levels[] =
+static const struct acpi_dlevel acpi_debug_levels[] =
 {
 	ACPI_DEBUG_INIT(ACPI_LV_ERROR),
 	ACPI_DEBUG_INIT(ACPI_LV_WARN),
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/ec.c.old	2005-01-26 20:05:54.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/ec.c	2005-01-26 20:06:06.000000000 +0100
@@ -514,7 +514,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_ec_dir;
+static struct proc_dir_entry	*acpi_ec_dir;
 
 
 static int
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/fan.c.old	2005-01-26 21:39:11.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/fan.c	2005-01-26 21:40:22.000000000 +0100
@@ -50,8 +50,8 @@
 MODULE_DESCRIPTION(ACPI_FAN_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
-int acpi_fan_add (struct acpi_device *device);
-int acpi_fan_remove (struct acpi_device *device, int type);
+static int acpi_fan_add (struct acpi_device *device);
+static int acpi_fan_remove (struct acpi_device *device, int type);
 
 static struct acpi_driver acpi_fan_driver = {
 	.name =		ACPI_FAN_DRIVER_NAME,
@@ -72,7 +72,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_fan_dir;
+static struct proc_dir_entry	*acpi_fan_dir;
 
 
 static int
@@ -194,7 +194,7 @@
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-int
+static int
 acpi_fan_add (
 	struct acpi_device	*device)
 {
@@ -240,7 +240,7 @@
 }
 
 
-int
+static int
 acpi_fan_remove (
 	struct acpi_device	*device,
 	int			type)
@@ -262,7 +262,7 @@
 }
 
 
-int __init
+static int __init
 acpi_fan_init (void)
 {
 	int			result = 0;
@@ -284,7 +284,7 @@
 }
 
 
-void __exit
+static void __exit
 acpi_fan_exit (void)
 {
 	ACPI_FUNCTION_TRACE("acpi_fan_exit");
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/ibm_acpi.c.old	2005-01-26 21:41:22.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/ibm_acpi.c	2005-01-26 21:42:24.000000000 +0100
@@ -155,7 +155,7 @@
 	int experimental;
 };
 
-struct proc_dir_entry *proc_dir = NULL;
+static struct proc_dir_entry *proc_dir = NULL;
 
 #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
@@ -856,7 +856,7 @@
 	return 0;
 }	
 		
-struct ibm_struct ibms[] = {
+static struct ibm_struct ibms[] = {
 	{
 		.name	= "driver",
 		.init	= driver_init,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/osl.c.old	2005-01-26 21:59:25.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/osl.c	2005-01-26 22:00:15.000000000 +0100
@@ -563,7 +563,7 @@
 }
 
 /* TODO: Change code to take advantage of driver model more */
-void
+static void
 acpi_os_derive_pci_id_2 (
 	acpi_handle		rhandle,        /* upper bound  */
 	acpi_handle		chandle,        /* current node */
@@ -1071,7 +1071,7 @@
 }
 EXPORT_SYMBOL(acpi_os_signal);
 
-int __init
+static int __init
 acpi_os_name_setup(char *str)
 {
 	char *p = acpi_os_name;
@@ -1101,7 +1101,7 @@
  * empty string disables _OSI
  * TBD additional string adds to _OSI
  */
-int __init
+static int __init
 acpi_osi_setup(char *str)
 {
 	if (str == NULL || *str == '\0') {
@@ -1119,7 +1119,7 @@
 __setup("acpi_osi=", acpi_osi_setup);
 
 /* enable serialization to combat AE_ALREADY_EXISTS errors */
-int __init
+static int __init
 acpi_serialize_setup(char *str)
 {
 	printk(KERN_INFO PREFIX "serialize enabled\n");
@@ -1140,7 +1140,7 @@
  * Run-time events on the same GPE this flag is available
  * to tell Linux to keep the wake-time GPEs enabled at run-time.
  */
-int __init
+static int __init
 acpi_wake_gpes_always_on_setup(char *str)
 {
 	printk(KERN_INFO PREFIX "wake GPEs not disabled\n");
--- linux-2.6.11-rc2-mm1-full/include/linux/acpi.h.old	2005-01-26 22:09:31.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/linux/acpi.h	2005-01-26 22:09:44.000000000 +0100
@@ -455,8 +455,6 @@
 	struct list_head	entries;
 };
 
-extern struct acpi_prt_list	acpi_prt;
-
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/pci_irq.c.old	2005-01-26 22:09:52.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/pci_irq.c	2005-01-26 22:10:10.000000000 +0100
@@ -42,8 +42,8 @@
 #define _COMPONENT		ACPI_PCI_COMPONENT
 ACPI_MODULE_NAME		("pci_irq")
 
-struct acpi_prt_list		acpi_prt;
-DEFINE_SPINLOCK(acpi_prt_lock);
+static struct acpi_prt_list	acpi_prt;
+static DEFINE_SPINLOCK(acpi_prt_lock);
 
 /* --------------------------------------------------------------------------
                          PCI IRQ Routing Table (PRT) Support
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/power.c.old	2005-01-26 22:10:27.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/power.c	2005-01-26 22:11:21.000000000 +0100
@@ -58,8 +58,8 @@
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
 
-int acpi_power_add (struct acpi_device *device);
-int acpi_power_remove (struct acpi_device *device, int type);
+static int acpi_power_add (struct acpi_device *device);
+static int acpi_power_remove (struct acpi_device *device, int type);
 static int acpi_power_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_power_driver = {
@@ -479,7 +479,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_power_dir;
+static struct proc_dir_entry	*acpi_power_dir;
 
 static int acpi_power_seq_show(struct seq_file *seq, void *offset)
 {
@@ -576,7 +576,7 @@
                                 Driver Interface
    -------------------------------------------------------------------------- */
 
-int
+static int
 acpi_power_add (
 	struct acpi_device	*device)
 {
@@ -642,7 +642,7 @@
 }
 
 
-int
+static int
 acpi_power_remove (
 	struct acpi_device	*device,
 	int			type)
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_core.c.old	2005-01-26 22:11:36.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_core.c	2005-01-26 22:48:14.000000000 +0100
@@ -105,7 +105,7 @@
 #define UNINSTALL_NOTIFY_HANDLER	2
 
 
-struct file_operations acpi_processor_info_fops = {
+static struct file_operations acpi_processor_info_fops = {
 	.open 		= acpi_processor_info_open_fs,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -121,7 +121,7 @@
                                 Errata Handling
    -------------------------------------------------------------------------- */
 
-int
+static int
 acpi_processor_errata_piix4 (
 	struct pci_dev		*dev)
 {
@@ -259,7 +259,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_processor_dir = NULL;
+static struct proc_dir_entry	*acpi_processor_dir = NULL;
 
 static int acpi_processor_info_seq_show(struct seq_file *seq, void *offset)
 {
--- linux-2.6.11-rc2-mm1-full/include/acpi/processor.h.old	2005-01-26 22:13:23.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/processor.h	2005-01-26 22:14:00.000000000 +0100
@@ -201,7 +201,6 @@
 /* in processor_throttling.c */
 int acpi_processor_get_throttling_info (struct acpi_processor *pr);
 int acpi_processor_set_throttling (struct acpi_processor *pr, int state);
-int acpi_processor_throttling_open_fs(struct inode *inode, struct file *file);
 ssize_t acpi_processor_write_throttling (
         struct file		*file,
         const char		__user *buffer,
@@ -217,7 +216,6 @@
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info (struct acpi_processor *pr);
-int acpi_processor_limit_open_fs(struct inode *inode, struct file *file);
 ssize_t acpi_processor_write_limit (
 	struct file		*file,
 	const char		__user *buffer,
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_thermal.c.old	2005-01-26 22:13:39.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_thermal.c	2005-01-26 22:13:47.000000000 +0100
@@ -345,7 +345,7 @@
 	return_VALUE(0);
 }
 
-int acpi_processor_limit_open_fs(struct inode *inode, struct file *file)
+static int acpi_processor_limit_open_fs(struct inode *inode, struct file *file)
 {
 	return single_open(file, acpi_processor_limit_seq_show,
 						PDE(inode)->data);
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_throttling.c.old	2005-01-26 22:14:14.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/processor_throttling.c	2005-01-26 22:14:19.000000000 +0100
@@ -308,7 +308,7 @@
 	return_VALUE(0);
 }
 
-int acpi_processor_throttling_open_fs(struct inode *inode, struct file *file)
+static int acpi_processor_throttling_open_fs(struct inode *inode, struct file *file)
 {
 	return single_open(file, acpi_processor_throttling_seq_show,
 						PDE(inode)->data);
--- linux-2.6.11-rc2-mm1-full/include/acpi/acpi_bus.h.old	2005-01-26 22:15:33.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/acpi/acpi_bus.h	2005-01-26 22:15:37.000000000 +0100
@@ -328,7 +328,6 @@
 int acpi_bus_register_driver (struct acpi_driver *driver);
 int acpi_bus_unregister_driver (struct acpi_driver *driver);
 int acpi_bus_scan (struct acpi_device *start);
-int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 int acpi_bus_add (struct acpi_device **child, struct acpi_device *parent,
 		acpi_handle handle, int type);
 
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/scan.c.old	2005-01-26 22:14:34.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/scan.c	2005-01-26 22:16:02.000000000 +0100
@@ -27,6 +27,10 @@
 DEFINE_SPINLOCK(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 
+static int
+acpi_bus_trim(struct acpi_device	*start,
+		int rmdevice);
+
 static void acpi_device_release(struct kobject * kobj)
 {
 	struct acpi_device * dev = container_of(kobj,struct acpi_device,kobj);
@@ -849,7 +853,7 @@
 	acpi_os_free(buffer.pointer);
 }
 
-int acpi_device_set_context(struct acpi_device * device, int type)
+static int acpi_device_set_context(struct acpi_device * device, int type)
 {
 	acpi_status status = AE_OK;
 	int result = 0;
@@ -874,7 +878,7 @@
 	return result;
 }
 
-void acpi_device_get_debug_info(struct acpi_device * device, acpi_handle handle, int type)
+static void acpi_device_get_debug_info(struct acpi_device * device, acpi_handle handle, int type)
 {
 #ifdef CONFIG_ACPI_DEBUG_OUTPUT
 	char		*type_string = NULL;
@@ -917,7 +921,7 @@
 }
 
 
-int
+static int
 acpi_bus_remove (
 	struct acpi_device *dev,
 	int rmdevice)
@@ -1215,7 +1219,7 @@
 EXPORT_SYMBOL(acpi_bus_scan);
 
 
-int
+static int
 acpi_bus_trim(struct acpi_device	*start,
 		int rmdevice)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/thermal.c.old	2005-01-26 22:22:43.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/thermal.c	2005-01-26 22:22:54.000000000 +0100
@@ -774,7 +774,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_thermal_dir;
+static struct proc_dir_entry	*acpi_thermal_dir;
 
 static int acpi_thermal_state_seq_show(struct seq_file *seq, void *offset)
 {
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/toshiba_acpi.c.old	2005-01-26 22:23:11.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/toshiba_acpi.c	2005-01-26 22:23:18.000000000 +0100
@@ -481,7 +481,7 @@
 
 #define PROC_TOSHIBA		"toshiba"
 
-ProcItem proc_items[] =
+static ProcItem proc_items[] =
 {
 	{ "lcd"		, read_lcd	, write_lcd	},
 	{ "video"	, read_video	, write_video	},
--- linux-2.6.11-rc2-mm1-full/drivers/acpi/video.c.old	2005-01-26 22:34:56.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/acpi/video.c	2005-01-26 22:35:07.000000000 +0100
@@ -683,7 +683,7 @@
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
 
-struct proc_dir_entry		*acpi_video_dir;
+static struct proc_dir_entry	*acpi_video_dir;
 
 /* video devices */
 


