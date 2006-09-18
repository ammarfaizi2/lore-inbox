Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbWIRAyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWIRAyt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWIRAy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:54:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:2839 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965191AbWIRAyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:54:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VUbUwW9j98bsz18frE5NLcDtsW1/WrZG6T0lZ687Xs6iBpD16QoVvyZ6+txtkIFirJey1jS8JvXMsmT5pOJHGCrj0HFkZ1wgvTMFmfMLSYtNZ7b2CsrUkyWnGFG2r3KF7mi8UpdFhRQD/5n3Bht+NtQQ3T8zaMafFQ+HW5+6XJA=
Message-ID: <6b4e42d10609171754raaf8d59oc98affb0c26b6f81@mail.gmail.com>
Date: Sun, 17 Sep 2006 17:54:10 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: kmalloc to kzalloc patches for drivers/block
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested by compiling.

Signed off by Om Narasimhan <om.turyx@gmail.com>

drivers/block/DAC960.c     |   16 ++++++++--------
 drivers/block/amiflop.c    |    2 +-
 drivers/block/aoe/aoechr.c |    2 +-
 drivers/block/cciss.c      |   26 ++++++++++++--------------
 drivers/block/cpqarray.c   |   30 +++++++++++-------------------
 drivers/block/loop.c       |    6 ++----
 drivers/block/paride/pg.c  |    2 +-
 drivers/block/paride/pt.c  |    2 +-
 drivers/block/pktcdvd.c    |    2 +-
 9 files changed, 38 insertions(+), 50 deletions(-)

diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 4cd23c3..50621ad 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -1880,7 +1880,7 @@ static boolean DAC960_V2_ReadControllerC
 	  DAC960_V2_LogicalDevice_Offline)
 	Controller->LogicalDriveInitiallyAccessible[LogicalDeviceNumber] = true;
       LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
-	kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
+	kzalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
       if (LogicalDeviceInfo == NULL)
 	return DAC960_Failure(Controller, "LOGICAL DEVICE ALLOCATION");
       Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
@@ -2114,7 +2114,7 @@ static boolean DAC960_V2_ReadDeviceConfi
 	  break;

       PhysicalDeviceInfo = (DAC960_V2_PhysicalDeviceInfo_T *)
-		kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
+		kzalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
       if (PhysicalDeviceInfo == NULL)
 		return DAC960_Failure(Controller, "PHYSICAL DEVICE ALLOCATION");
       Controller->V2.PhysicalDeviceInformation[PhysicalDeviceIndex] =
@@ -2123,7 +2123,7 @@ static boolean DAC960_V2_ReadDeviceConfi
 		sizeof(DAC960_V2_PhysicalDeviceInfo_T));

       InquiryUnitSerialNumber = (DAC960_SCSI_Inquiry_UnitSerialNumber_T *)
-	kmalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
+	kzalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
       if (InquiryUnitSerialNumber == NULL) {
 	kfree(PhysicalDeviceInfo);
 	return DAC960_Failure(Controller, "SERIAL NUMBER ALLOCATION");
@@ -4780,9 +4780,9 @@ #endif
 	       PhysicalDeviceInfo->LogicalUnit))
 	    {
 	      PhysicalDeviceInfo =
-		kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
+		kzalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
 	      InquiryUnitSerialNumber =
-		  kmalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T),
+		  kzalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T),
 			  GFP_ATOMIC);
 	      if (InquiryUnitSerialNumber == NULL ||
 		  PhysicalDeviceInfo == NULL)
@@ -4951,7 +4951,7 @@ #endif
 	      Controller->V2.LogicalDriveToVirtualDevice[LogicalDeviceNumber] =
 		PhysicalDevice;
 	      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
