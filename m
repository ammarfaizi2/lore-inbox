Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTHVHcl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTHVHbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:31:19 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:56338 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263066AbTHVGx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 02:53:29 -0400
Date: Fri, 22 Aug 2003 03:52:45 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH][resend] 2/13 2.4.22-rc2 fix __FUNCTION__ warnings
 drivers/hotplug
Message-Id: <20030822035245.0940b4bd.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 cpqphp.h           |    6 ++--
 cpqphp_core.c      |   30 +++++++++++------------
 cpqphp_ctrl.c      |   68 ++++++++++++++++++++++++++---------------------------
 cpqphp_nvram.c     |    2 -
 cpqphp_pci.c       |   12 ++++-----
 pci_hotplug_core.c |    2 -
 pci_hotplug_util.c |    2 -
 7 files changed, 61 insertions(+), 61 deletions(-)

--- linux-2.4.22-rc2/drivers/hotplug/cpqphp.h	2003-06-13 11:51:33.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/hotplug/cpqphp.h	2003-08-21 00:08:28.000000000 -0300
@@ -747,7 +747,7 @@
 		return 1;
 
 	hp_slot = slot->device - ctrl->slot_device_offset;
-	dbg(__FUNCTION__": slot->device = %d, ctrl->slot_device_offset = %d \n", slot->device, ctrl->slot_device_offset);
+	dbg("%s: slot->device = %d, ctrl->slot_device_offset = %d \n", __FUNCTION__, slot->device, ctrl->slot_device_offset);
 
 	status = (readl(ctrl->hpc_reg + INT_INPUT_CLEAR) & (0x01L << hp_slot));
 
@@ -785,7 +785,7 @@
         DECLARE_WAITQUEUE(wait, current);
 	int retval = 0;
 
-	dbg(__FUNCTION__" - start\n");
+	dbg("%s - start\n", __FUNCTION__);
 	add_wait_queue(&ctrl->queue, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	/* Sleep for up to 1 second to wait for the LED to change. */
@@ -795,7 +795,7 @@
 	if (signal_pending(current))
 		retval =  -EINTR;
 
-	dbg(__FUNCTION__" - end\n");
+	dbg("%s - end\n", __FUNCTION__);
 	return retval;
 }
 
--- linux-2.4.22-rc2/drivers/hotplug/cpqphp_core.c	2003-06-13 11:51:33.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/hotplug/cpqphp_core.c	2003-08-21 00:08:28.000000000 -0300
@@ -320,7 +320,7 @@
 	void *slot_entry= NULL;
 	int result;
 
-	dbg(__FUNCTION__"\n");
+	dbg("%s\n", __FUNCTION__);
 
 	tempdword = readl(ctrl->hpc_reg + INT_INPUT_CLEAR);
 
@@ -482,7 +482,7 @@
 
 	u8 tbus, tdevice, tslot, bridgeSlot;
 
-	dbg(__FUNCTION__" %p, %d, %d, %p\n", ops, bus_num, dev_num, slot);
+	dbg("%s %p, %d, %d, %p\n", __FUNCTION__, ops, bus_num, dev_num, slot);
 
 	bridgeSlot = 0xFF;
 
@@ -598,7 +598,7 @@
 	if (slot == NULL)
 		return -ENODEV;
 	
