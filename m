Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265547AbUBJADT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUBJAAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:00:16 -0500
Received: from mail.kroah.org ([65.200.24.183]:57788 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265401AbUBIXWe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:34 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689383236@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:18 -0800
Message-Id: <10763689382788@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.8, 2004/02/02 11:42:58-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: Kill spaces before \n in ibmphp*

Don't use a space directly before '\n' in error/debug messages. This adds
extra code size, causes unneeded line breaks in xterms, noone else does it
and it's just superfluos and ugly.

This also adds a missing ")" in a comment.


 drivers/pci/hotplug/ibmphp_core.c |   78 +++++++++++++++++++-------------------
 drivers/pci/hotplug/ibmphp_ebda.c |   22 +++++-----
 drivers/pci/hotplug/ibmphp_pci.c  |   76 ++++++++++++++++++-------------------
 drivers/pci/hotplug/ibmphp_res.c  |   56 +++++++++++++--------------
 4 files changed, 116 insertions(+), 116 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	Mon Feb  9 14:59:18 2004
+++ b/drivers/pci/hotplug/ibmphp_core.c	Mon Feb  9 14:59:18 2004
@@ -116,7 +116,7 @@
 
 	list_for_each (tmp, &ibmphp_slot_head) {
 		slot_cur = list_entry (tmp, struct slot, ibm_slot_list);
-		/* sometimes the hot-pluggable slots start with 4 (not always from 1 */
+		/* sometimes the hot-pluggable slots start with 4 (not always from 1) */
 		slot_count = max (slot_count, slot_cur->number);
 	}
 	return slot_count;
@@ -187,7 +187,7 @@
 		return retval;
 	}
 	if (CTLR_RESULT (slot_cur->ctrl->status)) {
-		err ("command not completed successfully in power_on \n");
+		err ("command not completed successfully in power_on\n");
 		return -EIO;
 	}
 	long_delay (3 * HZ); /* For ServeRAID cards, and some 66 PCI */
@@ -201,12 +201,12 @@
 
 	retval = ibmphp_hpc_writeslot (slot_cur, cmd);
 	if (retval) {
-		err ("power off failed \n");
+		err ("power off failed\n");
 		return retval;
 	}
 	if (CTLR_RESULT (slot_cur->ctrl->status)) {
-		err ("command not completed successfully in power_off \n");
-		return -EIO;
+		err ("command not completed successfully in power_off\n");
+		retval = -EIO;
 	}
 	return 0;
 }
@@ -520,7 +520,7 @@
 	int rc = -ENODEV;
 	struct slot *pslot = NULL;
 
-	debug ("get_bus_name - Entry hotplug_slot[%lx] \n", (ulong)hotplug_slot);
+	debug ("get_bus_name - Entry hotplug_slot[%lx]\n", (ulong)hotplug_slot);
 
 	ibmphp_lock_operations ();
 
@@ -654,7 +654,7 @@
 
 	info = kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
 	if (!info) {
-		err ("out of system memory \n");
+		err ("out of system memory\n");
 		return -ENOMEM;
 	}
         
@@ -794,7 +794,7 @@
 	dev->bus = bus;
 	for (dev->devfn = 0; dev->devfn < 256; dev->devfn += 8) {
 		if (!pci_read_config_word (dev, PCI_VENDOR_ID, &l) &&  l != 0x0000 && l != 0xffff) {
-			debug ("%s - Inside bus_struture_fixup() \n", __FUNCTION__);
+			debug ("%s - Inside bus_struture_fixup()\n", __FUNCTION__);
 			pci_scan_bus (busno, ibmphp_pci_bus->ops, NULL);
 			break;
 		}
@@ -829,7 +829,7 @@
 
 		func->dev = pci_find_slot(func->busno, PCI_DEVFN(func->device, func->function));
 		if (func->dev == NULL) {
-			err ("ERROR... : pci_dev still NULL \n");
+			err ("ERROR... : pci_dev still NULL\n");
 			return 0;
 		}
 	}
@@ -883,7 +883,7 @@
 	struct pci_dev *dev = NULL;
 	int retval;
 
-	debug ("%s - entry slot # %d \n", __FUNCTION__, slot_cur->number);
+	debug ("%s - entry slot # %d\n", __FUNCTION__, slot_cur->number);
 	if (SET_BUS_STATUS (slot_cur->ctrl) && is_bus_empty (slot_cur)) {
 		rc = slot_update (&slot_cur);
 		if (rc)
@@ -934,12 +934,12 @@
 				cmd = HPC_BUS_133PCIXMODE;
 				break;
 			default:
-				err ("Wrong bus speed \n");
+				err ("Wrong bus speed\n");
 				return -ENODEV;
 			}
 			break;
 		default:
