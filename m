Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVIATKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVIATKs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbVIATKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:10:48 -0400
Received: from sccrmhc11.comcast.net ([63.240.76.21]:36527 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030262AbVIATKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:10:47 -0400
Subject: [PATCH] part 1 - IPMI style cleanups
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-6jKy9hdONLz2rQ0bFRb3"
Date: Thu, 01 Sep 2005 14:10:36 -0500
Message-Id: <1125601836.4403.2.camel@i2.minyard.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6jKy9hdONLz2rQ0bFRb3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-6jKy9hdONLz2rQ0bFRb3
Content-Disposition: attachment; filename=ipmi-cleanup-style.patch
Content-Type: text/x-patch; name=ipmi-cleanup-style.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Clean up various style issues in the IPMI driver.  Should be
no functional changes.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.13/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.13.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.13/drivers/char/ipmi/ipmi_poweroff.c
@@ -527,7 +527,7 @@ static void ipmi_po_new_smi(int if_num)
 
 
 	/* Scan for a poweroff method */
-	for (i=0; i<NUM_PO_FUNCS; i++) {
+	for (i = 0; i < NUM_PO_FUNCS; i++) {
 		if (poweroff_functions[i].detect(ipmi_user))
 			goto found;
 	}
Index: linux-2.6.13/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.13.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.13/drivers/char/ipmi/ipmi_watchdog.c
@@ -657,19 +657,18 @@ static ssize_t ipmi_read(struct file *fi
 
 static int ipmi_open(struct inode *ino, struct file *filep)
 {
-        switch (iminor(ino))
-        {
-                case WATCHDOG_MINOR:
-		    if(test_and_set_bit(0, &ipmi_wdog_open))
+        switch (iminor(ino)) {
+        case WATCHDOG_MINOR:
+		if (test_and_set_bit(0, &ipmi_wdog_open))
                         return -EBUSY;
 
-		    /* Don't start the timer now, let it start on the
-		       first heartbeat. */
-		    ipmi_start_timer_on_heartbeat = 1;
-                    return nonseekable_open(ino, filep);
+		/* Don't start the timer now, let it start on the
+		   first heartbeat. */
+		ipmi_start_timer_on_heartbeat = 1;
+		return nonseekable_open(ino, filep);
 
-                default:
-                    return (-ENODEV);
+	default:
+		return (-ENODEV);
         }
 }
 
Index: linux-2.6.13/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.13.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.13/drivers/char/ipmi/ipmi_msghandler.c
@@ -117,7 +117,7 @@ struct seq_table
 	do {								\
 		seq = ((msgid >> 26) & 0x3f);				\
 		seqid = (msgid & 0x3fffff);				\
-        } while(0)
+        } while (0)
 
 #define NEXT_SEQID(seqid) (((seqid) + 1) & 0x3fffff)
 
@@ -326,7 +326,7 @@ int ipmi_smi_watcher_register(struct ipm
 	down_read(&interfaces_sem);
 	down_write(&smi_watchers_sem);
 	list_add(&(watcher->link), &smi_watchers);
-	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		if (ipmi_interfaces[i] != NULL) {
 			watcher->new_smi(i);
 		}
@@ -496,9 +496,9 @@ static int intf_next_seq(ipmi_smi_t     
 	int          rv = 0;
 	unsigned int i;
 
-	for (i=intf->curr_seq;
+	for (i = intf->curr_seq;
 	     (i+1)%IPMI_IPMB_NUM_SEQ != intf->curr_seq;
-	     i=(i+1)%IPMI_IPMB_NUM_SEQ)
+	     i = (i+1)%IPMI_IPMB_NUM_SEQ)
 	{
 		if (! intf->seq_table[i].inuse)
 			break;
@@ -733,7 +733,7 @@ static int ipmi_destroy_user_nolock(ipmi
 
 	/* Remove the user from the interfaces sequence table. */
 	spin_lock_irqsave(&(user->intf->seq_lock), flags);
-	for (i=0; i<IPMI_IPMB_NUM_SEQ; i++) {
+	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
 		if (user->intf->seq_table[i].inuse
 		    && (user->intf->seq_table[i].recv_msg->user == user))
 		{
@@ -1370,7 +1370,7 @@ static inline int i_ipmi_request(ipmi_us
 #ifdef DEBUG_MSGING
 	{
 		int m;
-		for (m=0; m<smi_msg->data_size; m++)
+		for (m = 0; m < smi_msg->data_size; m++)
 			printk(" %2.2x", smi_msg->data[m]);
 		printk("\n");
 	}
@@ -1467,7 +1467,7 @@ static int ipmb_file_read_proc(char *pag
 	int        i;
 	int        rv= 0;
 
-	for (i=0; i<IPMI_MAX_CHANNELS; i++)
+	for (i = 0; i < IPMI_MAX_CHANNELS; i++)
 		rv += sprintf(out+rv, "%x ", intf->channels[i].address);
 	out[rv-1] = '\n'; /* Replace the final space with a newline */
 	out[rv] = '\0';
@@ -1766,12 +1766,12 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	rv = -ENOMEM;
 
 	down_write(&interfaces_sem);
-	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		if (ipmi_interfaces[i] == NULL) {
 			new_intf->intf_num = i;
 			new_intf->version_major = version_major;
 			new_intf->version_minor = version_minor;
-			for (j=0; j<IPMI_MAX_CHANNELS; j++) {
+			for (j = 0; j < IPMI_MAX_CHANNELS; j++) {
 				new_intf->channels[j].address
 					= IPMI_BMC_SLAVE_ADDR;
 				new_intf->channels[j].lun = 2;
@@ -1783,7 +1783,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 			new_intf->handlers = handlers;
 			new_intf->send_info = send_info;
 			spin_lock_init(&(new_intf->seq_lock));
-			for (j=0; j<IPMI_IPMB_NUM_SEQ; j++) {
+			for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++) {
 				new_intf->seq_table[j].inuse = 0;
 				new_intf->seq_table[j].seqid = 0;
 			}
@@ -1891,7 +1891,7 @@ static void clean_up_interface_data(ipmi
 	free_recv_msg_list(&(intf->waiting_events));
 	free_cmd_rcvr_list(&(intf->cmd_rcvrs));
 
-	for (i=0; i<IPMI_IPMB_NUM_SEQ; i++) {
+	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
 		if ((intf->seq_table[i].inuse)
 		    && (intf->seq_table[i].recv_msg))
 		{
@@ -1910,7 +1910,7 @@ int ipmi_unregister_smi(ipmi_smi_t intf)
 	down_write(&interfaces_sem);
 	if (list_empty(&(intf->users)))
 	{
-		for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+		for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 			if (ipmi_interfaces[i] == intf) {
 				remove_proc_entries(intf);
 				spin_lock_irqsave(&interfaces_lock, flags);
@@ -2074,7 +2074,7 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 	{
 		int m;
 		printk("Invalid command:");
-		for (m=0; m<msg->data_size; m++)
+		for (m = 0; m < msg->data_size; m++)
 			printk(" %2.2x", msg->data[m]);
 		printk("\n");
 	}
@@ -2469,7 +2469,7 @@ static int handle_new_recv_msg(ipmi_smi_
 #ifdef DEBUG_MSGING
 	int m;
 	printk("Recv:");
-	for (m=0; m<msg->rsp_size; m++)
+	for (m = 0; m < msg->rsp_size; m++)
 		printk(" %2.2x", msg->rsp[m]);
 	printk("\n");
 #endif
@@ -2703,7 +2703,7 @@ smi_from_recv_msg(ipmi_smi_t intf, struc
 	{
 		int m;
 		printk("Resend: ");
-		for (m=0; m<smi_msg->data_size; m++)
+		for (m = 0; m < smi_msg->data_size; m++)
 			printk(" %2.2x", smi_msg->data[m]);
 		printk("\n");
 	}
@@ -2724,7 +2724,7 @@ ipmi_timeout_handler(long timeout_period
 	INIT_LIST_HEAD(&timeouts);
 
 	spin_lock(&interfaces_lock);
-	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		intf = ipmi_interfaces[i];
 		if (intf == NULL)
 			continue;
@@ -2749,7 +2749,7 @@ ipmi_timeout_handler(long timeout_period
 		   have timed out, putting them in the timeouts
 		   list. */
 		spin_lock_irqsave(&(intf->seq_lock), flags);
-		for (j=0; j<IPMI_IPMB_NUM_SEQ; j++) {
+		for (j = 0; j < IPMI_IPMB_NUM_SEQ; j++) {
 			struct seq_table *ent = &(intf->seq_table[j]);
 			if (!ent->inuse)
 				continue;
@@ -2789,7 +2789,7 @@ ipmi_timeout_handler(long timeout_period
 				spin_unlock(&intf->counter_lock);
 				smi_msg = smi_from_recv_msg(intf,
 						ent->recv_msg, j, ent->seqid);
-				if(!smi_msg)
+				if (! smi_msg)
 					continue;
 
 				spin_unlock_irqrestore(&(intf->seq_lock),flags);
@@ -2820,7 +2820,7 @@ static void ipmi_request_event(void)
 	int        i;
 
 	spin_lock(&interfaces_lock);
-	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		intf = ipmi_interfaces[i];
 		if (intf == NULL)
 			continue;
@@ -2982,7 +2982,7 @@ static void send_panic_events(char *str)
 	recv_msg.done = dummy_recv_done_handler;
 
 	/* For every registered interface, send the event. */
-	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		intf = ipmi_interfaces[i];
 		if (intf == NULL)
 			continue;
@@ -3009,7 +3009,7 @@ static void send_panic_events(char *str)
 	if (!str) 
 		return;
 
-	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		char                  *p = str;
 		struct ipmi_ipmb_addr *ipmb;
 		int                   j;
@@ -3149,7 +3149,7 @@ static int panic_event(struct notifier_b
 	has_paniced = 1;
 
 	/* For every registered interface, set it to run to completion. */
-	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		intf = ipmi_interfaces[i];
 		if (intf == NULL)
 			continue;
@@ -3180,7 +3180,7 @@ static int ipmi_init_msghandler(void)
 	printk(KERN_INFO "ipmi message handler version "
 	       IPMI_DRIVER_VERSION "\n");
 
-	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
 		ipmi_interfaces[i] = NULL;
 	}
 
Index: linux-2.6.13/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.13.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.13/drivers/char/ipmi/ipmi_si_intf.c
@@ -267,7 +267,7 @@ static enum si_sm_result start_next_msg(
 		entry = smi_info->xmit_msgs.next;
 	}
 
-	if (!entry) {
+	if (! entry) {
 		smi_info->curr_msg = NULL;
 		rv = SI_SM_IDLE;
 	} else {
@@ -328,7 +328,7 @@ static void start_clear_flags(struct smi
    memory, we will re-enable the interrupt. */
 static inline void disable_si_irq(struct smi_info *smi_info)
 {
-	if ((smi_info->irq) && (!smi_info->interrupt_disabled)) {
+	if ((smi_info->irq) && (! smi_info->interrupt_disabled)) {
 		disable_irq_nosync(smi_info->irq);
 		smi_info->interrupt_disabled = 1;
 	}
@@ -359,7 +359,7 @@ static void handle_flags(struct smi_info
 	} else if (smi_info->msg_flags & RECEIVE_MSG_AVAIL) {
 		/* Messages available. */
 		smi_info->curr_msg = ipmi_alloc_smi_msg();
-		if (!smi_info->curr_msg) {
+		if (! smi_info->curr_msg) {
 			disable_si_irq(smi_info);
 			smi_info->si_state = SI_NORMAL;
 			return;
@@ -378,7 +378,7 @@ static void handle_flags(struct smi_info
 	} else if (smi_info->msg_flags & EVENT_MSG_BUFFER_FULL) {
 		/* Events available. */
 		smi_info->curr_msg = ipmi_alloc_smi_msg();
-		if (!smi_info->curr_msg) {
+		if (! smi_info->curr_msg) {
 			disable_si_irq(smi_info);
 			smi_info->si_state = SI_NORMAL;
 			return;
@@ -414,7 +414,7 @@ static void handle_transaction_done(stru
 #endif
 	switch (smi_info->si_state) {
 	case SI_NORMAL:
-		if (!smi_info->curr_msg)
+		if (! smi_info->curr_msg)
 			break;
 
 		smi_info->curr_msg->rsp_size
@@ -1047,7 +1047,7 @@ static int std_irq_setup(struct smi_info
 {
 	int rv;
 
-	if (!info->irq)
+	if (! info->irq)
 		return 0;
 
 	if (info->si_type == SI_BT) {
@@ -1056,7 +1056,7 @@ static int std_irq_setup(struct smi_info
 				 SA_INTERRUPT,
 				 DEVICE_NAME,
 				 info);
-		if (!rv)
+		if (! rv)
 			/* Enable the interrupt in the BT interface. */
 			info->io.outputb(&info->io, IPMI_BT_INTMASK_REG,
 					 IPMI_BT_INTMASK_ENABLE_IRQ_BIT);
@@ -1081,7 +1081,7 @@ static int std_irq_setup(struct smi_info
 
 static void std_irq_cleanup(struct smi_info *info)
 {
-	if (!info->irq)
+	if (! info->irq)
 		return;
 
 	if (info->si_type == SI_BT)
@@ -1154,7 +1154,7 @@ static int port_setup(struct smi_info *i
 	unsigned int *addr = info->io.info;
 	int           mapsize;
 
-	if (!addr || (!*addr))
+	if (! addr || (! *addr))
 		return -ENODEV;
 
 	info->io_cleanup = port_cleanup;
@@ -1197,15 +1197,15 @@ static int try_init_port(int intf_num, s
 {
 	struct smi_info *info;
 
-	if (!ports[intf_num])
+	if (! ports[intf_num])
 		return -ENODEV;
 
-	if (!is_new_interface(intf_num, IPMI_IO_ADDR_SPACE,
+	if (! is_new_interface(intf_num, IPMI_IO_ADDR_SPACE,
 			      ports[intf_num]))
 		return -ENODEV;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
+	if (! info) {
 		printk(KERN_ERR "ipmi_si: Could not allocate SI data (1)\n");
 		return -ENOMEM;
 	}
@@ -1215,10 +1215,10 @@ static int try_init_port(int intf_num, s
 	info->io.info = &(ports[intf_num]);
 	info->io.addr = NULL;
 	info->io.regspacing = regspacings[intf_num];
-	if (!info->io.regspacing)
+	if (! info->io.regspacing)
 		info->io.regspacing = DEFAULT_REGSPACING;
 	info->io.regsize = regsizes[intf_num];
-	if (!info->io.regsize)
+	if (! info->io.regsize)
 		info->io.regsize = DEFAULT_REGSPACING;
 	info->io.regshift = regshifts[intf_num];
 	info->irq = 0;
@@ -1303,7 +1303,7 @@ static int mem_setup(struct smi_info *in
 	unsigned long *addr = info->io.info;
 	int           mapsize;
 
-	if (!addr || (!*addr))
+	if (! addr || (! *addr))
 		return -ENODEV;
 
 	info->io_cleanup = mem_cleanup;
@@ -1358,15 +1358,15 @@ static int try_init_mem(int intf_num, st
 {
 	struct smi_info *info;
 
-	if (!addrs[intf_num])
+	if (! addrs[intf_num])
 		return -ENODEV;
 
-	if (!is_new_interface(intf_num, IPMI_MEM_ADDR_SPACE,
+	if (! is_new_interface(intf_num, IPMI_MEM_ADDR_SPACE,
 			      addrs[intf_num]))
 		return -ENODEV;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
+	if (! info) {
 		printk(KERN_ERR "ipmi_si: Could not allocate SI data (2)\n");
 		return -ENOMEM;
 	}
@@ -1376,10 +1376,10 @@ static int try_init_mem(int intf_num, st
 	info->io.info = &addrs[intf_num];
 	info->io.addr = NULL;
 	info->io.regspacing = regspacings[intf_num];
-	if (!info->io.regspacing)
+	if (! info->io.regspacing)
 		info->io.regspacing = DEFAULT_REGSPACING;
 	info->io.regsize = regsizes[intf_num];
-	if (!info->io.regsize)
+	if (! info->io.regsize)
 		info->io.regsize = DEFAULT_REGSPACING;
 	info->io.regshift = regshifts[intf_num];
 	info->irq = 0;
@@ -1437,7 +1437,7 @@ static int acpi_gpe_irq_setup(struct smi
 {
 	acpi_status status;
 
-	if (!info->irq)
+	if (! info->irq)
 		return 0;
 
 	/* FIXME - is level triggered right? */
@@ -1461,7 +1461,7 @@ static int acpi_gpe_irq_setup(struct smi
 
 static void acpi_gpe_irq_cleanup(struct smi_info *info)
 {
-	if (!info->irq)
+	if (! info->irq)
 		return;
 
 	acpi_remove_gpe_handler(NULL, info->irq, &ipmi_acpi_gpe);
@@ -1537,10 +1537,10 @@ static int try_init_acpi(int intf_num, s
 		addr_space = IPMI_MEM_ADDR_SPACE;
 	else
 		addr_space = IPMI_IO_ADDR_SPACE;
-	if (!is_new_interface(-1, addr_space, spmi->addr.address))
+	if (! is_new_interface(-1, addr_space, spmi->addr.address))
 		return -ENODEV;
 
-	if (!spmi->addr.register_bit_width) {
+	if (! spmi->addr.register_bit_width) {
 		acpi_failure = 1;
 		return -ENODEV;
 	}
@@ -1567,7 +1567,7 @@ static int try_init_acpi(int intf_num, s
 	}
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
+	if (! info) {
 		printk(KERN_ERR "ipmi_si: Could not allocate SI data (3)\n");
 		return -ENOMEM;
 	}
@@ -1645,7 +1645,7 @@ static int dmi_data_entries;
 
 static int __init decode_dmi(struct dmi_header *dm, int intf_num)
 {
-	u8 *data = (u8 *)dm;
+	u8              *data = (u8 *)dm;
 	unsigned long  	base_addr;
 	u8		reg_spacing;
 	u8              len = dm->length;
@@ -1714,7 +1714,7 @@ static int __init decode_dmi(struct dmi_
 static void __init dmi_find_bmc(void)
 {
 	struct dmi_device *dev = NULL;
-	int intf_num = 0;
+	int               intf_num = 0;
 
 	while ((dev = dmi_find_device(DMI_DEV_TYPE_IPMI, NULL, dev))) {
 		if (intf_num >= SI_MAX_DRIVERS)
@@ -1726,14 +1726,14 @@ static void __init dmi_find_bmc(void)
 
 static int try_init_smbios(int intf_num, struct smi_info **new_info)
 {
-	struct smi_info   *info;
-	dmi_ipmi_data_t   *ipmi_data = dmi_data+intf_num;
-	char              *io_type;
+	struct smi_info *info;
+	dmi_ipmi_data_t *ipmi_data = dmi_data+intf_num;
+	char            *io_type;
 
 	if (intf_num >= dmi_data_entries)
 		return -ENODEV;
 
-	switch(ipmi_data->type) {
+	switch (ipmi_data->type) {
 		case 0x01: /* KCS */
 			si_type[intf_num] = "kcs";
 			break;
@@ -1748,7 +1748,7 @@ static int try_init_smbios(int intf_num,
 	}
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
+	if (! info) {
 		printk(KERN_ERR "ipmi_si: Could not allocate SI data (4)\n");
 		return -ENOMEM;
 	}
@@ -1772,7 +1772,7 @@ static int try_init_smbios(int intf_num,
 
 	regspacings[intf_num] = ipmi_data->offset;
 	info->io.regspacing = regspacings[intf_num];
-	if (!info->io.regspacing)
+	if (! info->io.regspacing)
 		info->io.regspacing = DEFAULT_REGSPACING;
 	info->io.regsize = DEFAULT_REGSPACING;
 	info->io.regshift = regshifts[intf_num];
@@ -1814,14 +1814,14 @@ static int find_pci_smic(int intf_num, s
 
 	pci_smic_checked = 1;
 
-	if ((pci_dev = pci_get_device(PCI_HP_VENDOR_ID, PCI_MMC_DEVICE_ID,
-				       NULL)))
-		;
-	else if ((pci_dev = pci_get_class(PCI_ERMC_CLASSCODE, NULL)) &&
-		 pci_dev->subsystem_vendor == PCI_HP_VENDOR_ID)
-		fe_rmc = 1;
-	else
-		return -ENODEV;
+	pci_dev = pci_get_device(PCI_HP_VENDOR_ID, PCI_MMC_DEVICE_ID, NULL);
+	if (! pci_dev) {
+		pci_dev = pci_get_class(PCI_ERMC_CLASSCODE, NULL);
+		if (pci_dev && (pci_dev->subsystem_vendor == PCI_HP_VENDOR_ID))
+			fe_rmc = 1;
+		else
+			return -ENODEV;
+	}
 
 	error = pci_read_config_word(pci_dev, PCI_MMC_ADDR_CW, &base_addr);
 	if (error)
@@ -1834,7 +1834,7 @@ static int find_pci_smic(int intf_num, s
 	}
 
 	/* Bit 0: 1 specifies programmed I/O, 0 specifies memory mapped I/O */
-	if (!(base_addr & 0x0001))
+	if (! (base_addr & 0x0001))
 	{
 		pci_dev_put(pci_dev);
 		printk(KERN_ERR
@@ -1844,17 +1844,17 @@ static int find_pci_smic(int intf_num, s
 	}
 
 	base_addr &= 0xFFFE;
-	if (!fe_rmc)
+	if (! fe_rmc)
 		/* Data register starts at base address + 1 in eRMC */
 		++base_addr;
 
-	if (!is_new_interface(-1, IPMI_IO_ADDR_SPACE, base_addr)) {
+	if (! is_new_interface(-1, IPMI_IO_ADDR_SPACE, base_addr)) {
 		pci_dev_put(pci_dev);
 		return -ENODEV;
 	}
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
+	if (! info) {
 		pci_dev_put(pci_dev);
 		printk(KERN_ERR "ipmi_si: Could not allocate SI data (5)\n");
 		return -ENOMEM;
@@ -1865,7 +1865,7 @@ static int find_pci_smic(int intf_num, s
 	ports[intf_num] = base_addr;
 	info->io.info = &(ports[intf_num]);
 	info->io.regspacing = regspacings[intf_num];
-	if (!info->io.regspacing)
+	if (! info->io.regspacing)
 		info->io.regspacing = DEFAULT_REGSPACING;
 	info->io.regsize = DEFAULT_REGSPACING;
 	info->io.regshift = regshifts[intf_num];
@@ -1886,7 +1886,7 @@ static int find_pci_smic(int intf_num, s
 static int try_init_plug_and_play(int intf_num, struct smi_info **new_info)
 {
 #ifdef CONFIG_PCI
-	if (find_pci_smic(intf_num, new_info)==0)
+	if (find_pci_smic(intf_num, new_info) == 0)
 		return 0;
 #endif
 	/* Include other methods here. */
@@ -1904,7 +1904,7 @@ static int try_get_dev_id(struct smi_inf
 	int               rv = 0;
 
 	resp = kmalloc(IPMI_MAX_MSG_LENGTH, GFP_KERNEL);
-	if (!resp)
+	if (! resp)
 		return -ENOMEM;
 
 	/* Do a Get Device ID command, since it comes back with some
@@ -1986,7 +1986,7 @@ static int stat_file_read_proc(char *pag
 	struct smi_info *smi = data;
 
 	out += sprintf(out, "interrupts_enabled:    %d\n",
-		       smi->irq && !smi->interrupt_disabled);
+		       smi->irq && ! smi->interrupt_disabled);
 	out += sprintf(out, "short_timeouts:        %ld\n",
 		       smi->short_timeouts);
 	out += sprintf(out, "long_timeouts:         %ld\n",
@@ -2024,8 +2024,8 @@ static int stat_file_read_proc(char *pag
  */
 static int oem_data_avail_to_receive_msg_avail(struct smi_info *smi_info)
 {
-	smi_info->msg_flags = (smi_info->msg_flags & ~OEM_DATA_AVAIL) |
-		RECEIVE_MSG_AVAIL;
+	smi_info->msg_flags = ((smi_info->msg_flags & ~OEM_DATA_AVAIL) |
+			      	RECEIVE_MSG_AVAIL);
 	return 1;
 }
 
@@ -2059,10 +2059,11 @@ static void setup_dell_poweredge_oem_dat
 {
 	struct ipmi_device_id *id = &smi_info->device_id;
 	const char mfr[3]=DELL_IANA_MFR_ID;
-	if (!memcmp(mfr, id->manufacturer_id, sizeof(mfr)) &&
-	    id->device_id       == DELL_POWEREDGE_8G_BMC_DEVICE_ID &&
-	    id->device_revision == DELL_POWEREDGE_8G_BMC_DEVICE_REV &&
-	    id->ipmi_version    == DELL_POWEREDGE_8G_BMC_IPMI_VERSION) {
+	if (! memcmp(mfr, id->manufacturer_id, sizeof(mfr))
+	    && (id->device_id       == DELL_POWEREDGE_8G_BMC_DEVICE_ID)
+	    && (id->device_revision == DELL_POWEREDGE_8G_BMC_DEVICE_REV)
+	    && (id->ipmi_version    == DELL_POWEREDGE_8G_BMC_IPMI_VERSION))
+	{
 		smi_info->oem_data_avail_handler =
 			oem_data_avail_to_receive_msg_avail;
 	}
@@ -2092,16 +2093,16 @@ static int init_one_smi(int intf_num, st
 	if (rv)
 		rv = try_init_port(intf_num, &new_smi);
 #ifdef CONFIG_ACPI_INTERPRETER
-	if ((rv) && (si_trydefaults)) {
+	if (rv && si_trydefaults) {
 		rv = try_init_acpi(intf_num, &new_smi);
 	}
 #endif
 #ifdef CONFIG_X86
-	if ((rv) && (si_trydefaults)) {
+	if (rv && si_trydefaults) {
 		rv = try_init_smbios(intf_num, &new_smi);
         }
 #endif
-	if ((rv) && (si_trydefaults)) {
+	if (rv && si_trydefaults) {
 		rv = try_init_plug_and_play(intf_num, &new_smi);
 	}
 
@@ -2114,7 +2115,7 @@ static int init_one_smi(int intf_num, st
 	new_smi->si_sm = NULL;
 	new_smi->handlers = NULL;
 
-	if (!new_smi->irq_setup) {
+	if (! new_smi->irq_setup) {
 		new_smi->irq = irqs[intf_num];
 		new_smi->irq_setup = std_irq_setup;
 		new_smi->irq_cleanup = std_irq_cleanup;
@@ -2148,7 +2149,7 @@ static int init_one_smi(int intf_num, st
 
 	/* Allocate the state machine's data and initialize it. */
 	new_smi->si_sm = kmalloc(new_smi->handlers->size(), GFP_KERNEL);
-	if (!new_smi->si_sm) {
+	if (! new_smi->si_sm) {
 		printk(" Could not allocate state machine memory\n");
 		rv = -ENOMEM;
 		goto out_err;
@@ -2256,7 +2257,7 @@ static int init_one_smi(int intf_num, st
 
 	/* Wait for the timer to stop.  This avoids problems with race
 	   conditions removing the timer here. */
-	while (!new_smi->timer_stopped) {
+	while (! new_smi->timer_stopped) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
 	}
@@ -2296,7 +2297,7 @@ static __init int init_ipmi_si(void)
 	/* Parse out the si_type string into its components. */
 	str = si_type_str;
 	if (*str != '\0') {
-		for (i=0; (i<SI_MAX_PARMS) && (*str != '\0'); i++) {
+		for (i = 0; (i < SI_MAX_PARMS) && (*str != '\0'); i++) {
 			si_type[i] = str;
 			str = strchr(str, ',');
 			if (str) {
@@ -2315,7 +2316,7 @@ static __init int init_ipmi_si(void)
 #endif
 
 	rv = init_one_smi(0, &(smi_infos[pos]));
-	if (rv && !ports[0] && si_trydefaults) {
+	if (rv && ! ports[0] && si_trydefaults) {
 		/* If we are trying defaults and the initial port is
                    not set, then set it. */
 		si_type[0] = "kcs";
@@ -2337,7 +2338,7 @@ static __init int init_ipmi_si(void)
 	if (rv == 0)
 		pos++;
 
-	for (i=1; i < SI_MAX_PARMS; i++) {
+	for (i = 1; i < SI_MAX_PARMS; i++) {
 		rv = init_one_smi(i, &(smi_infos[pos]));
 		if (rv == 0)
 			pos++;
@@ -2379,14 +2380,14 @@ static void __exit cleanup_one_si(struct
 
 	/* Wait for the timer to stop.  This avoids problems with race
 	   conditions removing the timer here. */
-	while (!to_clean->timer_stopped) {
+	while (! to_clean->timer_stopped) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 
 	/* Interrupts and timeouts are stopped, now make sure the
 	   interface is in a clean state. */
-	while ((to_clean->curr_msg) || (to_clean->si_state != SI_NORMAL)) {
+	while (to_clean->curr_msg || (to_clean->si_state != SI_NORMAL)) {
 		poll(to_clean);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
@@ -2410,10 +2411,10 @@ static __exit void cleanup_ipmi_si(void)
 {
 	int i;
 
-	if (!initialized)
+	if (! initialized)
 		return;
 
-	for (i=0; i<SI_MAX_DRIVERS; i++) {
+	for (i = 0; i < SI_MAX_DRIVERS; i++) {
 		cleanup_one_si(smi_infos[i]);
 	}
 }
Index: linux-2.6.13/drivers/char/ipmi/ipmi_bt_sm.c
===================================================================
--- linux-2.6.13.orig/drivers/char/ipmi/ipmi_bt_sm.c
+++ linux-2.6.13/drivers/char/ipmi/ipmi_bt_sm.c
@@ -161,7 +161,8 @@ static int bt_start_transaction(struct s
 {
 	unsigned int i;
 
-	if ((size < 2) || (size > IPMI_MAX_MSG_LENGTH)) return -1;
+	if ((size < 2) || (size > IPMI_MAX_MSG_LENGTH))
+	       return -1;
 
 	if ((bt->state != BT_STATE_IDLE) && (bt->state != BT_STATE_HOSED))
 		return -2;
@@ -169,7 +170,8 @@ static int bt_start_transaction(struct s
 	if (bt_debug & BT_DEBUG_MSG) {
     		printk(KERN_WARNING "+++++++++++++++++++++++++++++++++++++\n");
 		printk(KERN_WARNING "BT: write seq=0x%02X:", bt->seq);
-		for (i = 0; i < size; i ++) printk (" %02x", data[i]);
+		for (i = 0; i < size; i ++)
+		       printk (" %02x", data[i]);
 		printk("\n");
 	}
 	bt->write_data[0] = size + 1;	/* all data plus seq byte */
@@ -208,15 +210,18 @@ static int bt_get_result(struct si_sm_da
 	} else {
 		data[0] = bt->read_data[1];
 		data[1] = bt->read_data[3];
-		if (length < msg_len) bt->truncated = 1;
+		if (length < msg_len)
+		       bt->truncated = 1;
 		if (bt->truncated) {	/* can be set in read_all_bytes() */
 			data[2] = IPMI_ERR_MSG_TRUNCATED;
 			msg_len = 3;
-		} else memcpy(data + 2, bt->read_data + 4, msg_len - 2);
+		} else
+		       memcpy(data + 2, bt->read_data + 4, msg_len - 2);
 
 		if (bt_debug & BT_DEBUG_MSG) {
 			printk (KERN_WARNING "BT: res (raw)");
-			for (i = 0; i < msg_len; i++) printk(" %02x", data[i]);
+			for (i = 0; i < msg_len; i++)
+			       printk(" %02x", data[i]);
 			printk ("\n");
 		}
 	}
@@ -229,8 +234,10 @@ static int bt_get_result(struct si_sm_da
 
 static void reset_flags(struct si_sm_data *bt)
 {
-	if (BT_STATUS & BT_H_BUSY) BT_CONTROL(BT_H_BUSY);
-	if (BT_STATUS & BT_B_BUSY) BT_CONTROL(BT_B_BUSY);
+	if (BT_STATUS & BT_H_BUSY)
+	       BT_CONTROL(BT_H_BUSY);
+	if (BT_STATUS & BT_B_BUSY)
+	       BT_CONTROL(BT_B_BUSY);
 	BT_CONTROL(BT_CLR_WR_PTR);
 	BT_CONTROL(BT_SMS_ATN);
 #ifdef DEVELOPMENT_ONLY_NOT_FOR_PRODUCTION
@@ -239,7 +246,8 @@ static void reset_flags(struct si_sm_dat
 		BT_CONTROL(BT_H_BUSY);
 		BT_CONTROL(BT_B2H_ATN);
 		BT_CONTROL(BT_CLR_RD_PTR);
-		for (i = 0; i < IPMI_MAX_MSG_LENGTH + 2; i++) BMC2HOST;
+		for (i = 0; i < IPMI_MAX_MSG_LENGTH + 2; i++)
+		       BMC2HOST;
 		BT_CONTROL(BT_H_BUSY);
 	}
 #endif
@@ -256,7 +264,8 @@ static inline void write_all_bytes(struc
 			printk (" %02x", bt->write_data[i]);
 		printk ("\n");
 	}
-	for (i = 0; i < bt->write_count; i++) HOST2BMC(bt->write_data[i]);
+	for (i = 0; i < bt->write_count; i++)
+	       HOST2BMC(bt->write_data[i]);
 }
 
 static inline int read_all_bytes(struct si_sm_data *bt)
@@ -276,7 +285,8 @@ static inline int read_all_bytes(struct 
 		bt->truncated = 1;
 		return 1;	/* let next XACTION START clean it up */
 	}
-	for (i = 1; i <= bt->read_count; i++) bt->read_data[i] = BMC2HOST;
+	for (i = 1; i <= bt->read_count; i++)
+	       bt->read_data[i] = BMC2HOST;
 	bt->read_count++;	/* account for the length byte */
 
 	if (bt_debug & BT_DEBUG_MSG) {
@@ -293,7 +303,8 @@ static inline int read_all_bytes(struct 
         	((bt->read_data[1] & 0xF8) == (bt->write_data[1] & 0xF8)))
 			return 1;
 
-	if (bt_debug & BT_DEBUG_MSG) printk(KERN_WARNING "BT: bad packet: "
+	if (bt_debug & BT_DEBUG_MSG)
+	       printk(KERN_WARNING "BT: bad packet: "
 		"want 0x(%02X, %02X, %02X) got (%02X, %02X, %02X)\n",
 		bt->write_data[1], bt->write_data[2], bt->write_data[3],
 		bt->read_data[1],  bt->read_data[2],  bt->read_data[3]);
@@ -357,7 +368,8 @@ static enum si_sm_result bt_event(struct
 			time);
 	bt->last_state = bt->state;
 
-	if (bt->state == BT_STATE_HOSED) return SI_SM_HOSED;
+	if (bt->state == BT_STATE_HOSED)
+	       return SI_SM_HOSED;
 
 	if (bt->state != BT_STATE_IDLE) {	/* do timeout test */
 
@@ -369,7 +381,8 @@ static enum si_sm_result bt_event(struct
     	/* FIXME: bt_event is sometimes called with time > BT_NORMAL_TIMEOUT
               (noticed in ipmi_smic_sm.c January 2004) */
 
-		if ((time <= 0) || (time >= BT_NORMAL_TIMEOUT)) time = 100;
+		if ((time <= 0) || (time >= BT_NORMAL_TIMEOUT))
+		       time = 100;
 		bt->timeout -= time;
 		if ((bt->timeout < 0) && (bt->state < BT_STATE_RESET1)) {
 			error_recovery(bt, "timed out");
@@ -391,12 +404,14 @@ static enum si_sm_result bt_event(struct
 			BT_CONTROL(BT_H_BUSY);
 			break;
 		}
-    		if (status & BT_B2H_ATN) break;
+    		if (status & BT_B2H_ATN)
+		       break;
 		bt->state = BT_STATE_WRITE_BYTES;
 		return SI_SM_CALL_WITHOUT_DELAY;	/* for logging */
 
 	case BT_STATE_WRITE_BYTES:
-		if (status & (BT_B_BUSY | BT_H2B_ATN)) break;
+		if (status & (BT_B_BUSY | BT_H2B_ATN))
+		       break;
 		BT_CONTROL(BT_CLR_WR_PTR);
 		write_all_bytes(bt);
 		BT_CONTROL(BT_H2B_ATN);	/* clears too fast to catch? */
@@ -404,7 +419,8 @@ static enum si_sm_result bt_event(struct
 		return SI_SM_CALL_WITHOUT_DELAY; /* it MIGHT sail through */
 
 	case BT_STATE_WRITE_CONSUME: /* BMCs usually blow right thru here */
-        	if (status & (BT_H2B_ATN | BT_B_BUSY)) break;
+        	if (status & (BT_H2B_ATN | BT_B_BUSY))
+		       break;
 		bt->state = BT_STATE_B2H_WAIT;
 		/* fall through with status */
 
@@ -413,15 +429,18 @@ static enum si_sm_result bt_event(struct
 	   generation of B2H_ATN so ALWAYS return CALL_WITH_DELAY. */
 
 	case BT_STATE_B2H_WAIT:
-    		if (!(status & BT_B2H_ATN)) break;
+    		if (!(status & BT_B2H_ATN))
+		       break;
 
 		/* Assume ordered, uncached writes: no need to wait */
-		if (!(status & BT_H_BUSY)) BT_CONTROL(BT_H_BUSY); /* set */
+		if (!(status & BT_H_BUSY))
+		       BT_CONTROL(BT_H_BUSY); /* set */
 		BT_CONTROL(BT_B2H_ATN);		/* clear it, ACK to the BMC */
 		BT_CONTROL(BT_CLR_RD_PTR);	/* reset the queue */
 		i = read_all_bytes(bt);
 		BT_CONTROL(BT_H_BUSY);		/* clear */
-		if (!i) break;			/* Try this state again */
+		if (!i)				/* Try this state again */
+		       break;
 		bt->state = BT_STATE_READ_END;
 		return SI_SM_CALL_WITHOUT_DELAY;	/* for logging */
 
@@ -434,7 +453,8 @@ static enum si_sm_result bt_event(struct
 
 #ifdef MAKE_THIS_TRUE_IF_NECESSARY
 
-		if (status & BT_H_BUSY) break;
+		if (status & BT_H_BUSY)
+		       break;
 #endif
 		bt->seq++;
 		bt->state = BT_STATE_IDLE;
@@ -457,7 +477,8 @@ static enum si_sm_result bt_event(struct
 		break;
 
 	case BT_STATE_RESET3:
-		if (bt->timeout > 0) return SI_SM_CALL_WITH_DELAY;
+		if (bt->timeout > 0)
+		       return SI_SM_CALL_WITH_DELAY;
 		bt->state = BT_STATE_RESTART;	/* printk in debug modes */
 		break;
 
@@ -483,7 +504,8 @@ static int bt_detect(struct si_sm_data *
 	   but that's what you get from reading a bogus address, so we
 	   test that first.  The calling routine uses negative logic. */
 
-	if ((BT_STATUS == 0xFF) && (BT_INTMASK_R == 0xFF)) return 1;
+	if ((BT_STATUS == 0xFF) && (BT_INTMASK_R == 0xFF))
+	       return 1;
 	reset_flags(bt);
 	return 0;
 }

--=-6jKy9hdONLz2rQ0bFRb3--