-		kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
+		kzalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
 	      Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
 		LogicalDeviceInfo;
 	      DAC960_Critical("Logical Drive %d (/dev/rd/c%dd%d) "
@@ -5718,13 +5718,13 @@ static boolean DAC960_CheckStatusBuffer(
       while (NewStatusBufferLength < ByteCount)
 	NewStatusBufferLength *= 2;
       Controller->CombinedStatusBuffer =
-	(unsigned char *) kmalloc(NewStatusBufferLength, GFP_ATOMIC);
+	(unsigned char *) kzalloc(NewStatusBufferLength, GFP_ATOMIC);
       if (Controller->CombinedStatusBuffer == NULL) return false;
       Controller->CombinedStatusBufferLength = NewStatusBufferLength;
       return true;
     }
   NewStatusBuffer = (unsigned char *)
-    kmalloc(2 * Controller->CombinedStatusBufferLength, GFP_ATOMIC);
+    kzalloc(2 * Controller->CombinedStatusBufferLength, GFP_ATOMIC);
   if (NewStatusBuffer == NULL)
     {
       DAC960_Warning("Unable to expand Combined Status Buffer - Truncating\n",
diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 2641597..e903fcd 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1674,7 +1674,7 @@ static int __init fd_probe_drives(void)
 		}
 		unit[drive].gendisk = disk;
 		drives++;
-		if ((unit[drive].trackbuf = kmalloc(FLOPPY_MAX_SECTORS * 512,
GFP_KERNEL)) == NULL) {
+		if ((unit[drive].trackbuf = kzalloc(FLOPPY_MAX_SECTORS * 512,
GFP_KERNEL)) == NULL) {
 			printk("no mem for ");
 			unit[drive].type = &drive_types[num_dr_types - 1]; /* FD_NODRIVE */
 			drives--;
diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index 1bc1cf9..3491577 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -114,7 +114,7 @@ bail:		spin_unlock_irqrestore(&emsgs_loc
 		return;
 	}

-	mp = kmalloc(n, GFP_ATOMIC);
+	mp = kzalloc(n, GFP_ATOMIC);
 	if (mp == NULL) {
 		printk(KERN_CRIT "aoe: aoechr_error: allocation failure, len=%ld\n", n);
 		goto bail;
diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 2cd3391..dcf019a 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -900,7 +900,7 @@ #if 0				/* 'buf_size' member is 16-bits
 				return -EINVAL;
 #endif
 			if (iocommand.buf_size > 0) {
-				buff = kmalloc(iocommand.buf_size, GFP_KERNEL);
+				buff = kzalloc(iocommand.buf_size, GFP_KERNEL);
 				if (buff == NULL)
 					return -EFAULT;
 			}
@@ -911,8 +911,6 @@ #endif
 					kfree(buff);
 					return -EFAULT;
 				}
-			} else {
-				memset(buff, 0, iocommand.buf_size);
 			}
 			if ((c = cmd_alloc(host, 0)) == NULL) {
 				kfree(buff);
@@ -1007,7 +1005,7 @@ #endif
 			if (!capable(CAP_SYS_RAWIO))
 				return -EPERM;
 			ioc = (BIG_IOCTL_Command_struct *)
-			    kmalloc(sizeof(*ioc), GFP_KERNEL);
+			    kzalloc(sizeof(*ioc), GFP_KERNEL);
 			if (!ioc) {
 				status = -ENOMEM;
 				goto cleanup1;
@@ -1036,7 +1034,7 @@ #endif
 				status = -ENOMEM;
 				goto cleanup1;
 			}
-			buff_size = (int *)kmalloc(MAXSGENTRIES * sizeof(int),
+			buff_size = (int *)kzalloc(MAXSGENTRIES * sizeof(int),
 						   GFP_KERNEL);
 			if (!buff_size) {
 				status = -ENOMEM;
@@ -1049,7 +1047,7 @@ #endif
 				      ioc->malloc_size) ? ioc->
 				    malloc_size : left;
 				buff_size[sg_used] = sz;
-				buff[sg_used] = kmalloc(sz, GFP_KERNEL);
+				buff[sg_used] = kzalloc(sz, GFP_KERNEL);
 				if (buff[sg_used] == NULL) {
 					status = -ENOMEM;
 					goto cleanup1;
@@ -1348,10 +1346,10 @@ static void cciss_update_drive_info(int
 		return;

 	/* Get information about the disk and modify the driver structure */
-	size_buff = kmalloc(sizeof(ReadCapdata_struct), GFP_KERNEL);
+	size_buff = kzalloc(sizeof(ReadCapdata_struct), GFP_KERNEL);
 	if (size_buff == NULL)
 		goto mem_msg;
-	inq_buff = kmalloc(sizeof(InquiryData_struct), GFP_KERNEL);
+	inq_buff = kzalloc(sizeof(InquiryData_struct), GFP_KERNEL);
 	if (inq_buff == NULL)
 		goto mem_msg;

@@ -1990,12 +1988,12 @@ static int cciss_revalidate(struct gendi
 	if (!FOUND)
 		return 1;

-	size_buff = kmalloc(sizeof(ReadCapdata_struct), GFP_KERNEL);
+	size_buff = kzalloc(sizeof(ReadCapdata_struct), GFP_KERNEL);
 	if (size_buff == NULL) {
 		printk(KERN_WARNING "cciss: out of memory\n");
 		return 1;
 	}
-	inq_buff = kmalloc(sizeof(InquiryData_struct), GFP_KERNEL);
+	inq_buff = kzalloc(sizeof(InquiryData_struct), GFP_KERNEL);
 	if (inq_buff == NULL) {
 		printk(KERN_WARNING "cciss: out of memory\n");
 		kfree(size_buff);
@@ -2962,13 +2960,13 @@ static void cciss_getgeometry(int cntl_n
 		printk(KERN_ERR "cciss: out of memory\n");
 		return;
 	}
-	size_buff = kmalloc(sizeof(ReadCapdata_struct), GFP_KERNEL);
+	size_buff = kzalloc(sizeof(ReadCapdata_struct), GFP_KERNEL);
 	if (size_buff == NULL) {
 		printk(KERN_ERR "cciss: out of memory\n");
 		kfree(ld_buff);
 		return;
 	}
-	inq_buff = kmalloc(sizeof(InquiryData_struct), GFP_KERNEL);
+	inq_buff = kzalloc(sizeof(InquiryData_struct), GFP_KERNEL);
 	if (inq_buff == NULL) {
 		printk(KERN_ERR "cciss: out of memory\n");
 		kfree(ld_buff);
@@ -3176,7 +3174,7 @@ static int __devinit cciss_init_one(stru
 	       hba[i]->intr[SIMPLE_MODE_INT], dac ? "" : " not");

 	hba[i]->cmd_pool_bits =
-	    kmalloc(((NR_CMDS + BITS_PER_LONG -
+	    kzalloc(((NR_CMDS + BITS_PER_LONG -
 		      1) / BITS_PER_LONG) * sizeof(unsigned long), GFP_KERNEL);
 	hba[i]->cmd_pool = (CommandList_struct *)
 	    pci_alloc_consistent(hba[i]->pdev,
@@ -3194,7 +3192,7 @@ static int __devinit cciss_init_one(stru
 	}
 #ifdef CONFIG_CISS_SCSI_TAPE
 	hba[i]->scsi_rejects.complete =
-	    kmalloc(sizeof(hba[i]->scsi_rejects.complete[0]) *
+	    kzalloc(sizeof(hba[i]->scsi_rejects.complete[0]) *
 		    (NR_CMDS + 5), GFP_KERNEL);
 	if (hba[i]->scsi_rejects.complete == NULL) {
 		printk(KERN_ERR "cciss: out of memory");
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index 78082ed..4cace59 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -424,7 +424,7 @@ static int __init cpqarray_register_ctlr
 	hba[i]->cmd_pool = (cmdlist_t *)pci_alloc_consistent(
 		hba[i]->pci_dev, NR_CMDS * sizeof(cmdlist_t),
 		&(hba[i]->cmd_pool_dhandle));
-	hba[i]->cmd_pool_bits = kmalloc(
+	hba[i]->cmd_pool_bits = kzalloc(
 		((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long),
 		GFP_KERNEL);

@@ -432,7 +432,6 @@ static int __init cpqarray_register_ctlr
 			goto Enomem1;

 	memset(hba[i]->cmd_pool, 0, NR_CMDS * sizeof(cmdlist_t));
-	memset(hba[i]->cmd_pool_bits, 0,
((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long));
 	printk(KERN_INFO "cpqarray: Finding drives on %s",
 		hba[i]->devname);

@@ -523,7 +522,6 @@ static int __init cpqarray_init_one( str
 	i = alloc_cpqarray_hba();
 	if( i < 0 )
 		return (-1);
-	memset(hba[i], 0, sizeof(ctlr_info_t));
 	sprintf(hba[i]->devname, "ida%d", i);
 	hba[i]->ctlr = i;
 	/* Initialize the pdev driver private data */
@@ -580,7 +578,7 @@ static int alloc_cpqarray_hba(void)

 	for(i=0; i< MAX_CTLR; i++) {
 		if (hba[i] == NULL) {
-			hba[i] = kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);
+			hba[i] = kzalloc(sizeof(ctlr_info_t), GFP_KERNEL);
 			if(hba[i]==NULL) {
 				printk(KERN_ERR "cpqarray: out of memory.\n");
 				return (-1);
@@ -765,7 +763,6 @@ static int __init cpqarray_eisa_detect(v
 			continue;
 		}

-		memset(hba[ctlr], 0, sizeof(ctlr_info_t));
 		hba[ctlr]->io_mem_addr = eisa[i];
 		hba[ctlr]->io_mem_length = 0x7FF;
 		if(!request_region(hba[ctlr]->io_mem_addr,
@@ -1161,7 +1158,7 @@ static int ida_ioctl(struct inode *inode
 	case IDAPASSTHRU:
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
-		my_io = kmalloc(sizeof(ida_ioctl_t), GFP_KERNEL);
+		my_io = kzalloc(sizeof(ida_ioctl_t), GFP_KERNEL);
 		if (!my_io)
 			return -ENOMEM;
 		error = -EFAULT;
@@ -1242,7 +1239,7 @@ static int ida_ctlr_ioctl(ctlr_info_t *h
 	/* Pre submit processing */
 	switch(io->cmd) {
 	case PASSTHRU_A:
-		p = kmalloc(io->sg[0].size, GFP_KERNEL);
+		p = kzalloc(io->sg[0].size, GFP_KERNEL);
 		if (!p)
 		{
 			error = -ENOMEM;
@@ -1265,7 +1262,7 @@ static int ida_ctlr_ioctl(ctlr_info_t *h
 	case IDA_READ:
 	case READ_FLASH_ROM:
 	case SENSE_CONTROLLER_PERFORMANCE:
-		p = kmalloc(io->sg[0].size, GFP_KERNEL);
+		p = kzalloc(io->sg[0].size, GFP_KERNEL);
 		if (!p)
 		{
                         error = -ENOMEM;
@@ -1283,7 +1280,7 @@ static int ida_ctlr_ioctl(ctlr_info_t *h
 	case DIAG_PASS_THRU:
 	case COLLECT_BUFFER:
 	case WRITE_FLASH_ROM:
-		p = kmalloc(io->sg[0].size, GFP_KERNEL);
+		p = kzalloc(io->sg[0].size, GFP_KERNEL);
 		if (!p)
  		{
                         error = -ENOMEM;
@@ -1620,7 +1617,7 @@ static void start_fwbk(int ctlr)
 		" processing\n");
 	/* Command does not return anything, but idasend command needs a
 		buffer */
-	id_ctlr_buf = (id_ctlr_t *)kmalloc(sizeof(id_ctlr_t), GFP_KERNEL);
+	id_ctlr_buf = (id_ctlr_t *)kzalloc(sizeof(id_ctlr_t), GFP_KERNEL);
 	if(id_ctlr_buf==NULL)
 	{
 		printk(KERN_WARNING "cpqarray: Out of memory. "
@@ -1655,14 +1652,14 @@ static void getgeometry(int ctlr)

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
@@ -1670,7 +1667,7 @@ static void getgeometry(int ctlr)
 		return;
 	}

-	id_lstatus_buf = (sense_log_drv_stat_t
*)kmalloc(sizeof(sense_log_drv_stat_t), GFP_KERNEL);
+	id_lstatus_buf = (sense_log_drv_stat_t
*)kzalloc(sizeof(sense_log_drv_stat_t), GFP_KERNEL);
 	if(id_lstatus_buf == NULL)
 	{
 		kfree(id_ctlr_buf);
@@ -1679,7 +1676,7 @@ static void getgeometry(int ctlr)
 		return;
 	}

-	sense_config_buf = (config_t *)kmalloc(sizeof(config_t), GFP_KERNEL);
+	sense_config_buf = (config_t *)kzalloc(sizeof(config_t), GFP_KERNEL);
 	if(sense_config_buf == NULL)
 	{
 		kfree(id_lstatus_buf);
@@ -1689,11 +1686,6 @@ static void getgeometry(int ctlr)
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
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7b3b94d..e6b83b8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1260,12 +1260,10 @@ static int __init loop_init(void)
 	if (register_blkdev(LOOP_MAJOR, "loop"))
 		return -EIO;

-	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
+	loop_dev = kzalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
 	if (!loop_dev)
 		goto out_mem1;
-	memset(loop_dev, 0, max_loop * sizeof(struct loop_device));
-
-	disks = kmalloc(max_loop * sizeof(struct gendisk *), GFP_KERNEL);
+	disks = kzalloc(max_loop * sizeof(struct gendisk *), GFP_KERNEL);
 	if (!disks)
 		goto out_mem2;

diff --git a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
index 13f998a..1be6ff3 100644
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -529,7 +529,7 @@ static int pg_open(struct inode *inode,

 	pg_identify(dev, (verbose > 1));

-	dev->bufptr = kmalloc(PG_MAX_DATA, GFP_KERNEL);
+	dev->bufptr = kzalloc(PG_MAX_DATA, GFP_KERNEL);
 	if (dev->bufptr == NULL) {
 		clear_bit(0, &dev->access);
 		printk("%s: buffer allocation failed\n", dev->name);
diff --git a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
index 35fb266..2ead336 100644
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -671,7 +671,7 @@ static int pt_open(struct inode *inode,
 		tape->flags |= PT_REWIND;

 	err = -ENOMEM;
-	tape->bufptr = kmalloc(PT_BUFSIZE, GFP_KERNEL);
+	tape->bufptr = kzalloc(PT_BUFSIZE, GFP_KERNEL);
 	if (tape->bufptr == NULL) {
 		printk("%s: buffer allocation failed\n", tape->name);
 		goto out;
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 451b996..de21cfd 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -106,7 +106,7 @@ static struct bio *pkt_bio_alloc(int nr_
 	struct bio_vec *bvl = NULL;
 	struct bio *bio;

-	bio = kmalloc(sizeof(struct bio), GFP_KERNEL);
+	bio = kzalloc(sizeof(struct bio), GFP_KERNEL);
 	if (!bio)
 		goto no_bio;
 	bio_init(bio);
