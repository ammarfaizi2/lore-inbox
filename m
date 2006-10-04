Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWJDVlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWJDVlG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWJDVlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:41:05 -0400
Received: from mga03.intel.com ([143.182.124.21]:1048 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751161AbWJDVlA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:41:00 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,256,1157353200"; 
   d="scan'208"; a="127013880:sNHT73829238"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Cast removal
Date: Wed, 4 Oct 2006 14:40:56 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A40111D341@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Cast removal
Thread-Index: Acbk4A7xqTPUCw8UROOsF7k/09hogwDHXvUA
From: "Moore, Robert" <robert.moore@intel.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>,
       "ACPI List" <linux-acpi@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 04 Oct 2006 21:40:57.0732 (UTC) FILETIME=[C6F4EC40:01C6E7FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the casting stuff is because ACPICA has to support a bunch of
different compilers.



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Jan Engelhardt
> Sent: Saturday, September 30, 2006 3:29 PM
> To: Linux Kernel Mailing List
> Cc: Brown, Len; ACPI List; Andrew Morton
> Subject: [PATCH] Cast removal
> 
> Hello,
> 
> 
> enclosed is a patch that does...
> 
> Remove unnecessary from/to-void* and to-void (which is really
> anachronistic) casts. I wonder why the ACPI code is still full of
them.
> GCC should have an option to forbid casting in places where the
absence
> of a cast does not produce a warning.
> 
> Also, the acpi code uses {} in single-statement if()s.
> 
> Some places now read a = acpi_driver_data(x); kfree(a); maybe
> these could be consolidated into kfree(acpi_driver_data(x));
> 
> I am also seeing kmalloc+memset -> kzalloc potential.
> 
> But these last three will be addressed in another patch another
> day, and probably by someone else.
> 
> 
> --
> 
> Remove unnecessary from/to-void* and to-void casts in drivers/acpi/.
> 
> Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
> 
> Index: linux-2.6.18/drivers/acpi/ac.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/ac.c
> +++ linux-2.6.18/drivers/acpi/ac.c
> @@ -109,7 +109,7 @@ static struct proc_dir_entry *acpi_ac_di
> 
>  static int acpi_ac_seq_show(struct seq_file *seq, void *offset)
>  {
> -	struct acpi_ac *ac = (struct acpi_ac *)seq->private;
> +	struct acpi_ac *ac = seq->private;
> 
> 
>  	if (!ac)
> @@ -187,7 +187,7 @@ static int acpi_ac_remove_fs(struct acpi
> 
>  static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct acpi_ac *ac = (struct acpi_ac *)data;
> +	struct acpi_ac *ac = data;
>  	struct acpi_device *device = NULL;
> 
> 
> @@ -269,7 +269,7 @@ static int acpi_ac_remove(struct acpi_de
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	ac = (struct acpi_ac *)acpi_driver_data(device);
> +	ac = acpi_driver_data(device);
> 
>  	status = acpi_remove_notify_handler(device->handle,
>  					    ACPI_ALL_NOTIFY,
acpi_ac_notify);
> Index: linux-2.6.18/drivers/acpi/acpi_memhotplug.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/acpi_memhotplug.c
> +++ linux-2.6.18/drivers/acpi/acpi_memhotplug.c
> @@ -423,7 +423,7 @@ static int acpi_memory_device_remove(str
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	mem_device = (struct acpi_memory_device
*)acpi_driver_data(device);
> +	mem_device = acpi_driver_data(device);
>  	kfree(mem_device);
> 
>  	return 0;
> Index: linux-2.6.18/drivers/acpi/asus_acpi.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/asus_acpi.c
> +++ linux-2.6.18/drivers/acpi/asus_acpi.c
> @@ -1128,7 +1128,7 @@ static int asus_hotk_get_info(void)
>  	if (ACPI_FAILURE(status))
>  		printk(KERN_WARNING "  Couldn't get the DSDT table
header\n");
>  	else
> -		asus_info = (struct acpi_table_header *)dsdt.pointer;
> +		asus_info = dsdt.pointer;
> 
>  	/* We have to write 0 on init this far for all ASUS models */
>  	if (!write_acpi_int(hotk->handle, "INIT", 0, &buffer)) {
> @@ -1150,7 +1150,7 @@ static int asus_hotk_get_info(void)
>  	 * asus_model_match() and try something completely different.
>  	 */
>  	if (buffer.pointer) {
> -		model = (union acpi_object *)buffer.pointer;
> +		model = buffer.pointer;
>  		switch (model->type) {
>  		case ACPI_TYPE_STRING:
>  			string = model->string.pointer;
> @@ -1245,8 +1245,7 @@ static int asus_hotk_add(struct acpi_dev
>  	printk(KERN_NOTICE "Asus Laptop ACPI Extras version %s\n",
>  	       ASUS_ACPI_VERSION);
> 
> -	hotk =
> -	    (struct asus_hotk *)kmalloc(sizeof(struct asus_hotk),
> GFP_KERNEL);
> +	hotk = kmalloc(sizeof(struct asus_hotk), GFP_KERNEL);
>  	if (!hotk)
>  		return -ENOMEM;
>  	memset(hotk, 0, sizeof(struct asus_hotk));
> Index: linux-2.6.18/drivers/acpi/battery.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/battery.c
> +++ linux-2.6.18/drivers/acpi/battery.c
> @@ -147,7 +147,7 @@ acpi_battery_get_info(struct acpi_batter
>  		return -ENODEV;
>  	}
> 
> -	package = (union acpi_object *)buffer.pointer;
> +	package = buffer.pointer;
> 
>  	/* Extract Package Data */
> 
> @@ -177,7 +177,7 @@ acpi_battery_get_info(struct acpi_batter
>  	kfree(buffer.pointer);
> 
>  	if (!result)
> -		(*bif) = (struct acpi_battery_info *)data.pointer;
> +		(*bif) = data.pointer;
> 
>  	return result;
>  }
> @@ -207,7 +207,7 @@ acpi_battery_get_status(struct acpi_batt
>  		return -ENODEV;
>  	}
> 
> -	package = (union acpi_object *)buffer.pointer;
> +	package = buffer.pointer;
> 
>  	/* Extract Package Data */
> 
> @@ -237,7 +237,7 @@ acpi_battery_get_status(struct acpi_batt
>  	kfree(buffer.pointer);
> 
>  	if (!result)
> -		(*bst) = (struct acpi_battery_status *)data.pointer;
> +		(*bst) = data.pointer;
> 
>  	return result;
>  }
> @@ -332,7 +332,7 @@ static struct proc_dir_entry *acpi_batte
>  static int acpi_battery_read_info(struct seq_file *seq, void *offset)
>  {
>  	int result = 0;
> -	struct acpi_battery *battery = (struct acpi_battery
*)seq->private;
> +	struct acpi_battery *battery = seq->private;
>  	struct acpi_battery_info *bif = NULL;
>  	char *units = "?";
> 
> @@ -416,7 +416,7 @@ static int acpi_battery_info_open_fs(str
>  static int acpi_battery_read_state(struct seq_file *seq, void
*offset)
>  {
>  	int result = 0;
> -	struct acpi_battery *battery = (struct acpi_battery
*)seq->private;
> +	struct acpi_battery *battery = seq->private;
>  	struct acpi_battery_status *bst = NULL;
>  	char *units = "?";
> 
> @@ -492,7 +492,7 @@ static int acpi_battery_state_open_fs(st
> 
>  static int acpi_battery_read_alarm(struct seq_file *seq, void
*offset)
>  {
> -	struct acpi_battery *battery = (struct acpi_battery
*)seq->private;
> +	struct acpi_battery *battery = seq->private;
>  	char *units = "?";
> 
> 
> @@ -529,8 +529,8 @@ acpi_battery_write_alarm(struct file *fi
>  {
>  	int result = 0;
>  	char alarm_string[12] = { '\0' };
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_battery *battery = (struct acpi_battery
*)m->private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_battery *battery = m->private;
> 
> 
>  	if (!battery || (count > sizeof(alarm_string) - 1))
> @@ -656,7 +656,7 @@ static int acpi_battery_remove_fs(struct
> 
>  static void acpi_battery_notify(acpi_handle handle, u32 event, void
> *data)
>  {
> -	struct acpi_battery *battery = (struct acpi_battery *)data;
> +	struct acpi_battery *battery = data;
>  	struct acpi_device *device = NULL;
> 
> 
> @@ -740,7 +740,7 @@ static int acpi_battery_remove(struct ac
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	battery = (struct acpi_battery *)acpi_driver_data(device);
> +	battery = acpi_driver_data(device);
> 
>  	status = acpi_remove_notify_handler(device->handle,
>  					    ACPI_ALL_NOTIFY,
> Index: linux-2.6.18/drivers/acpi/button.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/button.c
> +++ linux-2.6.18/drivers/acpi/button.c
> @@ -109,7 +109,7 @@ static struct proc_dir_entry *acpi_butto
> 
>  static int acpi_button_info_seq_show(struct seq_file *seq, void
*offset)
>  {
> -	struct acpi_button *button = (struct acpi_button *)seq->private;
> +	struct acpi_button *button = seq->private;
> 
> 
>  	if (!button || !button->device)
> @@ -128,7 +128,7 @@ static int acpi_button_info_open_fs(stru
> 
>  static int acpi_button_state_seq_show(struct seq_file *seq, void
*offset)
>  {
> -	struct acpi_button *button = (struct acpi_button *)seq->private;
> +	struct acpi_button *button = seq->private;
>  	acpi_status status;
>  	unsigned long state;
> 
> @@ -253,7 +253,7 @@ static int acpi_button_remove_fs(struct
> 
>  static void acpi_button_notify(acpi_handle handle, u32 event, void
*data)
>  {
> -	struct acpi_button *button = (struct acpi_button *)data;
> +	struct acpi_button *button = data;
> 
> 
>  	if (!button || !button->device)
> @@ -275,7 +275,7 @@ static void acpi_button_notify(acpi_hand
> 
>  static acpi_status acpi_button_notify_fixed(void *data)
>  {
> -	struct acpi_button *button = (struct acpi_button *)data;
> +	struct acpi_button *button = data;
> 
> 
>  	if (!button)
> Index: linux-2.6.18/drivers/acpi/container.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/container.c
> +++ linux-2.6.18/drivers/acpi/container.c
> @@ -117,7 +117,7 @@ static int acpi_container_remove(struct
>  	acpi_status status = AE_OK;
>  	struct acpi_container *pc = NULL;
> 
> -	pc = (struct acpi_container *)acpi_driver_data(device);
> +	pc = acpi_driver_data(device);
>  	kfree(pc);
>  	return status;
>  }
> Index: linux-2.6.18/drivers/acpi/dock.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/dock.c
> +++ linux-2.6.18/drivers/acpi/dock.c
> @@ -524,7 +524,7 @@ EXPORT_SYMBOL_GPL(unregister_hotplug_doc
>   */
>  static void dock_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct dock_station *ds = (struct dock_station *)data;
> +	struct dock_station *ds = data;
> 
>  	switch (event) {
>  	case ACPI_NOTIFY_BUS_CHECK:
> @@ -587,7 +587,7 @@ find_dock_devices(acpi_handle handle, u3
>  {
>  	acpi_status status;
>  	acpi_handle tmp;
> -	struct dock_station *ds = (struct dock_station *)context;
> +	struct dock_station *ds = context;
>  	struct dock_dependent_device *dd;
> 
>  	status = acpi_bus_get_ejd(handle, &tmp);
> @@ -702,7 +702,7 @@ static int dock_remove(void)
>  static acpi_status
>  find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
>  {
> -	int *count = (int *)context;
> +	int *count = context;
>  	acpi_status status = AE_OK;
> 
>  	if (is_dock(handle)) {
> Index: linux-2.6.18/drivers/acpi/ec.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/ec.c
> +++ linux-2.6.18/drivers/acpi/ec.c
> @@ -716,7 +716,7 @@ static void acpi_ec_gpe_poll_query(void
>  }
>  static void acpi_ec_gpe_intr_query(void *ec_cxt)
>  {
> -	union acpi_ec *ec = (union acpi_ec *)ec_cxt;
> +	union acpi_ec *ec = ec_cxt;
>  	u32 value;
>  	int result = -ENODATA;
>  	static char object_name[5] = { '_', 'Q', '0', '0', '\0' };
> @@ -752,7 +752,7 @@ static u32 acpi_ec_gpe_handler(void *dat
>  static u32 acpi_ec_gpe_poll_handler(void *data)
>  {
>  	acpi_status status = AE_OK;
> -	union acpi_ec *ec = (union acpi_ec *)data;
> +	union acpi_ec *ec = data;
> 
>  	if (!ec)
>  		return ACPI_INTERRUPT_NOT_HANDLED;
> @@ -770,7 +770,7 @@ static u32 acpi_ec_gpe_intr_handler(void
>  {
>  	acpi_status status = AE_OK;
>  	u32 value;
> -	union acpi_ec *ec = (union acpi_ec *)data;
> +	union acpi_ec *ec = data;
> 
>  	if (!ec)
>  		return ACPI_INTERRUPT_NOT_HANDLED;
> @@ -848,7 +848,7 @@ acpi_ec_space_handler(u32 function,
>  		return AE_BAD_PARAMETER;
>  	}
> 
> -	ec = (union acpi_ec *)handler_context;
> +	ec = handler_context;
> 
>        next_byte:
>  	switch (function) {
> @@ -905,7 +905,7 @@ static struct proc_dir_entry *acpi_ec_di
> 
>  static int acpi_ec_read_info(struct seq_file *seq, void *offset)
>  {
> -	union acpi_ec *ec = (union acpi_ec *)seq->private;
> +	union acpi_ec *ec = seq->private;
> 
> 
>  	if (!ec)
> @@ -1136,7 +1136,7 @@ static int acpi_ec_remove(struct acpi_de
>  static acpi_status
>  acpi_ec_io_ports(struct acpi_resource *resource, void *context)
>  {
> -	union acpi_ec *ec = (union acpi_ec *)context;
> +	union acpi_ec *ec = context;
>  	struct acpi_generic_address *addr;
> 
>  	if (resource->type != ACPI_RESOURCE_TYPE_IO) {
> Index: linux-2.6.18/drivers/acpi/fan.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/fan.c
> +++ linux-2.6.18/drivers/acpi/fan.c
> @@ -99,8 +99,8 @@ acpi_fan_write_state(struct file *file,
>  		     size_t count, loff_t * ppos)
>  {
>  	int result = 0;
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_fan *fan = (struct acpi_fan *)m->private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_fan *fan = m->private;
>  	char state_string[12] = { '\0' };
> 
> 
> @@ -229,7 +229,7 @@ static int acpi_fan_remove(struct acpi_d
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	fan = (struct acpi_fan *)acpi_driver_data(device);
> +	fan = acpi_driver_data(device);
> 
>  	acpi_fan_remove_fs(device);
> 
> Index: linux-2.6.18/drivers/acpi/glue.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/glue.c
> +++ linux-2.6.18/drivers/acpi/glue.c
> @@ -96,7 +96,7 @@ struct acpi_find_pci_root {
>  static acpi_status
>  do_root_bridge_busnr_callback(struct acpi_resource *resource, void
*data)
>  {
> -	unsigned long *busnr = (unsigned long *)data;
> +	unsigned long *busnr = data;
>  	struct acpi_resource_address64 address;
> 
>  	if (resource->type != ACPI_RESOURCE_TYPE_ADDRESS16 &&
> @@ -217,7 +217,7 @@ do_acpi_find_child(acpi_handle handle, u
>  	acpi_status status;
>  	struct acpi_device_info *info;
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> -	struct acpi_find_child *find = (struct acpi_find_child
*)context;
> +	struct acpi_find_child *find = context;
> 
>  	status = acpi_get_object_info(handle, &buffer);
>  	if (ACPI_SUCCESS(status)) {
> Index: linux-2.6.18/drivers/acpi/hotkey.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/hotkey.c
> +++ linux-2.6.18/drivers/acpi/hotkey.c
> @@ -265,8 +265,7 @@ static char *format_result(union acpi_ob
> 
>  static int hotkey_polling_seq_show(struct seq_file *seq, void
*offset)
>  {
> -	struct acpi_polling_hotkey *poll_hotkey =
> -	    (struct acpi_polling_hotkey *)seq->private;
> +	struct acpi_polling_hotkey *poll_hotkey = seq->private;
>  	char *buf;
> 
> 
> @@ -577,7 +576,7 @@ init_poll_hotkey_device(union acpi_hotke
>  	if (ACPI_FAILURE(status))
>  		goto do_fail_zero;
>  	key->poll_hotkey.poll_result =
> -	    (union acpi_object *)kmalloc(sizeof(union acpi_object),
> GFP_KERNEL);
> +	    kmalloc(sizeof(union acpi_object), GFP_KERNEL);
>  	if (!key->poll_hotkey.poll_result)
>  		goto do_fail_zero;
>  	return AE_OK;
> Index: linux-2.6.18/drivers/acpi/i2c_ec.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/i2c_ec.c
> +++ linux-2.6.18/drivers/acpi/i2c_ec.c
> @@ -393,7 +393,7 @@ static void __exit acpi_ec_hc_exit(void)
> 
>  struct acpi_ec_hc *acpi_get_ec_hc(struct acpi_device *device)
>  {
> -	return ((struct acpi_ec_hc *)acpi_driver_data(device->parent));
> +	return acpi_driver_data(device->parent);
>  }
> 
>  EXPORT_SYMBOL(acpi_get_ec_hc);
> Index: linux-2.6.18/drivers/acpi/ibm_acpi.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/ibm_acpi.c
> +++ linux-2.6.18/drivers/acpi/ibm_acpi.c
> @@ -1721,7 +1721,7 @@ static struct ibm_struct ibms[] = {
>  static int dispatch_read(char *page, char **start, off_t off, int
count,
>  			 int *eof, void *data)
>  {
> -	struct ibm_struct *ibm = (struct ibm_struct *)data;
> +	struct ibm_struct *ibm = data;
>  	int len;
> 
>  	if (!ibm || !ibm->read)
> @@ -1746,7 +1746,7 @@ static int dispatch_read(char *page, cha
>  static int dispatch_write(struct file *file, const char __user *
userbuf,
>  			  unsigned long count, void *data)
>  {
> -	struct ibm_struct *ibm = (struct ibm_struct *)data;
> +	struct ibm_struct *ibm = data;
>  	char *kernbuf;
>  	int ret;
> 
> @@ -1775,7 +1775,7 @@ static int dispatch_write(struct file *f
> 
>  static void dispatch_notify(acpi_handle handle, u32 event, void
*data)
>  {
> -	struct ibm_struct *ibm = (struct ibm_struct *)data;
> +	struct ibm_struct *ibm = data;
> 
>  	if (!ibm || !ibm->notify)
>  		return;
> Index: linux-2.6.18/drivers/acpi/numa.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/numa.c
> +++ linux-2.6.18/drivers/acpi/numa.c
> @@ -248,7 +248,7 @@ int acpi_get_pxm(acpi_handle h)
>  		handle = phandle;
>  		status = acpi_evaluate_integer(handle, "_PXM", NULL,
&pxm);
>  		if (ACPI_SUCCESS(status))
> -			return (int)pxm;
> +			return pxm;
>  		status = acpi_get_parent(handle, &phandle);
>  	} while (ACPI_SUCCESS(status));
>  	return -1;
> Index: linux-2.6.18/drivers/acpi/osl.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/osl.c
> +++ linux-2.6.18/drivers/acpi/osl.c
> @@ -569,7 +569,7 @@ static void acpi_os_execute_deferred(voi
>  	struct acpi_os_dpc *dpc = NULL;
> 
> 
> -	dpc = (struct acpi_os_dpc *)context;
> +	dpc = context;
>  	if (!dpc) {
>  		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
>  		return;
> @@ -1060,7 +1060,7 @@ acpi_os_create_cache(char *name, u16 siz
> 
>  acpi_status acpi_os_purge_cache(acpi_cache_t * cache)
>  {
> -	(void)kmem_cache_shrink(cache);
> +	kmem_cache_shrink(cache);
>  	return (AE_OK);
>  }
> 
> @@ -1079,7 +1079,7 @@ acpi_status acpi_os_purge_cache(acpi_cac
> 
>  acpi_status acpi_os_delete_cache(acpi_cache_t * cache)
>  {
> -	(void)kmem_cache_destroy(cache);
> +	kmem_cache_destroy(cache);
>  	return (AE_OK);
>  }
> 
> Index: linux-2.6.18/drivers/acpi/pci_bind.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/pci_bind.c
> +++ linux-2.6.18/drivers/acpi/pci_bind.c
> @@ -281,7 +281,7 @@ int acpi_pci_unbind(struct acpi_device *
>  	if (!device || !device->parent)
>  		return -EINVAL;
> 
> -	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
> +	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
>  	if (!pathname)
>  		return -ENOMEM;
>  	memset(pathname, 0, ACPI_PATHNAME_MAX);
> @@ -332,7 +332,7 @@ acpi_pci_bind_root(struct acpi_device *d
>  	struct acpi_buffer buffer = { 0, NULL };
> 
> 
> -	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
> +	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
>  	if (!pathname)
>  		return -ENOMEM;
>  	memset(pathname, 0, ACPI_PATHNAME_MAX);
> Index: linux-2.6.18/drivers/acpi/pci_irq.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/pci_irq.c
> +++ linux-2.6.18/drivers/acpi/pci_irq.c
> @@ -161,7 +161,7 @@ int acpi_pci_irq_add_prt(acpi_handle han
>  	static int first_time = 1;
> 
> 
> -	pathname = (char *)kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
> +	pathname = kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
>  	if (!pathname)
>  		return -ENOMEM;
>  	memset(pathname, 0, ACPI_PATHNAME_MAX);
> Index: linux-2.6.18/drivers/acpi/pci_link.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/pci_link.c
> +++ linux-2.6.18/drivers/acpi/pci_link.c
> @@ -103,7 +103,7 @@ DEFINE_MUTEX(acpi_link_lock);
>  static acpi_status
>  acpi_pci_link_check_possible(struct acpi_resource *resource, void
> *context)
>  {
> -	struct acpi_pci_link *link = (struct acpi_pci_link *)context;
> +	struct acpi_pci_link *link = context;
>  	u32 i = 0;
> 
> 
> @@ -613,7 +613,7 @@ acpi_pci_link_allocate_irq(acpi_handle h
>  		return -1;
>  	}
> 
> -	link = (struct acpi_pci_link *)acpi_driver_data(device);
> +	link = acpi_driver_data(device);
>  	if (!link) {
>  		printk(KERN_ERR PREFIX "Invalid link context\n");
>  		return -1;
> @@ -668,7 +668,7 @@ int acpi_pci_link_free_irq(acpi_handle h
>  		return -1;
>  	}
> 
> -	link = (struct acpi_pci_link *)acpi_driver_data(device);
> +	link = acpi_driver_data(device);
>  	if (!link) {
>  		printk(KERN_ERR PREFIX "Invalid link context\n");
>  		return -1;
> @@ -808,7 +808,7 @@ static int acpi_pci_link_remove(struct a
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	link = (struct acpi_pci_link *)acpi_driver_data(device);
> +	link = acpi_driver_data(device);
> 
>  	mutex_lock(&acpi_link_lock);
>  	list_del(&link->node);
> Index: linux-2.6.18/drivers/acpi/pci_root.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/pci_root.c
> +++ linux-2.6.18/drivers/acpi/pci_root.c
> @@ -119,7 +119,7 @@ EXPORT_SYMBOL(acpi_pci_unregister_driver
>  static acpi_status
>  get_root_bridge_busnr_callback(struct acpi_resource *resource, void
> *data)
>  {
> -	int *busnr = (int *)data;
> +	int *busnr = data;
>  	struct acpi_resource_address64 address;
> 
>  	if (resource->type != ACPI_RESOURCE_TYPE_ADDRESS16 &&
> @@ -331,7 +331,7 @@ static int acpi_pci_root_remove(struct a
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	root = (struct acpi_pci_root *)acpi_driver_data(device);
> +	root = acpi_driver_data(device);
> 
>  	kfree(root);
> 
> Index: linux-2.6.18/drivers/acpi/power.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/power.c
> +++ linux-2.6.18/drivers/acpi/power.c
> @@ -108,7 +108,7 @@ acpi_power_get_context(acpi_handle handl
>  		return result;
>  	}
> 
> -	*resource = (struct acpi_power_resource
*)acpi_driver_data(device);
> +	*resource = acpi_driver_data(device);
>  	if (!resource)
>  		return -ENODEV;
> 
> @@ -445,7 +445,7 @@ static int acpi_power_seq_show(struct se
>  	struct acpi_power_resource *resource = NULL;
> 
> 
> -	resource = (struct acpi_power_resource *)seq->private;
> +	resource = seq->private;
> 
>  	if (!resource)
>  		goto end;
> @@ -593,7 +593,7 @@ static int acpi_power_remove(struct acpi
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	resource = (struct acpi_power_resource
*)acpi_driver_data(device);
> +	resource = acpi_driver_data(device);
> 
>  	acpi_power_remove_fs(device);
> 
> Index: linux-2.6.18/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/processor_core.c
> +++ linux-2.6.18/drivers/acpi/processor_core.c
> @@ -277,7 +277,7 @@ static struct proc_dir_entry *acpi_proce
> 
>  static int acpi_processor_info_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_processor *pr = (struct acpi_processor
*)seq->private;
> +	struct acpi_processor *pr = seq->private;
> 
> 
>  	if (!pr)
> @@ -542,12 +542,12 @@ static int acpi_processor_start(struct a
>  	 * Don't trust it blindly
>  	 */
>  	if (processor_device_array[pr->id] != NULL &&
> -	    processor_device_array[pr->id] != (void *)device) {
> +	    processor_device_array[pr->id] != device) {
>  		printk(KERN_WARNING "BIOS reported wrong ACPI id"
>  			"for the processor\n");
>  		return -ENODEV;
>  	}
> -	processor_device_array[pr->id] = (void *)device;
> +	processor_device_array[pr->id] = device;
> 
>  	processors[pr->id] = pr;
> 
> @@ -578,7 +578,7 @@ static int acpi_processor_start(struct a
> 
>  static void acpi_processor_notify(acpi_handle handle, u32 event, void
> *data)
>  {
> -	struct acpi_processor *pr = (struct acpi_processor *)data;
> +	struct acpi_processor *pr = data;
>  	struct acpi_device *device = NULL;
> 
> 
> @@ -637,7 +637,7 @@ static int acpi_processor_remove(struct
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	pr = (struct acpi_processor *)acpi_driver_data(device);
> +	pr = acpi_driver_data(device);
> 
>  	if (pr->id >= NR_CPUS) {
>  		kfree(pr);
> Index: linux-2.6.18/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/processor_idle.c
> +++ linux-2.6.18/drivers/acpi/processor_idle.c
> @@ -667,7 +667,7 @@ static int acpi_processor_get_power_info
>  		return -ENODEV;
>  	}
> 
> -	cst = (union acpi_object *)buffer.pointer;
> +	cst = buffer.pointer;
> 
>  	/* There must be at least 2 elements */
>  	if (!cst || (cst->type != ACPI_TYPE_PACKAGE) ||
cst->package.count <
> 2) {
> @@ -696,14 +696,14 @@ static int acpi_processor_get_power_info
> 
>  		memset(&cx, 0, sizeof(cx));
> 
> -		element = (union acpi_object
*)&(cst->package.elements[i]);
> +		element = &(cst->package.elements[i]);
>  		if (element->type != ACPI_TYPE_PACKAGE)
>  			continue;
> 
>  		if (element->package.count != 4)
>  			continue;
> 
> -		obj = (union acpi_object
*)&(element->package.elements[0]);
> +		obj = &(element->package.elements[0]);
> 
>  		if (obj->type != ACPI_TYPE_BUFFER)
>  			continue;
> @@ -718,7 +718,7 @@ static int acpi_processor_get_power_info
>  		    0 : reg->address;
> 
>  		/* There should be an easy way to extract an integer...
*/
> -		obj = (union acpi_object
*)&(element->package.elements[1]);
> +		obj = &(element->package.elements[1]);
>  		if (obj->type != ACPI_TYPE_INTEGER)
>  			continue;
> 
> @@ -731,13 +731,13 @@ static int acpi_processor_get_power_info
>  		if ((cx.type < ACPI_STATE_C2) || (cx.type >
ACPI_STATE_C3))
>  			continue;
> 
> -		obj = (union acpi_object
*)&(element->package.elements[2]);
> +		obj = &(element->package.elements[2]);
>  		if (obj->type != ACPI_TYPE_INTEGER)
>  			continue;
> 
>  		cx.latency = obj->integer.value;
> 
> -		obj = (union acpi_object
*)&(element->package.elements[3]);
> +		obj = &(element->package.elements[3]);
>  		if (obj->type != ACPI_TYPE_INTEGER)
>  			continue;
> 
> @@ -1000,7 +1000,7 @@ int acpi_processor_cst_has_changed(struc
> 
>  static int acpi_processor_power_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_processor *pr = (struct acpi_processor
*)seq->private;
> +	struct acpi_processor *pr = seq->private;
>  	unsigned int i;
> 
> 
> Index: linux-2.6.18/drivers/acpi/processor_perflib.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/processor_perflib.c
> +++ linux-2.6.18/drivers/acpi/processor_perflib.c
> @@ -238,7 +238,7 @@ static int acpi_processor_get_performanc
>  		return -ENODEV;
>  	}
> 
> -	pss = (union acpi_object *)buffer.pointer;
> +	pss = buffer.pointer;
>  	if (!pss || (pss->type != ACPI_TYPE_PACKAGE)) {
>  		printk(KERN_ERR PREFIX "Invalid _PSS data\n");
>  		result = -EFAULT;
> @@ -412,7 +412,7 @@ static struct file_operations acpi_proce
> 
>  static int acpi_processor_perf_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_processor *pr = (struct acpi_processor
*)seq->private;
> +	struct acpi_processor *pr = seq->private;
>  	int i;
> 
> 
> @@ -453,8 +453,8 @@ acpi_processor_write_performance(struct
>  				 size_t count, loff_t * data)
>  {
>  	int result = 0;
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_processor *pr = (struct acpi_processor *)m->private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_processor *pr = m->private;
>  	struct acpi_processor_performance *perf;
>  	char state_string[12] = { '\0' };
>  	unsigned int new_state = 0;
> @@ -553,7 +553,7 @@ static int acpi_processor_get_psd(struct
>  		return -ENODEV;
>  	}
> 
> -	psd = (union acpi_object *) buffer.pointer;
> +	psd = buffer.pointer;
>  	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD
data\n"));
>  		result = -EFAULT;
> Index: linux-2.6.18/drivers/acpi/processor_thermal.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/processor_thermal.c
> +++ linux-2.6.18/drivers/acpi/processor_thermal.c
> @@ -208,7 +208,7 @@ int acpi_processor_set_thermal_limit(acp
>  	if (result)
>  		return result;
> 
> -	pr = (struct acpi_processor *)acpi_driver_data(device);
> +	pr = acpi_driver_data(device);
>  	if (!pr)
>  		return -ENODEV;
> 
> @@ -348,8 +348,8 @@ static ssize_t acpi_processor_write_limi
>  					  size_t count, loff_t * data)
>  {
>  	int result = 0;
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_processor *pr = (struct acpi_processor *)m->private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_processor *pr = m->private;
>  	char limit_string[25] = { '\0' };
>  	int px = 0;
>  	int tx = 0;
> Index: linux-2.6.18/drivers/acpi/processor_throttling.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/processor_throttling.c
> +++ linux-2.6.18/drivers/acpi/processor_throttling.c
> @@ -259,7 +259,7 @@ int acpi_processor_get_throttling_info(s
>  static int acpi_processor_throttling_seq_show(struct seq_file *seq,
>  					      void *offset)
>  {
> -	struct acpi_processor *pr = (struct acpi_processor
*)seq->private;
> +	struct acpi_processor *pr = seq->private;
>  	int i = 0;
>  	int result = 0;
> 
> @@ -307,8 +307,8 @@ static ssize_t acpi_processor_write_thro
>  					       size_t count, loff_t *
data)
>  {
>  	int result = 0;
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_processor *pr = (struct acpi_processor *)m->private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_processor *pr = m->private;
>  	char state_string[12] = { '\0' };
> 
> 
> Index: linux-2.6.18/drivers/acpi/sbs.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/sbs.c
> +++ linux-2.6.18/drivers/acpi/sbs.c
> @@ -923,7 +923,7 @@ static struct proc_dir_entry *acpi_batte
> 
>  static int acpi_battery_read_info(struct seq_file *seq, void *offset)
>  {
> -	struct acpi_battery *battery = (struct acpi_battery
*)seq->private;
> +	struct acpi_battery *battery = seq->private;
>  	int cscale;
>  	int result = 0;
> 
> @@ -1076,7 +1076,7 @@ static int acpi_battery_state_open_fs(st
> 
>  static int acpi_battery_read_alarm(struct seq_file *seq, void
*offset)
>  {
> -	struct acpi_battery *battery = (struct acpi_battery
*)seq->private;
> +	struct acpi_battery *battery = seq->private;
>  	int result = 0;
>  	int cscale;
> 
> @@ -1125,8 +1125,8 @@ static ssize_t
>  acpi_battery_write_alarm(struct file *file, const char __user *
buffer,
>  			 size_t count, loff_t * ppos)
>  {
> -	struct seq_file *seq = (struct seq_file *)file->private_data;
> -	struct acpi_battery *battery = (struct acpi_battery
*)seq->private;
> +	struct seq_file *seq = file->private_data;
> +	struct acpi_battery *battery = seq->private;
>  	char alarm_string[12] = { '\0' };
>  	int result, old_alarm, new_alarm;
> 
> @@ -1160,14 +1160,14 @@ acpi_battery_write_alarm(struct file *fi
>  	if (result) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>  				  "acpi_battery_set_alarm() failed\n"));
> -		(void)acpi_battery_set_alarm(battery, old_alarm);
> +		acpi_battery_set_alarm(battery, old_alarm);
>  		goto end;
>  	}
>  	result = acpi_battery_get_alarm(battery);
>  	if (result) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>  				  "acpi_battery_get_alarm() failed\n"));
> -		(void)acpi_battery_set_alarm(battery, old_alarm);
> +		acpi_battery_set_alarm(battery, old_alarm);
>  		goto end;
>  	}
> 
> @@ -1217,7 +1217,7 @@ static struct proc_dir_entry *acpi_ac_di
> 
>  static int acpi_ac_read_state(struct seq_file *seq, void *offset)
>  {
> -	struct acpi_sbs *sbs = (struct acpi_sbs *)seq->private;
> +	struct acpi_sbs *sbs = seq->private;
>  	int result;
> 
>  	if (sbs->zombie) {
> @@ -1302,7 +1302,7 @@ static int acpi_battery_add(struct acpi_
>  		battery->init_state = 1;
>  	}
> 
> -	(void)sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
> +	sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
> 
>  	result = acpi_sbs_generic_add_fs(&battery->battery_entry,
>  					 acpi_battery_dir,
> @@ -1485,7 +1485,7 @@ static int acpi_sbs_update_run(struct ac
>  		}
> 
>  		if (old_battery_present != new_battery_present) {
> -			(void)sprintf(dir_name, ACPI_BATTERY_DIR_NAME,
id);
> +			sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
>  			result = acpi_sbs_generate_event(sbs->device,
>
ACPI_SBS_BATTERY_NOTIFY_STATUS,
>
new_battery_present,
> @@ -1498,7 +1498,7 @@ static int acpi_sbs_update_run(struct ac
>  			}
>  		}
>  		if (old_remaining_capacity != battery-
> >state.remaining_capacity) {
> -			(void)sprintf(dir_name, ACPI_BATTERY_DIR_NAME,
id);
> +			sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
>  			result = acpi_sbs_generate_event(sbs->device,
>
ACPI_SBS_BATTERY_NOTIFY_STATUS,
>
new_battery_present,
> @@ -1659,7 +1659,7 @@ static int acpi_sbs_add(struct acpi_devi
>  	init_timer(&sbs->update_timer);
>  	if (update_mode == QUEUE_UPDATE_MODE) {
>  		status = acpi_os_execute(OSL_GPE_HANDLER,
> -					 acpi_sbs_update_queue, (void
*)sbs);
> +					 acpi_sbs_update_queue, sbs);
>  		if (status != AE_OK) {
>  			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
>  					  "acpi_os_execute()
failed\n"));
> @@ -1685,7 +1685,7 @@ static int acpi_sbs_add(struct acpi_devi
> 
>  int acpi_sbs_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_sbs *sbs = (struct acpi_sbs
*)acpi_driver_data(device);
> +	struct acpi_sbs *sbs = acpi_driver_data(device);
>  	int id;
> 
>  	if (!device || !sbs) {
> Index: linux-2.6.18/drivers/acpi/tables.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/tables.c
> +++ linux-2.6.18/drivers/acpi/tables.c
> @@ -228,7 +228,7 @@ void acpi_table_print_madt_entry(acpi_ta
>  static int
>  acpi_table_compute_checksum(void *table_pointer, unsigned long
length)
>  {
> -	u8 *p = (u8 *) table_pointer;
> +	u8 *p = table_pointer;
>  	unsigned long remains = length;
>  	unsigned long sum = 0;
> 
> Index: linux-2.6.18/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/thermal.c
> +++ linux-2.6.18/drivers/acpi/thermal.c
> @@ -663,7 +663,7 @@ static void acpi_thermal_run(unsigned lo
>  static void acpi_thermal_check(void *data)
>  {
>  	int result = 0;
> -	struct acpi_thermal *tz = (struct acpi_thermal *)data;
> +	struct acpi_thermal *tz = data;
>  	unsigned long sleep_time = 0;
>  	int i = 0;
>  	struct acpi_thermal_state state;
> @@ -778,7 +778,7 @@ static struct proc_dir_entry *acpi_therm
> 
>  static int acpi_thermal_state_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_thermal *tz = (struct acpi_thermal *)seq->private;
> +	struct acpi_thermal *tz = seq->private;
> 
> 
>  	if (!tz)
> @@ -813,7 +813,7 @@ static int acpi_thermal_state_open_fs(st
>  static int acpi_thermal_temp_seq_show(struct seq_file *seq, void
*offset)
>  {
>  	int result = 0;
> -	struct acpi_thermal *tz = (struct acpi_thermal *)seq->private;
> +	struct acpi_thermal *tz = seq->private;
> 
> 
>  	if (!tz)
> @@ -837,7 +837,7 @@ static int acpi_thermal_temp_open_fs(str
> 
>  static int acpi_thermal_trip_seq_show(struct seq_file *seq, void
*offset)
>  {
> -	struct acpi_thermal *tz = (struct acpi_thermal *)seq->private;
> +	struct acpi_thermal *tz = seq->private;
>  	int i = 0;
>  	int j = 0;
> 
> @@ -893,8 +893,8 @@ acpi_thermal_write_trip_points(struct fi
>  			       const char __user * buffer,
>  			       size_t count, loff_t * ppos)
>  {
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_thermal *tz = (struct acpi_thermal *)m->private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_thermal *tz = m->private;
> 
>  	char *limit_string;
>  	int num, critical, hot, passive;
> @@ -953,7 +953,7 @@ acpi_thermal_write_trip_points(struct fi
> 
>  static int acpi_thermal_cooling_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_thermal *tz = (struct acpi_thermal *)seq->private;
> +	struct acpi_thermal *tz = seq->private;
> 
> 
>  	if (!tz)
> @@ -984,8 +984,8 @@ acpi_thermal_write_cooling_mode(struct f
>  				const char __user * buffer,
>  				size_t count, loff_t * ppos)
>  {
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_thermal *tz = (struct acpi_thermal *)m->private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_thermal *tz = m->private;
>  	int result = 0;
>  	char mode_string[12] = { '\0' };
> 
> @@ -1014,7 +1014,7 @@ acpi_thermal_write_cooling_mode(struct f
> 
>  static int acpi_thermal_polling_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_thermal *tz = (struct acpi_thermal *)seq->private;
> +	struct acpi_thermal *tz = seq->private;
> 
> 
>  	if (!tz)
> @@ -1043,8 +1043,8 @@ acpi_thermal_write_polling(struct file *
>  			   const char __user * buffer,
>  			   size_t count, loff_t * ppos)
>  {
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_thermal *tz = (struct acpi_thermal *)m->private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_thermal *tz = m->private;
>  	int result = 0;
>  	char polling_string[12] = { '\0' };
>  	int seconds = 0;
> @@ -1170,7 +1170,7 @@ static int acpi_thermal_remove_fs(struct
> 
>  static void acpi_thermal_notify(acpi_handle handle, u32 event, void
> *data)
>  {
> -	struct acpi_thermal *tz = (struct acpi_thermal *)data;
> +	struct acpi_thermal *tz = data;
>  	struct acpi_device *device = NULL;
> 
> 
> @@ -1324,7 +1324,7 @@ static int acpi_thermal_remove(struct ac
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	tz = (struct acpi_thermal *)acpi_driver_data(device);
> +	tz = acpi_driver_data(device);
> 
>  	/* avoid timer adding new defer task */
>  	tz->zombie = 1;
> @@ -1364,7 +1364,7 @@ static int acpi_thermal_resume(struct ac
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	tz = (struct acpi_thermal *)acpi_driver_data(device);
> +	tz = acpi_driver_data(device);
> 
>  	acpi_thermal_get_temperature(tz);
> 
> Index: linux-2.6.18/drivers/acpi/utils.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/utils.c
> +++ linux-2.6.18/drivers/acpi/utils.c
> @@ -83,7 +83,7 @@ acpi_extract_package(union acpi_object *
>  		return AE_BAD_DATA;
>  	}
> 
> -	format_string = (char *)format->pointer;
> +	format_string = format->pointer;
> 
>  	/*
>  	 * Calculate size_required.
> @@ -361,7 +361,7 @@ acpi_evaluate_reference(acpi_handle hand
>  	if (ACPI_FAILURE(status))
>  		goto end;
> 
> -	package = (union acpi_object *)buffer.pointer;
> +	package = buffer.pointer;
> 
>  	if ((buffer.length == 0) || !package) {
>  		printk(KERN_ERR PREFIX "No return object (len %X ptr
%p)\n",
> Index: linux-2.6.18/drivers/acpi/video.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/acpi/video.c
> +++ linux-2.6.18/drivers/acpi/video.c
> @@ -386,7 +386,7 @@ acpi_video_device_EDID(struct acpi_video
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
> 
> -	obj = (union acpi_object *)buffer.pointer;
> +	obj = buffer.pointer;
> 
>  	if (obj && obj->type == ACPI_TYPE_BUFFER)
>  		*edid = obj;
> @@ -654,8 +654,7 @@ static struct proc_dir_entry *acpi_video
> 
>  static int acpi_video_device_info_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_video_device *dev =
> -	    (struct acpi_video_device *)seq->private;
> +	struct acpi_video_device *dev = seq->private;
> 
> 
>  	if (!dev)
> @@ -688,8 +687,7 @@ acpi_video_device_info_open_fs(struct in
>  static int acpi_video_device_state_seq_show(struct seq_file *seq,
void
> *offset)
>  {
>  	int status;
> -	struct acpi_video_device *dev =
> -	    (struct acpi_video_device *)seq->private;
> +	struct acpi_video_device *dev = seq->private;
>  	unsigned long state;
> 
> 
> @@ -727,8 +725,8 @@ acpi_video_device_write_state(struct fil
>  			      size_t count, loff_t * data)
>  {
>  	int status;
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_video_device *dev = (struct acpi_video_device *)m-
> >private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_video_device *dev = m->private;
>  	char str[12] = { 0 };
>  	u32 state = 0;
> 
> @@ -754,8 +752,7 @@ acpi_video_device_write_state(struct fil
>  static int
>  acpi_video_device_brightness_seq_show(struct seq_file *seq, void
*offset)
>  {
> -	struct acpi_video_device *dev =
> -	    (struct acpi_video_device *)seq->private;
> +	struct acpi_video_device *dev = seq->private;
>  	int i;
> 
> 
> @@ -784,8 +781,8 @@ acpi_video_device_write_brightness(struc
>  				   const char __user * buffer,
>  				   size_t count, loff_t * data)
>  {
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_video_device *dev = (struct acpi_video_device *)m-
> >private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_video_device *dev = m->private;
>  	char str[4] = { 0 };
>  	unsigned int level = 0;
>  	int i;
> @@ -817,8 +814,7 @@ acpi_video_device_write_brightness(struc
> 
>  static int acpi_video_device_EDID_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_video_device *dev =
> -	    (struct acpi_video_device *)seq->private;
> +	struct acpi_video_device *dev = seq->private;
>  	int status;
>  	int i;
>  	union acpi_object *edid = NULL;
> @@ -866,7 +862,7 @@ static int acpi_video_device_add_fs(stru
>  	if (!device)
>  		return -ENODEV;
> 
> -	vid_dev = (struct acpi_video_device *)acpi_driver_data(device);
> +	vid_dev = acpi_driver_data(device);
>  	if (!vid_dev)
>  		return -ENODEV;
> 
> @@ -931,7 +927,7 @@ static int acpi_video_device_remove_fs(s
>  {
>  	struct acpi_video_device *vid_dev;
> 
> -	vid_dev = (struct acpi_video_device *)acpi_driver_data(device);
> +	vid_dev = acpi_driver_data(device);
>  	if (!vid_dev || !vid_dev->video || !vid_dev->video->dir)
>  		return -ENODEV;
> 
> @@ -950,7 +946,7 @@ static int acpi_video_device_remove_fs(s
>  /* video bus */
>  static int acpi_video_bus_info_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_video_bus *video = (struct acpi_video_bus *)seq-
> >private;
> +	struct acpi_video_bus *video = seq->private;
> 
> 
>  	if (!video)
> @@ -975,7 +971,7 @@ static int acpi_video_bus_info_open_fs(s
> 
>  static int acpi_video_bus_ROM_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_video_bus *video = (struct acpi_video_bus *)seq-
> >private;
> +	struct acpi_video_bus *video = seq->private;
> 
> 
>  	if (!video)
> @@ -995,7 +991,7 @@ static int acpi_video_bus_ROM_open_fs(st
> 
>  static int acpi_video_bus_POST_info_seq_show(struct seq_file *seq,
void
> *offset)
>  {
> -	struct acpi_video_bus *video = (struct acpi_video_bus *)seq-
> >private;
> +	struct acpi_video_bus *video = seq->private;
>  	unsigned long options;
>  	int status;
> 
> @@ -1033,7 +1029,7 @@ acpi_video_bus_POST_info_open_fs(struct
> 
>  static int acpi_video_bus_POST_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_video_bus *video = (struct acpi_video_bus *)seq-
> >private;
> +	struct acpi_video_bus *video = seq->private;
>  	int status;
>  	unsigned long id;
> 
> @@ -1054,7 +1050,7 @@ static int acpi_video_bus_POST_seq_show(
> 
>  static int acpi_video_bus_DOS_seq_show(struct seq_file *seq, void
> *offset)
>  {
> -	struct acpi_video_bus *video = (struct acpi_video_bus *)seq-
> >private;
> +	struct acpi_video_bus *video = seq->private;
> 
> 
>  	seq_printf(seq, "DOS setting: <%d>\n", video->dos_setting);
> @@ -1079,8 +1075,8 @@ acpi_video_bus_write_POST(struct file *f
>  			  size_t count, loff_t * data)
>  {
>  	int status;
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_video_bus *video = (struct acpi_video_bus
*)m->private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_video_bus *video = m->private;
>  	char str[12] = { 0 };
>  	unsigned long opt, options;
> 
> @@ -1119,8 +1115,8 @@ acpi_video_bus_write_DOS(struct file *fi
>  			 size_t count, loff_t * data)
>  {
>  	int status;
> -	struct seq_file *m = (struct seq_file *)file->private_data;
> -	struct acpi_video_bus *video = (struct acpi_video_bus
*)m->private;
> +	struct seq_file *m = file->private_data;
> +	struct acpi_video_bus *video = m->private;
>  	char str[12] = { 0 };
>  	unsigned long opt;
> 
> @@ -1150,7 +1146,7 @@ static int acpi_video_bus_add_fs(struct
>  	struct acpi_video_bus *video;
> 
> 
> -	video = (struct acpi_video_bus *)acpi_driver_data(device);
> +	video = acpi_driver_data(device);
> 
>  	if (!acpi_device_dir(device)) {
>  		acpi_device_dir(device) =
proc_mkdir(acpi_device_bid(device),
> @@ -1226,7 +1222,7 @@ static int acpi_video_bus_remove_fs(stru
>  	struct acpi_video_bus *video;
> 
> 
> -	video = (struct acpi_video_bus *)acpi_driver_data(device);
> +	video = acpi_driver_data(device);
> 
>  	if (acpi_device_dir(device)) {
>  		remove_proc_entry("info", acpi_device_dir(device));
> @@ -1403,7 +1399,7 @@ static int acpi_video_device_enumerate(s
>  		return status;
>  	}
> 
> -	dod = (union acpi_object *)buffer.pointer;
> +	dod = buffer.pointer;
>  	if (!dod || (dod->type != ACPI_TYPE_PACKAGE)) {
>  		ACPI_EXCEPTION((AE_INFO, status, "Invalid _DOD data"));
>  		status = -EFAULT;
> @@ -1426,7 +1422,7 @@ static int acpi_video_device_enumerate(s
> 
>  	count = 0;
>  	for (i = 0; i < dod->package.count; i++) {
> -		obj = (union acpi_object *)&dod->package.elements[i];
> +		obj = &dod->package.elements[i];
> 
>  		if (obj->type != ACPI_TYPE_INTEGER) {
>  			printk(KERN_ERR PREFIX "Invalid _DOD data\n");
> @@ -1612,7 +1608,7 @@ static int acpi_video_bus_stop_devices(s
> 
>  static void acpi_video_bus_notify(acpi_handle handle, u32 event, void
> *data)
>  {
> -	struct acpi_video_bus *video = (struct acpi_video_bus *)data;
> +	struct acpi_video_bus *video = data;
>  	struct acpi_device *device = NULL;
> 
>  	printk("video bus notify\n");
> @@ -1654,8 +1650,7 @@ static void acpi_video_bus_notify(acpi_h
> 
>  static void acpi_video_device_notify(acpi_handle handle, u32 event,
void
> *data)
>  {
> -	struct acpi_video_device *video_device =
> -	    (struct acpi_video_device *)data;
> +	struct acpi_video_device *video_device = data;
>  	struct acpi_device *device = NULL;
> 
> 
> @@ -1757,7 +1752,7 @@ static int acpi_video_bus_remove(struct
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> 
> -	video = (struct acpi_video_bus *)acpi_driver_data(device);
> +	video = acpi_driver_data(device);
> 
>  	acpi_video_bus_stop_devices(video);
> 
> #<EOF>
> 
> Jan Engelhardt
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
