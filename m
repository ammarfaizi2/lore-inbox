Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVBBQMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVBBQMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVBBQMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:12:14 -0500
Received: from mail0.lsil.com ([147.145.40.20]:26868 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262537AbVBBP4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:56:32 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570366265E@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: "'Matt Domsch'" <Matt_Domsch@dell.com>, "Ju, Seokmann" <sju@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: [Announce] megaraid_mbox 2.20.4.4 patch
Date: Wed, 2 Feb 2005 10:56:23 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C5093F.BED1FE70"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C5093F.BED1FE70
Content-Type: text/plain

On Tuesday, February 01, 2005 1:15 PM, Matt Domsch wrote:
> This patch is mangled.  Long lines are wrapped, and appears to be in
> ISO-8859-1, such that spaces (ascii 0x20) appear as hex 0xa0.  This
> makes it difficult to review, and impossible to apply.
> 
> +// definitions for the device attributes for exporting logical drive
> number
> +// for a scsi address (Host, Channel, Id, Lun)
> +
> +CLASS_DEVICE_ATTR(megaraid_mbox_app_hndl, S_IRUSR,
> megaraid_sysfs_show_app_hndl,
> +           NULL);
> 
> How is this being used by your apps please?
> 
> 
> Otherwise the patch looks sane.

Thanks for feedback and sorry for inconvenience.
Here, I'm attaching updated patch and inlining as well.

Thanks,

Seokmann
LSI Logic Corporation.

---

diff -Naur linux_bk/Documentation/scsi/ChangeLog.megaraid
linux_bk.new/Documentation/scsi/ChangeLog.megaraid
--- linux_bk/Documentation/scsi/ChangeLog.megaraid	2005-02-02
11:06:01.488871288 -0500
+++ linux_bk.new/Documentation/scsi/ChangeLog.megaraid	2005-02-02
11:06:15.256778248 -0500
@@ -1,3 +1,89 @@
+Release Date	: Thu Jan 27 00:01:03 EST 2005 - Atul Mukker
<atulm@lsil.com>
+Current Version	: 2.20.4.4 (scsi module), 2.20.2.5 (cmm module)
+Older Version	: 2.20.4.3 (scsi module), 2.20.2.4 (cmm module)
+
+1.	Bump up the version of scsi module due to its conflict.
+
+Release Date	: Thu Jan 21 00:01:03 EST 2005 - Atul Mukker
<atulm@lsil.com>
+Current Version	: 2.20.4.3 (scsi module), 2.20.2.5 (cmm module)
+Older Version	: 2.20.4.2 (scsi module), 2.20.2.4 (cmm module)
+
+1.	Remove driver ioctl for logical drive to scsi address translation
and
+	replace with the sysfs attribute. To remove drives and change
+	capacity, application shall now use the device attribute to get the
+	logical drive number for a scsi device. For adding newly created
+	logical drives, class device attribute would be required to uniquely
+	identify each controller.
+		- Atul Mukker <atulm@lsil.com>
+
+	"James, I've been thinking about this a little more, and you may be
on
+	to something here. Let each driver add files as such:"
+
+		- Matt Domsch <Matt_Domsch@dell.com>, 12.15.2004
+		 linux-scsi mailing list
+
+
+	"Then, if you simply publish your LD number as an extra parameter of
+	the device, you can look through /sys to find it."
+
+		- James Bottomley <James.Bottomley@SteelEye.com>, 01.03.2005
+		 linux-scsi mailing list
+
+
+	"I don't see why not ... it's your driver, you can publish whatever
+	extra information you need as scsi_device attributes; that was one
of
+	the designs of the extensible attribute system."
+
+		- James Bottomley <James.Bottomley@SteelEye.com>, 01.06.2005
+		 linux-scsi mailing list
+
+2.	Add AMI megaraid support - Brian King <brking@charter.net>
+		PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID3,
+		PCI_VENDOR_ID_AMI, PCI_SUBSYS_ID_PERC3_DC,
+
+3.	Make some code static - Adrian Bunk <bunk@stusta.de>
+	Date:	Mon, 15 Nov 2004 03:14:57 +0100
+
+	The patch below makes some needlessly global code static.
+	-wait_queue_head_t wait_q;
+	+static wait_queue_head_t wait_q;
+
+	Signed-off-by: Adrian Bunk <bunk@stusta.de>
+
+4.	Added NEC ROMB support - NEC MegaRAID PCI Express ROMB controller
+		PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E,
+		PCI_SUBSYS_ID_NEC, PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E,
+
+5.	Fixed Tape drive issue : For any Direct CDB command to physical
device
+	including tape, timeout value set by driver was 10 minutes. With
this 
+	value, most of command will return within timeout. However, for
those
+	command like ERASE or FORMAT, it takes more than an hour depends on
+	capacity of the device and the command could be terminated before it

+	completes.
+	To address this issue, the 'timeout' field in the DCDB command will 
+	have NO TIMEOUT (i.e., 4) value as its timeout on DCDB command.
+
+
+
+Release Date	: Thu Dec  9 19:10:23 EST 2004
+	- Sreenivas Bagalkote <sreenib@lsil.com>
+
+Current Version	: 2.20.4.2 (scsi module), 2.20.2.4 (cmm module)
+Older Version	: 2.20.4.1 (scsi module), 2.20.2.3 (cmm module)
+
+i.	Introduced driver ioctl that returns scsi address for a given ld.
+	
+	"Why can't the existing sysfs interfaces be used to do this?"
+		- Brian King (brking@us.ibm.com)
+	
+	"I've looked into solving this another way, but I cannot see how
+	to get this driver-private mapping of logical drive number-> HCTL
+	without putting code something like this into the driver."
+
+	"...and by providing a mapping a function to userspace, the driver
+	is free to change its mapping algorithm in the future if necessary
.."
+		- Matt Domsch (Matt_Domsch@dell.com)
+
 Release Date	: Thu Dec  9 19:02:14 EST 2004 - Sreenivas Bagalkote
<sreenib@lsil.com>
 
 Current Version	: 2.20.4.1 (scsi module), 2.20.2.3 (cmm module)
@@ -13,7 +99,7 @@
 i.	Handle IOCTL cmd timeouts more properly.
 
 ii.	pci_dma_sync_{sg,single}_for_cpu was introduced into megaraid_mbox
-	incorrectly (instead of _for_device). Changed to appropriate
+	incorrectly (instead of _for_device). Changed to appropriate 
 	pci_dma_sync_{sg,single}_for_device.
 
 Release Date	: Wed Oct 06 11:15:29 EDT 2004 - Sreenivas Bagalkote
<sreenib@lsil.com>
diff -Naur linux_bk/drivers/scsi/megaraid/Kconfig.megaraid
linux_bk.new/drivers/scsi/megaraid/Kconfig.megaraid
--- linux_bk/drivers/scsi/megaraid/Kconfig.megaraid	2005-02-02
11:05:45.194348432 -0500
+++ linux_bk.new/drivers/scsi/megaraid/Kconfig.megaraid	2005-02-02
11:06:28.963694480 -0500
@@ -59,6 +59,7 @@
 	INTEL RAID Controller SRCU51L	1000:1960:8086:0520
 	FSC MegaRAID PCI Express ROMB	1000:0408:1734:1065
 	ACER MegaRAID ROMB-2E		1000:0408:1025:004D
+	NEC MegaRAID PCI Express ROMB	1000:0408:1033:8287
 
 	To compile this driver as a module, choose M here: the
 	module will be called megaraid_mbox
diff -Naur linux_bk/drivers/scsi/megaraid/mega_common.h
linux_bk.new/drivers/scsi/megaraid/mega_common.h
--- linux_bk/drivers/scsi/megaraid/mega_common.h	2005-02-02
11:05:45.197347976 -0500
+++ linux_bk.new/drivers/scsi/megaraid/mega_common.h	2005-02-02
11:06:28.965694176 -0500
@@ -221,6 +221,9 @@
 #define MRAID_IS_LOGICAL(adp, scp)	\
 	(SCP2CHANNEL(scp) == (adp)->max_channel) ? 1 : 0
 
+#define MRAID_IS_LOGICAL_SDEV(adp, sdev)	\
+	(sdev->channel == (adp)->max_channel) ? 1 : 0
+
 #define MRAID_GET_DEVICE_MAP(adp, scp, p_chan, target, islogical)	\
 	/*								\
 	 * Is the request coming for the virtual channel		\
diff -Naur linux_bk/drivers/scsi/megaraid/megaraid_ioctl.h
linux_bk.new/drivers/scsi/megaraid/megaraid_ioctl.h
--- linux_bk/drivers/scsi/megaraid/megaraid_ioctl.h	2005-02-02
11:05:45.197347976 -0500
+++ linux_bk.new/drivers/scsi/megaraid/megaraid_ioctl.h	2005-02-02
11:06:28.965694176 -0500
@@ -291,5 +291,6 @@
 
 int mraid_mm_register_adp(mraid_mmadp_t *);
 int mraid_mm_unregister_adp(uint32_t);
+uint32_t mraid_mm_adapter_app_handle(uint32_t);
 
 #endif /* _MEGARAID_IOCTL_H_ */
diff -Naur linux_bk/drivers/scsi/megaraid/megaraid_mbox.c
linux_bk.new/drivers/scsi/megaraid/megaraid_mbox.c
--- linux_bk/drivers/scsi/megaraid/megaraid_mbox.c	2005-02-02
11:05:45.202347216 -0500
+++ linux_bk.new/drivers/scsi/megaraid/megaraid_mbox.c	2005-02-02
11:06:28.971693264 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.1 (Nov 04 2004)
+ * Version	: v2.20.4.4 (Jan 27 2005)
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -60,12 +60,11 @@
  * INTEL RAID Controller SROMBU42E	1000	0408	8086	3499
  * INTEL RAID Controller SRCU51L	1000	1960	8086	0520
  *
- *
  * FSC	MegaRAID PCI Express ROMB	1000	0408	1734	1065
  *
- *
  * ACER	MegaRAID ROMB-2E		1000	0408	1025	004D
  *
+ * NEC	MegaRAID PCI Express ROMB	1000	0408	1033	8287
  *
  * For history of changes, see Documentation/ChangeLog.megaraid
  */
@@ -91,6 +90,9 @@
 static int megaraid_mbox_setup_dma_pools(adapter_t *);
 static void megaraid_mbox_teardown_dma_pools(adapter_t *);
 
+static int megaraid_sysfs_alloc_resources(adapter_t *);
+static void megaraid_sysfs_free_resources(adapter_t *);
+
 static int megaraid_abort_handler(struct scsi_cmnd *);
 static int megaraid_reset_handler(struct scsi_cmnd *);
 
@@ -121,6 +123,9 @@
 
 static void megaraid_mbox_dpc(unsigned long);
 
+static ssize_t megaraid_sysfs_show_app_hndl(struct class_device *, char *);
+static ssize_t megaraid_sysfs_show_ldnum(struct device *, char *);
+
 static int megaraid_cmm_register(adapter_t *);
 static int megaraid_cmm_unregister(adapter_t *);
 static int megaraid_mbox_mm_handler(unsigned long, uioc_t *, uint32_t);
@@ -197,7 +202,7 @@
  * ### global data ###
  */
 static uint8_t megaraid_mbox_version[8] =
-	{ 0x02, 0x20, 0x04, 0x00, 9, 27, 20, 4 };
+	{ 0x02, 0x20, 0x04, 0x04, 1, 27, 20, 5 };
 
 
 /*
@@ -301,6 +306,12 @@
 		PCI_SUBSYS_ID_PERC3_SC,
 	},
 	{
+		PCI_VENDOR_ID_AMI,
+		PCI_DEVICE_ID_AMI_MEGARAID3,
+		PCI_VENDOR_ID_AMI,
+		PCI_SUBSYS_ID_PERC3_DC,
+	},
+	{
 		PCI_VENDOR_ID_LSI_LOGIC,
 		PCI_DEVICE_ID_MEGARAID_SCSI_320_0,
 		PCI_VENDOR_ID_LSI_LOGIC,
@@ -438,6 +449,12 @@
 		PCI_VENDOR_ID_AI,
 		PCI_SUBSYS_ID_MEGARAID_ACER_ROMB_2E,
 	},
+	{
+		PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E,
+		PCI_VENDOR_ID_NEC,
+		PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E,
+	},
 	{0}	/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, pci_id_table_g);
@@ -454,6 +471,29 @@
 };
 
 
+
+// definitions for the device attributes for exporting logical drive number
+// for a scsi address (Host, Channel, Id, Lun)
+
+CLASS_DEVICE_ATTR(megaraid_mbox_app_hndl, S_IRUSR,
megaraid_sysfs_show_app_hndl,
+		NULL);
+
+// Host template initializer for megaraid mbox sysfs device attributes
+static struct class_device_attribute *megaraid_class_device_attrs[] = {
+	&class_device_attr_megaraid_mbox_app_hndl,
+	NULL,
+};
+
+
+DEVICE_ATTR(megaraid_mbox_ld, S_IRUSR, megaraid_sysfs_show_ldnum, NULL);
+
+// Host template initializer for megaraid mbox sysfs device attributes
+static struct device_attribute *megaraid_device_attrs[] = {
+	&dev_attr_megaraid_mbox_ld,
+	NULL,
+};
+
+
 /*
  * Scsi host template for megaraid unified driver
  */
@@ -467,6 +507,8 @@
 	.eh_bus_reset_handler		= megaraid_reset_handler,
 	.eh_host_reset_handler		= megaraid_reset_handler,
 	.use_clustering			= ENABLE_CLUSTERING,
+	.sdev_attrs			= megaraid_device_attrs,
+	.shost_attrs			= megaraid_class_device_attrs,
 };
 
 
