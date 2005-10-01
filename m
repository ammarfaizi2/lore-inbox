Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVJAGhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVJAGhc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 02:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVJAGhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 02:37:32 -0400
Received: from sccrmhc13.comcast.net ([63.240.76.28]:44218 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750744AbVJAGhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 02:37:31 -0400
Date: Fri, 30 Sep 2005 23:37:33 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] [BLOCK] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001063733.GB24250@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Linus, do you want these broken up into individual files for submission?)

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -318,11 +318,10 @@ static boolean DAC960_CreateAuxiliaryStr
 		CommandsRemaining = CommandAllocationGroupSize;
 	  CommandGroupByteCount =
 		CommandsRemaining * CommandAllocationLength;
-	  AllocationPointer = kmalloc(CommandGroupByteCount, GFP_ATOMIC);
+	  AllocationPointer = kzalloc(CommandGroupByteCount, GFP_ATOMIC);
 	  if (AllocationPointer == NULL)
 		return DAC960_Failure(Controller,
 					"AUXILIARY STRUCTURE CREATION");
-	  memset(AllocationPointer, 0, CommandGroupByteCount);
 	 }
       Command = (DAC960_Command_T *) AllocationPointer;
       AllocationPointer += CommandAllocationLength;
@@ -2726,13 +2725,12 @@ DAC960_DetectController(struct pci_dev *
   int i;
 
   Controller = (DAC960_Controller_T *)
-	kmalloc(sizeof(DAC960_Controller_T), GFP_ATOMIC);
+	kzalloc(sizeof(DAC960_Controller_T), GFP_ATOMIC);
   if (Controller == NULL) {
 	DAC960_Error("Unable to allocate Controller structure for "
                        "Controller at\n", NULL);
 	return NULL;
   }
-  memset(Controller, 0, sizeof(DAC960_Controller_T));
   Controller->ControllerNumber = DAC960_ControllerCount;
   DAC960_Controllers[DAC960_ControllerCount++] = Controller;
   Controller->Bus = PCI_Device->bus->number;
@@ -4665,7 +4663,6 @@ static void DAC960_V2_ProcessCompletedCo
 	   */
 	   DAC960_queue_partial_rw(Command);
 	   return;
-	}
       else
 	{
 	  if (Command->V2.RequestSense->SenseKey != DAC960_SenseKey_NotReady)
@@ -4799,10 +4796,10 @@ static void DAC960_V2_ProcessCompletedCo
 	       PhysicalDeviceInfo->LogicalUnit))
 	    {
 	      PhysicalDeviceInfo = (DAC960_V2_PhysicalDeviceInfo_T *)
-		kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
+		kzalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
 	      InquiryUnitSerialNumber =
 		(DAC960_SCSI_Inquiry_UnitSerialNumber_T *)
-		  kmalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T),
+		  kzalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T),
 			  GFP_ATOMIC);
 	      if (InquiryUnitSerialNumber == NULL &&
 		  PhysicalDeviceInfo != NULL)
