Return-Path: <linux-kernel-owner+w=401wt.eu-S1161042AbXAEK0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbXAEK0m (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbXAEK0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:26:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:28401 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161042AbXAEK0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:26:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=m/qiAwhvEnmsHGx2/jizLA1jTToAzX49Lu4IYOB3ervIDlpmkXOIZ4CSCtmqWm7R4tTsXiVzxaBls/LKHqzfaUjsHPZANOcI7nLot4tIgZ/sJD+B/QTadoKNLrSwAG1ou4zc2IrQIBTOPqPJ/9Q10Sl5NGfeqP1v9kSc5n6JVT0=
Date: Fri, 5 Jan 2007 12:26:23 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH UPDATED 2.6.20-rc3] Remove all the unneeded k[mzc]alloc casts
Message-ID: <20070105102623.GB382@Ahmed>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, 
This is a patch to remove the unneeded k[mzc]alloc casts in the whole 
2.6.20-rc3 tree. I tried to put this patch in a patchset but I couldn't
cause the modified files have nothing in common (except the unneeded casts 
ofcourse).

This patch includes http://lkml.org/lkml/fancy/2007/1/5/12 and
http://lkml.org/lkml/2007/1/5/6.

Signed-off-by: Ahmed Darwish

diff --git a/arch/cris/arch-v32/mm/intmem.c b/arch/cris/arch-v32/mm/intmem.c
index 41ee7f7..acb4e21 100644
--- a/arch/cris/arch-v32/mm/intmem.c
+++ b/arch/cris/arch-v32/mm/intmem.c
@@ -27,8 +27,8 @@ static void crisv32_intmem_init(void)
 {
 	static int initiated = 0;
 	if (!initiated) {
-		struct intmem_allocation* alloc =
-		  (struct intmem_allocation*)kmalloc(sizeof *alloc, GFP_KERNEL);
+		struct intmem_allocation* alloc = kmalloc(sizeof *alloc, 
+							  GFP_KERNEL);
 		INIT_LIST_HEAD(&intmem_allocations);
 		intmem_virtual = ioremap(MEM_INTMEM_START, MEM_INTMEM_SIZE);
 		initiated = 1;
@@ -56,7 +56,6 @@ void* crisv32_intmem_alloc(unsigned size, unsigned align)
 		    allocation->size >= size + alignment) {
 			if (allocation->size > size + alignment) {
 				struct intmem_allocation* alloc =
-					(struct intmem_allocation*)
 					kmalloc(sizeof *alloc, GFP_ATOMIC);
 				alloc->status = STATUS_FREE;
 				alloc->size = allocation->size - size - alignment;
@@ -65,8 +64,7 @@ void* crisv32_intmem_alloc(unsigned size, unsigned align)
 
 				if (alignment) {
 					struct intmem_allocation* tmp;
-					tmp = (struct intmem_allocation*)
-						kmalloc(sizeof *tmp, GFP_ATOMIC);
+					tmp = kmalloc(sizeof *tmp, GFP_ATOMIC);
 					tmp->offset = allocation->offset;
 					tmp->size = alignment;
 					tmp->status = STATUS_FREE;
diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 8d81a3a..72b998b 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -1879,8 +1879,8 @@ static boolean DAC960_V2_ReadControllerConfiguration(DAC960_Controller_T
       if (NewLogicalDeviceInfo->LogicalDeviceState !=
 	  DAC960_V2_LogicalDevice_Offline)
 	Controller->LogicalDriveInitiallyAccessible[LogicalDeviceNumber] = true;
-      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
-	kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
+      LogicalDeviceInfo = kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T),
+				   GFP_ATOMIC);
       if (LogicalDeviceInfo == NULL)
 	return DAC960_Failure(Controller, "LOGICAL DEVICE ALLOCATION");
       Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
@@ -2113,8 +2113,8 @@ static boolean DAC960_V2_ReadDeviceConfiguration(DAC960_Controller_T
       if (!DAC960_V2_NewPhysicalDeviceInfo(Controller, Channel, TargetID, LogicalUnit))
 	  break;
 
-      PhysicalDeviceInfo = (DAC960_V2_PhysicalDeviceInfo_T *)
-		kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
+      PhysicalDeviceInfo = kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T),
+				    GFP_ATOMIC);
       if (PhysicalDeviceInfo == NULL)
 		return DAC960_Failure(Controller, "PHYSICAL DEVICE ALLOCATION");
       Controller->V2.PhysicalDeviceInformation[PhysicalDeviceIndex] =
@@ -2122,8 +2122,8 @@ static boolean DAC960_V2_ReadDeviceConfiguration(DAC960_Controller_T
       memcpy(PhysicalDeviceInfo, NewPhysicalDeviceInfo,
 		sizeof(DAC960_V2_PhysicalDeviceInfo_T));
 
-      InquiryUnitSerialNumber = (DAC960_SCSI_Inquiry_UnitSerialNumber_T *)
-	kmalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
+      InquiryUnitSerialNumber = kmalloc(
+	      sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
       if (InquiryUnitSerialNumber == NULL) {
 	kfree(PhysicalDeviceInfo);
 	return DAC960_Failure(Controller, "SERIAL NUMBER ALLOCATION");
@@ -4949,8 +4949,8 @@ static void DAC960_V2_ProcessCompletedCommand(DAC960_Command_T *Command)
 	      PhysicalDevice.LogicalUnit = NewLogicalDeviceInfo->LogicalUnit;
 	      Controller->V2.LogicalDriveToVirtualDevice[LogicalDeviceNumber] =
 		PhysicalDevice;
-	      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
-		kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
+	      LogicalDeviceInfo = kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T),
+					  GFP_ATOMIC);
 	      Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
 		LogicalDeviceInfo;
 	      DAC960_Critical("Logical Drive %d (/dev/rd/c%dd%d) "
@@ -5709,14 +5709,14 @@ static boolean DAC960_CheckStatusBuffer(DAC960_Controller_T *Controller,
       unsigned int NewStatusBufferLength = DAC960_InitialStatusBufferSize;
       while (NewStatusBufferLength < ByteCount)
 	NewStatusBufferLength *= 2;
-      Controller->CombinedStatusBuffer =
-	(unsigned char *) kmalloc(NewStatusBufferLength, GFP_ATOMIC);
+      Controller->CombinedStatusBuffer = kmalloc(NewStatusBufferLength, 
+						 GFP_ATOMIC);
       if (Controller->CombinedStatusBuffer == NULL) return false;
       Controller->CombinedStatusBufferLength = NewStatusBufferLength;
       return true;
     }
-  NewStatusBuffer = (unsigned char *)
-    kmalloc(2 * Controller->CombinedStatusBufferLength, GFP_ATOMIC);
+  NewStatusBuffer = kmalloc(2 * Controller->CombinedStatusBufferLength, 
+			    GFP_ATOMIC);
   if (NewStatusBuffer == NULL)
     {
       DAC960_Warning("Unable to expand Combined Status Buffer - Truncating\n",
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 47a6eac..ad4d32b 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1932,16 +1932,16 @@ static int init_dev(struct tty_driver *driver, int idx,
 	}
 
 	if (!*tp_loc) {
-		tp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
-						GFP_KERNEL);
+		tp = kmalloc(sizeof(struct ktermios),
+			     GFP_KERNEL);
 		if (!tp)
 			goto free_mem_out;
 		*tp = driver->init_termios;
 	}
 
 	if (!*ltp_loc) {
-		ltp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
-						 GFP_KERNEL);
+		ltp = kmalloc(sizeof(struct ktermios),
+			      GFP_KERNEL);
 		if (!ltp)
 			goto free_mem_out;
 		memset(ltp, 0, sizeof(struct ktermios));
@@ -1965,16 +1965,14 @@ static int init_dev(struct tty_driver *driver, int idx,
 		}
 
 		if (!*o_tp_loc) {
-			o_tp = (struct ktermios *)
-				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
+			o_tp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
 			if (!o_tp)
 				goto free_mem_out;
 			*o_tp = driver->other->init_termios;
 		}
 
 		if (!*o_ltp_loc) {
-			o_ltp = (struct ktermios *)
-				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
+			o_ltp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
 			if (!o_ltp)
 				goto free_mem_out;
 			memset(o_ltp, 0, sizeof(struct ktermios));
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 18c2b3c..2fcfdbb 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -656,7 +656,7 @@ struct hid_device *hid_parse_report(__u8 *start, unsigned size)
 	for (i = 0; i < HID_REPORT_TYPES; i++)
 		INIT_LIST_HEAD(&device->report_enum[i].report_list);
 
-	if (!(device->rdesc = (__u8 *)kmalloc(size, GFP_KERNEL))) {
+	if (!(device->rdesc = kmalloc(size, GFP_KERNEL))) {
 		kfree(device->collection);
 		kfree(device);
 		return NULL;
diff --git a/drivers/media/video/zoran_driver.c b/drivers/media/video/zoran_driver.c
index 862a984..f83059d 100644
--- a/drivers/media/video/zoran_driver.c
+++ b/drivers/media/video/zoran_driver.c
@@ -343,10 +343,8 @@ v4l_fbuffer_alloc (struct file *file)
 		if (fh->v4l_buffers.buffer_size <= MAX_KMALLOC_MEM) {
 			/* Use kmalloc */
 
-			mem =
-			    (unsigned char *) kmalloc(fh->v4l_buffers.
-						      buffer_size,
-						      GFP_KERNEL);
+			mem = kmalloc(fh->v4l_buffers.buffer_size, GFP_KERNEL);
+
 			if (mem == 0) {
 				dprintk(1,
 					KERN_ERR
@@ -569,10 +567,7 @@ jpg_fbuffer_alloc (struct file *file)
 
 		//if (alloc_contig) {
 		if (fh->jpg_buffers.need_contiguous) {
-			mem =
-			    (unsigned long) kmalloc(fh->jpg_buffers.
-						    buffer_size,
-						    GFP_KERNEL);
+			mem = kmalloc(fh->jpg_buffers.buffer_size, GFP_KERNEL);
 			if (mem == 0) {
 				dprintk(1,
 					KERN_ERR
diff --git a/drivers/message/i2o/i2o_config.c b/drivers/message/i2o/i2o_config.c
index e33d446..e25993a 100644
--- a/drivers/message/i2o/i2o_config.c
+++ b/drivers/message/i2o/i2o_config.c
@@ -1039,8 +1039,7 @@ static int i2o_cfg_ioctl(struct inode *inode, struct file *fp, unsigned int cmd,
 
 static int cfg_open(struct inode *inode, struct file *file)
 {
-	struct i2o_cfg_info *tmp =
-	    (struct i2o_cfg_info *)kmalloc(sizeof(struct i2o_cfg_info),
+	struct i2o_cfg_info *tmp = kmalloc(sizeof(struct i2o_cfg_info),
 					   GFP_KERNEL);
 	unsigned long flags;
 
diff --git a/drivers/mtd/chips/amd_flash.c b/drivers/mtd/chips/amd_flash.c
index 16eaca6..7689155 100644
--- a/drivers/mtd/chips/amd_flash.c
+++ b/drivers/mtd/chips/amd_flash.c
@@ -643,7 +643,7 @@ static struct mtd_info *amd_flash_probe(struct map_info *map)
 	int reg_idx;
 	int offset;
 
-	mtd = (struct mtd_info*)kmalloc(sizeof(*mtd), GFP_KERNEL);
+	mtd = kmalloc(sizeof(*mtd), GFP_KERNEL);
 	if (!mtd) {
 		printk(KERN_WARNING
 		       "%s: kmalloc failed for info structure\n", map->name);
diff --git a/drivers/mtd/maps/tqm834x.c b/drivers/mtd/maps/tqm834x.c
index 58e5912..30c292e 100644
--- a/drivers/mtd/maps/tqm834x.c
+++ b/drivers/mtd/maps/tqm834x.c
@@ -132,15 +132,14 @@ static int __init init_tqm834x_mtd(void)
 
 		pr_debug("%s: chip probing count %d\n", __FUNCTION__, idx);
 
-		map_banks[idx] =
-			(struct map_info *)kmalloc(sizeof(struct map_info),
-						   GFP_KERNEL);
+		map_banks[idx] = kmalloc(sizeof(struct map_info),
+					 GFP_KERNEL);
 		if (map_banks[idx] == NULL) {
 			ret = -ENOMEM;
 			goto error_mem;
 		}
 		memset((void *)map_banks[idx], 0, sizeof(struct map_info));
-		map_banks[idx]->name = (char *)kmalloc(16, GFP_KERNEL);
+		map_banks[idx]->name = kmalloc(16, GFP_KERNEL);
 		if (map_banks[idx]->name == NULL) {
 			ret = -ENOMEM;
 			goto error_mem;
diff --git a/drivers/mtd/maps/tqm8xxl.c b/drivers/mtd/maps/tqm8xxl.c
index 19578ba..73f2245 100644
--- a/drivers/mtd/maps/tqm8xxl.c
+++ b/drivers/mtd/maps/tqm8xxl.c
@@ -134,7 +134,7 @@ int __init init_tqm_mtd(void)
 
 		printk(KERN_INFO "%s: chip probing count %d\n", __FUNCTION__, idx);
 
-		map_banks[idx] = (struct map_info *)kmalloc(sizeof(struct map_info), GFP_KERNEL);
+		map_banks[idx] = kmalloc(sizeof(struct map_info), GFP_KERNEL);
 		if(map_banks[idx] == NULL) {
 			ret = -ENOMEM;
 			/* FIXME: What if some MTD devices were probed already? */
@@ -142,7 +142,7 @@ int __init init_tqm_mtd(void)
 		}
 
 		memset((void *)map_banks[idx], 0, sizeof(struct map_info));
-		map_banks[idx]->name = (char *)kmalloc(16, GFP_KERNEL);
+		map_banks[idx]->name = kmalloc(16, GFP_KERNEL);
 
 		if (!map_banks[idx]->name) {
 			ret = -ENOMEM;
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 8243150..001109e 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2864,8 +2864,8 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 			if (UCC_GETH_TX_BD_RING_ALIGNMENT > 4)
 				align = UCC_GETH_TX_BD_RING_ALIGNMENT;
 			ugeth->tx_bd_ring_offset[j] =
-				(u32) (kmalloc((u32) (length + align),
-				GFP_KERNEL));
+				kmalloc((u32) (length + align), GFP_KERNEL);
+					 
 			if (ugeth->tx_bd_ring_offset[j] != 0)
 				ugeth->p_tx_bd_ring[j] =
 					(void*)((ugeth->tx_bd_ring_offset[j] +
@@ -2900,7 +2900,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 			if (UCC_GETH_RX_BD_RING_ALIGNMENT > 4)
 				align = UCC_GETH_RX_BD_RING_ALIGNMENT;
 			ugeth->rx_bd_ring_offset[j] =
-			    (u32) (kmalloc((u32) (length + align), GFP_KERNEL));
+				kmalloc((u32) (length + align), GFP_KERNEL);
 			if (ugeth->rx_bd_ring_offset[j] != 0)
 				ugeth->p_rx_bd_ring[j] =
 					(void*)((ugeth->rx_bd_ring_offset[j] +
@@ -2926,10 +2926,9 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/* Init Tx bds */
 	for (j = 0; j < ug_info->numQueuesTx; j++) {
 		/* Setup the skbuff rings */
-		ugeth->tx_skbuff[j] =
-		    (struct sk_buff **)kmalloc(sizeof(struct sk_buff *) *
-					       ugeth->ug_info->bdRingLenTx[j],
-					       GFP_KERNEL);
+		ugeth->tx_skbuff[j] = kmalloc(sizeof(struct sk_buff *) *
+					      ugeth->ug_info->bdRingLenTx[j],
+					      GFP_KERNEL);
 
 		if (ugeth->tx_skbuff[j] == NULL) {
 			ugeth_err("%s: Could not allocate tx_skbuff",
@@ -2958,10 +2957,9 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	/* Init Rx bds */
 	for (j = 0; j < ug_info->numQueuesRx; j++) {
 		/* Setup the skbuff rings */
-		ugeth->rx_skbuff[j] =
-		    (struct sk_buff **)kmalloc(sizeof(struct sk_buff *) *
-					       ugeth->ug_info->bdRingLenRx[j],
-					       GFP_KERNEL);
+		ugeth->rx_skbuff[j] = kmalloc(sizeof(struct sk_buff *) *
+					      ugeth->ug_info->bdRingLenRx[j],
+					      GFP_KERNEL);
 
 		if (ugeth->rx_skbuff[j] == NULL) {
 			ugeth_err("%s: Could not allocate rx_skbuff",
@@ -3452,8 +3450,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	 * allocated resources can be released when the channel is freed.
 	 */
 	if (!(ugeth->p_init_enet_param_shadow =
-	     (struct ucc_geth_init_pram *) kmalloc(sizeof(struct ucc_geth_init_pram),
-					      GFP_KERNEL))) {
+	      kmalloc(sizeof(struct ucc_geth_init_pram), GFP_KERNEL))) {
 		ugeth_err
 		    ("%s: Can not allocate memory for"
 			" p_UccInitEnetParamShadows.", __FUNCTION__);
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index 0e94fbb..e270732 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -3361,11 +3361,9 @@ static int ipw2100_msg_allocate(struct ipw2100_priv *priv)
 	void *v;
 	dma_addr_t p;
 
-	priv->msg_buffers =
-	    (struct ipw2100_tx_packet *)kmalloc(IPW_COMMAND_POOL_SIZE *
-						sizeof(struct
-						       ipw2100_tx_packet),
-						GFP_KERNEL);
+	priv->msg_buffers = kmalloc(IPW_COMMAND_POOL_SIZE *
+				    sizeof(struct ipw2100_tx_packet),
+				    GFP_KERNEL);
 	if (!priv->msg_buffers) {
 		printk(KERN_ERR DRV_NAME ": %s: PCI alloc failed for msg "
 		       "buffers.\n", priv->net_dev->name);
@@ -4395,11 +4393,9 @@ static int ipw2100_tx_allocate(struct ipw2100_priv *priv)
 		return err;
 	}
 
-	priv->tx_buffers =
-	    (struct ipw2100_tx_packet *)kmalloc(TX_PENDED_QUEUE_LENGTH *
-						sizeof(struct
-						       ipw2100_tx_packet),
-						GFP_ATOMIC);
+	priv->tx_buffers = kmalloc(TX_PENDED_QUEUE_LENGTH *
+				   sizeof(struct ipw2100_tx_packet),
+				   GFP_ATOMIC);
 	if (!priv->tx_buffers) {
 		printk(KERN_ERR DRV_NAME
 		       ": %s: alloc failed form tx buffers.\n",
@@ -4548,9 +4544,9 @@ static int ipw2100_rx_allocate(struct ipw2100_priv *priv)
 	/*
 	 * allocate packets
 	 */
-	priv->rx_buffers = (struct ipw2100_rx_packet *)
-	    kmalloc(RX_QUEUE_LENGTH * sizeof(struct ipw2100_rx_packet),
-		    GFP_KERNEL);
+	priv->rx_buffers = kmalloc(RX_QUEUE_LENGTH * 
+				   sizeof(struct ipw2100_rx_packet),
+				   GFP_KERNEL);
 	if (!priv->rx_buffers) {
 		IPW_DEBUG_INFO("can't allocate rx packet buffer table\n");
 
diff --git a/drivers/s390/net/ctcmain.c b/drivers/s390/net/ctcmain.c
index 03cc263..d2a3d48 100644
--- a/drivers/s390/net/ctcmain.c
+++ b/drivers/s390/net/ctcmain.c
@@ -1639,9 +1639,7 @@ add_channel(struct ccw_device *cdev, enum channel_types type)
 	struct channel *ch;
 
 	DBF_TEXT(trace, 2, __FUNCTION__);
-	if ((ch =
-	     (struct channel *) kmalloc(sizeof (struct channel),
-					GFP_KERNEL)) == NULL) {
+	if ((ch = kmalloc(sizeof (struct channel), GFP_KERNEL)) == NULL) {
 		ctc_pr_warn("ctc: Out of memory in add_channel\n");
 		return -1;
 	}
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 2b34435..df76b7c 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -5256,8 +5256,7 @@ advansys_detect(struct scsi_host_template *tpnt)
                  * Allocate buffer carrier structures. The total size
                  * is about 4 KB, so allocate all at once.
                  */
-                carrp =
-                    (ADV_CARR_T *) kmalloc(ADV_CARRIER_BUFSIZE, GFP_ATOMIC);
+                carrp = kmalloc(ADV_CARRIER_BUFSIZE, GFP_ATOMIC);
                 ASC_DBG1(1, "advansys_detect: carrp 0x%lx\n", (ulong) carrp);
 
                 if (carrp == NULL) {
@@ -5273,8 +5272,7 @@ advansys_detect(struct scsi_host_template *tpnt)
                 for (req_cnt = adv_dvc_varp->max_host_qng;
                     req_cnt > 0; req_cnt--) {
 
-                    reqp = (adv_req_t *)
-                        kmalloc(sizeof(adv_req_t) * req_cnt, GFP_ATOMIC);
+                    reqp = kmalloc(sizeof(adv_req_t) * req_cnt, GFP_ATOMIC);
 
                     ASC_DBG3(1,
                         "advansys_detect: reqp 0x%lx, req_cnt %d, bytes %lu\n",
@@ -5297,8 +5295,7 @@ advansys_detect(struct scsi_host_template *tpnt)
                 boardp->adv_sgblkp = NULL;
                 for (sg_cnt = 0; sg_cnt < ADV_TOT_SG_BLOCK; sg_cnt++) {
 
-                    sgp = (adv_sgblk_t *)
-                        kmalloc(sizeof(adv_sgblk_t), GFP_ATOMIC);
+                    sgp = kmalloc(sizeof(adv_sgblk_t), GFP_ATOMIC);
 
                     if (sgp == NULL) {
                         break;
diff --git a/drivers/serial/jsm/jsm_tty.c b/drivers/serial/jsm/jsm_tty.c
index 7cf1c60..610290a 100644
--- a/drivers/serial/jsm/jsm_tty.c
+++ b/drivers/serial/jsm/jsm_tty.c
@@ -194,7 +194,7 @@ static int jsm_tty_open(struct uart_port *port)
 	/* Drop locks, as malloc with GFP_KERNEL can sleep */
 
 	if (!channel->ch_rqueue) {
-		channel->ch_rqueue = (u8 *) kmalloc(RQUEUESIZE, GFP_KERNEL);
+		channel->ch_rqueue = kmalloc(RQUEUESIZE, GFP_KERNEL);
 		if (!channel->ch_rqueue) {
 			jsm_printk(INIT, ERR, &channel->ch_bd->pci_dev,
 				"unable to allocate read queue buf");
@@ -203,7 +203,7 @@ static int jsm_tty_open(struct uart_port *port)
 		memset(channel->ch_rqueue, 0, RQUEUESIZE);
 	}
 	if (!channel->ch_equeue) {
-		channel->ch_equeue = (u8 *) kmalloc(EQUEUESIZE, GFP_KERNEL);
+		channel->ch_equeue = kmalloc(EQUEUESIZE, GFP_KERNEL);
 		if (!channel->ch_equeue) {
 			jsm_printk(INIT, ERR, &channel->ch_bd->pci_dev,
 				"unable to allocate error queue buf");
@@ -212,7 +212,7 @@ static int jsm_tty_open(struct uart_port *port)
 		memset(channel->ch_equeue, 0, EQUEUESIZE);
 	}
 	if (!channel->ch_wqueue) {
-		channel->ch_wqueue = (u8 *) kmalloc(WQUEUESIZE, GFP_KERNEL);
+		channel->ch_wqueue = kmalloc(WQUEUESIZE, GFP_KERNEL);
 		if (!channel->ch_wqueue) {
 			jsm_printk(INIT, ERR, &channel->ch_bd->pci_dev,
 				"unable to allocate write queue buf");
diff --git a/drivers/usb/host/ohci-pnx4008.c b/drivers/usb/host/ohci-pnx4008.c
index 3a8cbfb..f3c9e61 100644
--- a/drivers/usb/host/ohci-pnx4008.c
+++ b/drivers/usb/host/ohci-pnx4008.c
@@ -134,7 +134,7 @@ static int isp1301_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct i2c_client *c;
 
-	c = (struct i2c_client *)kzalloc(sizeof(*c), GFP_KERNEL);
+	c = kzalloc(sizeof(*c), GFP_KERNEL);
 
 	if (!c)
 		return -ENOMEM;
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index aedf683..90f95ed 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -71,9 +71,7 @@ sesInfoAlloc(void)
 {
 	struct cifsSesInfo *ret_buf;
 
-	ret_buf =
-	    (struct cifsSesInfo *) kzalloc(sizeof (struct cifsSesInfo),
-					   GFP_KERNEL);
+	ret_buf = kzalloc(sizeof (struct cifsSesInfo), GFP_KERNEL);
 	if (ret_buf) {
 		write_lock(&GlobalSMBSeslock);
 		atomic_inc(&sesInfoAllocCount);
@@ -109,9 +107,8 @@ struct cifsTconInfo *
 tconInfoAlloc(void)
 {
 	struct cifsTconInfo *ret_buf;
-	ret_buf =
-	    (struct cifsTconInfo *) kzalloc(sizeof (struct cifsTconInfo),
-					    GFP_KERNEL);
+	ret_buf = kzalloc(sizeof (struct cifsTconInfo),
+			  GFP_KERNEL);
 	if (ret_buf) {
 		write_lock(&GlobalSMBSeslock);
 		atomic_inc(&tconInfoAllocCount);
diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 6d62f32..7c7195a 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -592,9 +592,8 @@ int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
 	struct component_name ciKey;
 	struct super_block *sb = ip->i_sb;
 
-	ciKey.name =
-	    (wchar_t *) kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t),
-				GFP_NOFS);
+	ciKey.name = kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t),
+			     GFP_NOFS);
 	if (ciKey.name == 0) {
 		rc = -ENOMEM;
 		goto dtSearch_Exit2;
@@ -957,9 +956,7 @@ static int dtSplitUp(tid_t tid,
 	smp = split->mp;
 	sp = DT_PAGE(ip, smp);
 
-	key.name =
-	    (wchar_t *) kmalloc((JFS_NAME_MAX + 2) * sizeof(wchar_t),
-				GFP_NOFS);
+	key.name = kmalloc((JFS_NAME_MAX + 2) * sizeof(wchar_t), GFP_NOFS);
 	if (key.name == 0) {
 		DT_PUTPAGE(smp);
 		rc = -ENOMEM;

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