@@ -953,6 +995,8 @@
 		}
 		adapter->device_ids[adapter->max_channel][adapter->init_id]
=
 			0xFF;
+
+		raid_dev->random_del_supported = 1;
 	}
 
 	/*
@@ -977,6 +1021,14 @@
 	 */
 	adapter->cmd_per_lun = megaraid_cmd_per_lun;
 
+	/*
+	 * Allocate resources required to issue FW calls, when sysfs is
+	 * accessed
+	 */
+	if (megaraid_sysfs_alloc_resources(adapter) != 0) {
+		goto out_alloc_cmds;
+	}
+
 	// Set the DMA mask to 64-bit. All supported controllers as capable
of
 	// DMA in this range
 	if (pci_set_dma_mask(adapter->pdev, 0xFFFFFFFFFFFFFFFFULL) != 0) {
@@ -984,7 +1036,7 @@
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: could not set DMA mask for 64-bit.\n"));
 
-		goto out_alloc_cmds;
+		goto out_free_sysfs_res;
 	}
 
 	// setup tasklet for DPC
@@ -996,6 +1048,8 @@
 
 	return 0;
 
+out_free_sysfs_res:
+	megaraid_sysfs_free_resources(adapter);
 out_alloc_cmds:
 	megaraid_free_cmd_packets(adapter);
 out_free_irq:
@@ -1025,6 +1079,8 @@
 
 	tasklet_kill(&adapter->dpc_h);
 
+	megaraid_sysfs_free_resources(adapter);
+
 	megaraid_free_cmd_packets(adapter);
 
 	free_irq(adapter->irq, adapter);