@@ -4818,12 +4815,8 @@ static void DAC960_V2_ProcessCompletedCo
 			       ? "" : " - Allocation Failed"));
 	      if (PhysicalDeviceInfo != NULL)
 		{
-		  memset(PhysicalDeviceInfo, 0,
-			 sizeof(DAC960_V2_PhysicalDeviceInfo_T));
 		  PhysicalDeviceInfo->PhysicalDeviceState =
 		    DAC960_V2_Device_InvalidState;
-		  memset(InquiryUnitSerialNumber, 0,
-			 sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T));
 		  InquiryUnitSerialNumber->PeripheralDeviceType = 0x1F;
 		  for (DeviceIndex = DAC960_V2_MaxPhysicalDevices - 1;
 		       DeviceIndex > PhysicalDeviceIndex;
@@ -4969,7 +4962,7 @@ static void DAC960_V2_ProcessCompletedCo
 	      Controller->V2.LogicalDriveToVirtualDevice[LogicalDeviceNumber] =
 		PhysicalDevice;
 	      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
-		kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
+		kzalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
 	      Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
 		LogicalDeviceInfo;
 	      DAC960_Critical("Logical Drive %d (/dev/rd/c%dd%d) "
@@ -4980,11 +4973,7 @@ static void DAC960_V2_ProcessCompletedCo
 			      (LogicalDeviceInfo != NULL
 			       ? "" : " - Allocation Failed"));
 	      if (LogicalDeviceInfo != NULL)
-		{
-		  memset(LogicalDeviceInfo, 0,
-			 sizeof(DAC960_V2_LogicalDeviceInfo_T));
 		  DAC960_ComputeGenericDiskInfo(Controller);
-		}
 	    }
 	  if (LogicalDeviceInfo != NULL)
 	    {
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -2733,13 +2733,12 @@ static void cciss_getgeometry(int cntl_n
 	int block_size;
 	int total_size; 
 
-	ld_buff = kmalloc(sizeof(ReportLunData_struct), GFP_KERNEL);
+	ld_buff = kzalloc(sizeof(ReportLunData_struct), GFP_KERNEL);
 	if (ld_buff == NULL)
 	{
 		printk(KERN_ERR "cciss: out of memory\n");
 		return;
 	}
-	memset(ld_buff, 0, sizeof(ReportLunData_struct));
 	size_buff = kmalloc(sizeof( ReadCapdata_struct), GFP_KERNEL);
         if (size_buff == NULL)
         {
@@ -2853,10 +2852,9 @@ static int alloc_cciss_hba(void)
 	for(i=0; i< MAX_CTLR; i++) {
 		if (!hba[i]) {
 			ctlr_info_t *p;
-			p = kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);
+			p = kzalloc(sizeof(ctlr_info_t), GFP_KERNEL);
 			if (!p)
 				goto Enomem;
-			memset(p, 0, sizeof(ctlr_info_t));
 			for (n = 0; n < NWD; n++)
 				p->gendisk[n] = disk[n];
 			hba[i] = p;
diff --git a/drivers/block/cciss_scsi.c b/drivers/block/cciss_scsi.c
--- a/drivers/block/cciss_scsi.c
+++ b/drivers/block/cciss_scsi.c
@@ -1015,12 +1015,11 @@ cciss_update_non_disk_devices(int cntl_n
 	int i;
 
 	c = (ctlr_info_t *) hba[cntl_num];	
-	ld_buff = kmalloc(reportlunsize, GFP_KERNEL);
+	ld_buff = kzalloc(reportlunsize, GFP_KERNEL);
 	if (ld_buff == NULL) {
 		printk(KERN_ERR "cciss: out of memory\n");
 		return;
 	}
-	memset(ld_buff, 0, reportlunsize);
 	inq_buff = kmalloc(OBDR_TAPE_INQ_SIZE, GFP_KERNEL);
         if (inq_buff == NULL) {
                 printk(KERN_ERR "cciss: out of memory\n");
diff --git a/drivers/block/cfq-iosched.c b/drivers/block/cfq-iosched.c
--- a/drivers/block/cfq-iosched.c
+++ b/drivers/block/cfq-iosched.c
@@ -2284,12 +2284,10 @@ static int cfq_init_queue(request_queue_
 	struct cfq_data *cfqd;
 	int i;
 
-	cfqd = kmalloc(sizeof(*cfqd), GFP_KERNEL);
+	cfqd = kzalloc(sizeof(*cfqd), GFP_KERNEL);
 	if (!cfqd)
 		return -ENOMEM;
 
-	memset(cfqd, 0, sizeof(*cfqd));
-
 	for (i = 0; i < CFQ_PRIO_LISTS; i++)
 		INIT_LIST_HEAD(&cfqd->rr_list[i]);
 
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -425,7 +425,7 @@ static int cpqarray_register_ctlr( int i
 	hba[i]->cmd_pool = (cmdlist_t *)pci_alloc_consistent(
 		hba[i]->pci_dev, NR_CMDS * sizeof(cmdlist_t),
 		&(hba[i]->cmd_pool_dhandle));
-	hba[i]->cmd_pool_bits = kmalloc(
+	hba[i]->cmd_pool_bits = kzalloc(
 		((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long),
 		GFP_KERNEL);
 
@@ -433,7 +433,6 @@ static int cpqarray_register_ctlr( int i
 			goto Enomem1;
 
 	memset(hba[i]->cmd_pool, 0, NR_CMDS * sizeof(cmdlist_t));
-	memset(hba[i]->cmd_pool_bits, 0, ((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long));
 	printk(KERN_INFO "cpqarray: Finding drives on %s",
 		hba[i]->devname);
 
@@ -1655,14 +1654,14 @@ static void getgeometry(int ctlr)
 
 	info_p->log_drv_map = 0;	
 	
-	id_ldrive = (id_log_drv_t *)kmalloc(sizeof(id_log_drv_t), GFP_KERNEL);
+	id_ldrive = (id_log_drv_t *)kzalloc(sizeof(id_log_drv_t), GFP_KERNEL);
 	if(id_ldrive == NULL)
 	{
 		printk( KERN_ERR "cpqarray:  out of memory.\n");
 		return;
 	}
 
-	id_ctlr_buf = (id_ctlr_t *)kmalloc(sizeof(id_ctlr_t), GFP_KERNEL);
+	id_ctlr_buf = (id_ctlr_t *)kzalloc(sizeof(id_ctlr_t), GFP_KERNEL);
 	if(id_ctlr_buf == NULL)
 	{
 		kfree(id_ldrive);
@@ -1670,7 +1669,7 @@ static void getgeometry(int ctlr)
 		return;
 	}
 
-	id_lstatus_buf = (sense_log_drv_stat_t *)kmalloc(sizeof(sense_log_drv_stat_t), GFP_KERNEL);
+	id_lstatus_buf = (sense_log_drv_stat_t *)kzalloc(sizeof(sense_log_drv_stat_t), GFP_KERNEL);
 	if(id_lstatus_buf == NULL)
 	{
 		kfree(id_ctlr_buf);
@@ -1679,7 +1678,7 @@ static void getgeometry(int ctlr)
 		return;
 	}
 
-	sense_config_buf = (config_t *)kmalloc(sizeof(config_t), GFP_KERNEL);
+	sense_config_buf = (config_t *)kzalloc(sizeof(config_t), GFP_KERNEL);
 	if(sense_config_buf == NULL)
 	{
 		kfree(id_lstatus_buf);
@@ -1689,11 +1688,6 @@ static void getgeometry(int ctlr)
 		return;
 	}
 
-	memset(id_ldrive, 0, sizeof(id_log_drv_t));
-	memset(id_ctlr_buf, 0, sizeof(id_ctlr_t));
-	memset(id_lstatus_buf, 0, sizeof(sense_log_drv_stat_t));
-	memset(sense_config_buf, 0, sizeof(config_t));
-
 	info_p->phys_drives = 0;
 	info_p->log_drv_map = 0;
 	info_p->drv_assign_map = 0;
diff --git a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c
+++ b/drivers/block/ll_rw_blk.c
@@ -788,17 +788,15 @@ init_tag_map(request_queue_t *q, struct 
 				__FUNCTION__, depth);
 	}
 
-	tag_index = kmalloc(depth * sizeof(struct request *), GFP_ATOMIC);
+	tag_index = kzalloc(depth * sizeof(struct request *), GFP_ATOMIC);
 	if (!tag_index)
 		goto fail;
 
 	nr_ulongs = ALIGN(depth, BITS_PER_LONG) / BITS_PER_LONG;
-	tag_map = kmalloc(nr_ulongs * sizeof(unsigned long), GFP_ATOMIC);
+	tag_map = kzalloc(nr_ulongs * sizeof(unsigned long), GFP_ATOMIC);
 	if (!tag_map)
 		goto fail;
 
-	memset(tag_index, 0, depth * sizeof(struct request *));
-	memset(tag_map, 0, nr_ulongs * sizeof(unsigned long));
 	tags->real_max_depth = depth;
 	tags->max_depth = depth;
 	tags->tag_index = tag_index;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1250,10 +1250,9 @@ static int __init loop_init(void)
 	if (register_blkdev(LOOP_MAJOR, "loop"))
 		return -EIO;
 
-	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
+	loop_dev = kzalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
 	if (!loop_dev)
 		goto out_mem1;
-	memset(loop_dev, 0, max_loop * sizeof(struct loop_device));
 
 	disks = kmalloc(max_loop * sizeof(struct gendisk *), GFP_KERNEL);
 	if (!disks)
@@ -1271,7 +1270,6 @@ static int __init loop_init(void)
 		struct loop_device *lo = &loop_dev[i];
 		struct gendisk *disk = disks[i];
 
-		memset(lo, 0, sizeof(*lo));
 		lo->lo_queue = blk_alloc_queue(GFP_KERNEL);
 		if (!lo->lo_queue)
 			goto out_mem4;
diff --git a/drivers/block/paride/bpck6.c b/drivers/block/paride/bpck6.c
--- a/drivers/block/paride/bpck6.c
+++ b/drivers/block/paride/bpck6.c
@@ -224,10 +224,9 @@ static void bpck6_log_adapter( PIA *pi, 
 
 static int bpck6_init_proto(PIA *pi)
 {
-	Interface *p = kmalloc(sizeof(Interface), GFP_KERNEL);
+	Interface *p = kzalloc(sizeof(Interface), GFP_KERNEL);
 
 	if (p) {
-		memset(p, 0, sizeof(Interface));
 		pi->private = (unsigned long)p;
 		return 0;
 	}
diff --git a/drivers/block/scsi_ioctl.c b/drivers/block/scsi_ioctl.c
--- a/drivers/block/scsi_ioctl.c
+++ b/drivers/block/scsi_ioctl.c
@@ -366,11 +366,9 @@ static int sg_scsi_ioctl(struct file *fi
 
 	bytes = max(in_len, out_len);
 	if (bytes) {
-		buffer = kmalloc(bytes, q->bounce_gfp | GFP_USER| __GFP_NOWARN);
+		buffer = kzalloc(bytes, q->bounce_gfp | GFP_USER| __GFP_NOWARN);
 		if (!buffer)
 			return -ENOMEM;
-
-		memset(buffer, 0, bytes);
 	}
 
 	rq = blk_get_request(q, in_len ? WRITE : READ, __GFP_WAIT);
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1605,7 +1605,7 @@ static int carm_init_one (struct pci_dev
 	}
 #endif
 
-	host = kmalloc(sizeof(*host), GFP_KERNEL);
+	host = kzalloc(sizeof(*host), GFP_KERNEL);
 	if (!host) {
 		printk(KERN_ERR DRV_NAME "(%s): memory alloc failure\n",
 		       pci_name(pdev));
@@ -1613,7 +1613,6 @@ static int carm_init_one (struct pci_dev
 		goto err_out_regions;
 	}
 
-	memset(host, 0, sizeof(*host));
 	host->pdev = pdev;
 	host->flags = pci_dac ? FL_DAC : 0;
 	spin_lock_init(&host->lock);
diff --git a/drivers/block/ub.c b/drivers/block/ub.c
--- a/drivers/block/ub.c
+++ b/drivers/block/ub.c
@@ -1824,9 +1824,8 @@ static int ub_sync_tur(struct ub_dev *sc
 	init_completion(&compl);
 
 	rc = -ENOMEM;
-	if ((cmd = kmalloc(ALLOC_SIZE, GFP_KERNEL)) == NULL)
+	if ((cmd = kzalloc(ALLOC_SIZE, GFP_KERNEL)) == NULL)
 		goto err_alloc;
-	memset(cmd, 0, ALLOC_SIZE);
 
 	cmd->cdb[0] = TEST_UNIT_READY;
 	cmd->cdb_len = 6;
@@ -1879,9 +1878,8 @@ static int ub_sync_read_cap(struct ub_de
 	init_completion(&compl);
 
 	rc = -ENOMEM;
-	if ((cmd = kmalloc(ALLOC_SIZE, GFP_KERNEL)) == NULL)
+	if ((cmd = kzalloc(ALLOC_SIZE, GFP_KERNEL)) == NULL)
 		goto err_alloc;
-	memset(cmd, 0, ALLOC_SIZE);
 	p = (char *)cmd + sizeof(struct ub_scsi_cmd);
 
 	cmd->cdb[0] = 0x25;
@@ -2173,9 +2171,8 @@ static int ub_probe(struct usb_interface
 	int i;
 
 	rc = -ENOMEM;
-	if ((sc = kmalloc(sizeof(struct ub_dev), GFP_KERNEL)) == NULL)
+	if ((sc = kzalloc(sizeof(struct ub_dev), GFP_KERNEL)) == NULL)
 		goto err_core;
-	memset(sc, 0, sizeof(struct ub_dev));
 	spin_lock_init(&sc->lock);
 	INIT_LIST_HEAD(&sc->luns);
 	usb_init_urb(&sc->work_urb);
@@ -2288,9 +2285,8 @@ static int ub_probe_lun(struct ub_dev *s
 	int rc;
 
 	rc = -ENOMEM;
-	if ((lun = kmalloc(sizeof(struct ub_lun), GFP_KERNEL)) == NULL)
+	if ((lun = kzalloc(sizeof(struct ub_lun), GFP_KERNEL)) == NULL)
 		goto err_alloc;
-	memset(lun, 0, sizeof(struct ub_lun));
 	lun->num = lnum;
 
 	rc = -ENOSR;

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
