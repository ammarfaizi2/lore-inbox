Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVAJReJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVAJReJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVAJReJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:34:09 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:29076 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262360AbVAJRVH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:07 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776572169@kroah.com>
Date: Mon, 10 Jan 2005 09:20:57 -0800
Message-Id: <11053776574186@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.4, 2004/12/16 15:59:19-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: ibmphp_core.c: coding style

this is a cleanup patch for ibmphp_core.c. It does not change anything, it
only wraps long lines and removes spaces before opening braces of funtions.

Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp_core.c |  788 ++++++++++++++++++++------------------
 1 files changed, 432 insertions(+), 356 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	2005-01-10 09:05:15 -08:00
+++ b/drivers/pci/hotplug/ibmphp_core.c	2005-01-10 09:05:15 -08:00
@@ -59,7 +59,8 @@
 struct pci_bus *ibmphp_pci_bus;
 static int max_slots;
 
-static int irqs[16];    /* PIC mode IRQ's we're using so far (in case MPS tables don't provide default info for empty slots */
+static int irqs[16];    /* PIC mode IRQ's we're using so far (in case MPS
+			 * tables don't provide default info for empty slots */
 
 static int init_flag;
 
@@ -71,36 +72,40 @@
 	return get_max_adapter_speed_1 (hs, value, 1);
 }
 */
-static inline int get_cur_bus_info (struct slot **sl) 
+static inline int get_cur_bus_info(struct slot **sl) 
 {
 	int rc = 1;
 	struct slot * slot_cur = *sl;
 
-	debug ("options = %x\n", slot_cur->ctrl->options);
-	debug ("revision = %x\n", slot_cur->ctrl->revision);	
+	debug("options = %x\n", slot_cur->ctrl->options);
+	debug("revision = %x\n", slot_cur->ctrl->revision);	
 
-	if (READ_BUS_STATUS (slot_cur->ctrl)) 
-		rc = ibmphp_hpc_readslot (slot_cur, READ_BUSSTATUS, NULL);
+	if (READ_BUS_STATUS(slot_cur->ctrl)) 
+		rc = ibmphp_hpc_readslot(slot_cur, READ_BUSSTATUS, NULL);
 	
 	if (rc) 
 		return rc;
 	  
-	slot_cur->bus_on->current_speed = CURRENT_BUS_SPEED (slot_cur->busstatus);
-	if (READ_BUS_MODE (slot_cur->ctrl))
-		slot_cur->bus_on->current_bus_mode = CURRENT_BUS_MODE (slot_cur->busstatus);
+	slot_cur->bus_on->current_speed = CURRENT_BUS_SPEED(slot_cur->busstatus);
+	if (READ_BUS_MODE(slot_cur->ctrl))
+		slot_cur->bus_on->current_bus_mode =
+				CURRENT_BUS_MODE(slot_cur->busstatus);
 	else
 		slot_cur->bus_on->current_bus_mode = 0xFF;
 
-	debug ("busstatus = %x, bus_speed = %x, bus_mode = %x\n", slot_cur->busstatus, slot_cur->bus_on->current_speed, slot_cur->bus_on->current_bus_mode);
+	debug("busstatus = %x, bus_speed = %x, bus_mode = %x\n",
+			slot_cur->busstatus,
+			slot_cur->bus_on->current_speed,
+			slot_cur->bus_on->current_bus_mode);
 	
 	*sl = slot_cur;
 	return 0;
 }
 