@@ -1559,12 +1615,14 @@
 
 	if (scb->dma_direction == PCI_DMA_TODEVICE) {
 		if (!scb->scp->use_sg) {	// sg list not used
-			pci_dma_sync_single_for_device(adapter->pdev,
ccb->buf_dma_h,
+			pci_dma_sync_single_for_device(adapter->pdev,
+					ccb->buf_dma_h,
 					scb->scp->request_bufflen,
 					PCI_DMA_TODEVICE);
 		}
 		else {
-			pci_dma_sync_sg_for_device(adapter->pdev,
scb->scp->request_buffer,
+			pci_dma_sync_sg_for_device(adapter->pdev,
+				scb->scp->request_buffer,
 				scb->scp->use_sg, PCI_DMA_TODEVICE);
 		}
 	}
@@ -2107,7 +2165,8 @@
 	channel	= scb->dev_channel;
 	target	= scb->dev_target;
 
-	pthru->timeout		= 1;	// 0=6sec, 1=60sec, 2=10min, 3=3hrs
+	// 0=6sec, 1=60sec, 2=10min, 3=3hrs, 4=NO timeout
+	pthru->timeout		= 4;	
 	pthru->ars		= 1;
 	pthru->islogical	= 0;
 	pthru->channel		= 0;
@@ -2155,7 +2214,8 @@
 	channel	= scb->dev_channel;
 	target	= scb->dev_target;
 
-	epthru->timeout		= 1;	// 0=6sec, 1=60sec, 2=10min, 3=3hrs
+	// 0=6sec, 1=60sec, 2=10min, 3=3hrs, 4=NO timeout
+	epthru->timeout		= 4;	
 	epthru->ars		= 1;
 	epthru->islogical	= 0;
 	epthru->channel		= 0;
@@ -3306,7 +3366,7 @@
 	memset((caddr_t)raw_mbox, 0, sizeof(mbox_t));
 
 	raw_mbox[0] = FC_DEL_LOGDRV;
-	raw_mbox[0] = OP_SUP_DEL_LOGDRV;
+	raw_mbox[2] = OP_SUP_DEL_LOGDRV;
 
 	// Issue the command
 	rval = 0;
@@ -3719,8 +3779,9 @@
 
 	spin_unlock_irqrestore(USER_FREE_LIST_LOCK(adapter), flags);
 
-	scb->state	= SCB_ACTIVE;
-	scb->dma_type	= MRAID_DMA_NONE;
+	scb->state		= SCB_ACTIVE;
+	scb->dma_type		= MRAID_DMA_NONE;
+	scb->dma_direction	= PCI_DMA_NONE;
 
 	ccb		= (mbox_ccb_t *)scb->ccb;
 	mbox64		= (mbox64_t *)(unsigned long)kioc->cmdbuf;
@@ -3888,6 +3949,324 @@
  */
 
 
+
+/**
+ * megaraid_sysfs_alloc_resources - allocate sysfs related resources
+ *
+ * Allocate packets required to issue FW calls whenever the sysfs
attributes
+ * are read. These attributes would require up-to-date information from the
+ * FW. Also set up resources for mutual exclusion to share these resources
and
+ * the wait queue.
+ *
+ * @param adapter : controller's soft state
+ *
+ * @return 0 on success
+ * @return -ERROR_CODE on failure
+ */
+static int
+megaraid_sysfs_alloc_resources(adapter_t *adapter)
+{
+	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
+	int		rval = 0;
+
+	raid_dev->sysfs_uioc = kmalloc(sizeof(uioc_t), GFP_KERNEL);
+
+	raid_dev->sysfs_mbox64 = kmalloc(sizeof(mbox64_t), GFP_KERNEL);
+
+	raid_dev->sysfs_buffer = pci_alloc_consistent(adapter->pdev,
+			PAGE_SIZE, &raid_dev->sysfs_buffer_dma);
+
+	if (!raid_dev->sysfs_uioc || !raid_dev->sysfs_mbox64 ||
+		!raid_dev->sysfs_buffer) {
+
+		con_log(CL_ANN, (KERN_WARNING
+			"megaraid: out of memory, %s %d\n", __FUNCTION__,
+			__LINE__));
+
+		rval = -ENOMEM;
+
+		megaraid_sysfs_free_resources(adapter);
+	}
+
+	sema_init(&raid_dev->sysfs_sem, 1);
+
+	init_waitqueue_head(&raid_dev->sysfs_wait_q);
+
+	return rval;
+}
+
+
+/**
+ * megaraid_sysfs_free_resources - free sysfs related resources
+ *
+ * Free packets allocated for sysfs FW commands
+ *
+ * @param adapter : controller's soft state
+ */
+static void
+megaraid_sysfs_free_resources(adapter_t *adapter)
+{
+	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
+
+	if (raid_dev->sysfs_uioc) kfree(raid_dev->sysfs_uioc);
+
+	if (raid_dev->sysfs_mbox64) kfree(raid_dev->sysfs_mbox64);
+
+	if (raid_dev->sysfs_buffer) {
+		pci_free_consistent(adapter->pdev, PAGE_SIZE,
+			raid_dev->sysfs_buffer, raid_dev->sysfs_buffer_dma);
+	}
+}
+
+
+/**
+ * megaraid_sysfs_get_ldmap_done - callback for get ldmap
+ *
+ * Callback routine called in the ISR/tasklet context for get ldmap call
+ *
+ * @param uioc : completed packet
+ */
+static void
+megaraid_sysfs_get_ldmap_done(uioc_t *uioc)
+{
+	adapter_t	*adapter = (adapter_t *)uioc->buf_vaddr;
+	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
+
+	uioc->status = 0;
+
+	wake_up(&raid_dev->sysfs_wait_q);
+}
+
+
+/**
+ * megaraid_sysfs_get_ldmap_timeout - timeout handling for get ldmap
+ *
+ * Timeout routine to recover and return to application, in case the
adapter
+ * has stopped responding. A timeout of 60 seconds for this command seem
like
+ * a good value
+ *
+ * @param uioc : timed out packet
+ */
+static void
+megaraid_sysfs_get_ldmap_timeout(unsigned long data)
+{
+	uioc_t		*uioc = (uioc_t *)data;
+	adapter_t	*adapter = (adapter_t *)uioc->buf_vaddr;
+	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
+
+	uioc->status = -ETIME;
+
+	wake_up(&raid_dev->sysfs_wait_q);
+}
+
+
+/**
+ * megaraid_sysfs_get_ldmap - get update logical drive map
+ *
+ * This routine will be called whenever user reads the logical drive
+ * attributes, go get the current logical drive mapping table from the
+ * firmware. We use the managment API's to issue commands to the
controller.
+ *
+ * NOTE: The commands issuance functionality is not generalized and
+ * implemented in context of "get ld map" command only. If required, the
+ * command issuance logical can be trivially pulled out and implemented as
a
+ * standalone libary. For now, this should suffice since there is no other
+ * user of this interface.
+ *
+ * @param adapter : controller's soft state
+ *
+ * @return 0 on success
+ * @return -1 on failure
+ */
+static int
+megaraid_sysfs_get_ldmap(adapter_t *adapter)
+{
+	mraid_device_t		*raid_dev = ADAP2RAIDDEV(adapter);
+	uioc_t			*uioc;
+	mbox64_t		*mbox64;
+	mbox_t			*mbox;
+	char			*raw_mbox;
+	struct timer_list	sysfs_timer;
+	struct timer_list	*timerp;
+	caddr_t			ldmap;
+	int			rval = 0;
+
+	/*
+	 * Allow only one read at a time to go through the sysfs attributes
+	 */
+	down(&raid_dev->sysfs_sem);
+
+	uioc	= raid_dev->sysfs_uioc;
+	mbox64	= raid_dev->sysfs_mbox64;
+	ldmap	= raid_dev->sysfs_buffer;
+
+	memset(uioc, sizeof(uioc_t), 0);
+	memset(mbox64, sizeof(mbox64_t), 0);
+	memset(ldmap, sizeof(raid_dev->curr_ldmap), 0);
+
+	mbox		= &mbox64->mbox32;
+	raw_mbox	= (char *)mbox;
+	uioc->cmdbuf    = (uint64_t)(unsigned long)mbox64;
+	uioc->buf_vaddr	= (caddr_t)adapter;
+	uioc->status	= -ENODATA;
+	uioc->done	= megaraid_sysfs_get_ldmap_done;
+
+	/*
+	 * Prepare the mailbox packet to get the current logical drive
mapping
+	 * table
+	 */
+	mbox->xferaddr = (uint32_t)raid_dev->sysfs_buffer_dma;
+
+	raw_mbox[0] = FC_DEL_LOGDRV;
+	raw_mbox[2] = OP_GET_LDID_MAP;
+
+	/*
+	 * Setup a timer to recover from a non-responding controller
+	 */
+	timerp	= &sysfs_timer;
+	init_timer(timerp);
+
+	timerp->function	= megaraid_sysfs_get_ldmap_timeout;
+	timerp->data		= (unsigned long)uioc;
+	timerp->expires		= jiffies + 60 * HZ;
+
+	add_timer(timerp);
+
+	/*
+	 * Send the command to the firmware
+	 */
+	rval = megaraid_mbox_mm_command(adapter, uioc);
+
+	if (rval == 0) {	// command successfully issued
+		wait_event(raid_dev->sysfs_wait_q, (uioc->status !=
-ENODATA));
+
+		/*
+		 * Check if the command timed out
+		 */
+		if (uioc->status == -ETIME) {
+			con_log(CL_ANN, (KERN_NOTICE
+				"megaraid: sysfs get ld map timed out\n"));
+
+			rval = -ETIME;
+		}
+		else {
+			rval = mbox->status;
+		}
+
+		if (rval == 0) {
+			memcpy(raid_dev->curr_ldmap, ldmap,
+				sizeof(raid_dev->curr_ldmap));
+		}
+		else {
+			con_log(CL_ANN, (KERN_NOTICE
+				"megaraid: get ld map failed with %x\n",
rval));
+		}
+	}
+	else {
+		con_log(CL_ANN, (KERN_NOTICE
+			"megaraid: could not issue ldmap command:%x\n",
rval));
+	}
+
+
+	del_timer_sync(timerp);
+
+	up(&raid_dev->sysfs_sem);
+
+	return rval;
+}
+
+
+/**
+ * megaraid_sysfs_show_app_hndl - display application handle for this
adapter
+ *
+ * Display the handle used by the applications while executing management
+ * tasks on the adapter. We invoke a management module API to get the
adapter
+ * handle, since we do not interface with applications directly.
+ *
+ * @param cdev	: class device object representation for the host
+ * @param buf	: buffer to send data to
+ */
+static ssize_t
+megaraid_sysfs_show_app_hndl(struct class_device *cdev, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(cdev);
+	adapter_t	*adapter = (adapter_t *)SCSIHOST2ADAP(shost);
+	uint32_t	app_hndl;
+
+	app_hndl = mraid_mm_adapter_app_handle(adapter->unique_id);
+
+	return snprintf(buf, 8, "%u\n", app_hndl);
+}
+
+
+/**
+ * megaraid_sysfs_show_ldnum - display the logical drive number for this
device
+ *
+ * Display the logical drive number for the device in question, if it a
valid
+ * logical drive. For physical devices, "-1" is returned
+ * The logical drive number is displayed in following format
+ *
+ * <SCSI ID> <LD NUM> <LD STICKY ID> <APP ADAPTER HANDLE>
+ *   <int>     <int>       <int>            <int>
+ *
+ * @param dev	: device object representation for the scsi device
+ * @param buf	: buffer to send data to
+ */
+static ssize_t
+megaraid_sysfs_show_ldnum(struct device *dev, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	adapter_t	*adapter = (adapter_t *)SCSIHOST2ADAP(sdev->host);
+	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
+	int		scsi_id = -1;
+	int		logical_drv = -1;
+	int		ldid_map = -1;
+	uint32_t	app_hndl = 0;
+	int		mapped_sdev_id;
+	int		rval;
+	int		i;
+
+	if (raid_dev->random_del_supported &&
+			MRAID_IS_LOGICAL_SDEV(adapter, sdev)) {
+
+		rval = megaraid_sysfs_get_ldmap(adapter);
+		if (rval == 0) {
+
+			for (i = 0; i < MAX_LOGICAL_DRIVES_40LD; i++) {
+
+				mapped_sdev_id = sdev->id;
+
+				if (sdev->id > adapter->init_id) {
+					mapped_sdev_id -= 1;
+				}
+
+				if (raid_dev->curr_ldmap[i] ==
mapped_sdev_id) {
+
+					scsi_id = sdev->id;
+
+					logical_drv = i;
+
+					ldid_map = raid_dev->curr_ldmap[i];
+
+					app_hndl =
mraid_mm_adapter_app_handle(
+							adapter->unique_id);
+
+					break;
+				}
+			}
+		}
+		else {
+			con_log(CL_ANN, (KERN_NOTICE
+				"megaraid: sysfs get ld map failed: %x\n",
+				rval));
+		}
+	}
+
+	return snprintf(buf, 36, "%d %d %d %d\n", scsi_id, logical_drv,
+			ldid_map, app_hndl);
+}
+
+
 /*
  * END: Mailbox Low Level Driver
  */
diff -Naur linux_bk/drivers/scsi/megaraid/megaraid_mbox.h
linux_bk.new/drivers/scsi/megaraid/megaraid_mbox.h
--- linux_bk/drivers/scsi/megaraid/megaraid_mbox.h	2005-02-02
11:05:45.203347064 -0500
+++ linux_bk.new/drivers/scsi/megaraid/megaraid_mbox.h	2005-02-02
11:06:28.972693112 -0500
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
 
 
-#define MEGARAID_VERSION	"2.20.4.1"
-#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov  4 17:44:59 EST
2004)"
+#define MEGARAID_VERSION	"2.20.4.4"
+#define MEGARAID_EXT_VERSION	"(Release Date: Thu Jan 27 00:01:03 EST
2005)"
 
 
 /*
@@ -137,6 +137,9 @@
 #define PCI_SUBSYS_ID_PERC3_DC				0x0493
 #define PCI_SUBSYS_ID_PERC3_SC				0x0475
 
+#define PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E		0x0408
+#define PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E		0x8287
+
 #ifndef PCI_SUBSYS_ID_FSC
 #define PCI_SUBSYS_ID_FSC				0x1734
 #endif
@@ -216,6 +219,14 @@
  * @param hw_error		: set if FW not responding
  * @param fast_load		: If set, skip physical device scanning
  * @channel_class		: channel class, RAID or SCSI
+ * @sysfs_sem			: semaphore to serialize access to sysfs
res.
+ * @sysfs_uioc			: management packet to issue FW calls from
sysfs
+ * @sysfs_mbox64		: mailbox packet to issue FW calls from
sysfs
+ * @sysfs_buffer		: data buffer for FW commands issued from
sysfs
+ * @sysfs_buffer_dma		: DMA buffer for FW commands issued from
sysfs
+ * @sysfs_wait_q		: wait queue for sysfs operations
+ * @random_del_supported	: set if the random deletion is supported
+ * @curr_ldmap			: current LDID map
  *
  * Initialization structure for mailbox controllers: memory based and IO
based
  * All the fields in this structure are LLD specific and may be discovered
at
@@ -223,6 +234,7 @@
  *
  * NOTE: The fields of this structures are placed to minimize cache misses
  */