-			err ("wrong slot speed \n");
+			err ("wrong slot speed\n");
 			return -ENODEV;
 		}
 		debug ("setting bus speed for slot %d, cmd %x\n", slot_cur->number, cmd);
@@ -949,14 +949,14 @@
 			return retval;
 		}
 		if (CTLR_RESULT (slot_cur->ctrl->status)) {
-			err ("command not completed successfully in set_bus \n");
+			err ("command not completed successfully in set_bus\n");
 			return -EIO;
 		}
 	}
 	/* This is for x440, once Brandon fixes the firmware, 
 	will not need this delay */
 	long_delay (1 * HZ);
-	debug ("%s -Exit \n", __FUNCTION__);
+	debug ("%s -Exit\n", __FUNCTION__);
 	return 0;
 }
 
@@ -1009,13 +1009,13 @@
 {
 	info ("capability of the card is ");
 	if ((slot_cur->ext_status & CARD_INFO) == PCIX133) 
-		info ("   133 MHz PCI-X \n");
+		info ("   133 MHz PCI-X\n");
 	else if ((slot_cur->ext_status & CARD_INFO) == PCIX66)
-		info ("    66 MHz PCI-X \n");
+		info ("    66 MHz PCI-X\n");
 	else if ((slot_cur->ext_status & CARD_INFO) == PCI66)
-		info ("    66 MHz PCI \n");
+		info ("    66 MHz PCI\n");
 	else
-		info ("    33 MHz PCI \n");
+		info ("    33 MHz PCI\n");
 
 }
 
@@ -1033,11 +1033,11 @@
 
 	ibmphp_lock_operations ();
 
-	debug ("ENABLING SLOT........ \n");
+	debug ("ENABLING SLOT........\n");
 	slot_cur = (struct slot *) hs->private;
 
 	if ((rc = validate (slot_cur, ENABLE))) {
-		err ("validate function failed \n");
+		err ("validate function failed\n");
 		goto error_nopower;
 	}
 
@@ -1045,13 +1045,13 @@
 	
 	rc = set_bus (slot_cur);
 	if (rc) {
-		err ("was not able to set the bus \n");
+		err ("was not able to set the bus\n");
 		goto error_nopower;
 	}
 
 	/*-----------------debugging------------------------------*/
 	get_cur_bus_info (&slot_cur);
-	debug ("the current bus speed right after set_bus = %x \n", slot_cur->bus_on->current_speed); 
+	debug ("the current bus speed right after set_bus = %x\n", slot_cur->bus_on->current_speed); 
 	/*----------------------------------------------------------*/
 
 	rc = check_limitations (slot_cur);
@@ -1059,7 +1059,7 @@
 		err ("Adding this card exceeds the limitations of this bus.\n");
 		err ("(i.e., >1 133MHz cards running on same bus, or "
 		     ">2 66 PCI cards running on same bus\n.");
-		err ("Try hot-adding into another bus \n");
+		err ("Try hot-adding into another bus\n");
 		rc = -EINVAL;
 		goto error_nopower;
 	}
@@ -1079,12 +1079,12 @@
 		}
 		/* Check to see the error of why it failed */
 		if ((SLOT_POWER (slot_cur->status)) && !(SLOT_PWRGD (slot_cur->status)))
-			err ("power fault occurred trying to power up \n");
+			err ("power fault occurred trying to power up\n");
 		else if (SLOT_BUS_SPEED (slot_cur->status)) {
-			err ("bus speed mismatch occurred.  please check current bus speed and card capability \n");
+			err ("bus speed mismatch occurred.  please check current bus speed and card capability\n");
 			print_card_capability (slot_cur);
 		} else if (SLOT_BUS_MODE (slot_cur->ext_status)) {
-			err ("bus mode mismatch occurred.  please check current bus mode and card capability \n");
+			err ("bus mode mismatch occurred.  please check current bus mode and card capability\n");
 			print_card_capability (slot_cur);
 		}
 		ibmphp_update_slot_info (slot_cur);
@@ -1093,7 +1093,7 @@
 	debug ("after power_on\n");
 	/*-----------------------debugging---------------------------*/
 	get_cur_bus_info (&slot_cur);
-	debug ("the current bus speed right after power_on = %x \n", slot_cur->bus_on->current_speed);
+	debug ("the current bus speed right after power_on = %x\n", slot_cur->bus_on->current_speed);
 	/*----------------------------------------------------------*/
 
 	rc = slot_update (&slot_cur);