-static inline int slot_update (struct slot **sl)
+static inline int slot_update(struct slot **sl)
 {
 	int rc;
- 	rc = ibmphp_hpc_readslot (*sl, READ_ALLSTAT, NULL);
+ 	rc = ibmphp_hpc_readslot(*sl, READ_ALLSTAT, NULL);
 	if (rc) 
 		return rc;
 	if (!init_flag)
@@ -114,10 +119,10 @@
 	struct list_head * tmp;
 	u8 slot_count = 0;
 
-	list_for_each (tmp, &ibmphp_slot_head) {
-		slot_cur = list_entry (tmp, struct slot, ibm_slot_list);
+	list_for_each(tmp, &ibmphp_slot_head) {
+		slot_cur = list_entry(tmp, struct slot, ibm_slot_list);
 		/* sometimes the hot-pluggable slots start with 4 (not always from 1) */
-		slot_count = max (slot_count, slot_cur->number);
+		slot_count = max(slot_count, slot_cur->number);
 	}
 	return slot_count;
 }
@@ -128,46 +133,61 @@
  * Parameters: struct slot
  * Returns 0 or errors
  */
-int ibmphp_init_devno (struct slot **cur_slot)
+int ibmphp_init_devno(struct slot **cur_slot)
 {
 	struct irq_routing_table *rtable;
 	int len;
 	int loop;
 	int i;
 
-	rtable = pcibios_get_irq_routing_table ();
+	rtable = pcibios_get_irq_routing_table();
 	if (!rtable) {
-		err ("no BIOS routing table...\n");
+		err("no BIOS routing table...\n");
 		return -ENOMEM;
 	}
 
-	len = (rtable->size - sizeof (struct irq_routing_table)) / sizeof (struct irq_info);
+	len = (rtable->size - sizeof(struct irq_routing_table)) /
+			sizeof(struct irq_info);
 
 	if (!len)
 		return -1;
 	for (loop = 0; loop < len; loop++) {
 		if ((*cur_slot)->number == rtable->slots[loop].slot) {
 		if ((*cur_slot)->bus == rtable->slots[loop].bus) {
-			(*cur_slot)->device = PCI_SLOT (rtable->slots[loop].devfn);
+			(*cur_slot)->device = PCI_SLOT(rtable->slots[loop].devfn);
 			for (i = 0; i < 4; i++)
-				(*cur_slot)->irq[i] = IO_APIC_get_PCI_irq_vector ((int) (*cur_slot)->bus, (int) (*cur_slot)->device, i);
+				(*cur_slot)->irq[i] = IO_APIC_get_PCI_irq_vector((int) (*cur_slot)->bus,
+						(int) (*cur_slot)->device, i);
 
-				debug ("(*cur_slot)->irq[0] = %x\n", (*cur_slot)->irq[0]);
-				debug ("(*cur_slot)->irq[1] = %x\n", (*cur_slot)->irq[1]);
-				debug ("(*cur_slot)->irq[2] = %x\n", (*cur_slot)->irq[2]);
-				debug ("(*cur_slot)->irq[3] = %x\n", (*cur_slot)->irq[3]);
-
-				debug ("rtable->exlusive_irqs = %x\n", rtable->exclusive_irqs);
-				debug ("rtable->slots[loop].irq[0].bitmap = %x\n", rtable->slots[loop].irq[0].bitmap);
-				debug ("rtable->slots[loop].irq[1].bitmap = %x\n", rtable->slots[loop].irq[1].bitmap);
-				debug ("rtable->slots[loop].irq[2].bitmap = %x\n", rtable->slots[loop].irq[2].bitmap);
-				debug ("rtable->slots[loop].irq[3].bitmap = %x\n", rtable->slots[loop].irq[3].bitmap);
-
-				debug ("rtable->slots[loop].irq[0].link= %x\n", rtable->slots[loop].irq[0].link);
-				debug ("rtable->slots[loop].irq[1].link = %x\n", rtable->slots[loop].irq[1].link);
-				debug ("rtable->slots[loop].irq[2].link = %x\n", rtable->slots[loop].irq[2].link);
-				debug ("rtable->slots[loop].irq[3].link = %x\n", rtable->slots[loop].irq[3].link);
-				debug ("end of init_devno\n");
+				debug("(*cur_slot)->irq[0] = %x\n",
+						(*cur_slot)->irq[0]);
+				debug("(*cur_slot)->irq[1] = %x\n",
+						(*cur_slot)->irq[1]);
+				debug("(*cur_slot)->irq[2] = %x\n",
+						(*cur_slot)->irq[2]);
+				debug("(*cur_slot)->irq[3] = %x\n",
+						(*cur_slot)->irq[3]);
+
+				debug("rtable->exlusive_irqs = %x\n",
+					rtable->exclusive_irqs);
+				debug("rtable->slots[loop].irq[0].bitmap = %x\n",
+					rtable->slots[loop].irq[0].bitmap);
+				debug("rtable->slots[loop].irq[1].bitmap = %x\n",
+					rtable->slots[loop].irq[1].bitmap);
+				debug("rtable->slots[loop].irq[2].bitmap = %x\n",
+					rtable->slots[loop].irq[2].bitmap);
+				debug("rtable->slots[loop].irq[3].bitmap = %x\n",
+					rtable->slots[loop].irq[3].bitmap);
+
+				debug("rtable->slots[loop].irq[0].link = %x\n",
+					rtable->slots[loop].irq[0].link);
+				debug("rtable->slots[loop].irq[1].link = %x\n",
+					rtable->slots[loop].irq[1].link);
+				debug("rtable->slots[loop].irq[2].link = %x\n",
+					rtable->slots[loop].irq[2].link);
+				debug("rtable->slots[loop].irq[3].link = %x\n",
+					rtable->slots[loop].irq[3].link);
+				debug("end of init_devno\n");
 				return 0;
 			}
 		}
@@ -176,49 +196,50 @@
 	return -1;
 }
 
-static inline int power_on (struct slot *slot_cur)
+static inline int power_on(struct slot *slot_cur)
 {
 	u8 cmd = HPC_SLOT_ON;
 	int retval;
 
-	retval = ibmphp_hpc_writeslot (slot_cur, cmd);
+	retval = ibmphp_hpc_writeslot(slot_cur, cmd);
 	if (retval) {
-		err ("power on failed\n");
+		err("power on failed\n");
 		return retval;
 	}
-	if (CTLR_RESULT (slot_cur->ctrl->status)) {
-		err ("command not completed successfully in power_on\n");
+	if (CTLR_RESULT(slot_cur->ctrl->status)) {
+		err("command not completed successfully in power_on\n");
 		return -EIO;
 	}
 	msleep(3000);	/* For ServeRAID cards, and some 66 PCI */
 	return 0;
 }
 
-static inline int power_off (struct slot *slot_cur)
+static inline int power_off(struct slot *slot_cur)
 {
 	u8 cmd = HPC_SLOT_OFF;
 	int retval;
 
-	retval = ibmphp_hpc_writeslot (slot_cur, cmd);
+	retval = ibmphp_hpc_writeslot(slot_cur, cmd);
 	if (retval) {
-		err ("power off failed\n");
+		err("power off failed\n");
 		return retval;
 	}
-	if (CTLR_RESULT (slot_cur->ctrl->status)) {
-		err ("command not completed successfully in power_off\n");
+	if (CTLR_RESULT(slot_cur->ctrl->status)) {
+		err("command not completed successfully in power_off\n");
 		retval = -EIO;
 	}
 	return retval;
 }
 
-static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 value)
+static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 {
 	int rc = 0;
 	struct slot *pslot;
 	u8 cmd;
 
-	debug ("set_attention_status - Entry hotplug_slot[%lx] value[%x]\n", (ulong) hotplug_slot, value);
-	ibmphp_lock_operations ();
+	debug("set_attention_status - Entry hotplug_slot[%lx] value[%x]\n",
+			(ulong) hotplug_slot, value);
+	ibmphp_lock_operations();
 	cmd = 0x00;     // avoid compiler warning
 
 	if (hotplug_slot) {
@@ -234,7 +255,8 @@
 			break;
 		default:
 			rc = -ENODEV;
-			err ("set_attention_status - Error : invalid input [%x]\n", value);
+			err("set_attention_status - Error : invalid input [%x]\n",
+					value);
 			break;
 		}
 		if (rc == 0) {
@@ -247,101 +269,118 @@
 	} else	
 		rc = -ENODEV;
 
-	ibmphp_unlock_operations ();
+	ibmphp_unlock_operations();
 
-	debug ("set_attention_status - Exit rc[%d]\n", rc);
+	debug("set_attention_status - Exit rc[%d]\n", rc);
 	return rc;
 }
 
-static int get_attention_status (struct hotplug_slot *hotplug_slot, u8 * value)
+static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 * value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
 	struct slot myslot;
 
-	debug ("get_attention_status - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong) hotplug_slot, (ulong) value);
+	debug("get_attention_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
+					(ulong) hotplug_slot, (ulong) value);
         
-	ibmphp_lock_operations ();
+	ibmphp_lock_operations();
 	if (hotplug_slot && value) {
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
-			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
-			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &(myslot.status));
+			memcpy((void *) &myslot, (void *) pslot,
+						sizeof(struct slot));
+			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
+						&(myslot.status));
 			if (!rc)
-				rc = ibmphp_hpc_readslot(pslot, READ_EXTSLOTSTATUS, &(myslot.ext_status));
+				rc = ibmphp_hpc_readslot(pslot,
+						READ_EXTSLOTSTATUS,
+						&(myslot.ext_status));
 			if (!rc)
-				*value = SLOT_ATTN (myslot.status, myslot.ext_status);
+				*value = SLOT_ATTN(myslot.status,
+						myslot.ext_status);
 		}
 	}
 
-	ibmphp_unlock_operations ();
+	ibmphp_unlock_operations();
 	debug("get_attention_status - Exit rc[%d] value[%x]\n", rc, *value);
 	return rc;
 }
 
-static int get_latch_status (struct hotplug_slot *hotplug_slot, u8 * value)
+static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 * value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
 	struct slot myslot;
 
-	debug ("get_latch_status - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong) hotplug_slot, (ulong) value);
-	ibmphp_lock_operations ();
+	debug("get_latch_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
+					(ulong) hotplug_slot, (ulong) value);
+	ibmphp_lock_operations();
 	if (hotplug_slot && value) {
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
-			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
-			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &(myslot.status));
+			memcpy((void *) &myslot, (void *) pslot,
+						sizeof(struct slot));
+			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
+						&(myslot.status));
 			if (!rc)
-				*value = SLOT_LATCH (myslot.status);
+				*value = SLOT_LATCH(myslot.status);
 		}
 	}
 
-	ibmphp_unlock_operations ();
-	debug("get_latch_status - Exit rc[%d] rc[%x] value[%x]\n", rc, rc, *value);
+	ibmphp_unlock_operations();
+	debug("get_latch_status - Exit rc[%d] rc[%x] value[%x]\n",
+			rc, rc, *value);
 	return rc;
 }
 
 
-static int get_power_status (struct hotplug_slot *hotplug_slot, u8 * value)
+static int get_power_status(struct hotplug_slot *hotplug_slot, u8 * value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
 	struct slot myslot;
 
-	debug ("get_power_status - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong) hotplug_slot, (ulong) value);
-	ibmphp_lock_operations ();
+	debug("get_power_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
+					(ulong) hotplug_slot, (ulong) value);
+	ibmphp_lock_operations();
 	if (hotplug_slot && value) {
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
-			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
-			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &(myslot.status));
+			memcpy((void *) &myslot, (void *) pslot,
+						sizeof(struct slot));
+			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
+						&(myslot.status));
 			if (!rc)
-				*value = SLOT_PWRGD (myslot.status);
+				*value = SLOT_PWRGD(myslot.status);
 		}
 	}
 
-	ibmphp_unlock_operations ();
-	debug("get_power_status - Exit rc[%d] rc[%x] value[%x]\n", rc, rc, *value);
+	ibmphp_unlock_operations();
+	debug("get_power_status - Exit rc[%d] rc[%x] value[%x]\n",
+			rc, rc, *value);
 	return rc;
 }
 