+#define MAX_LD_EXTENDED64	64
 typedef struct {
 	mbox64_t			*una_mbox64;
 	dma_addr_t			una_mbox64_dma;
@@ -247,6 +259,14 @@
 	int				hw_error;
 	int				fast_load;
 	uint8_t				channel_class;
+	struct semaphore		sysfs_sem;
+	uioc_t				*sysfs_uioc;
+	mbox64_t			*sysfs_mbox64;
+	caddr_t				sysfs_buffer;
+	dma_addr_t			sysfs_buffer_dma;
+	wait_queue_head_t		sysfs_wait_q;
+	int				random_del_supported;
+	uint16_t			curr_ldmap[MAX_LD_EXTENDED64];
 } mraid_device_t;
 
 // route to raid device from adapter
diff -Naur linux_bk/drivers/scsi/megaraid/megaraid_mm.c
linux_bk.new/drivers/scsi/megaraid/megaraid_mm.c
--- linux_bk/drivers/scsi/megaraid/megaraid_mm.c	2005-02-02
11:05:45.205346760 -0500
+++ linux_bk.new/drivers/scsi/megaraid/megaraid_mm.c	2005-02-02
11:06:28.973692960 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mm.c
- * Version	: v2.20.2.3 (Dec 09 2004)
+ * Version	: v2.20.2.5 (Jan 21 2005)
  *
  * Common management module
  */
@@ -58,6 +58,7 @@
 
 EXPORT_SYMBOL(mraid_mm_register_adp);
 EXPORT_SYMBOL(mraid_mm_unregister_adp);
+EXPORT_SYMBOL(mraid_mm_adapter_app_handle);
 
 static int majorno;
 static uint32_t drvr_ver	= 0x02200201;
@@ -65,7 +66,7 @@
 static int adapters_count_g;
 static struct list_head adapters_list_g;
 
-wait_queue_head_t wait_q;
+static wait_queue_head_t wait_q;
 
 static struct file_operations lsi_fops = {
 	.open	= mraid_mm_open,
@@ -1007,6 +1008,40 @@
 	return rval;
 }
 
+
+/**
+ * mraid_mm_adapter_app_handle - return the application handle for this
adapter
+ *
+ * For the given driver data, locate the adadpter in our global list and
+ * return the corresponding handle, which is also used by applications to
+ * uniquely identify an adapter.
+ *
+ * @param unique_id : adapter unique identifier
+ *
+ * @return adapter handle if found in the list
+ * @return 0 if adapter could not be located, should never happen though
+ */
+uint32_t
+mraid_mm_adapter_app_handle(uint32_t unique_id)
+{
+	mraid_mmadp_t	*adapter;
+	mraid_mmadp_t	*tmp;
+	int		index = 0;
+
+	list_for_each_entry_safe(adapter, tmp, &adapters_list_g, list) {
+
+		if (adapter->unique_id == unique_id) {
+
+			return MKADAP(index);
+		}
+
+		index++;
+	}
+
+	return 0;
+}
+
+
 /**
  * mraid_mm_setup_dma_pools - Set up dma buffer pools per adapter
  *
diff -Naur linux_bk/drivers/scsi/megaraid/megaraid_mm.h
linux_bk.new/drivers/scsi/megaraid/megaraid_mm.h
--- linux_bk/drivers/scsi/megaraid/megaraid_mm.h	2005-02-02
11:05:45.205346760 -0500
+++ linux_bk.new/drivers/scsi/megaraid/megaraid_mm.h	2005-02-02
11:06:28.974692808 -0500
@@ -29,9 +29,10 @@
 #include "megaraid_ioctl.h"
 
 
-#define LSI_COMMON_MOD_VERSION	"2.20.2.3"
+#define LSI_COMMON_MOD_VERSION	"2.20.2.5"
 #define LSI_COMMON_MOD_EXT_VERSION	\
-		"(Release Date: Thu Dec  9 19:02:14 EST 2004)"
+		"(Release Date: Fri Jan 21 00:01:03 EST 2005)"
+
 
 #define LSI_DBGLVL			dbglevel



------_=_NextPart_000_01C5093F.BED1FE70
Content-Type: application/octet-stream;
	name="megaraid_2.20.4.4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid_2.20.4.4.patch"

diff -Naur linux_bk/Documentation/scsi/ChangeLog.megaraid =
linux_bk.new/Documentation/scsi/ChangeLog.megaraid=0A=
--- linux_bk/Documentation/scsi/ChangeLog.megaraid	2005-02-02 =
11:06:01.488871288 -0500=0A=
+++ linux_bk.new/Documentation/scsi/ChangeLog.megaraid	2005-02-02 =
11:06:15.256778248 -0500=0A=
@@ -1,3 +1,89 @@=0A=
+Release Date	: Thu Jan 27 00:01:03 EST 2005 - Atul Mukker =
<atulm@lsil.com>=0A=
+Current Version	: 2.20.4.4 (scsi module), 2.20.2.5 (cmm module)=0A=
+Older Version	: 2.20.4.3 (scsi module), 2.20.2.4 (cmm module)=0A=
+=0A=
+1.	Bump up the version of scsi module due to its conflict.=0A=
+=0A=
+Release Date	: Thu Jan 21 00:01:03 EST 2005 - Atul Mukker =
<atulm@lsil.com>=0A=
+Current Version	: 2.20.4.3 (scsi module), 2.20.2.5 (cmm module)=0A=
+Older Version	: 2.20.4.2 (scsi module), 2.20.2.4 (cmm module)=0A=
+=0A=
+1.	Remove driver ioctl for logical drive to scsi address translation =
and=0A=
+	replace with the sysfs attribute. To remove drives and change=0A=
+	capacity, application shall now use the device attribute to get =
the=0A=
+	logical drive number for a scsi device. For adding newly created=0A=
+	logical drives, class device attribute would be required to =
uniquely=0A=
+	identify each controller.=0A=
+		- Atul Mukker <atulm@lsil.com>=0A=
+=0A=
+	"James, I've been thinking about this a little more, and you may be =
on=0A=
+	to something here. Let each driver add files as such:"=0A=
+=0A=
+		- Matt Domsch <Matt_Domsch@dell.com>, 12.15.2004=0A=
+		 linux-scsi mailing list=0A=
+=0A=
+=0A=
+	"Then, if you simply publish your LD number as an extra parameter =
of=0A=
+	the device, you can look through /sys to find it."=0A=
+=0A=
+		- James Bottomley <James.Bottomley@SteelEye.com>, 01.03.2005=0A=
+		 linux-scsi mailing list=0A=
+=0A=
+=0A=
+	"I don't see why not ... it's your driver, you can publish =
whatever=0A=
+	extra information you need as scsi_device attributes; that was one =
of=0A=
+	the designs of the extensible attribute system."=0A=
+=0A=
+		- James Bottomley <James.Bottomley@SteelEye.com>, 01.06.2005=0A=
+		 linux-scsi mailing list=0A=
+=0A=
+2.	Add AMI megaraid support - Brian King <brking@charter.net>=0A=
+		PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID3,=0A=
+		PCI_VENDOR_ID_AMI, PCI_SUBSYS_ID_PERC3_DC,=0A=
+=0A=
+3.	Make some code static - Adrian Bunk <bunk@stusta.de>=0A=
+	Date:	Mon, 15 Nov 2004 03:14:57 +0100=0A=
+=0A=
+	The patch below makes some needlessly global code static.=0A=
+	-wait_queue_head_t wait_q;=0A=
+	+static wait_queue_head_t wait_q;=0A=
+=0A=
+	Signed-off-by: Adrian Bunk <bunk@stusta.de>=0A=
+=0A=
+4.	Added NEC ROMB support - NEC MegaRAID PCI Express ROMB =
controller=0A=
+		PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E,=0A=
+		PCI_SUBSYS_ID_NEC, PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E,=0A=
+=0A=
+5.	Fixed Tape drive issue : For any Direct CDB command to physical =
device=0A=
+	including tape, timeout value set by driver was 10 minutes. With this =
=0A=
+	value, most of command will return within timeout. However, for =
those=0A=
+	command like ERASE or FORMAT, it takes more than an hour depends =
on=0A=
+	capacity of the device and the command could be terminated before it =
=0A=
+	completes.=0A=
+	To address this issue, the 'timeout' field in the DCDB command will =
=0A=
+	have NO TIMEOUT (i.e., 4) value as its timeout on DCDB command.=0A=
+=0A=
+=0A=
+=0A=
+Release Date	: Thu Dec  9 19:10:23 EST 2004=0A=
+	- Sreenivas Bagalkote <sreenib@lsil.com>=0A=
+=0A=
+Current Version	: 2.20.4.2 (scsi module), 2.20.2.4 (cmm module)=0A=
+Older Version	: 2.20.4.1 (scsi module), 2.20.2.3 (cmm module)=0A=
+=0A=
+i.	Introduced driver ioctl that returns scsi address for a given =
ld.=0A=
+	=0A=
+	"Why can't the existing sysfs interfaces be used to do this?"=0A=
+		- Brian King (brking@us.ibm.com)=0A=
+	=0A=
+	"I've looked into solving this another way, but I cannot see how=0A=
+	to get this driver-private mapping of logical drive number-> HCTL=0A=
+	without putting code something like this into the driver."=0A=
+=0A=
+	"...and by providing a mapping a function to userspace, the driver=0A=
+	is free to change its mapping algorithm in the future if necessary =
.."=0A=
+		- Matt Domsch (Matt_Domsch@dell.com)=0A=
+=0A=
 Release Date	: Thu Dec  9 19:02:14 EST 2004 - Sreenivas Bagalkote =
<sreenib@lsil.com>=0A=
 =0A=
 Current Version	: 2.20.4.1 (scsi module), 2.20.2.3 (cmm module)=0A=
@@ -13,7 +99,7 @@=0A=
 i.	Handle IOCTL cmd timeouts more properly.=0A=
 =0A=
 ii.	pci_dma_sync_{sg,single}_for_cpu was introduced into =
megaraid_mbox=0A=
-	incorrectly (instead of _for_device). Changed to appropriate=0A=
+	incorrectly (instead of _for_device). Changed to appropriate =0A=
 	pci_dma_sync_{sg,single}_for_device.=0A=
 =0A=
 Release Date	: Wed Oct 06 11:15:29 EDT 2004 - Sreenivas Bagalkote =
<sreenib@lsil.com>=0A=
diff -Naur linux_bk/drivers/scsi/megaraid/Kconfig.megaraid =
linux_bk.new/drivers/scsi/megaraid/Kconfig.megaraid=0A=
--- linux_bk/drivers/scsi/megaraid/Kconfig.megaraid	2005-02-02 =
11:05:45.194348432 -0500=0A=
+++ linux_bk.new/drivers/scsi/megaraid/Kconfig.megaraid	2005-02-02 =
11:06:28.963694480 -0500=0A=
@@ -59,6 +59,7 @@=0A=
 	INTEL RAID Controller SRCU51L	1000:1960:8086:0520=0A=
 	FSC MegaRAID PCI Express ROMB	1000:0408:1734:1065=0A=
 	ACER MegaRAID ROMB-2E		1000:0408:1025:004D=0A=
+	NEC MegaRAID PCI Express ROMB	1000:0408:1033:8287=0A=
 =0A=
 	To compile this driver as a module, choose M here: the=0A=
 	module will be called megaraid_mbox=0A=
diff -Naur linux_bk/drivers/scsi/megaraid/mega_common.h =
linux_bk.new/drivers/scsi/megaraid/mega_common.h=0A=
--- linux_bk/drivers/scsi/megaraid/mega_common.h	2005-02-02 =
11:05:45.197347976 -0500=0A=
+++ linux_bk.new/drivers/scsi/megaraid/mega_common.h	2005-02-02 =
11:06:28.965694176 -0500=0A=
@@ -221,6 +221,9 @@=0A=
 #define MRAID_IS_LOGICAL(adp, scp)	\=0A=
 	(SCP2CHANNEL(scp) =3D=3D (adp)->max_channel) ? 1 : 0=0A=
 =0A=
+#define MRAID_IS_LOGICAL_SDEV(adp, sdev)	\=0A=
+	(sdev->channel =3D=3D (adp)->max_channel) ? 1 : 0=0A=
+=0A=
 #define MRAID_GET_DEVICE_MAP(adp, scp, p_chan, target, islogical)	\=0A=
 	/*								\=0A=
 	 * Is the request coming for the virtual channel		\=0A=
diff -Naur linux_bk/drivers/scsi/megaraid/megaraid_ioctl.h =
linux_bk.new/drivers/scsi/megaraid/megaraid_ioctl.h=0A=
--- linux_bk/drivers/scsi/megaraid/megaraid_ioctl.h	2005-02-02 =
11:05:45.197347976 -0500=0A=
+++ linux_bk.new/drivers/scsi/megaraid/megaraid_ioctl.h	2005-02-02 =
11:06:28.965694176 -0500=0A=
@@ -291,5 +291,6 @@=0A=
 =0A=
 int mraid_mm_register_adp(mraid_mmadp_t *);=0A=
 int mraid_mm_unregister_adp(uint32_t);=0A=
+uint32_t mraid_mm_adapter_app_handle(uint32_t);=0A=
 =0A=
 #endif /* _MEGARAID_IOCTL_H_ */=0A=