@@ -1102,17 +1102,17 @@
 	
 	rc = -EINVAL;
 	if (SLOT_POWER (slot_cur->status) && !(SLOT_PWRGD (slot_cur->status))) {
-		err ("power fault occurred trying to power up... \n");
+		err ("power fault occurred trying to power up...\n");
 		goto error_power;
 	}
 	if (SLOT_POWER (slot_cur->status) && (SLOT_BUS_SPEED (slot_cur->status))) {
-		err ("bus speed mismatch occurred.  please check current bus speed and card capability \n");
+		err ("bus speed mismatch occurred.  please check current bus speed and card capability\n");
 		print_card_capability (slot_cur);
 		goto error_power;
 	} 
 	/* Don't think this case will happen after above checks... but just in case, for paranoia sake */
 	if (!(SLOT_POWER (slot_cur->status))) {
-		err ("power on failed... \n");
+		err ("power on failed...\n");
 		goto error_power;
 	}
 
@@ -1120,7 +1120,7 @@
 	if (!slot_cur->func) {
 		/* We cannot do update_slot_info here, since no memory for
 		 * kmalloc n.e.ways, and update_slot_info allocates some */
-		err ("out of system memory \n");
+		err ("out of system memory\n");
 		rc = -ENOMEM;
 		goto error_power;
 	}