-static int get_adapter_present (struct hotplug_slot *hotplug_slot, u8 * value)
+static int get_adapter_present(struct hotplug_slot *hotplug_slot, u8 * value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
 	u8 present;
 	struct slot myslot;
 
-	debug ("get_adapter_status - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong) hotplug_slot, (ulong) value);
-	ibmphp_lock_operations ();
+	debug("get_adapter_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
+					(ulong) hotplug_slot, (ulong) value);
+	ibmphp_lock_operations();
 	if (hotplug_slot && value) {
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
-			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
-			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &(myslot.status));
+			memcpy((void *) &myslot, (void *) pslot,
+						sizeof(struct slot));
+			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
+						&(myslot.status));
 			if (!rc) {
-				present = SLOT_PRESENT (myslot.status);
+				present = SLOT_PRESENT(myslot.status);
 				if (present == HPC_SLOT_EMPTY)
 					*value = 0;
 				else
@@ -350,21 +389,21 @@
 		}
 	}
 
-	ibmphp_unlock_operations ();
+	ibmphp_unlock_operations();
 	debug("get_adapter_present - Exit rc[%d] value[%x]\n", rc, *value);
 	return rc;
 }
 
-static int get_max_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+static int get_max_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
 	u8 mode = 0;
 
-	debug ("%s - Entry hotplug_slot[%p] pvalue[%p]\n", __FUNCTION__,
+	debug("%s - Entry hotplug_slot[%p] pvalue[%p]\n", __FUNCTION__,
 		hotplug_slot, value);
 
-	ibmphp_lock_operations ();
+	ibmphp_lock_operations();
 
 	if (hotplug_slot && value) {
 		pslot = (struct slot *) hotplug_slot->private;
@@ -390,26 +429,26 @@
 		}
 	}
 
-	ibmphp_unlock_operations ();
-	debug ("%s - Exit rc[%d] value[%x]\n", __FUNCTION__, rc, *value);
+	ibmphp_unlock_operations();
+	debug("%s - Exit rc[%d] value[%x]\n", __FUNCTION__, rc, *value);
 	return rc;
 }
 
-static int get_cur_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+static int get_cur_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
 	u8 mode = 0;
 
-	debug ("%s - Entry hotplug_slot[%p] pvalue[%p]\n", __FUNCTION__,
+	debug("%s - Entry hotplug_slot[%p] pvalue[%p]\n", __FUNCTION__,
 		hotplug_slot, value);
 
-	ibmphp_lock_operations ();
+	ibmphp_lock_operations();
 
 	if (hotplug_slot && value) {
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
-			rc = get_cur_bus_info (&pslot);
+			rc = get_cur_bus_info(&pslot);
 			if (!rc) {
 				mode = pslot->bus_on->current_bus_mode;
 				*value = pslot->bus_on->current_speed;
@@ -436,121 +475,130 @@
 		}
 	}
 
-	ibmphp_unlock_operations ();
-	debug ("%s - Exit rc[%d] value[%x]\n", __FUNCTION__, rc, *value);
+	ibmphp_unlock_operations();
+	debug("%s - Exit rc[%d] value[%x]\n", __FUNCTION__, rc, *value);
 	return rc;
 }
+
 /*
-static int get_max_adapter_speed_1 (struct hotplug_slot *hotplug_slot, u8 * value, u8 flag)
+static int get_max_adapter_speed_1(struct hotplug_slot *hotplug_slot, u8 * value, u8 flag)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
 	struct slot myslot;
 
-	debug ("get_max_adapter_speed_1 - Entry hotplug_slot[%lx] pvalue[%lx]\n", (ulong)hotplug_slot, (ulong) value);
+	debug("get_max_adapter_speed_1 - Entry hotplug_slot[%lx] pvalue[%lx]\n",
+						(ulong)hotplug_slot, (ulong) value);
 
 	if (flag)
-		ibmphp_lock_operations ();
+		ibmphp_lock_operations();
 
 	if (hotplug_slot && value) {
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
-			memcpy ((void *) &myslot, (void *) pslot, sizeof (struct slot));
-			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &(myslot.status));
-
-			if (!(SLOT_LATCH (myslot.status)) && (SLOT_PRESENT (myslot.status))) {
-				rc = ibmphp_hpc_readslot(pslot, READ_EXTSLOTSTATUS, &(myslot.ext_status));
+			memcpy((void *) &myslot, (void *) pslot,
+						sizeof(struct slot));
+			rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
+						&(myslot.status));
+
+			if (!(SLOT_LATCH (myslot.status)) &&
+					(SLOT_PRESENT (myslot.status))) {
+				rc = ibmphp_hpc_readslot(pslot,
+						READ_EXTSLOTSTATUS,
+						&(myslot.ext_status));
 				if (!rc)
-					*value = SLOT_SPEED (myslot.ext_status);
+					*value = SLOT_SPEED(myslot.ext_status);
 			} else
 				*value = MAX_ADAPTER_NONE;
                 }
 	}
 
 	if (flag)
-		ibmphp_unlock_operations ();
+		ibmphp_unlock_operations();
 
 	debug("get_max_adapter_speed_1 - Exit rc[%d] value[%x]\n", rc, *value);
 	return rc;
 }
 
-static int get_bus_name (struct hotplug_slot *hotplug_slot, char * value)
+static int get_bus_name(struct hotplug_slot *hotplug_slot, char * value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot = NULL;
 
-	debug ("get_bus_name - Entry hotplug_slot[%lx]\n", (ulong)hotplug_slot);
+	debug("get_bus_name - Entry hotplug_slot[%lx]\n", (ulong)hotplug_slot);
 
-	ibmphp_lock_operations ();
+	ibmphp_lock_operations();
 
 	if (hotplug_slot) {
 		pslot = (struct slot *) hotplug_slot->private;
 		if (pslot) {
 			rc = 0;
-			snprintf (value, 100, "Bus %x", pslot->bus);
+			snprintf(value, 100, "Bus %x", pslot->bus);
 		}
 	} else
 		rc = -ENODEV;
 
-	ibmphp_unlock_operations ();
-	debug ("get_bus_name - Exit rc[%d] value[%x]\n", rc, *value);
+	ibmphp_unlock_operations();
+	debug("get_bus_name - Exit rc[%d] value[%x]\n", rc, *value);
 	return rc;
 }
 */
 