diff -Naur linux_bk/drivers/scsi/megaraid/megaraid_mbox.c =
linux_bk.new/drivers/scsi/megaraid/megaraid_mbox.c=0A=
--- linux_bk/drivers/scsi/megaraid/megaraid_mbox.c	2005-02-02 =
11:05:45.202347216 -0500=0A=
+++ linux_bk.new/drivers/scsi/megaraid/megaraid_mbox.c	2005-02-02 =
11:06:28.971693264 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mbox.c=0A=
- * Version	: v2.20.4.1 (Nov 04 2004)=0A=
+ * Version	: v2.20.4.4 (Jan 27 2005)=0A=
  *=0A=
  * Authors:=0A=
  * 	Atul Mukker		<Atul.Mukker@lsil.com>=0A=
@@ -60,12 +60,11 @@=0A=
  * INTEL RAID Controller SROMBU42E	1000	0408	8086	3499=0A=
  * INTEL RAID Controller SRCU51L	1000	1960	8086	0520=0A=
  *=0A=
- *=0A=
  * FSC	MegaRAID PCI Express ROMB	1000	0408	1734	1065=0A=
  *=0A=
- *=0A=
  * ACER	MegaRAID ROMB-2E		1000	0408	1025	004D=0A=
  *=0A=
+ * NEC	MegaRAID PCI Express ROMB	1000	0408	1033	8287=0A=
  *=0A=
  * For history of changes, see Documentation/ChangeLog.megaraid=0A=
  */=0A=
@@ -91,6 +90,9 @@=0A=
 static int megaraid_mbox_setup_dma_pools(adapter_t *);=0A=
 static void megaraid_mbox_teardown_dma_pools(adapter_t *);=0A=
 =0A=
+static int megaraid_sysfs_alloc_resources(adapter_t *);=0A=
+static void megaraid_sysfs_free_resources(adapter_t *);=0A=
+=0A=
 static int megaraid_abort_handler(struct scsi_cmnd *);=0A=
 static int megaraid_reset_handler(struct scsi_cmnd *);=0A=
 =0A=
@@ -121,6 +123,9 @@=0A=
 =0A=
 static void megaraid_mbox_dpc(unsigned long);=0A=
 =0A=
+static ssize_t megaraid_sysfs_show_app_hndl(struct class_device *, =
char *);=0A=
+static ssize_t megaraid_sysfs_show_ldnum(struct device *, char *);=0A=
+=0A=
 static int megaraid_cmm_register(adapter_t *);=0A=
 static int megaraid_cmm_unregister(adapter_t *);=0A=
 static int megaraid_mbox_mm_handler(unsigned long, uioc_t *, =
uint32_t);=0A=
@@ -197,7 +202,7 @@=0A=
  * ### global data ###=0A=
  */=0A=
 static uint8_t megaraid_mbox_version[8] =3D=0A=
-	{ 0x02, 0x20, 0x04, 0x00, 9, 27, 20, 4 };=0A=
+	{ 0x02, 0x20, 0x04, 0x04, 1, 27, 20, 5 };=0A=
 =0A=
 =0A=
 /*=0A=
@@ -301,6 +306,12 @@=0A=
 		PCI_SUBSYS_ID_PERC3_SC,=0A=
 	},=0A=
 	{=0A=
+		PCI_VENDOR_ID_AMI,=0A=
+		PCI_DEVICE_ID_AMI_MEGARAID3,=0A=
+		PCI_VENDOR_ID_AMI,=0A=
+		PCI_SUBSYS_ID_PERC3_DC,=0A=
+	},=0A=
+	{=0A=
 		PCI_VENDOR_ID_LSI_LOGIC,=0A=
 		PCI_DEVICE_ID_MEGARAID_SCSI_320_0,=0A=
 		PCI_VENDOR_ID_LSI_LOGIC,=0A=
@@ -438,6 +449,12 @@=0A=
 		PCI_VENDOR_ID_AI,=0A=
 		PCI_SUBSYS_ID_MEGARAID_ACER_ROMB_2E,=0A=
 	},=0A=
+	{=0A=
+		PCI_VENDOR_ID_LSI_LOGIC,=0A=
+		PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E,=0A=
+		PCI_VENDOR_ID_NEC,=0A=
+		PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E,=0A=
+	},=0A=
 	{0}	/* Terminating entry */=0A=
 };=0A=
 MODULE_DEVICE_TABLE(pci, pci_id_table_g);=0A=
@@ -454,6 +471,29 @@=0A=
 };=0A=
 =0A=
 =0A=