-	dbg(__FUNCTION__" - physical_slot = %s\n", hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	ctrl = slot->ctrl;
 	if (ctrl == NULL)
@@ -633,7 +633,7 @@
 	if (slot == NULL)
 		return -ENODEV;
 	
-	dbg(__FUNCTION__" - physical_slot = %s\n", hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	ctrl = slot->ctrl;
 	if (ctrl == NULL)
@@ -673,7 +673,7 @@
 	if (slot == NULL)
 		return -ENODEV;
 	
-	dbg(__FUNCTION__" - physical_slot = %s\n", hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	ctrl = slot->ctrl;
 	if (ctrl == NULL)
@@ -701,7 +701,7 @@
 	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
 	struct controller *ctrl;
 
-	dbg(__FUNCTION__"\n");
+	dbg("%s\n", __FUNCTION__);
 
 	if (slot == NULL)
 		return -ENODEV;
@@ -722,7 +722,7 @@
 	if (slot == NULL)
 		return -ENODEV;
 	
-	dbg(__FUNCTION__" - physical_slot = %s\n", hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	ctrl = slot->ctrl;
 	if (ctrl == NULL)
@@ -740,7 +740,7 @@
 	if (slot == NULL)
 		return -ENODEV;
 	
-	dbg(__FUNCTION__" - physical_slot = %s\n", hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	ctrl = slot->ctrl;
 	if (ctrl == NULL)
@@ -758,7 +758,7 @@
 	if (slot == NULL)
 		return -ENODEV;
 	
-	dbg(__FUNCTION__" - physical_slot = %s\n", hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	ctrl = slot->ctrl;
 	if (ctrl == NULL)
@@ -777,7 +777,7 @@
 	if (slot == NULL)
 		return -ENODEV;
 	
-	dbg(__FUNCTION__" - physical_slot = %s\n", hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	ctrl = slot->ctrl;
 	if (ctrl == NULL)
@@ -865,7 +865,7 @@
 		// TODO: This code can be made to support non-Compaq or Intel subsystem IDs
 		rc = pci_read_config_word(pdev, PCI_SUBSYSTEM_VENDOR_ID, &subsystem_vid);
 		if (rc) {
-			err(__FUNCTION__" : pci_read_config_word failed\n");
+			err("%s : pci_read_config_word failed\n", __FUNCTION__);
 			return rc;
 		}
 		dbg("Subsystem Vendor ID: %x\n", subsystem_vid);
@@ -876,14 +876,14 @@
 
 		ctrl = (struct controller *) kmalloc(sizeof(struct controller), GFP_KERNEL);
 		if (!ctrl) {
-			err(__FUNCTION__" : out of memory\n");
+			err("%s : out of memory\n", __FUNCTION__);
 			return -ENOMEM;
 		}
 		memset(ctrl, 0, sizeof(struct controller));
 
 		rc = pci_read_config_word(pdev, PCI_SUBSYSTEM_ID, &subsystem_deviceid);
 		if (rc) {
-			err(__FUNCTION__" : pci_read_config_word failed\n");
+			err("%s : pci_read_config_word failed\n", __FUNCTION__);
 			goto err_free_ctrl;
 		}
 
@@ -1139,7 +1139,7 @@
 	// Store PCI Config Space for all devices on this bus
 	rc = cpqhp_save_config(ctrl, ctrl->bus, readb(ctrl->hpc_reg + SLOT_MASK));
 	if (rc) {
-		err(__FUNCTION__": unable to save PCI configuration data, error %d\n", rc);
+		err("%s: unable to save PCI configuration data, error %d\n", __FUNCTION__, rc);
 		goto err_iounmap;
 	}
 
@@ -1169,7 +1169,7 @@
 	rc = ctrl_slot_setup(ctrl, smbios_start, smbios_table);
 	if (rc) {
 		err(msg_initialization_err, 6);
-		err(__FUNCTION__": unable to save PCI configuration data, error %d\n", rc);
+		err("%s: unable to save PCI configuration data, error %d\n", __FUNCTION__, rc);
 		goto err_iounmap;
 	}
 	
--- linux-2.4.22-rc2/drivers/hotplug/cpqphp_ctrl.c	2003-06-13 11:51:33.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/hotplug/cpqphp_ctrl.c	2003-08-21 00:08:28.000000000 -0300
@@ -771,13 +771,13 @@
 		return(NULL);
 
 	for (node = *head; node; node = node->next) {
-		dbg(__FUNCTION__": req_size =%x node=%p, base=%x, length=%x\n",
-		    size, node, node->base, node->length);
+		dbg("%s: req_size =%x node=%p, base=%x, length=%x\n",
+		    __FUNCTION__, size, node, node->base, node->length);
 		if (node->length < size)
 			continue;
 
 		if (node->base & (size - 1)) {
-			dbg(__FUNCTION__": not aligned\n");
+			dbg("%s: not aligned\n", __FUNCTION__);
 			// this one isn't base aligned properly
 			// so we'll make a new entry and split it up
 			temp_dword = (node->base | (size-1)) + 1;
@@ -803,7 +803,7 @@
 
 		// Don't need to check if too small since we already did
 		if (node->length > size) {
-			dbg(__FUNCTION__": too big\n");
+			dbg("%s: too big\n", __FUNCTION__);
 			// this one is longer than we need
 			// so we'll make a new entry and split it up
 			split_node = (struct pci_resource*) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
@@ -820,7 +820,7 @@
 			node->next = split_node;
 		}  // End of too big on top end
 
-		dbg(__FUNCTION__": got one!!!\n");
+		dbg("%s: got one!!!\n", __FUNCTION__);
 		// If we got here, then it is the right size
 		// Now take it out of the list
 		if (*head == node) {
@@ -855,7 +855,7 @@
 	struct pci_resource *node2;
 	int out_of_order = 1;
 
-	dbg(__FUNCTION__": head = %p, *head = %p\n", head, *head);
+	dbg("%s: head = %p, *head = %p\n",__FUNCTION__, head, *head);
 
 	if (!(*head))
 		return(1);
@@ -942,7 +942,7 @@
 		// Read to clear posted writes
 		misc = readw(ctrl->hpc_reg + MISC);
 
-		dbg (__FUNCTION__" - waking up\n");
+		dbg ("%s - waking up\n", __FUNCTION__);
 		wake_up_interruptible(&ctrl->queue);
 	}
 
@@ -1394,8 +1394,8 @@
 	struct resource_lists res_lists;
 
 	hp_slot = func->device - ctrl->slot_device_offset;
-	dbg(__FUNCTION__": func->device, slot_offset, hp_slot = %d, %d ,%d\n",
-	    func->device, ctrl->slot_device_offset, hp_slot);
+	dbg("%s: func->device, slot_offset, hp_slot = %d, %d ,%d\n",
+	    __FUNCTION__, func->device, ctrl->slot_device_offset, hp_slot);
 	
 	// Wait for exclusive access to hardware
 	down(&ctrl->crit_sect);
@@ -1444,55 +1444,55 @@
 	// turn on board and blink green LED
 
 	// Wait for exclusive access to hardware
-	dbg(__FUNCTION__": before down\n");
+	dbg("%s: before down\n", __FUNCTION__);
 	down(&ctrl->crit_sect);
-	dbg(__FUNCTION__": after down\n");
+	dbg("%s: after down\n", __FUNCTION__);
 
-	dbg(__FUNCTION__": before slot_enable\n");
+	dbg("%s: before slot_enable\n", __FUNCTION__);
 	slot_enable (ctrl, hp_slot);
 
-	dbg(__FUNCTION__": before green_LED_blink\n");
+	dbg("%s: before green_LED_blink\n", __FUNCTION__);
 	green_LED_blink (ctrl, hp_slot);
 
-	dbg(__FUNCTION__": before amber_LED_blink\n");
+	dbg("%s: before amber_LED_blink\n", __FUNCTION__);
 	amber_LED_off (ctrl, hp_slot);
 
-	dbg(__FUNCTION__": before set_SOGO\n");
+	dbg("%s: before set_SOGO\n", __FUNCTION__);
 	set_SOGO(ctrl);
 
 	// Wait for SOBS to be unset
-	dbg(__FUNCTION__": before wait_for_ctrl_irq\n");
+	dbg("%s: before wait_for_ctrl_irq\n", __FUNCTION__);
 	wait_for_ctrl_irq (ctrl);
-	dbg(__FUNCTION__": after wait_for_ctrl_irq\n");
+	dbg("%s: after wait_for_ctrl_irq\n", __FUNCTION__);
 
 	// Done with exclusive hardware access
-	dbg(__FUNCTION__": before up\n");
+	dbg("%s: before up\n", __FUNCTION__);
 	up(&ctrl->crit_sect);
-	dbg(__FUNCTION__": after up\n");
+	dbg("%s: after up\n", __FUNCTION__);
 
 	// Wait for ~1 second because of hot plug spec
-	dbg(__FUNCTION__": before long_delay\n");
+	dbg("%s: before long_delay\n", __FUNCTION__);
 	long_delay(1*HZ);
-	dbg(__FUNCTION__": after long_delay\n");
+	dbg("%s: after long_delay\n", __FUNCTION__);
 
-	dbg(__FUNCTION__": func status = %x\n", func->status);
+	dbg("%s: func status = %x\n", __FUNCTION__, func->status);
 	// Check for a power fault
 	if (func->status == 0xFF) {
 		// power fault occurred, but it was benign
 		temp_register = 0xFFFFFFFF;
-		dbg(__FUNCTION__": temp register set to %x by power fault\n", temp_register);
+		dbg("%s: temp register set to %x by power fault\n", __FUNCTION__, temp_register);
 		rc = POWER_FAILURE;
 		func->status = 0;
 	} else {
 		// Get vendor/device ID u32
 		rc = pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_VENDOR_ID, &temp_register);
-		dbg(__FUNCTION__": pci_read_config_dword returns %d\n", rc);
-		dbg(__FUNCTION__": temp_register is %x\n", temp_register);
+		dbg("%s: pci_read_config_dword returns %d\n", __FUNCTION__, rc);
+		dbg("%s: temp_register is %x\n", __FUNCTION__, temp_register);
 
 		if (rc != 0) {
 			// Something's wrong here
 			temp_register = 0xFFFFFFFF;
-			dbg(__FUNCTION__": temp register set to %x by error\n", temp_register);
+			dbg("%s: temp register set to %x by error\n", __FUNCTION__, temp_register);
 		}
 		// Preset return code.  It will be changed later if things go okay.
 		rc = NO_ADAPTER_PRESENT;
@@ -1508,7 +1508,7 @@
 
 		rc = configure_new_device(ctrl, func, 0, &res_lists);
 
-		dbg(__FUNCTION__": back from configure_new_device\n");
+		dbg("%s: back from configure_new_device\n", __FUNCTION__);
 		ctrl->io_head = res_lists.io_head;
 		ctrl->mem_head = res_lists.mem_head;
 		ctrl->p_mem_head = res_lists.p_mem_head;
@@ -1545,7 +1545,7 @@
 		func->is_a_board = 0x01;
 
 		//next, we will instantiate the linux pci_dev structures (with appropriate driver notification, if already present)
-		dbg(__FUNCTION__": configure linux pci_dev structure\n");
+		dbg("%s: configure linux pci_dev structure\n", __FUNCTION__);
 		index = 0;
 		do {
 			new_slot = cpqhp_slot_find(ctrl->bus, func->device, index++);
@@ -1612,7 +1612,7 @@
 	device = func->device;
 
 	hp_slot = func->device - ctrl->slot_device_offset;
-	dbg("In "__FUNCTION__", hp_slot = %d\n", hp_slot);
+	dbg("In %s, hp_slot = %d\n", __FUNCTION__, hp_slot);
 
 	// When we get here, it is safe to change base Address Registers.
 	// We will attempt to save the base Address Register Lengths
@@ -1942,7 +1942,7 @@
 		func = cpqhp_slot_find(p_slot->bus, p_slot->device, 0);
 		dbg("In power_down_board, func = %p, ctrl = %p\n", func, ctrl);
 		if (!func) {
-			dbg("Error! func NULL in "__FUNCTION__"\n");
+			dbg("Error! func NULL in %s\n", __FUNCTION__);
 			return ;
 		}
 
@@ -1966,7 +1966,7 @@
 		func = cpqhp_slot_find(p_slot->bus, p_slot->device, 0);
 		dbg("In add_board, func = %p, ctrl = %p\n", func, ctrl);
 		if (!func) {
-			dbg("Error! func NULL in "__FUNCTION__"\n");
+			dbg("Error! func NULL in %s\n", __FUNCTION__);
 			return ;
 		}
 
@@ -2081,7 +2081,7 @@
 	}
 
 	if (rc) {
-		dbg(__FUNCTION__": rc = %d\n", rc);
+		dbg("%s: rc = %d\n", __FUNCTION__, rc);
 	}
 
 	if (p_slot)
@@ -2347,11 +2347,11 @@
 
 	new_slot = func;
 
-	dbg(__FUNCTION__"\n");
+	dbg("%s\n", __FUNCTION__);
 	// Check for Multi-function device
 	rc = pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, 0x0E, &temp_byte);
 	if (rc) {
-		dbg(__FUNCTION__": rc = %d\n", rc);
+		dbg("%s: rc = %d\n", __FUNCTION__, rc);
 		return rc;
 	}
 
--- linux-2.4.22-rc2/drivers/hotplug/cpqphp_nvram.c	2002-11-28 20:53:12.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/hotplug/cpqphp_nvram.c	2003-08-21 00:08:28.000000000 -0300
@@ -160,7 +160,7 @@
 	    (temp6 == 'Q')) {
 		result = 1;
 	}
-	dbg (__FUNCTION__" - returned %d\n", result);
+	dbg ("%s - returned %d\n",__FUNCTION__, result);
 	return result;
 }
 
--- linux-2.4.22-rc2/drivers/hotplug/cpqphp_pci.c	2002-11-28 20:53:12.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/hotplug/cpqphp_pci.c	2003-08-21 00:08:28.000000000 -0300
@@ -139,7 +139,7 @@
 		//We did not even find a hotplug rep of the function, create it
 		//This code might be taken out if we can guarantee the creation of functions
 		//in parallel (hotplug and Linux at the same time).
-		dbg("@@@@@@@@@@@ cpqhp_slot_create in "__FUNCTION__"\n");
+		dbg("@@@@@@@@@@@ cpqhp_slot_create in %s\n", __FUNCTION__);
 		temp_func = cpqhp_slot_create(bus->number);
 		if (temp_func == NULL)
 			return -ENOMEM;
@@ -306,7 +306,7 @@
 	memset(&wrapped_dev, 0, sizeof(struct pci_dev_wrapped));
 	memset(&wrapped_bus, 0, sizeof(struct pci_bus_wrapped));
 
-	dbg(__FUNCTION__": bus/dev/func = %x/%x/%x\n",func->bus, func->device, func->function);
+	dbg("%s: bus/dev/func = %x/%x/%x\n", __FUNCTION__, func->bus, func->device, func->function);
 
 	for (j=0; j<8 ; j++) {
 		struct pci_dev* temp = pci_find_slot(func->bus, (func->device << 3) | j);
@@ -354,10 +354,10 @@
 	fakedev.devfn = dev_num << 3;
 	fakedev.bus = &fakebus;
 	fakebus.number = bus_num;
-	dbg(__FUNCTION__": dev %d, bus %d, pin %d, num %d\n",
-	    dev_num, bus_num, int_pin, irq_num);
+	dbg("%s: dev %d, bus %d, pin %d, num %d\n",
+	    __FUNCTION__, dev_num, bus_num, int_pin, irq_num);
 	rc = pcibios_set_irq_routing(&fakedev, int_pin - 0x0a, irq_num);
-	dbg(__FUNCTION__":rc %d\n", rc);
+	dbg("%s:rc %d\n", __FUNCTION__, rc);
 	if (!rc)
 		return !rc;
 
@@ -1585,7 +1585,7 @@
 	int rc = 0;
 	struct pci_resource *node;
 	struct pci_resource *t_node;
-	dbg(__FUNCTION__"\n");
+	dbg("%s\n", __FUNCTION__);
 
 	if (!func)
 		return(1);
--- linux-2.4.22-rc2/drivers/hotplug/pci_hotplug_core.c	2002-11-28 20:53:13.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/hotplug/pci_hotplug_core.c	2003-08-21 00:08:28.000000000 -0300
@@ -49,7 +49,7 @@
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
-#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: "__FUNCTION__": " fmt , MY_NAME , ## arg); } while (0)
+#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __FUNCTION__ , ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
--- linux-2.4.22-rc2/drivers/hotplug/pci_hotplug_util.c	2003-06-13 11:51:33.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/hotplug/pci_hotplug_util.c	2003-08-21 00:08:28.000000000 -0300
@@ -41,7 +41,7 @@
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
-#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: "__FUNCTION__": " fmt , MY_NAME , ## arg); } while (0)
+#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __FUNCTION__ , ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