-/*******************************************************************************
+/****************************************************************************
  * This routine will initialize the ops data structure used in the validate
  * function. It will also power off empty slots that are powered on since BIOS
  * leaves those on, albeit disconnected
- ******************************************************************************/
-static int __init init_ops (void)
+ ****************************************************************************/
+static int __init init_ops(void)
 {
 	struct slot *slot_cur;
 	struct list_head *tmp;
 	int retval;
 	int rc;
 
-	list_for_each (tmp, &ibmphp_slot_head) {
-		slot_cur = list_entry (tmp, struct slot, ibm_slot_list);
+	list_for_each(tmp, &ibmphp_slot_head) {
+		slot_cur = list_entry(tmp, struct slot, ibm_slot_list);
 
 		if (!slot_cur)
 			return -ENODEV;
 
-		debug ("BEFORE GETTING SLOT STATUS, slot # %x\n", slot_cur->number);
+		debug("BEFORE GETTING SLOT STATUS, slot # %x\n",
+							slot_cur->number);
 		if (slot_cur->ctrl->revision == 0xFF) 
-			if (get_ctrl_revision (slot_cur, &slot_cur->ctrl->revision))
+			if (get_ctrl_revision(slot_cur,
+						&slot_cur->ctrl->revision))
 				return -1;
 
 		if (slot_cur->bus_on->current_speed == 0xFF) 
-			if (get_cur_bus_info (&slot_cur)) 
+			if (get_cur_bus_info(&slot_cur)) 
 				return -1;
 
 		if (slot_cur->ctrl->options == 0xFF)
-			if (get_hpc_options (slot_cur, &slot_cur->ctrl->options))
+			if (get_hpc_options(slot_cur, &slot_cur->ctrl->options))
 				return -1;
 
-		retval = slot_update (&slot_cur);
+		retval = slot_update(&slot_cur);
 		if (retval)
 			return retval;
 
-		debug ("status = %x\n", slot_cur->status);
-		debug ("ext_status = %x\n", slot_cur->ext_status);
-		debug ("SLOT_POWER = %x\n", SLOT_POWER (slot_cur->status));
-		debug ("SLOT_PRESENT = %x\n", SLOT_PRESENT (slot_cur->status));
-		debug ("SLOT_LATCH = %x\n", SLOT_LATCH (slot_cur->status));
-
-		if ((SLOT_PWRGD (slot_cur->status)) && 
-		    !(SLOT_PRESENT (slot_cur->status)) && 
-		    !(SLOT_LATCH (slot_cur->status))) {
-			debug ("BEFORE POWER OFF COMMAND\n");
-				rc = power_off (slot_cur);
+		debug("status = %x\n", slot_cur->status);
+		debug("ext_status = %x\n", slot_cur->ext_status);
+		debug("SLOT_POWER = %x\n", SLOT_POWER(slot_cur->status));
+		debug("SLOT_PRESENT = %x\n", SLOT_PRESENT(slot_cur->status));
+		debug("SLOT_LATCH = %x\n", SLOT_LATCH(slot_cur->status));
+
+		if ((SLOT_PWRGD(slot_cur->status)) && 
+		    !(SLOT_PRESENT(slot_cur->status)) && 
+		    !(SLOT_LATCH(slot_cur->status))) {
+			debug("BEFORE POWER OFF COMMAND\n");
+				rc = power_off(slot_cur);
 				if (rc)
 					return rc;
 
-	/*		retval = slot_update (&slot_cur);
+	/*		retval = slot_update(&slot_cur);
 	 *		if (retval)
 	 *			return retval;
-	 *		ibmphp_update_slot_info (slot_cur);
+	 *		ibmphp_update_slot_info(slot_cur);
 	 */
 		}
 	}
@@ -563,7 +611,7 @@
  * Parameters: slot, operation
  * Returns: 0 or error codes
  */
-static int validate (struct slot *slot_cur, int opn)
+static int validate(struct slot *slot_cur, int opn)
 {
 	int number;
 	int retval;
@@ -573,89 +621,91 @@
 	number = slot_cur->number;
 	if ((number > max_slots) || (number < 0))
 		return -EBADSLT;
-	debug ("slot_number in validate is %d\n", slot_cur->number);
+	debug("slot_number in validate is %d\n", slot_cur->number);
 
-	retval = slot_update (&slot_cur);
+	retval = slot_update(&slot_cur);
 	if (retval)
 		return retval;
 
 	switch (opn) {
 		case ENABLE:
-			if (!(SLOT_PWRGD (slot_cur->status)) && 
-			     (SLOT_PRESENT (slot_cur->status)) && 
-			     !(SLOT_LATCH (slot_cur->status)))
+			if (!(SLOT_PWRGD(slot_cur->status)) && 
+			     (SLOT_PRESENT(slot_cur->status)) && 
+			     !(SLOT_LATCH(slot_cur->status)))
 				return 0;
 			break;
 		case DISABLE:
-			if ((SLOT_PWRGD (slot_cur->status)) && 
-			    (SLOT_PRESENT (slot_cur->status)) &&
-			    !(SLOT_LATCH (slot_cur->status)))
+			if ((SLOT_PWRGD(slot_cur->status)) && 
+			    (SLOT_PRESENT(slot_cur->status)) &&
+			    !(SLOT_LATCH(slot_cur->status)))
 				return 0;
 			break;
 		default:
 			break;
 	}
-	err ("validate failed....\n");
+	err("validate failed....\n");
 	return -EINVAL;
 }
 
-/********************************************************************************
+/****************************************************************************
  * This routine is for updating the data structures in the hotplug core
  * Parameters: struct slot
  * Returns: 0 or error
- *******************************************************************************/
-int ibmphp_update_slot_info (struct slot *slot_cur)
+ ****************************************************************************/
+int ibmphp_update_slot_info(struct slot *slot_cur)
 {
 	struct hotplug_slot_info *info;
 	int rc;
 	u8 bus_speed;
 	u8 mode;
 
-	info = kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
+	info = kmalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
 	if (!info) {
-		err ("out of system memory\n");
+		err("out of system memory\n");
 		return -ENOMEM;
 	}
         
-	info->power_status = SLOT_PWRGD (slot_cur->status);
-	info->attention_status = SLOT_ATTN (slot_cur->status, slot_cur->ext_status);
-	info->latch_status = SLOT_LATCH (slot_cur->status);
-        if (!SLOT_PRESENT (slot_cur->status)) {
+	info->power_status = SLOT_PWRGD(slot_cur->status);
+	info->attention_status = SLOT_ATTN(slot_cur->status,
+						slot_cur->ext_status);
+	info->latch_status = SLOT_LATCH(slot_cur->status);
+        if (!SLOT_PRESENT(slot_cur->status)) {
                 info->adapter_status = 0;
-//		info->max_adapter_speed_status = MAX_ADAPTER_NONE;
+/*		info->max_adapter_speed_status = MAX_ADAPTER_NONE; */
 	} else {
                 info->adapter_status = 1;
-//		get_max_adapter_speed_1 (slot_cur->hotplug_slot, &info->max_adapter_speed_status, 0);
+/*		get_max_adapter_speed_1(slot_cur->hotplug_slot,
+					&info->max_adapter_speed_status, 0); */
 	}
 
 	bus_speed = slot_cur->bus_on->current_speed;
 	mode = slot_cur->bus_on->current_bus_mode;
 
 	switch (bus_speed) {
-	case BUS_SPEED_33:
-		break;
-	case BUS_SPEED_66:
-		if (mode == BUS_MODE_PCIX) 
+		case BUS_SPEED_33:
+			break;
+		case BUS_SPEED_66:
+			if (mode == BUS_MODE_PCIX) 
+				bus_speed += 0x01;
+			else if (mode == BUS_MODE_PCI)
+				;
+			else
+				bus_speed = PCI_SPEED_UNKNOWN;
+			break;
+		case BUS_SPEED_100:
+		case BUS_SPEED_133:
 			bus_speed += 0x01;
-		else if (mode == BUS_MODE_PCI)
-			;
-		else
+			break;
+		default:
 			bus_speed = PCI_SPEED_UNKNOWN;
-		break;
-	case BUS_SPEED_100:
-	case BUS_SPEED_133:
-		bus_speed += 0x01;
-		break;
-	default:
-		bus_speed = PCI_SPEED_UNKNOWN;
 	}
 
 	info->cur_bus_speed = bus_speed;
 	info->max_bus_speed = slot_cur->hotplug_slot->info->max_bus_speed;
 	// To do: bus_names 
 	
-	rc = pci_hp_change_slot_info (slot_cur->hotplug_slot, info);
-	kfree (info);
+	rc = pci_hp_change_slot_info(slot_cur->hotplug_slot, info);
+	kfree(info);
 	return rc;
 }
 
@@ -665,17 +715,19 @@
  * is called from visit routines
  ******************************************************************************/
 
-static struct pci_func *ibm_slot_find (u8 busno, u8 device, u8 function)
+static struct pci_func *ibm_slot_find(u8 busno, u8 device, u8 function)
 {
 	struct pci_func *func_cur;
 	struct slot *slot_cur;
 	struct list_head * tmp;
-	list_for_each (tmp, &ibmphp_slot_head) {
-		slot_cur = list_entry (tmp, struct slot, ibm_slot_list);
+	list_for_each(tmp, &ibmphp_slot_head) {
+		slot_cur = list_entry(tmp, struct slot, ibm_slot_list);
 		if (slot_cur->func) {
 			func_cur = slot_cur->func;
 			while (func_cur) {
-				if ((func_cur->busno == busno) && (func_cur->device == device) && (func_cur->function == function))
+				if ((func_cur->busno == busno) &&
+						(func_cur->device == device) &&
+						(func_cur->function == function))
 					return func_cur;
 				func_cur = func_cur->next;
 			}
@@ -689,19 +741,19 @@
  * the pointers to pci_func, bus, hotplug_slot, controller,
  * and deregistering from the hotplug core
  *************************************************************/
-static void free_slots (void)
+static void free_slots(void)
 {
 	struct slot *slot_cur;
 	struct list_head * tmp;
 	struct list_head * next;
 
-	debug ("%s -- enter\n", __FUNCTION__);
+	debug("%s -- enter\n", __FUNCTION__);
 
-	list_for_each_safe (tmp, next, &ibmphp_slot_head) {
-		slot_cur = list_entry (tmp, struct slot, ibm_slot_list);
-		pci_hp_deregister (slot_cur->hotplug_slot);
+	list_for_each_safe(tmp, next, &ibmphp_slot_head) {
+		slot_cur = list_entry(tmp, struct slot, ibm_slot_list);
+		pci_hp_deregister(slot_cur->hotplug_slot);
 	}
-	debug ("%s -- exit\n", __FUNCTION__);
+	debug("%s -- exit\n", __FUNCTION__);
 }
 
 static void ibm_unconfigure_device(struct pci_func *func)
@@ -710,7 +762,8 @@
 	u8 j;
 
 	debug("inside %s\n", __FUNCTION__);
-	debug("func->device = %x, func->function = %x\n", func->device, func->function);
+	debug("func->device = %x, func->function = %x\n",
+					func->device, func->function);
 	debug("func->device << 3 | 0x0  = %x\n", func->device << 3 | 0x0);
 
 	for (j = 0; j < 0x08; j++) {
@@ -725,25 +778,24 @@
  * getting bus entries, here we manually add those primary 
  * bus entries to kernel bus structure whenever apply
  */
-
-static u8 bus_structure_fixup (u8 busno)
+static u8 bus_structure_fixup(u8 busno)
 {
 	struct pci_bus *bus;
 	struct pci_dev *dev;
 	u16 l;
 
-	if (pci_find_bus(0, busno) || !(ibmphp_find_same_bus_num (busno)))
+	if (pci_find_bus(0, busno) || !(ibmphp_find_same_bus_num(busno)))
 		return 1;
 
-	bus = kmalloc (sizeof (*bus), GFP_KERNEL);
+	bus = kmalloc(sizeof(*bus), GFP_KERNEL);
 	if (!bus) {
-		err ("%s - out of memory\n", __FUNCTION__);
+		err("%s - out of memory\n", __FUNCTION__);
 		return 1;
 	}
-	dev = kmalloc (sizeof (*dev), GFP_KERNEL);
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
-		kfree (bus);
-		err ("%s - out of memory\n", __FUNCTION__);
+		kfree(bus);
+		err("%s - out of memory\n", __FUNCTION__);
 		return 1;
 	}
 
@@ -751,50 +803,57 @@
 	bus->ops = ibmphp_pci_bus->ops;
 	dev->bus = bus;
 	for (dev->devfn = 0; dev->devfn < 256; dev->devfn += 8) {
-		if (!pci_read_config_word (dev, PCI_VENDOR_ID, &l) &&  l != 0x0000 && l != 0xffff) {
-			debug ("%s - Inside bus_struture_fixup()\n", __FUNCTION__);
-			pci_scan_bus (busno, ibmphp_pci_bus->ops, NULL);
+		if (!pci_read_config_word(dev, PCI_VENDOR_ID, &l) &&
+					(l != 0x0000) && (l != 0xffff)) {
+			debug("%s - Inside bus_struture_fixup()\n",
+							__FUNCTION__);
+			pci_scan_bus(busno, ibmphp_pci_bus->ops, NULL);
 			break;
 		}
 	}
 
-	kfree (dev);
-	kfree (bus);
+	kfree(dev);
+	kfree(bus);
 
 	return 0;
 }
 
-static int ibm_configure_device (struct pci_func *func)
+static int ibm_configure_device(struct pci_func *func)
 {
 	unsigned char bus;
 	struct pci_bus *child;
 	int num;
-	int flag = 0;	/* this is to make sure we don't double scan the bus, for bridged devices primarily */
+	int flag = 0;	/* this is to make sure we don't double scan the bus,
+					for bridged devices primarily */
 
-	if (!(bus_structure_fixup (func->busno)))
+	if (!(bus_structure_fixup(func->busno)))
 		flag = 1;
 	if (func->dev == NULL)
-		func->dev = pci_find_slot (func->busno, PCI_DEVFN(func->device, func->function));
+		func->dev = pci_find_slot(func->busno,
+				PCI_DEVFN(func->device, func->function));
 
 	if (func->dev == NULL) {
 		struct pci_bus *bus = pci_find_bus(0, func->busno);
 		if (!bus)
 			return 0;
 
-		num = pci_scan_slot(bus, PCI_DEVFN(func->device, func->function));
+		num = pci_scan_slot(bus,
+				PCI_DEVFN(func->device, func->function));
 		if (num)
 			pci_bus_add_devices(bus);
 
-		func->dev = pci_find_slot(func->busno, PCI_DEVFN(func->device, func->function));
+		func->dev = pci_find_slot(func->busno,
+				PCI_DEVFN(func->device, func->function));
 		if (func->dev == NULL) {
-			err ("ERROR... : pci_dev still NULL\n");
+			err("ERROR... : pci_dev still NULL\n");
 			return 0;
 		}
 	}
 	if (!(flag) && (func->dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
-		pci_read_config_byte (func->dev, PCI_SECONDARY_BUS, &bus);
-		child = (struct pci_bus *) pci_add_new_bus (func->dev->bus, (func->dev), bus);
-		pci_do_scan_bus (child);
+		pci_read_config_byte(func->dev, PCI_SECONDARY_BUS, &bus);
+		child = (struct pci_bus *) pci_add_new_bus(func->dev->bus,
+							(func->dev), bus);
+		pci_do_scan_bus(child);
 	}
 
 	return 0;
@@ -803,7 +862,7 @@
 /*******************************************************
  * Returns whether the bus is empty or not 
  *******************************************************/
-static int is_bus_empty (struct slot * slot_cur)
+static int is_bus_empty(struct slot * slot_cur)
 {
 	int rc;
 	struct slot * tmp_slot;
@@ -814,13 +873,14 @@
 			i++;
 			continue;
 		}
-		tmp_slot = ibmphp_get_slot_from_physical_num (i);
+		tmp_slot = ibmphp_get_slot_from_physical_num(i);
 		if (!tmp_slot)
 			return 0;
-		rc = slot_update (&tmp_slot);
+		rc = slot_update(&tmp_slot);
 		if (rc)
 			return 0;
-		if (SLOT_PRESENT (tmp_slot->status) && SLOT_PWRGD (tmp_slot->status))
+		if (SLOT_PRESENT(tmp_slot->status) &&
+					SLOT_PWRGD(tmp_slot->status))
 			return 0;
 		i++;
 	}
@@ -833,7 +893,7 @@
  * Parameters: slot
  * Returns: bus is set (0) or error code
  ***********************************************************/
-static int set_bus (struct slot * slot_cur)
+static int set_bus(struct slot * slot_cur)
 {
 	int rc;
 	u8 speed;
@@ -844,22 +904,23 @@
 	        { },
 	};	
 
-	debug ("%s - entry slot # %d\n", __FUNCTION__, slot_cur->number);
-	if (SET_BUS_STATUS (slot_cur->ctrl) && is_bus_empty (slot_cur)) {
-		rc = slot_update (&slot_cur);
+	debug("%s - entry slot # %d\n", __FUNCTION__, slot_cur->number);
+	if (SET_BUS_STATUS(slot_cur->ctrl) && is_bus_empty(slot_cur)) {
+		rc = slot_update(&slot_cur);
 		if (rc)
 			return rc;
-		speed = SLOT_SPEED (slot_cur->ext_status);
-		debug ("ext_status = %x, speed = %x\n", slot_cur->ext_status, speed);
+		speed = SLOT_SPEED(slot_cur->ext_status);
+		debug("ext_status = %x, speed = %x\n", slot_cur->ext_status, speed);
 		switch (speed) {
 		case HPC_SLOT_SPEED_33:
 			cmd = HPC_BUS_33CONVMODE;
 			break;
 		case HPC_SLOT_SPEED_66:
-			if (SLOT_PCIX (slot_cur->ext_status)) {
-				if ((slot_cur->supported_speed >= BUS_SPEED_66) && (slot_cur->supported_bus_mode == BUS_MODE_PCIX))
+			if (SLOT_PCIX(slot_cur->ext_status)) {
+				if ((slot_cur->supported_speed >= BUS_SPEED_66) &&
+						(slot_cur->supported_bus_mode == BUS_MODE_PCIX))
 					cmd = HPC_BUS_66PCIXMODE;
-				else if (!SLOT_BUS_MODE (slot_cur->ext_status))
+				else if (!SLOT_BUS_MODE(slot_cur->ext_status))
 					/* if max slot/bus capability is 66 pci
 					and there's no bus mode mismatch, then
 					the adapter supports 66 pci */ 
@@ -890,33 +951,35 @@
 			case BUS_SPEED_133:
 				/* This is to take care of the bug in CIOBX chip */
 				if (pci_dev_present(ciobx))
-					ibmphp_hpc_writeslot (slot_cur, HPC_BUS_100PCIXMODE);
+					ibmphp_hpc_writeslot(slot_cur,
+							HPC_BUS_100PCIXMODE);
 				cmd = HPC_BUS_133PCIXMODE;
 				break;
 			default:
-				err ("Wrong bus speed\n");
+				err("Wrong bus speed\n");
 				return -ENODEV;
 			}
 			break;
 		default:
-			err ("wrong slot speed\n");
+			err("wrong slot speed\n");
 			return -ENODEV;
 		}
-		debug ("setting bus speed for slot %d, cmd %x\n", slot_cur->number, cmd);
-		retval = ibmphp_hpc_writeslot (slot_cur, cmd);
+		debug("setting bus speed for slot %d, cmd %x\n",
+						slot_cur->number, cmd);
+		retval = ibmphp_hpc_writeslot(slot_cur, cmd);
 		if (retval) {
-			err ("setting bus speed failed\n");
+			err("setting bus speed failed\n");
 			return retval;
 		}
-		if (CTLR_RESULT (slot_cur->ctrl->status)) {
-			err ("command not completed successfully in set_bus\n");
+		if (CTLR_RESULT(slot_cur->ctrl->status)) {
+			err("command not completed successfully in set_bus\n");
 			return -EIO;
 		}
 	}
 	/* This is for x440, once Brandon fixes the firmware, 
 	will not need this delay */
 	msleep(1000);
-	debug ("%s -Exit\n", __FUNCTION__);
+	debug("%s -Exit\n", __FUNCTION__);
 	return 0;
 }
 
@@ -927,7 +990,7 @@
  * Parameters: slot
  * Returns: 0 = no limitations, -EINVAL = exceeded limitations on the bus
  */
-static int check_limitations (struct slot *slot_cur)
+static int check_limitations(struct slot *slot_cur)
 {
 	u8 i;
 	struct slot * tmp_slot;
@@ -935,13 +998,14 @@
 	u8 limitation = 0;
 
 	for (i = slot_cur->bus_on->slot_min; i <= slot_cur->bus_on->slot_max; i++) {
-		tmp_slot = ibmphp_get_slot_from_physical_num (i);
+		tmp_slot = ibmphp_get_slot_from_physical_num(i);
 		if (!tmp_slot)
 			return -ENODEV;
-		if ((SLOT_PWRGD (tmp_slot->status)) && !(SLOT_CONNECT (tmp_slot->status))) 
+		if ((SLOT_PWRGD(tmp_slot->status)) &&
+					!(SLOT_CONNECT(tmp_slot->status)))
 			count++;
 	}
-	get_cur_bus_info (&slot_cur);
+	get_cur_bus_info(&slot_cur);
 	switch (slot_cur->bus_on->current_speed) {
 	case BUS_SPEED_33:
 		limitation = slot_cur->bus_on->slots_at_33_conv;
@@ -965,17 +1029,17 @@
 	return 0;
 }
 
-static inline void print_card_capability (struct slot *slot_cur)
+static inline void print_card_capability(struct slot *slot_cur)
 {
-	info ("capability of the card is ");
+	info("capability of the card is ");
 	if ((slot_cur->ext_status & CARD_INFO) == PCIX133) 
-		info ("   133 MHz PCI-X\n");
+		info("   133 MHz PCI-X\n");
 	else if ((slot_cur->ext_status & CARD_INFO) == PCIX66)
-		info ("    66 MHz PCI-X\n");
+		info("    66 MHz PCI-X\n");
 	else if ((slot_cur->ext_status & CARD_INFO) == PCI66)
-		info ("    66 MHz PCI\n");
+		info("    66 MHz PCI\n");
 	else
-		info ("    33 MHz PCI\n");
+		info("    33 MHz PCI\n");
 
 }
 
@@ -984,118 +1048,128 @@
  * Parameters: hotplug_slot
  * Returns: 0 or failure codes
  */
-static int enable_slot (struct hotplug_slot *hs)
+static int enable_slot(struct hotplug_slot *hs)
 {
 	int rc, i, rcpr;
 	struct slot *slot_cur;
 	u8 function;
 	struct pci_func *tmp_func;
 
-	ibmphp_lock_operations ();
+	ibmphp_lock_operations();
 
-	debug ("ENABLING SLOT........\n");
+	debug("ENABLING SLOT........\n");
 	slot_cur = (struct slot *) hs->private;
 
-	if ((rc = validate (slot_cur, ENABLE))) {
-		err ("validate function failed\n");
+	if ((rc = validate(slot_cur, ENABLE))) {
+		err("validate function failed\n");
 		goto error_nopower;
 	}
 
-	attn_LED_blink (slot_cur);
+	attn_LED_blink(slot_cur);
 	
-	rc = set_bus (slot_cur);
+	rc = set_bus(slot_cur);
 	if (rc) {
-		err ("was not able to set the bus\n");
+		err("was not able to set the bus\n");
 		goto error_nopower;
 	}
 
 	/*-----------------debugging------------------------------*/
-	get_cur_bus_info (&slot_cur);
-	debug ("the current bus speed right after set_bus = %x\n", slot_cur->bus_on->current_speed); 
+	get_cur_bus_info(&slot_cur);
+	debug("the current bus speed right after set_bus = %x\n",
+					slot_cur->bus_on->current_speed);
 	/*----------------------------------------------------------*/
 
-	rc = check_limitations (slot_cur);
+	rc = check_limitations(slot_cur);
 	if (rc) {
-		err ("Adding this card exceeds the limitations of this bus.\n");
-		err ("(i.e., >1 133MHz cards running on same bus, or "
+		err("Adding this card exceeds the limitations of this bus.\n");
+		err("(i.e., >1 133MHz cards running on same bus, or "
 		     ">2 66 PCI cards running on same bus\n.");
-		err ("Try hot-adding into another bus\n");
+		err("Try hot-adding into another bus\n");
 		rc = -EINVAL;
 		goto error_nopower;
 	}
 
-	rc = power_on (slot_cur);
+	rc = power_on(slot_cur);
 
 	if (rc) {
-		err ("something wrong when powering up... please see below for details\n");
+		err("something wrong when powering up... please see below for details\n");
 		/* need to turn off before on, otherwise, blinking overwrites */
 		attn_off(slot_cur);
-		attn_on (slot_cur);
-		if (slot_update (&slot_cur)) {
-			attn_off (slot_cur);
-			attn_on (slot_cur);
+		attn_on(slot_cur);
+		if (slot_update(&slot_cur)) {
+			attn_off(slot_cur);
+			attn_on(slot_cur);
 			rc = -ENODEV;
 			goto exit;
 		}
 		/* Check to see the error of why it failed */
-		if ((SLOT_POWER (slot_cur->status)) && !(SLOT_PWRGD (slot_cur->status)))
-			err ("power fault occurred trying to power up\n");
-		else if (SLOT_BUS_SPEED (slot_cur->status)) {
-			err ("bus speed mismatch occurred.  please check current bus speed and card capability\n");
-			print_card_capability (slot_cur);
-		} else if (SLOT_BUS_MODE (slot_cur->ext_status)) {
-			err ("bus mode mismatch occurred.  please check current bus mode and card capability\n");
-			print_card_capability (slot_cur);
+		if ((SLOT_POWER(slot_cur->status)) &&
+					!(SLOT_PWRGD(slot_cur->status)))
+			err("power fault occurred trying to power up\n");
+		else if (SLOT_BUS_SPEED(slot_cur->status)) {
+			err("bus speed mismatch occurred.  please check "
+				"current bus speed and card capability\n");
+			print_card_capability(slot_cur);
+		} else if (SLOT_BUS_MODE(slot_cur->ext_status)) {
+			err("bus mode mismatch occurred.  please check "
+				"current bus mode and card capability\n");
+			print_card_capability(slot_cur);
 		}
-		ibmphp_update_slot_info (slot_cur);
+		ibmphp_update_slot_info(slot_cur);
 		goto exit;
 	}
-	debug ("after power_on\n");
+	debug("after power_on\n");
 	/*-----------------------debugging---------------------------*/
-	get_cur_bus_info (&slot_cur);
-	debug ("the current bus speed right after power_on = %x\n", slot_cur->bus_on->current_speed);
+	get_cur_bus_info(&slot_cur);
+	debug("the current bus speed right after power_on = %x\n",
+					slot_cur->bus_on->current_speed);
 	/*----------------------------------------------------------*/
 
-	rc = slot_update (&slot_cur);
+	rc = slot_update(&slot_cur);
 	if (rc)
 		goto error_power;
 	
 	rc = -EINVAL;
-	if (SLOT_POWER (slot_cur->status) && !(SLOT_PWRGD (slot_cur->status))) {
-		err ("power fault occurred trying to power up...\n");
+	if (SLOT_POWER(slot_cur->status) && !(SLOT_PWRGD(slot_cur->status))) {
+		err("power fault occurred trying to power up...\n");
 		goto error_power;
 	}
-	if (SLOT_POWER (slot_cur->status) && (SLOT_BUS_SPEED (slot_cur->status))) {
-		err ("bus speed mismatch occurred.  please check current bus speed and card capability\n");
-		print_card_capability (slot_cur);
+	if (SLOT_POWER(slot_cur->status) && (SLOT_BUS_SPEED(slot_cur->status))) {
+		err("bus speed mismatch occurred.  please check current bus "
+					"speed and card capability\n");
+		print_card_capability(slot_cur);
 		goto error_power;
 	} 
-	/* Don't think this case will happen after above checks... but just in case, for paranoia sake */
-	if (!(SLOT_POWER (slot_cur->status))) {
-		err ("power on failed...\n");
+	/* Don't think this case will happen after above checks...
+	 * but just in case, for paranoia sake */
+	if (!(SLOT_POWER(slot_cur->status))) {
+		err("power on failed...\n");
 		goto error_power;
 	}
 
-	slot_cur->func = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
+	slot_cur->func = (struct pci_func *) kmalloc(sizeof(struct pci_func), GFP_KERNEL);
 	if (!slot_cur->func) {
 		/* We cannot do update_slot_info here, since no memory for
 		 * kmalloc n.e.ways, and update_slot_info allocates some */
-		err ("out of system memory\n");
+		err("out of system memory\n");
 		rc = -ENOMEM;
 		goto error_power;
 	}
-	memset (slot_cur->func, 0, sizeof (struct pci_func));
+	memset(slot_cur->func, 0, sizeof(struct pci_func));
 	slot_cur->func->busno = slot_cur->bus;
 	slot_cur->func->device = slot_cur->device;
 	for (i = 0; i < 4; i++)
 		slot_cur->func->irq[i] = slot_cur->irq[i];
 
-	debug ("b4 configure_card, slot_cur->bus = %x, slot_cur->device = %x\n", slot_cur->bus, slot_cur->device);
+	debug("b4 configure_card, slot_cur->bus = %x, slot_cur->device = %x\n",
+					slot_cur->bus, slot_cur->device);
 
-	if (ibmphp_configure_card (slot_cur->func, slot_cur->number)) {
-		err ("configure_card was unsuccessful...\n");
-		ibmphp_unconfigure_card (&slot_cur, 1); /* true because don't need to actually deallocate resources, just remove references */
-		debug ("after unconfigure_card\n");
+	if (ibmphp_configure_card(slot_cur->func, slot_cur->number)) {
+		err("configure_card was unsuccessful...\n");
+		/* true because don't need to actually deallocate resources,
+		 * just remove references */
+		ibmphp_unconfigure_card(&slot_cur, 1);
+		debug("after unconfigure_card\n");
 		slot_cur->func = NULL;
 		rc = -ENOMEM;
 		goto error_power;
@@ -1103,38 +1177,39 @@
 
 	function = 0x00;
 	do {
-		tmp_func = ibm_slot_find (slot_cur->bus, slot_cur->func->device, function++);
+		tmp_func = ibm_slot_find(slot_cur->bus, slot_cur->func->device,
+							function++);
 		if (tmp_func && !(tmp_func->dev))
-			ibm_configure_device (tmp_func);
+			ibm_configure_device(tmp_func);
 	} while (tmp_func);
 
-	attn_off (slot_cur);
-	if (slot_update (&slot_cur)) {
+	attn_off(slot_cur);
+	if (slot_update(&slot_cur)) {
 		rc = -EFAULT;
 		goto exit;
 	}
-	ibmphp_print_test ();
-	rc = ibmphp_update_slot_info (slot_cur);
+	ibmphp_print_test();
+	rc = ibmphp_update_slot_info(slot_cur);
 exit:
 	ibmphp_unlock_operations(); 
 	return rc;
 
 error_nopower:
-	attn_off (slot_cur);	/* need to turn off if was blinking b4 */
-	attn_on (slot_cur);
+	attn_off(slot_cur);	/* need to turn off if was blinking b4 */
+	attn_on(slot_cur);
 error_cont:
-	rcpr = slot_update (&slot_cur);
+	rcpr = slot_update(&slot_cur);
 	if (rcpr) {
 		rc = rcpr;
 		goto exit;
 	}
-	ibmphp_update_slot_info (slot_cur);
+	ibmphp_update_slot_info(slot_cur);
 	goto exit;
 
 error_power:
-	attn_off (slot_cur);	/* need to turn off if was blinking b4 */
-	attn_on (slot_cur);
-	rcpr = power_off (slot_cur);
+	attn_off(slot_cur);	/* need to turn off if was blinking b4 */
+	attn_on(slot_cur);
+	rcpr = power_off(slot_cur);
 	if (rcpr) {
 		rc = rcpr;
 		goto exit;
@@ -1148,7 +1223,7 @@
 * OUTPUT: SUCCESS 0 ; FAILURE: UNCONFIGURE , VALIDATE         *
           DISABLE POWER ,                                    *
 **************************************************************/
-static int ibmphp_disable_slot (struct hotplug_slot *hotplug_slot)
+static int ibmphp_disable_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct slot *slot = hotplug_slot->private;
 	int rc;
@@ -1159,12 +1234,12 @@
 	return rc;
 }
 
-int ibmphp_do_disable_slot (struct slot *slot_cur)
+int ibmphp_do_disable_slot(struct slot *slot_cur)
 {
 	int rc;
 	u8 flag;
 
-	debug ("DISABLING SLOT...\n"); 
+	debug("DISABLING SLOT...\n"); 
 		
 	if ((slot_cur == NULL) || (slot_cur->ctrl == NULL)) {
 		return -ENODEV;
@@ -1174,21 +1249,22 @@
 	slot_cur->flag = TRUE;
 
 	if (flag == TRUE) {
-		rc = validate (slot_cur, DISABLE);	/* checking if powered off already & valid slot # */
+		rc = validate(slot_cur, DISABLE);
+			/* checking if powered off already & valid slot # */
 		if (rc)
 			goto error;
 	}
-	attn_LED_blink (slot_cur);
+	attn_LED_blink(slot_cur);
 
 	if (slot_cur->func == NULL) {
 		/* We need this for fncs's that were there on bootup */
-		slot_cur->func = (struct pci_func *) kmalloc (sizeof (struct pci_func), GFP_KERNEL);
+		slot_cur->func = (struct pci_func *) kmalloc(sizeof(struct pci_func), GFP_KERNEL);
 		if (!slot_cur->func) {
-			err ("out of system memory\n");
+			err("out of system memory\n");
 			rc = -ENOMEM;
 			goto error;
 		}
-		memset (slot_cur->func, 0, sizeof (struct pci_func));
+		memset(slot_cur->func, 0, sizeof(struct pci_func));
 		slot_cur->func->busno = slot_cur->bus;
 		slot_cur->func->device = slot_cur->device;
 	}
@@ -1202,42 +1278,42 @@
 	lists at least */
 
 	if (!flag) {
-		attn_off (slot_cur);
+		attn_off(slot_cur);
 		return 0;
 	}
 
-	rc = ibmphp_unconfigure_card (&slot_cur, 0);
+	rc = ibmphp_unconfigure_card(&slot_cur, 0);
 	slot_cur->func = NULL;
-	debug ("in disable_slot. after unconfigure_card\n");
+	debug("in disable_slot. after unconfigure_card\n");
 	if (rc) {
-		err ("could not unconfigure card.\n");
+		err("could not unconfigure card.\n");
 		goto error;
 	}
 
-	rc = ibmphp_hpc_writeslot (slot_cur, HPC_SLOT_OFF);
+	rc = ibmphp_hpc_writeslot(slot_cur, HPC_SLOT_OFF);
 	if (rc)
 		goto error;
 
-	attn_off (slot_cur);
-	rc = slot_update (&slot_cur);
+	attn_off(slot_cur);
+	rc = slot_update(&slot_cur);
 	if (rc)
 		goto exit;
 
-	rc = ibmphp_update_slot_info (slot_cur);
-	ibmphp_print_test ();
+	rc = ibmphp_update_slot_info(slot_cur);
+	ibmphp_print_test();
 exit:
 	return rc;
 
 error:
 	/*  Need to turn off if was blinking b4 */
-	attn_off (slot_cur);
-	attn_on (slot_cur);
-	if (slot_update (&slot_cur)) {
+	attn_off(slot_cur);
+	attn_on(slot_cur);
+	if (slot_update(&slot_cur)) {
 		rc = -EFAULT;
 		goto exit;
 	}
 	if (flag)		
-		ibmphp_update_slot_info (slot_cur);
+		ibmphp_update_slot_info(slot_cur);
 	goto exit;
 }
 
@@ -1258,22 +1334,22 @@
 */
 };
 
-static void ibmphp_unload (void)
+static void ibmphp_unload(void)
 {
-	free_slots ();
-	debug ("after slots\n");
-	ibmphp_free_resources ();
-	debug ("after resources\n");
-	ibmphp_free_bus_info_queue ();
-	debug ("after bus info\n");
-	ibmphp_free_ebda_hpc_queue ();
-	debug ("after ebda hpc\n");
-	ibmphp_free_ebda_pci_rsrc_queue ();
-	debug ("after ebda pci rsrc\n");
-	kfree (ibmphp_pci_bus);
+	free_slots();
+	debug("after slots\n");
+	ibmphp_free_resources();
+	debug("after resources\n");
+	ibmphp_free_bus_info_queue();
+	debug("after bus info\n");
+	ibmphp_free_ebda_hpc_queue();
+	debug("after ebda hpc\n");
+	ibmphp_free_ebda_pci_rsrc_queue();
+	debug("after ebda pci rsrc\n");
+	kfree(ibmphp_pci_bus);
 }
 
-static int __init ibmphp_init (void)
+static int __init ibmphp_init(void)
 {
 	struct pci_bus *bus;
 	int i = 0;
@@ -1281,50 +1357,50 @@
 
 	init_flag = 1;
 
-	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
+	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
-	ibmphp_pci_bus = kmalloc (sizeof (*ibmphp_pci_bus), GFP_KERNEL);
+	ibmphp_pci_bus = kmalloc(sizeof(*ibmphp_pci_bus), GFP_KERNEL);
 	if (!ibmphp_pci_bus) {
-		err ("out of memory\n");
+		err("out of memory\n");
 		rc = -ENOMEM;
 		goto exit;
 	}
 
 	bus = pci_find_bus(0, 0);
 	if (!bus) {
-		err ("Can't find the root pci bus, can not continue\n");
+		err("Can't find the root pci bus, can not continue\n");
 		rc = -ENODEV;
 		goto error;
 	}
-	memcpy (ibmphp_pci_bus, bus, sizeof (*ibmphp_pci_bus));
+	memcpy(ibmphp_pci_bus, bus, sizeof(*ibmphp_pci_bus));
 
 	ibmphp_debug = debug;
 
-	ibmphp_hpc_initvars ();
+	ibmphp_hpc_initvars();
 
 	for (i = 0; i < 16; i++)
 		irqs[i] = 0;
 
-	if ((rc = ibmphp_access_ebda ()))
+	if ((rc = ibmphp_access_ebda()))
 		goto error;
-	debug ("after ibmphp_access_ebda ()\n");
+	debug("after ibmphp_access_ebda()\n");
 
-	if ((rc = ibmphp_rsrc_init ()))
+	if ((rc = ibmphp_rsrc_init()))
 		goto error;
-	debug ("AFTER Resource & EBDA INITIALIZATIONS\n");
+	debug("AFTER Resource & EBDA INITIALIZATIONS\n");
 
-	max_slots = get_max_slots ();
+	max_slots = get_max_slots();
 	
-	if ((rc = ibmphp_register_pci ()))
+	if ((rc = ibmphp_register_pci()))
 		goto error;
 
-	if (init_ops ()) {
+	if (init_ops()) {
 		rc = -ENODEV;
 		goto error;
 	}
 
-	ibmphp_print_test ();
-	if ((rc = ibmphp_hpc_start_poll_thread ())) {
+	ibmphp_print_test();
+	if ((rc = ibmphp_hpc_start_poll_thread())) {
 		goto error;
 	}
 
@@ -1336,17 +1412,17 @@
 	return rc;
 
 error:
-	ibmphp_unload ();
+	ibmphp_unload();
 	goto exit;
 }
 
-static void __exit ibmphp_exit (void)
+static void __exit ibmphp_exit(void)
 {
-	ibmphp_hpc_stop_poll_thread ();
-	debug ("after polling\n");
-	ibmphp_unload ();
-	debug ("done\n");
+	ibmphp_hpc_stop_poll_thread();
+	debug("after polling\n");
+	ibmphp_unload();
+	debug("done\n");
 }
 
-module_init (ibmphp_init);
-module_exit (ibmphp_exit);
+module_init(ibmphp_init);
+module_exit(ibmphp_exit);