+=0A=
+// definitions for the device attributes for exporting logical drive =
number=0A=
+// for a scsi address (Host, Channel, Id, Lun)=0A=
+=0A=
+CLASS_DEVICE_ATTR(megaraid_mbox_app_hndl, S_IRUSR, =
megaraid_sysfs_show_app_hndl,=0A=
+		NULL);=0A=
+=0A=
+// Host template initializer for megaraid mbox sysfs device =
attributes=0A=
+static struct class_device_attribute *megaraid_class_device_attrs[] =
=3D {=0A=
+	&class_device_attr_megaraid_mbox_app_hndl,=0A=
+	NULL,=0A=
+};=0A=
+=0A=
+=0A=
+DEVICE_ATTR(megaraid_mbox_ld, S_IRUSR, megaraid_sysfs_show_ldnum, =
NULL);=0A=
+=0A=
+// Host template initializer for megaraid mbox sysfs device =
attributes=0A=
+static struct device_attribute *megaraid_device_attrs[] =3D {=0A=
+	&dev_attr_megaraid_mbox_ld,=0A=
+	NULL,=0A=
+};=0A=
+=0A=
+=0A=
 /*=0A=
  * Scsi host template for megaraid unified driver=0A=
  */=0A=
@@ -467,6 +507,8 @@=0A=
 	.eh_bus_reset_handler		=3D megaraid_reset_handler,=0A=
 	.eh_host_reset_handler		=3D megaraid_reset_handler,=0A=
 	.use_clustering			=3D ENABLE_CLUSTERING,=0A=
+	.sdev_attrs			=3D megaraid_device_attrs,=0A=
+	.shost_attrs			=3D megaraid_class_device_attrs,=0A=
 };=0A=
 =0A=
 =0A=
@@ -953,6 +995,8 @@=0A=
 		}=0A=
 		adapter->device_ids[adapter->max_channel][adapter->init_id] =3D=0A=
 			0xFF;=0A=
+=0A=
+		raid_dev->random_del_supported =3D 1;=0A=
 	}=0A=
 =0A=
 	/*=0A=
@@ -977,6 +1021,14 @@=0A=
 	 */=0A=
 	adapter->cmd_per_lun =3D megaraid_cmd_per_lun;=0A=
 =0A=
+	/*=0A=
+	 * Allocate resources required to issue FW calls, when sysfs is=0A=
+	 * accessed=0A=
+	 */=0A=
+	if (megaraid_sysfs_alloc_resources(adapter) !=3D 0) {=0A=
+		goto out_alloc_cmds;=0A=
+	}=0A=
+=0A=
 	// Set the DMA mask to 64-bit. All supported controllers as capable =
of=0A=
 	// DMA in this range=0A=
 	if (pci_set_dma_mask(adapter->pdev, 0xFFFFFFFFFFFFFFFFULL) !=3D 0) =
{=0A=
@@ -984,7 +1036,7 @@=0A=
 		con_log(CL_ANN, (KERN_WARNING=0A=
 			"megaraid: could not set DMA mask for 64-bit.\n"));=0A=
 =0A=
-		goto out_alloc_cmds;=0A=
+		goto out_free_sysfs_res;=0A=
 	}=0A=
 =0A=
 	// setup tasklet for DPC=0A=
@@ -996,6 +1048,8 @@=0A=
 =0A=
 	return 0;=0A=
 =0A=
+out_free_sysfs_res:=0A=
+	megaraid_sysfs_free_resources(adapter);=0A=
 out_alloc_cmds:=0A=
 	megaraid_free_cmd_packets(adapter);=0A=
 out_free_irq:=0A=
@@ -1025,6 +1079,8 @@=0A=
 =0A=
 	tasklet_kill(&adapter->dpc_h);=0A=
 =0A=
+	megaraid_sysfs_free_resources(adapter);=0A=
+=0A=
 	megaraid_free_cmd_packets(adapter);=0A=
 =0A=
 	free_irq(adapter->irq, adapter);=0A=