@@ -1133,7 +1133,7 @@
 	debug ("b4 configure_card, slot_cur->bus = %x, slot_cur->device = %x\n", slot_cur->bus, slot_cur->device);
 
 	if (ibmphp_configure_card (slot_cur->func, slot_cur->number)) {
-		err ("configure_card was unsuccessful... \n");
+		err ("configure_card was unsuccessful...\n");
 		ibmphp_unconfigure_card (&slot_cur, 1); /* true because don't need to actually deallocate resources, just remove references */
 		debug ("after unconfigure_card\n");
 		slot_cur->func = NULL;
@@ -1204,7 +1204,7 @@
 	int rc;
 	u8 flag;
 
-	debug ("DISABLING SLOT... \n"); 
+	debug ("DISABLING SLOT...\n"); 
 		
 	if ((slot_cur == NULL) || (slot_cur->ctrl == NULL)) {
 		return -ENODEV;
@@ -1224,7 +1224,7 @@
 		/* We need this for fncs's that were there on bootup */
 		slot_cur->func = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
 		if (!slot_cur->func) {
-			err ("out of system memory \n");
+			err ("out of system memory\n");
 			rc = -ENOMEM;
 			goto error;
 		}
@@ -1306,15 +1306,15 @@
 static void ibmphp_unload (void)
 {
 	free_slots ();
-	debug ("after slots \n");
+	debug ("after slots\n");
 	ibmphp_free_resources ();
-	debug ("after resources \n");
+	debug ("after resources\n");
 	ibmphp_free_bus_info_queue ();
-	debug ("after bus info \n");
+	debug ("after bus info\n");
 	ibmphp_free_ebda_hpc_queue ();
-	debug ("after ebda hpc \n");
+	debug ("after ebda hpc\n");
 	ibmphp_free_ebda_pci_rsrc_queue ();
-	debug ("after ebda pci rsrc \n");
+	debug ("after ebda pci rsrc\n");
 	kfree (ibmphp_pci_bus);
 }
 
diff -Nru a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
--- a/drivers/pci/hotplug/ibmphp_ebda.c	Mon Feb  9 14:59:18 2004
+++ b/drivers/pci/hotplug/ibmphp_ebda.c	Mon Feb  9 14:59:18 2004
@@ -171,7 +171,7 @@
 {
 	struct rio_detail *ptr;
 	struct list_head *ptr1;
-	debug ("print_lo_info ---- \n");	
+	debug ("print_lo_info ----\n");	
 	list_for_each (ptr1, &rio_lo_head) {
 		ptr = list_entry (ptr1, struct rio_detail, rio_detail_list);
 		debug ("%s - rio_node_id = %x\n", __FUNCTION__, ptr->rio_node_id);
@@ -188,7 +188,7 @@
 {
 	struct rio_detail *ptr;
 	struct list_head *ptr1;
-	debug ("%s --- \n", __FUNCTION__);
+	debug ("%s ---\n", __FUNCTION__);
 	list_for_each (ptr1, &rio_vg_head) {
 		ptr = list_entry (ptr1, struct rio_detail, rio_detail_list);
 		debug ("%s - rio_node_id = %x\n", __FUNCTION__, ptr->rio_node_id);
@@ -220,7 +220,7 @@
 
 	list_for_each (ptr1, &ibmphp_slot_head) {
 		ptr = list_entry (ptr1, struct slot, ibm_slot_list);
-		debug ("%s - slot_number: %x \n", __FUNCTION__, ptr->number); 
+		debug ("%s - slot_number: %x\n", __FUNCTION__, ptr->number); 
 	}
 }
 
@@ -228,13 +228,13 @@
 {
 	struct opt_rio *ptr;
 	struct list_head *ptr1;
-	debug ("%s --- \n", __FUNCTION__);
+	debug ("%s ---\n", __FUNCTION__);
 	list_for_each (ptr1, &opt_vg_head) {
 		ptr = list_entry (ptr1, struct opt_rio, opt_rio_list);
-		debug ("%s - rio_type %x \n", __FUNCTION__, ptr->rio_type); 
-		debug ("%s - chassis_num: %x \n", __FUNCTION__, ptr->chassis_num); 
-		debug ("%s - first_slot_num: %x \n", __FUNCTION__, ptr->first_slot_num); 
-		debug ("%s - middle_num: %x \n", __FUNCTION__, ptr->middle_num); 
+		debug ("%s - rio_type %x\n", __FUNCTION__, ptr->rio_type); 
+		debug ("%s - chassis_num: %x\n", __FUNCTION__, ptr->chassis_num); 
+		debug ("%s - first_slot_num: %x\n", __FUNCTION__, ptr->first_slot_num); 
+		debug ("%s - middle_num: %x\n", __FUNCTION__, ptr->middle_num); 
 	}
 }
 
@@ -670,7 +670,7 @@
 	u8 flag = 0;
 
 	if (!slot_cur) {
-		err ("Structure passed is empty \n");
+		err ("Structure passed is empty\n");
 		return NULL;
 	}
 	
@@ -1269,14 +1269,14 @@
 	struct controller *ctrl;
 	struct list_head *tmp;
 
-	debug ("inside ibmphp_probe \n");
+	debug ("inside ibmphp_probe\n");
 	
 	list_for_each (tmp, &ebda_hpc_head) {
 		ctrl = list_entry (tmp, struct controller, ebda_hpc_list);
 		if (ctrl->ctlr_type == 1) {
 			if ((dev->devfn == ctrl->u.pci_ctlr.dev_fun) && (dev->bus->number == ctrl->u.pci_ctlr.bus)) {
 				ctrl->ctrl_dev = dev;
-				debug ("found device!!! \n");
+				debug ("found device!!!\n");
 				debug ("dev->device = %x, dev->subsystem_device = %x\n", dev->device, dev->subsystem_device);
 				return 0;
 			}
diff -Nru a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
--- a/drivers/pci/hotplug/ibmphp_pci.c	Mon Feb  9 14:59:18 2004
+++ b/drivers/pci/hotplug/ibmphp_pci.c	Mon Feb  9 14:59:18 2004
@@ -92,7 +92,7 @@
 	u8 flag;
 	u8 valid_device = 0x00; /* to see if we are able to read from card any device info at all */
 
-	debug ("inside configure_card, func->busno = %x \n", func->busno);
+	debug ("inside configure_card, func->busno = %x\n", func->busno);
 
 	device = func->device;
 	cur_func = func;
@@ -130,7 +130,7 @@
 			pci_bus_read_config_dword (ibmphp_pci_bus, devfn, PCI_CLASS_REVISION, &class);
 
 			class_code = class >> 24;
-			debug ("hrd_type = %x, class = %x, class_code %x \n", hdr_type, class, class_code);
+			debug ("hrd_type = %x, class = %x, class_code %x\n", hdr_type, class, class_code);
 			class >>= 8;	/* to take revision out, class = class.subclass.prog i/f */
 			if (class == PCI_CLASS_NOT_DEFINED_VGA) {
 				err ("The device %x is VGA compatible and as is not supported for hot plugging. "
@@ -147,7 +147,7 @@
 					assign_alt_irq (cur_func, class_code);
 					if ((rc = configure_device (cur_func)) < 0) {
 						/* We need to do this in case some other BARs were properly inserted */
-						err ("was not able to configure devfunc %x on bus %x. \n",
+						err ("was not able to configure devfunc %x on bus %x.\n",
 						     cur_func->device, cur_func->busno);
 						cleanup_count = 6;
 						goto error;
@@ -166,7 +166,7 @@
 					}
 					newfunc = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
 					if (!newfunc) {
-						err ("out of system memory \n");
+						err ("out of system memory\n");
 						return -ENOMEM;
 					}
 					memset (newfunc, 0, sizeof (struct pci_func));
@@ -188,7 +188,7 @@
 					rc = configure_bridge (&cur_func, slotno);
 					if (rc == -ENODEV) {
 						err ("You chose to insert Single Bridge, or nested bridges, this is not supported...\n");
-						err ("Bus %x, devfunc %x \n", cur_func->busno, cur_func->device);
+						err ("Bus %x, devfunc %x\n", cur_func->busno, cur_func->device);
 						return rc;
 					}
 					if (rc) {
@@ -205,7 +205,7 @@
 						if (func->devices[i]) {
 							newfunc = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
 							if (!newfunc) {
-								err ("out of system memory \n");
+								err ("out of system memory\n");
 								return -ENOMEM;
 							}
 							memset (newfunc, 0, sizeof (struct pci_func));
@@ -234,7 +234,7 @@
 
 					newfunc = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
 					if (!newfunc) {
-						err ("out of system memory \n");
+						err ("out of system memory\n");
 						return -ENOMEM;
 					}
 					memset (newfunc, 0, sizeof (struct pci_func));
@@ -261,7 +261,7 @@
 					rc = configure_bridge (&cur_func, slotno);
 					if (rc == -ENODEV) {
 						err ("You chose to insert Single Bridge, or nested bridges, this is not supported...\n");
-						err ("Bus %x, devfunc %x \n", cur_func->busno, cur_func->device);
+						err ("Bus %x, devfunc %x\n", cur_func->busno, cur_func->device);
 						return rc;
 					}
 					if (rc) {
@@ -281,7 +281,7 @@
 							debug ("inside for loop, device is %x\n", i);
 							newfunc = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
 							if (!newfunc) {
-								err (" out of system memory \n");
+								err (" out of system memory\n");
 								return -ENOMEM;
 							}
 							memset (newfunc, 0, sizeof (struct pci_func));
@@ -408,7 +408,7 @@
 			io[count] = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 
 			if (!io[count]) {
-				err ("out of system memory \n");
+				err ("out of system memory\n");
 				return -ENOMEM;
 			}
 			memset (io[count], 0, sizeof (struct resource_node));
@@ -446,7 +446,7 @@
 
 				pfmem[count] = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 				if (!pfmem[count]) {
-					err ("out of system memory \n");
+					err ("out of system memory\n");
 					return -ENOMEM;
 				}
 				memset (pfmem[count], 0, sizeof (struct resource_node));
@@ -461,7 +461,7 @@
 				} else {
 					mem_tmp = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 					if (!mem_tmp) {
-						err ("out of system memory \n");
+						err ("out of system memory\n");
 						kfree (pfmem[count]);
 						return -ENOMEM;
 					}
@@ -513,7 +513,7 @@
 
 				mem[count] = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 				if (!mem[count]) {
-					err ("out of system memory \n");
+					err ("out of system memory\n");
 					return -ENOMEM;
 				}
 				memset (mem[count], 0, sizeof (struct resource_node));
@@ -620,7 +620,7 @@
 	/* in EBDA, only get allocated 1 additional bus # per slot */
 	sec_number = find_sec_number (func->busno, slotno);
 	if (sec_number == 0xff) {
-		err ("cannot allocate secondary bus number for the bridged device \n");
+		err ("cannot allocate secondary bus number for the bridged device\n");
 		return -EINVAL;
 	}
 
@@ -678,7 +678,7 @@
 			bus_io[count] = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 		
 			if (!bus_io[count]) {
-				err ("out of system memory \n");
+				err ("out of system memory\n");
 				retval = -ENOMEM;
 				goto error;
 			}
@@ -710,7 +710,7 @@
 
 				bus_pfmem[count] = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 				if (!bus_pfmem[count]) {
-					err ("out of system memory \n");
+					err ("out of system memory\n");
 					retval = -ENOMEM;
 					goto error;
 				}
@@ -726,7 +726,7 @@
 				} else {
 					mem_tmp = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 					if (!mem_tmp) {
-						err ("out of system memory \n");
+						err ("out of system memory\n");
 						retval = -ENOMEM;
 						goto error;
 					}
@@ -768,7 +768,7 @@
 
 				bus_mem[count] = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 				if (!bus_mem[count]) {
-					err ("out of system memory \n");
+					err ("out of system memory\n");
 					retval = -ENOMEM;
 					goto error;
 				}
@@ -813,7 +813,7 @@
 	debug ("amount_needed->pfmem =  %x\n", amount_needed->pfmem);
 
 	if (amount_needed->not_correct) {		
-		debug ("amount_needed is not correct \n");
+		debug ("amount_needed is not correct\n");
 		for (count = 0; address[count]; count++) {
 			/* for 2 BARs */
 			if (bus_io[count]) {
@@ -835,11 +835,11 @@
 		debug ("it doesn't want IO?\n");
 		flag_io = TRUE;
 	} else {
-		debug ("it wants %x IO behind the bridge \n", amount_needed->io);
+		debug ("it wants %x IO behind the bridge\n", amount_needed->io);
 		io = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 		
 		if (!io) {
-			err ("out of system memory \n");
+			err ("out of system memory\n");
 			retval = -ENOMEM;
 			goto error;
 		}
@@ -862,7 +862,7 @@
 		debug ("it wants %x memory behind the bridge\n", amount_needed->mem);
 		mem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 		if (!mem) {
-			err ("out of system memory \n");
+			err ("out of system memory\n");
 			retval = -ENOMEM;
 			goto error;
 		}
@@ -885,7 +885,7 @@
 		debug ("it wants %x pfmemory behind the bridge\n", amount_needed->pfmem);
 		pfmem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 		if (!pfmem) {
-			err ("out of system memory \n");
+			err ("out of system memory\n");
 			retval = -ENOMEM;
 			goto error;
 		}
@@ -901,7 +901,7 @@
 		} else {
 			mem_tmp = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 			if (!mem_tmp) {
-				err ("out of system memory \n");
+				err ("out of system memory\n");
 				retval = -ENOMEM;
 				goto error;
 			}
@@ -933,7 +933,7 @@
 		if (!bus) {
 			bus = kmalloc (sizeof (struct bus_node), GFP_KERNEL);
 			if (!bus) {
-				err ("out of system memory \n");
+				err ("out of system memory\n");
 				retval = -ENOMEM;
 				goto error;
 			}
@@ -944,7 +944,7 @@
 		} else if (!(bus->rangeIO) && !(bus->rangeMem) && !(bus->rangePFMem))
 			rc = add_new_bus (bus, io, mem, pfmem, 0xFF);
 		else {
-			err ("expected bus structure not empty? \n");
+			err ("expected bus structure not empty?\n");
 			retval = -EIO;
 			goto error;
 		}
@@ -1050,7 +1050,7 @@
 		kfree (amount_needed);
 		return 0;
 	} else {
-		err ("Configuring bridge was unsuccessful... \n");
+		err ("Configuring bridge was unsuccessful...\n");
 		mem_tmp = NULL;
 		retval = -EIO;
 		goto error;
@@ -1171,7 +1171,7 @@
 
 					//tmp_bar = bar[count];
 
-					debug ("count %d device %x function %x wants %x resources \n", count, device, function, bar[count]);
+					debug ("count %d device %x function %x wants %x resources\n", count, device, function, bar[count]);
 
 					if (bar[count] & PCI_BASE_ADDRESS_SPACE_IO) {
 						/* This is IO */
@@ -1522,7 +1522,7 @@
 				case PCI_HEADER_TYPE_NORMAL:
 					rc = unconfigure_boot_device (busno, device, function);
 					if (rc) {
-						err ("was not able to unconfigure device %x func %x on bus %x. bailing out... \n",
+						err ("was not able to unconfigure device %x func %x on bus %x. bailing out...\n",
 						     device, function, busno);
 						return rc;
 					}
@@ -1531,7 +1531,7 @@
 				case PCI_HEADER_TYPE_MULTIDEVICE:
 					rc = unconfigure_boot_device (busno, device, function);
 					if (rc) {
-						err ("was not able to unconfigure device %x func %x on bus %x. bailing out... \n",
+						err ("was not able to unconfigure device %x func %x on bus %x. bailing out...\n",
 						     device, function, busno);
 						return rc;
 					}
@@ -1567,7 +1567,7 @@
 					}
 					break;
 				default:
-					err ("MAJOR PROBLEM!!!! Cannot read device's header \n");
+					err ("MAJOR PROBLEM!!!! Cannot read device's header\n");
 					return -1;
 					break;
 			}	/* end of switch */
@@ -1575,7 +1575,7 @@
 	}	/* end of for */
 
 	if (!valid_device) {
-		err ("Could not find device to unconfigure.  Or could not read the card. \n");
+		err ("Could not find device to unconfigure.  Or could not read the card.\n");
 		return -1;
 	}
 	return 0;
@@ -1623,19 +1623,19 @@
 
 			for (i = 0; i < count; i++) {
 				if (cur_func->io[i]) {
-					debug ("io[%d] exists \n", i);
+					debug ("io[%d] exists\n", i);
 					if (the_end > 0)
 						ibmphp_remove_resource (cur_func->io[i]);
 					cur_func->io[i] = NULL;
 				}
 				if (cur_func->mem[i]) {
-					debug ("mem[%d] exists \n", i);
+					debug ("mem[%d] exists\n", i);
 					if (the_end > 0)
 						ibmphp_remove_resource (cur_func->mem[i]);
 					cur_func->mem[i] = NULL;
 				}
 				if (cur_func->pfmem[i]) {
-					debug ("pfmem[%d] exists \n", i);
+					debug ("pfmem[%d] exists\n", i);
 					if (the_end > 0)
 						ibmphp_remove_resource (cur_func->pfmem[i]);
 					cur_func->pfmem[i] = NULL;
@@ -1682,7 +1682,7 @@
 	if (io) {
 		io_range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
 		if (!io_range) {
-			err ("out of system memory \n");
+			err ("out of system memory\n");
 			return -ENOMEM;
 		}
 		memset (io_range, 0, sizeof (struct range_node));
@@ -1695,7 +1695,7 @@
 	if (mem) {
 		mem_range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
 		if (!mem_range) {
-			err ("out of system memory \n");
+			err ("out of system memory\n");
 			return -ENOMEM;
 		}
 		memset (mem_range, 0, sizeof (struct range_node));
@@ -1708,7 +1708,7 @@
 	if (pfmem) {
 		pfmem_range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
 		if (!pfmem_range) {	
-			err ("out of system memory \n");
+			err ("out of system memory\n");
 			return -ENOMEM;
 		}
 		memset (pfmem_range, 0, sizeof (struct range_node));
diff -Nru a/drivers/pci/hotplug/ibmphp_res.c b/drivers/pci/hotplug/ibmphp_res.c
--- a/drivers/pci/hotplug/ibmphp_res.c	Mon Feb  9 14:59:18 2004
+++ b/drivers/pci/hotplug/ibmphp_res.c	Mon Feb  9 14:59:18 2004
@@ -52,13 +52,13 @@
 	struct bus_node * newbus;
 
 	if (!(curr) && !(flag)) {
-		err ("NULL pointer passed \n");
+		err ("NULL pointer passed\n");
 		return NULL;
 	}
 
 	newbus = kmalloc (sizeof (struct bus_node), GFP_KERNEL);
 	if (!newbus) {
-		err ("out of system memory \n");
+		err ("out of system memory\n");
 		return NULL;
 	}
 
@@ -76,13 +76,13 @@
 	struct resource_node *rs;
 	
 	if (!curr) {
-		err ("NULL passed to allocate \n");
+		err ("NULL passed to allocate\n");
 		return NULL;
 	}
 
 	rs = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 	if (!rs) {
-		err ("out of system memory \n");
+		err ("out of system memory\n");
 		return NULL;
 	}
 	memset (rs, 0, sizeof (struct resource_node));
@@ -103,7 +103,7 @@
 	if (first_bus) {
 		newbus = kmalloc (sizeof (struct bus_node), GFP_KERNEL);
 		if (!newbus) {
-			err ("out of system memory. \n");
+			err ("out of system memory.\n");
 			return -ENOMEM;
 		}
 		memset (newbus, 0, sizeof (struct bus_node));
@@ -127,7 +127,7 @@
 	if (!newrange) {
 		if (first_bus)
 			kfree (newbus);
-		err ("out of system memory \n");
+		err ("out of system memory\n");
 		return -ENOMEM;
 	}
 	memset (newrange, 0, sizeof (struct range_node));
@@ -607,7 +607,7 @@
 	debug ("%s - enter\n", __FUNCTION__);
 
 	if (!res) {
-		err ("NULL passed to add \n");
+		err ("NULL passed to add\n");
 		return -ENODEV;
 	}
 	
@@ -634,7 +634,7 @@
 			res_start = bus_cur->firstPFMem;
 			break;
 		default:
-			err ("cannot read the type of the resource to add... problem \n");
+			err ("cannot read the type of the resource to add... problem\n");
 			return -EINVAL;
 	}
 	while (range_cur) {
@@ -787,7 +787,7 @@
 	char * type = "";
 
 	if (!res)  {
-		err ("resource to remove is NULL \n");
+		err ("resource to remove is NULL\n");
 		return -ENODEV;
 	}
 
@@ -813,7 +813,7 @@
 			type = "pfmem";
 			break;
 		default:
-			err ("unknown type for resource to remove \n");
+			err ("unknown type for resource to remove\n");
 			return -EINVAL;
 	}
 	res_prev = NULL;
@@ -954,7 +954,7 @@
 			range = bus_cur->rangePFMem;
 			break;
 		default:
-			err ("cannot read resource type in find_range \n");
+			err ("cannot read resource type in find_range\n");
 	}
 
 	while (range) {
@@ -1002,7 +1002,7 @@
 
 	if (!bus_cur) {
 		/* didn't find a bus, smth's wrong!!! */
-		debug ("no bus in the system, either pci_dev's wrong or allocation failed \n");
+		debug ("no bus in the system, either pci_dev's wrong or allocation failed\n");
 		return -EINVAL;
 	}
 
@@ -1027,7 +1027,7 @@
 			noranges = bus_cur->noPFMemRanges;
 			break;
 		default:
-			err ("wrong type of resource to check \n");
+			err ("wrong type of resource to check\n");
 			return -EINVAL;
 	}
 	res_prev = NULL;
@@ -1496,7 +1496,7 @@
 	char * type = "";
 
 	if (!bus) {
-		err ("The bus passed in NULL to find resource \n");
+		err ("The bus passed in NULL to find resource\n");
 		return -ENODEV;
 	}
 
@@ -1514,7 +1514,7 @@
 			type = "pfmem";
 			break;
 		default:
-			err ("wrong type of flag \n");
+			err ("wrong type of flag\n");
 			return -EINVAL;
 	}
 	
@@ -1540,17 +1540,17 @@
 				res_cur = res_cur->next;
 			}
 			if (!res_cur) {
-				debug ("SOS...cannot find %s resource in the bus. \n", type);
+				debug ("SOS...cannot find %s resource in the bus.\n", type);
 				return -EINVAL;
 			}
 		} else {
-			debug ("SOS... cannot find %s resource in the bus. \n", type);
+			debug ("SOS... cannot find %s resource in the bus.\n", type);
 			return -EINVAL;
 		}
 	}
 
 	if (*res)
-		debug ("*res->start = %x \n", (*res)->start);
+		debug ("*res->start = %x\n", (*res)->start);
 
 	return 0;
 }
@@ -1708,7 +1708,7 @@
 
 				mem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);		
 				if (!mem) {
-					err ("out of system memory \n");
+					err ("out of system memory\n");
 					return -ENOMEM;
 				}
 				memset (mem, 0, sizeof (struct resource_node));
@@ -1792,7 +1792,7 @@
 
 	list_for_each (tmp, &gbuses) {
 		bus_cur = list_entry (tmp, struct bus_node, bus_list);
-		debug_pci ("This is bus # %d.  There are \n", bus_cur->busno);
+		debug_pci ("This is bus # %d.  There are\n", bus_cur->busno);
 		debug_pci ("IORanges = %d\t", bus_cur->noIORanges);
 		debug_pci ("MemRanges = %d\t", bus_cur->noMemRanges);
 		debug_pci ("PFMemRanges = %d\n", bus_cur->noPFMemRanges);
@@ -1903,7 +1903,7 @@
 			range_cur = bus_cur->rangePFMem;
 			break;
 		default:
-			err ("wrong type passed to find out if range already exists \n");
+			err ("wrong type passed to find out if range already exists\n");
 			return -ENODEV;
 	}
 
@@ -1948,7 +1948,7 @@
 		return -ENODEV;
 	ibmphp_pci_bus->number = bus_cur->busno;
 
-	debug ("inside %s \n", __FUNCTION__);
+	debug ("inside %s\n", __FUNCTION__);
 	debug ("bus_cur->busno = %x\n", bus_cur->busno);
 
 	for (device = 0; device < 32; device++) {
@@ -1997,7 +1997,7 @@
 						if ((start_address) && (start_address <= end_address)) {
 							range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
 							if (!range) {
-								err ("out of system memory \n");
+								err ("out of system memory\n");
 								return -ENOMEM;
 							}
 							memset (range, 0, sizeof (struct range_node));
@@ -2024,7 +2024,7 @@
 								io = kmalloc (sizeof (struct resource_node), GFP_KERNEL);							
 								if (!io) {
 									kfree (range);
-									err ("out of system memory \n");
+									err ("out of system memory\n");
 									return -ENOMEM;
 								}
 								memset (io, 0, sizeof (struct resource_node));
@@ -2048,7 +2048,7 @@
 
 							range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
 							if (!range) {
-								err ("out of system memory \n");
+								err ("out of system memory\n");
 								return -ENOMEM;
 							}
 							memset (range, 0, sizeof (struct range_node));
@@ -2076,7 +2076,7 @@
 								mem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 								if (!mem) {
 									kfree (range);
-									err ("out of system memory \n");
+									err ("out of system memory\n");
 									return -ENOMEM;
 								}
 								memset (mem, 0, sizeof (struct resource_node));
@@ -2104,7 +2104,7 @@
 
 							range = kmalloc (sizeof (struct range_node), GFP_KERNEL);
 							if (!range) {
-								err ("out of system memory \n");
+								err ("out of system memory\n");
 								return -ENOMEM;
 							}
 							memset (range, 0, sizeof (struct range_node));
@@ -2131,7 +2131,7 @@
 								pfmem = kmalloc (sizeof (struct resource_node), GFP_KERNEL);
 								if (!pfmem) {
 									kfree (range);
-									err ("out of system memory \n");
+									err ("out of system memory\n");
 									return -ENOMEM;
 								}
 								memset (pfmem, 0, sizeof (struct resource_node));