@@ -1559,12 +1615,14 @@=0A=
 =0A=
 	if (scb->dma_direction =3D=3D PCI_DMA_TODEVICE) {=0A=
 		if (!scb->scp->use_sg) {	// sg list not used=0A=
-			pci_dma_sync_single_for_device(adapter->pdev, ccb->buf_dma_h,=0A=
+			pci_dma_sync_single_for_device(adapter->pdev,=0A=
+					ccb->buf_dma_h,=0A=
 					scb->scp->request_bufflen,=0A=
 					PCI_DMA_TODEVICE);=0A=
 		}=0A=
 		else {=0A=
-			pci_dma_sync_sg_for_device(adapter->pdev, =
scb->scp->request_buffer,=0A=
+			pci_dma_sync_sg_for_device(adapter->pdev,=0A=
+				scb->scp->request_buffer,=0A=
 				scb->scp->use_sg, PCI_DMA_TODEVICE);=0A=
 		}=0A=
 	}=0A=
@@ -2107,7 +2165,8 @@=0A=
 	channel	=3D scb->dev_channel;=0A=
 	target	=3D scb->dev_target;=0A=
 =0A=
-	pthru->timeout		=3D 1;	// 0=3D6sec, 1=3D60sec, 2=3D10min, 3=3D3hrs=0A=
+	// 0=3D6sec, 1=3D60sec, 2=3D10min, 3=3D3hrs, 4=3DNO timeout=0A=
+	pthru->timeout		=3D 4;	=0A=
 	pthru->ars		=3D 1;=0A=
 	pthru->islogical	=3D 0;=0A=
 	pthru->channel		=3D 0;=0A=
@@ -2155,7 +2214,8 @@=0A=
 	channel	=3D scb->dev_channel;=0A=
 	target	=3D scb->dev_target;=0A=
 =0A=
-	epthru->timeout		=3D 1;	// 0=3D6sec, 1=3D60sec, 2=3D10min, =
3=3D3hrs=0A=
+	// 0=3D6sec, 1=3D60sec, 2=3D10min, 3=3D3hrs, 4=3DNO timeout=0A=
+	epthru->timeout		=3D 4;	=0A=
 	epthru->ars		=3D 1;=0A=
 	epthru->islogical	=3D 0;=0A=
 	epthru->channel		=3D 0;=0A=
@@ -3306,7 +3366,7 @@=0A=
 	memset((caddr_t)raw_mbox, 0, sizeof(mbox_t));=0A=
 =0A=
 	raw_mbox[0] =3D FC_DEL_LOGDRV;=0A=
-	raw_mbox[0] =3D OP_SUP_DEL_LOGDRV;=0A=
+	raw_mbox[2] =3D OP_SUP_DEL_LOGDRV;=0A=
 =0A=
 	// Issue the command=0A=
 	rval =3D 0;=0A=
@@ -3719,8 +3779,9 @@=0A=
 =0A=
 	spin_unlock_irqrestore(USER_FREE_LIST_LOCK(adapter), flags);=0A=
 =0A=
-	scb->state	=3D SCB_ACTIVE;=0A=
-	scb->dma_type	=3D MRAID_DMA_NONE;=0A=
+	scb->state		=3D SCB_ACTIVE;=0A=
+	scb->dma_type		=3D MRAID_DMA_NONE;=0A=
+	scb->dma_direction	=3D PCI_DMA_NONE;=0A=
 =0A=
 	ccb		=3D (mbox_ccb_t *)scb->ccb;=0A=
 	mbox64		=3D (mbox64_t *)(unsigned long)kioc->cmdbuf;=0A=
@@ -3888,6 +3949,324 @@=0A=
  */=0A=
 =0A=
 =0A=
+=0A=
+/**=0A=
+ * megaraid_sysfs_alloc_resources - allocate sysfs related =
resources=0A=
+ *=0A=
+ * Allocate packets required to issue FW calls whenever the sysfs =
attributes=0A=
+ * are read. These attributes would require up-to-date information =
from the=0A=
+ * FW. Also set up resources for mutual exclusion to share these =
resources and=0A=
+ * the wait queue.=0A=
+ *=0A=
+ * @param adapter : controller's soft state=0A=
+ *=0A=
+ * @return 0 on success=0A=
+ * @return -ERROR_CODE on failure=0A=
+ */=0A=
+static int=0A=
+megaraid_sysfs_alloc_resources(adapter_t *adapter)=0A=
+{=0A=
+	mraid_device_t	*raid_dev =3D ADAP2RAIDDEV(adapter);=0A=
+	int		rval =3D 0;=0A=
+=0A=
+	raid_dev->sysfs_uioc =3D kmalloc(sizeof(uioc_t), GFP_KERNEL);=0A=
+=0A=
+	raid_dev->sysfs_mbox64 =3D kmalloc(sizeof(mbox64_t), GFP_KERNEL);=0A=
+=0A=
+	raid_dev->sysfs_buffer =3D pci_alloc_consistent(adapter->pdev,=0A=
+			PAGE_SIZE, &raid_dev->sysfs_buffer_dma);=0A=
+=0A=
+	if (!raid_dev->sysfs_uioc || !raid_dev->sysfs_mbox64 ||=0A=
+		!raid_dev->sysfs_buffer) {=0A=
+=0A=
+		con_log(CL_ANN, (KERN_WARNING=0A=
+			"megaraid: out of memory, %s %d\n", __FUNCTION__,=0A=
+			__LINE__));=0A=
+=0A=
+		rval =3D -ENOMEM;=0A=
+=0A=
+		megaraid_sysfs_free_resources(adapter);=0A=
+	}=0A=
+=0A=
+	sema_init(&raid_dev->sysfs_sem, 1);=0A=
+=0A=
+	init_waitqueue_head(&raid_dev->sysfs_wait_q);=0A=
+=0A=
+	return rval;=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * megaraid_sysfs_free_resources - free sysfs related resources=0A=
+ *=0A=
+ * Free packets allocated for sysfs FW commands=0A=
+ *=0A=
+ * @param adapter : controller's soft state=0A=
+ */=0A=
+static void=0A=
+megaraid_sysfs_free_resources(adapter_t *adapter)=0A=
+{=0A=
+	mraid_device_t	*raid_dev =3D ADAP2RAIDDEV(adapter);=0A=
+=0A=
+	if (raid_dev->sysfs_uioc) kfree(raid_dev->sysfs_uioc);=0A=
+=0A=
+	if (raid_dev->sysfs_mbox64) kfree(raid_dev->sysfs_mbox64);=0A=
+=0A=
+	if (raid_dev->sysfs_buffer) {=0A=
+		pci_free_consistent(adapter->pdev, PAGE_SIZE,=0A=
+			raid_dev->sysfs_buffer, raid_dev->sysfs_buffer_dma);=0A=
+	}=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * megaraid_sysfs_get_ldmap_done - callback for get ldmap=0A=
+ *=0A=
+ * Callback routine called in the ISR/tasklet context for get ldmap =
call=0A=
+ *=0A=
+ * @param uioc : completed packet=0A=
+ */=0A=
+static void=0A=
+megaraid_sysfs_get_ldmap_done(uioc_t *uioc)=0A=
+{=0A=
+	adapter_t	*adapter =3D (adapter_t *)uioc->buf_vaddr;=0A=
+	mraid_device_t	*raid_dev =3D ADAP2RAIDDEV(adapter);=0A=
+=0A=
+	uioc->status =3D 0;=0A=
+=0A=
+	wake_up(&raid_dev->sysfs_wait_q);=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * megaraid_sysfs_get_ldmap_timeout - timeout handling for get =
ldmap=0A=
+ *=0A=
+ * Timeout routine to recover and return to application, in case the =
adapter=0A=
+ * has stopped responding. A timeout of 60 seconds for this command =
seem like=0A=
+ * a good value=0A=
+ *=0A=
+ * @param uioc : timed out packet=0A=
+ */=0A=
+static void=0A=
+megaraid_sysfs_get_ldmap_timeout(unsigned long data)=0A=
+{=0A=
+	uioc_t		*uioc =3D (uioc_t *)data;=0A=
+	adapter_t	*adapter =3D (adapter_t *)uioc->buf_vaddr;=0A=
+	mraid_device_t	*raid_dev =3D ADAP2RAIDDEV(adapter);=0A=
+=0A=
+	uioc->status =3D -ETIME;=0A=
+=0A=
+	wake_up(&raid_dev->sysfs_wait_q);=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * megaraid_sysfs_get_ldmap - get update logical drive map=0A=
+ *=0A=
+ * This routine will be called whenever user reads the logical =
drive=0A=
+ * attributes, go get the current logical drive mapping table from =
the=0A=
+ * firmware. We use the managment API's to issue commands to the =
controller.=0A=
+ *=0A=
+ * NOTE: The commands issuance functionality is not generalized and=0A=
+ * implemented in context of "get ld map" command only. If required, =
the=0A=
+ * command issuance logical can be trivially pulled out and =
implemented as a=0A=
+ * standalone libary. For now, this should suffice since there is no =
other=0A=
+ * user of this interface.=0A=
+ *=0A=
+ * @param adapter : controller's soft state=0A=
+ *=0A=
+ * @return 0 on success=0A=
+ * @return -1 on failure=0A=
+ */=0A=
+static int=0A=
+megaraid_sysfs_get_ldmap(adapter_t *adapter)=0A=
+{=0A=
+	mraid_device_t		*raid_dev =3D ADAP2RAIDDEV(adapter);=0A=
+	uioc_t			*uioc;=0A=
+	mbox64_t		*mbox64;=0A=
+	mbox_t			*mbox;=0A=
+	char			*raw_mbox;=0A=
+	struct timer_list	sysfs_timer;=0A=
+	struct timer_list	*timerp;=0A=
+	caddr_t			ldmap;=0A=
+	int			rval =3D 0;=0A=
+=0A=
+	/*=0A=
+	 * Allow only one read at a time to go through the sysfs =
attributes=0A=
+	 */=0A=
+	down(&raid_dev->sysfs_sem);=0A=
+=0A=
+	uioc	=3D raid_dev->sysfs_uioc;=0A=
+	mbox64	=3D raid_dev->sysfs_mbox64;=0A=
+	ldmap	=3D raid_dev->sysfs_buffer;=0A=
+=0A=
+	memset(uioc, sizeof(uioc_t), 0);=0A=
+	memset(mbox64, sizeof(mbox64_t), 0);=0A=
+	memset(ldmap, sizeof(raid_dev->curr_ldmap), 0);=0A=
+=0A=
+	mbox		=3D &mbox64->mbox32;=0A=
+	raw_mbox	=3D (char *)mbox;=0A=
+	uioc->cmdbuf    =3D (uint64_t)(unsigned long)mbox64;=0A=
+	uioc->buf_vaddr	=3D (caddr_t)adapter;=0A=
+	uioc->status	=3D -ENODATA;=0A=
+	uioc->done	=3D megaraid_sysfs_get_ldmap_done;=0A=
+=0A=
+	/*=0A=
+	 * Prepare the mailbox packet to get the current logical drive =
mapping=0A=
+	 * table=0A=
+	 */=0A=
+	mbox->xferaddr =3D (uint32_t)raid_dev->sysfs_buffer_dma;=0A=
+=0A=
+	raw_mbox[0] =3D FC_DEL_LOGDRV;=0A=
+	raw_mbox[2] =3D OP_GET_LDID_MAP;=0A=
+=0A=
+	/*=0A=
+	 * Setup a timer to recover from a non-responding controller=0A=
+	 */=0A=
+	timerp	=3D &sysfs_timer;=0A=
+	init_timer(timerp);=0A=
+=0A=
+	timerp->function	=3D megaraid_sysfs_get_ldmap_timeout;=0A=
+	timerp->data		=3D (unsigned long)uioc;=0A=
+	timerp->expires		=3D jiffies + 60 * HZ;=0A=
+=0A=
+	add_timer(timerp);=0A=
+=0A=
+	/*=0A=
+	 * Send the command to the firmware=0A=
+	 */=0A=
+	rval =3D megaraid_mbox_mm_command(adapter, uioc);=0A=
+=0A=
+	if (rval =3D=3D 0) {	// command successfully issued=0A=
+		wait_event(raid_dev->sysfs_wait_q, (uioc->status !=3D -ENODATA));=0A=
+=0A=
+		/*=0A=
+		 * Check if the command timed out=0A=
+		 */=0A=
+		if (uioc->status =3D=3D -ETIME) {=0A=
+			con_log(CL_ANN, (KERN_NOTICE=0A=
+				"megaraid: sysfs get ld map timed out\n"));=0A=
+=0A=
+			rval =3D -ETIME;=0A=
+		}=0A=
+		else {=0A=
+			rval =3D mbox->status;=0A=
+		}=0A=
+=0A=
+		if (rval =3D=3D 0) {=0A=
+			memcpy(raid_dev->curr_ldmap, ldmap,=0A=
+				sizeof(raid_dev->curr_ldmap));=0A=
+		}=0A=
+		else {=0A=
+			con_log(CL_ANN, (KERN_NOTICE=0A=
+				"megaraid: get ld map failed with %x\n", rval));=0A=
+		}=0A=
+	}=0A=
+	else {=0A=
+		con_log(CL_ANN, (KERN_NOTICE=0A=
+			"megaraid: could not issue ldmap command:%x\n", rval));=0A=
+	}=0A=
+=0A=
+=0A=
+	del_timer_sync(timerp);=0A=
+=0A=
+	up(&raid_dev->sysfs_sem);=0A=
+=0A=
+	return rval;=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * megaraid_sysfs_show_app_hndl - display application handle for this =
adapter=0A=
+ *=0A=
+ * Display the handle used by the applications while executing =
management=0A=
+ * tasks on the adapter. We invoke a management module API to get the =
adapter=0A=
+ * handle, since we do not interface with applications directly.=0A=
+ *=0A=
+ * @param cdev	: class device object representation for the host=0A=
+ * @param buf	: buffer to send data to=0A=
+ */=0A=
+static ssize_t=0A=
+megaraid_sysfs_show_app_hndl(struct class_device *cdev, char *buf)=0A=
+{=0A=
+	struct Scsi_Host *shost =3D class_to_shost(cdev);=0A=
+	adapter_t	*adapter =3D (adapter_t *)SCSIHOST2ADAP(shost);=0A=
+	uint32_t	app_hndl;=0A=
+=0A=
+	app_hndl =3D mraid_mm_adapter_app_handle(adapter->unique_id);=0A=
+=0A=
+	return snprintf(buf, 8, "%u\n", app_hndl);=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ * megaraid_sysfs_show_ldnum - display the logical drive number for =
this device=0A=
+ *=0A=
+ * Display the logical drive number for the device in question, if it =
a valid=0A=
+ * logical drive. For physical devices, "-1" is returned=0A=
+ * The logical drive number is displayed in following format=0A=
+ *=0A=
+ * <SCSI ID> <LD NUM> <LD STICKY ID> <APP ADAPTER HANDLE>=0A=
+ *   <int>     <int>       <int>            <int>=0A=
+ *=0A=
+ * @param dev	: device object representation for the scsi device=0A=
+ * @param buf	: buffer to send data to=0A=
+ */=0A=
+static ssize_t=0A=
+megaraid_sysfs_show_ldnum(struct device *dev, char *buf)=0A=
+{=0A=
+	struct scsi_device *sdev =3D to_scsi_device(dev);=0A=
+	adapter_t	*adapter =3D (adapter_t *)SCSIHOST2ADAP(sdev->host);=0A=
+	mraid_device_t	*raid_dev =3D ADAP2RAIDDEV(adapter);=0A=
+	int		scsi_id =3D -1;=0A=
+	int		logical_drv =3D -1;=0A=
+	int		ldid_map =3D -1;=0A=
+	uint32_t	app_hndl =3D 0;=0A=
+	int		mapped_sdev_id;=0A=
+	int		rval;=0A=
+	int		i;=0A=
+=0A=
+	if (raid_dev->random_del_supported &&=0A=
+			MRAID_IS_LOGICAL_SDEV(adapter, sdev)) {=0A=
+=0A=
+		rval =3D megaraid_sysfs_get_ldmap(adapter);=0A=
+		if (rval =3D=3D 0) {=0A=
+=0A=
+			for (i =3D 0; i < MAX_LOGICAL_DRIVES_40LD; i++) {=0A=
+=0A=
+				mapped_sdev_id =3D sdev->id;=0A=
+=0A=
+				if (sdev->id > adapter->init_id) {=0A=
+					mapped_sdev_id -=3D 1;=0A=
+				}=0A=
+=0A=
+				if (raid_dev->curr_ldmap[i] =3D=3D mapped_sdev_id) {=0A=
+=0A=
+					scsi_id =3D sdev->id;=0A=
+=0A=
+					logical_drv =3D i;=0A=
+=0A=
+					ldid_map =3D raid_dev->curr_ldmap[i];=0A=
+=0A=
+					app_hndl =3D mraid_mm_adapter_app_handle(=0A=
+							adapter->unique_id);=0A=
+=0A=
+					break;=0A=
+				}=0A=
+			}=0A=
+		}=0A=
+		else {=0A=
+			con_log(CL_ANN, (KERN_NOTICE=0A=
+				"megaraid: sysfs get ld map failed: %x\n",=0A=
+				rval));=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return snprintf(buf, 36, "%d %d %d %d\n", scsi_id, logical_drv,=0A=
+			ldid_map, app_hndl);=0A=
+}=0A=
+=0A=
+=0A=
 /*=0A=
  * END: Mailbox Low Level Driver=0A=
  */=0A=
diff -Naur linux_bk/drivers/scsi/megaraid/megaraid_mbox.h =
linux_bk.new/drivers/scsi/megaraid/megaraid_mbox.h=0A=
--- linux_bk/drivers/scsi/megaraid/megaraid_mbox.h	2005-02-02 =
11:05:45.203347064 -0500=0A=
+++ linux_bk.new/drivers/scsi/megaraid/megaraid_mbox.h	2005-02-02 =
11:06:28.972693112 -0500=0A=
@@ -21,8 +21,8 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define MEGARAID_VERSION	"2.20.4.1"=0A=
-#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov  4 17:44:59 EST =
2004)"=0A=
+#define MEGARAID_VERSION	"2.20.4.4"=0A=
+#define MEGARAID_EXT_VERSION	"(Release Date: Thu Jan 27 00:01:03 EST =
2005)"=0A=
 =0A=
 =0A=
 /*=0A=
@@ -137,6 +137,9 @@=0A=
 #define PCI_SUBSYS_ID_PERC3_DC				0x0493=0A=
 #define PCI_SUBSYS_ID_PERC3_SC				0x0475=0A=
 =0A=
+#define PCI_DEVICE_ID_MEGARAID_NEC_ROMB_2E		0x0408=0A=
+#define PCI_SUBSYS_ID_MEGARAID_NEC_ROMB_2E		0x8287=0A=
+=0A=
 #ifndef PCI_SUBSYS_ID_FSC=0A=
 #define PCI_SUBSYS_ID_FSC				0x1734=0A=
 #endif=0A=
@@ -216,6 +219,14 @@=0A=
  * @param hw_error		: set if FW not responding=0A=
  * @param fast_load		: If set, skip physical device scanning=0A=
  * @channel_class		: channel class, RAID or SCSI=0A=
+ * @sysfs_sem			: semaphore to serialize access to sysfs res.=0A=
+ * @sysfs_uioc			: management packet to issue FW calls from sysfs=0A=
+ * @sysfs_mbox64		: mailbox packet to issue FW calls from sysfs=0A=
+ * @sysfs_buffer		: data buffer for FW commands issued from sysfs=0A=
+ * @sysfs_buffer_dma		: DMA buffer for FW commands issued from =
sysfs=0A=
+ * @sysfs_wait_q		: wait queue for sysfs operations=0A=
+ * @random_del_supported	: set if the random deletion is supported=0A=
+ * @curr_ldmap			: current LDID map=0A=
  *=0A=
  * Initialization structure for mailbox controllers: memory based and =
IO based=0A=
  * All the fields in this structure are LLD specific and may be =
discovered at=0A=
@@ -223,6 +234,7 @@=0A=
  *=0A=
  * NOTE: The fields of this structures are placed to minimize cache =
misses=0A=
  */=0A=
+#define MAX_LD_EXTENDED64	64=0A=
 typedef struct {=0A=
 	mbox64_t			*una_mbox64;=0A=
 	dma_addr_t			una_mbox64_dma;=0A=
@@ -247,6 +259,14 @@=0A=
 	int				hw_error;=0A=
 	int				fast_load;=0A=
 	uint8_t				channel_class;=0A=
+	struct semaphore		sysfs_sem;=0A=
+	uioc_t				*sysfs_uioc;=0A=
+	mbox64_t			*sysfs_mbox64;=0A=
+	caddr_t				sysfs_buffer;=0A=
+	dma_addr_t			sysfs_buffer_dma;=0A=
+	wait_queue_head_t		sysfs_wait_q;=0A=
+	int				random_del_supported;=0A=
+	uint16_t			curr_ldmap[MAX_LD_EXTENDED64];=0A=
 } mraid_device_t;=0A=
 =0A=
 // route to raid device from adapter=0A=
diff -Naur linux_bk/drivers/scsi/megaraid/megaraid_mm.c =
linux_bk.new/drivers/scsi/megaraid/megaraid_mm.c=0A=
--- linux_bk/drivers/scsi/megaraid/megaraid_mm.c	2005-02-02 =
11:05:45.205346760 -0500=0A=
+++ linux_bk.new/drivers/scsi/megaraid/megaraid_mm.c	2005-02-02 =
11:06:28.973692960 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mm.c=0A=
- * Version	: v2.20.2.3 (Dec 09 2004)=0A=
+ * Version	: v2.20.2.5 (Jan 21 2005)=0A=
  *=0A=
  * Common management module=0A=
  */=0A=
@@ -58,6 +58,7 @@=0A=
 =0A=
 EXPORT_SYMBOL(mraid_mm_register_adp);=0A=
 EXPORT_SYMBOL(mraid_mm_unregister_adp);=0A=
+EXPORT_SYMBOL(mraid_mm_adapter_app_handle);=0A=
 =0A=
 static int majorno;=0A=
 static uint32_t drvr_ver	=3D 0x02200201;=0A=
@@ -65,7 +66,7 @@=0A=
 static int adapters_count_g;=0A=
 static struct list_head adapters_list_g;=0A=
 =0A=
-wait_queue_head_t wait_q;=0A=
+static wait_queue_head_t wait_q;=0A=
 =0A=
 static struct file_operations lsi_fops =3D {=0A=
 	.open	=3D mraid_mm_open,=0A=
@@ -1007,6 +1008,40 @@=0A=
 	return rval;=0A=
 }=0A=
 =0A=
+=0A=
+/**=0A=
+ * mraid_mm_adapter_app_handle - return the application handle for =
this adapter=0A=
+ *=0A=
+ * For the given driver data, locate the adadpter in our global list =
and=0A=
+ * return the corresponding handle, which is also used by applications =
to=0A=
+ * uniquely identify an adapter.=0A=
+ *=0A=
+ * @param unique_id : adapter unique identifier=0A=
+ *=0A=
+ * @return adapter handle if found in the list=0A=
+ * @return 0 if adapter could not be located, should never happen =
though=0A=
+ */=0A=
+uint32_t=0A=
+mraid_mm_adapter_app_handle(uint32_t unique_id)=0A=
+{=0A=
+	mraid_mmadp_t	*adapter;=0A=
+	mraid_mmadp_t	*tmp;=0A=
+	int		index =3D 0;=0A=
+=0A=
+	list_for_each_entry_safe(adapter, tmp, &adapters_list_g, list) {=0A=
+=0A=
+		if (adapter->unique_id =3D=3D unique_id) {=0A=
+=0A=
+			return MKADAP(index);=0A=
+		}=0A=
+=0A=
+		index++;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+=0A=
 /**=0A=
  * mraid_mm_setup_dma_pools - Set up dma buffer pools per adapter=0A=
  *=0A=
diff -Naur linux_bk/drivers/scsi/megaraid/megaraid_mm.h =
linux_bk.new/drivers/scsi/megaraid/megaraid_mm.h=0A=
--- linux_bk/drivers/scsi/megaraid/megaraid_mm.h	2005-02-02 =
11:05:45.205346760 -0500=0A=
+++ linux_bk.new/drivers/scsi/megaraid/megaraid_mm.h	2005-02-02 =
11:06:28.974692808 -0500=0A=
@@ -29,9 +29,10 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define LSI_COMMON_MOD_VERSION	"2.20.2.3"=0A=
+#define LSI_COMMON_MOD_VERSION	"2.20.2.5"=0A=
 #define LSI_COMMON_MOD_EXT_VERSION	\=0A=
-		"(Release Date: Thu Dec  9 19:02:14 EST 2004)"=0A=
+		"(Release Date: Fri Jan 21 00:01:03 EST 2005)"=0A=
+=0A=
 =0A=
 #define LSI_DBGLVL			dbglevel=0A=
 =0A=

------_=_NextPart_000_01C5093F.BED1FE70--
