Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbUAMVli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUAMVlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:41:37 -0500
Received: from mail0.lsil.com ([147.145.40.20]:3509 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S265683AbUAMVj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:39:57 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC2C3@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'hch@infradead.org'" <hch@infradead.org>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, "'torvalds@osdl.org'" <torvalds@osdl.org>,
       "'marcelo.tosatti@cyclades.com'" <marcelo.tosatti@cyclades.com>,
       Matt_Domsch@dell.com
Subject: RE: ANNOUNCE: megaraid driver version 2.10.1
Date: Tue, 13 Jan 2004 16:39:12 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The megaraid driver version 2.10.1 is released and can be 
> downloaded from
> > ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.10.1/
> > 
> > Following other components are also available at this location:
> > i.	Patches for Red Hat and SuSE stock kernels
> 
> Can't find patches for mainline anywhere.  Also it's usually a good
> idea to send the _patches_ to lkml for review.
I have inlined the patch for driver against kernel 2.4.24 version driver. It
is also available at
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.10.1/megaraid-linux-
2.4.24-megaraid-2.10.1.patch

Marcelo:
Please update your tree with the latest megaraid 2.10.1 using this patch

> 
> I've diffed the driver against the 2.4 megaraid2 driver and it looks
> mostly sane, the 2.6 version OTOH copletly backs out the changes that
> went into the driver from outside LSI.  Please try to port the changes
> you made to the driver in 2.6.1.
> 
The changes in 2.6.1 are rather extensive, so it would be sometime before
kernel 2.6.1 version of megaraid is sync'ed against megaraid-2.10.1. Also,
we would like to backport the PCI hotplug changes to 2.4.x kernel megaraid
as well.

diff -Naur megaraid-linux-2.4.24/changelog.megaraid2
megaraid-2.10.1/changelog.megaraid2
--- megaraid-linux-2.4.24/changelog.megaraid2	2004-01-13
17:22:25.000000000 -0500
+++ megaraid-2.10.1/changelog.megaraid2	2004-01-13 17:22:57.000000000 -0500
@@ -1,3 +1,31 @@
+### Version 2.10.1
+Wed Dec  3 15:34:42 EST 2003 - Atul Mukker <atulm@lsil.com>
+1.	pci_dma_sync_sg(), 2nd argument is pointer to scatter-gather list.
All
+	previous drivers have a pointer which is incremented beyond the end
of
+	the scatter-gather list
+2.	Remove 'ipdev', pci device pointer, to allocate memory for internal
+	commands. pci_alloc_consistent() guaranteed to allocate memory below
+	4GB, which is a requirement for these commands -
+		Tom Coughlan <coughlan@redhat.com>
+3.	Added support for LSI SATA PCI-X controllers
+4.	Advanced Server 3.0 version of the driver is the reference driver
now.
+	For all other kernels, we create patches.
+5.	Removed superfluous white spaces.
+6.	Corrected some comments
+
+### Version 2.10.0
+Tue Nov  4 14:33:43 EST 2003 - Atul Mukker <atulm@lsil.com>
+1.	Added vendor ids and device ids for PCI-Express controllers,
+	PERC4E/Si, PERC4E/Di, PERC4E/DC, PERC4E/SC
+2.	Backport some minor changes from 2.6 kernel version of the driver.
+
+### Version 2.00.9a
+Fri Oct  3 18:04:29 EDT 2003 - Atul Mukker <atulm@lsil.com>
+1.	Minor changes which are brough in when sync'ing with kernel
2.9-test6.
+2.	Use sizeof(mbox_t) in synchronous routines instead of hard-coded
value
+	of 16 bytes.
+3.	De-couple adapter->host->pci_dev. Replace with adapter->pdev
+
 ### Version 2.00.9
 Thu Sep  4 17:49:42 EDT 2003 - Atul Mukker <atulm@lsil.com>
 i.	For extended passthru commands, 64-bit scatter-gather list and
64-bit
diff -Naur megaraid-linux-2.4.24/megaraid2.c megaraid-2.10.1/megaraid2.c
--- megaraid-linux-2.4.24/megaraid2.c	2004-01-13 15:57:56.000000000 -0500
+++ megaraid-2.10.1/megaraid2.c	2004-01-13 17:17:52.000000000 -0500
@@ -14,7 +14,7 @@
  *	  - speed-ups (list handling fixes, issued_list, optimizations.)
  *	  - lots of cleanups.
  *
- * Version : v2.00.9 (Sep 04, 2003) - Atul Mukker <Atul.Mukker@lsil.com>
+ * Version : v2.10.1 (Dec 03, 2003) - Atul Mukker <Atul.Mukker@lsil.com>
  *
  * Description: Linux device driver for LSI Logic MegaRAID controller
  *
@@ -102,7 +102,7 @@
 static struct mcontroller mcontroller[MAX_CONTROLLERS];
 
 /* The current driver version */
-static u32 driver_ver = 0x02000000;
+static u32 driver_ver = 0x02100000;
 
 /* major number used by the device for character interface */
 static int major;
@@ -142,6 +142,7 @@
  * products. All of them share the same vendor id, device id, and subsystem
  * vendor id but different subsystem ids. As of now, driver does not use
the
  * subsystem id.
+ * PERC4E device ids are for the PCI-Express controllers
  */
 static int
 megaraid_detect(Scsi_Host_Template *host_template)
@@ -150,13 +151,16 @@
 	u16	dev_sw_table[] = {	/* Table of all supported
 					   vendor/device ids */
 
-		PCI_VENDOR_ID_DELL,		PCI_DEVICE_ID_DISCOVERY, 
-		PCI_VENDOR_ID_DELL,		PCI_DEVICE_ID_PERC4_DI, 
-		PCI_VENDOR_ID_LSI_LOGIC,
PCI_DEVICE_ID_PERC4_QC_VERDE, 
-		PCI_VENDOR_ID_AMI,		PCI_DEVICE_ID_AMI_MEGARAID, 
-		PCI_VENDOR_ID_AMI,		PCI_DEVICE_ID_AMI_MEGARAID2,

-		PCI_VENDOR_ID_AMI,		PCI_DEVICE_ID_AMI_MEGARAID3,

-		PCI_VENDOR_ID_INTEL,		PCI_DEVICE_ID_AMI_MEGARAID3,

+		PCI_VENDOR_ID_LSI_LOGIC,	PCI_DEVICE_ID_LSI_SATA_PCIX,
+		PCI_VENDOR_ID_LSI_LOGIC,	PCI_DEVICE_ID_PERC4E_DC_SC,
+		PCI_VENDOR_ID_DELL,		PCI_DEVICE_ID_PERC4E_SI_DI,
+		PCI_VENDOR_ID_DELL,		PCI_DEVICE_ID_DISCOVERY,
+		PCI_VENDOR_ID_DELL,		PCI_DEVICE_ID_PERC4_DI,
+		PCI_VENDOR_ID_LSI_LOGIC,
PCI_DEVICE_ID_PERC4_QC_VERDE,
+		PCI_VENDOR_ID_AMI,		PCI_DEVICE_ID_AMI_MEGARAID,
+		PCI_VENDOR_ID_AMI,		PCI_DEVICE_ID_AMI_MEGARAID2,
+		PCI_VENDOR_ID_AMI,		PCI_DEVICE_ID_AMI_MEGARAID3,
+		PCI_VENDOR_ID_INTEL,		PCI_DEVICE_ID_AMI_MEGARAID3,
 		PCI_VENDOR_ID_LSI_LOGIC,	PCI_DEVICE_ID_AMI_MEGARAID3
};
 
 
@@ -246,7 +250,6 @@
 	u8	did_ioremap_f = 0;
 	u8	did_req_region_f = 0;
 	u8	did_scsi_reg_f = 0;
-	u8	got_ipdev_f = 0;
 	u8	alloc_int_buf_f = 0;
 	u8	alloc_scb_f = 0;
 	u8	got_irq_f = 0;
@@ -261,7 +264,6 @@
 		did_ioremap_f = 0;
 		did_req_region_f = 0;
 		did_scsi_reg_f = 0;
-		got_ipdev_f = 0;
 		alloc_int_buf_f = 0;
 		alloc_scb_f = 0;
 		got_irq_f = 0;
@@ -277,9 +279,15 @@
 		 * valid and 64 bit is implicit
 		 */
 		if( (pci_vendor == PCI_VENDOR_ID_DELL &&
-			pci_device == PCI_DEVICE_ID_PERC4_DI) ||
+				pci_device == PCI_DEVICE_ID_PERC4_DI) ||
 			(pci_vendor == PCI_VENDOR_ID_LSI_LOGIC &&
-			pci_device == PCI_DEVICE_ID_PERC4_QC_VERDE) ) {
+				pci_device == PCI_DEVICE_ID_PERC4_QC_VERDE)
||
+			(pci_vendor == PCI_VENDOR_ID_LSI_LOGIC &&
+				pci_device == PCI_DEVICE_ID_PERC4E_DC_SC) ||
+			(pci_vendor == PCI_VENDOR_ID_DELL &&
+				pci_device == PCI_DEVICE_ID_PERC4E_SI_DI) ||
+			(pci_vendor == PCI_VENDOR_ID_LSI_LOGIC &&
+				pci_device == PCI_DEVICE_ID_LSI_SATA_PCIX))
{
 
 			flag |= BOARD_64BIT;
 		}
@@ -367,21 +375,6 @@
 		adapter = (adapter_t *)host->hostdata;
 		memset(adapter, 0, sizeof(adapter_t));
 
-		/*
-		 * Allocate a pci device structure for allocations done
-		 * internally - all of which would be in memory <4GB
-		 */
-		adapter->ipdev = kmalloc(sizeof(struct pci_dev),
GFP_KERNEL);
-
-		if( adapter->ipdev == NULL ) goto fail_attach;
-
-		got_ipdev_f = 1;
-
-		memcpy(adapter->ipdev, pdev, sizeof(struct pci_dev));
-
-		if( pci_set_dma_mask(adapter->ipdev, 0xffffffff) != 0 )
-			goto fail_attach;
-
 		printk(KERN_NOTICE
 			"scsi%d:Found MegaRAID controller at 0x%lx,
IRQ:%d\n",
 			host->host_no, mega_baseport, irq);
@@ -395,10 +388,24 @@
 		adapter->flag = flag;
 		spin_lock_init(&adapter->lock);
 
-		// replace adapter->lock with io_request_lock for kernels
w/o
-		// per host lock and delete the line which tries to
initialize
-		// the lock in host structure.
+#ifdef SCSI_HAS_HOST_LOCK
+#  if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,9)
+		/* This is the Red Hat AS2.1 kernel */
+		adapter->host_lock = &adapter->lock;
+		host->lock = adapter->host_lock;
+#  elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
+		/* This is the later Red Hat 2.4 kernels */
+		adapter->host_lock = &adapter->lock;
+		host->host_lock = adapter->host_lock;
+#  else
+		/* This is the 2.6 and later kernel series */
+		adapter->host_lock = &adapter->lock;
+		scsi_set_host_lock(&adapter->lock);
+#  endif
+#else
+		/* And this is the remainder of the 2.4 kernel series */
 		adapter->host_lock = &io_request_lock;
+#endif
 
 		host->cmd_per_lun = max_cmd_per_lun;
 		host->max_sectors = max_sectors_per_io;
@@ -613,14 +620,14 @@
 
 		/* Set the Mode of addressing to 64 bit if we can */
 		if((adapter->flag & BOARD_64BIT)&&(sizeof(dma_addr_t) == 8))
{
-			pci_set_dma_mask(pdev, 0xffffffffffffffff);
+			pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
 			adapter->has_64bit_addr = 1;
 		}
 		else  {
 			pci_set_dma_mask(pdev, 0xffffffff);
 			adapter->has_64bit_addr = 0;
 		}
-		
+
 		init_MUTEX(&adapter->int_mtx);
 		init_waitqueue_head(&adapter->int_waitq);
 
@@ -669,8 +676,6 @@
 					adapter->buf_dma_handle);
 		}
 
-		if( got_ipdev_f ) kfree(adapter->ipdev);
-
 		if( did_scsi_reg_f ) scsi_unregister(host);
 
 		if( did_ioremap_f ) {
@@ -701,7 +706,7 @@
 			sizeof(mbox64_t), &adapter->una_mbox64_dma);
 
 	if( !adapter->una_mbox64 ) return -1;
-		
+
 	adapter->mbox = &adapter->una_mbox64->mbox;
 
 	adapter->mbox = (mbox_t *)((((unsigned long) adapter->mbox) + 15) &
@@ -754,7 +759,7 @@
 {
 	dma_addr_t	prod_info_dma_handle;
 	mega_inquiry3	*inquiry3;
-	u8	raw_mbox[16];
+	u8	raw_mbox[sizeof(mbox_t)];
 	mbox_t	*mbox;
 	int	retval;
 
@@ -763,7 +768,7 @@
 	mbox = (mbox_t *)raw_mbox;
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
-	memset(mbox, 0, 16);
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 
 	/*
 	 * Try to issue Inquiry3 command
@@ -1695,21 +1700,22 @@
 	u8	status;
 	int	i;
 
-	raw_mbox[0x1] = 0xFE;	/* Set cmdid */
-	raw_mbox[0xF] = 1;	/* Set busy */
-
 	/* Wait until mailbox is free */
 	if(mega_busywait_mbox (adapter))
 		goto bug_blocked_mailbox;
 
 	/* Copy mailbox data into host structure */
-	memcpy((char *) mbox, raw_mbox, 16);
+	memcpy((char *)mbox, raw_mbox, 16);
+	mbox->cmdid = 0xFE;
+	mbox->busy = 1;
 
 	switch (raw_mbox[0]) {
+	case MEGA_MBOXCMD_EXTPTHRU:
+		if( !adapter->has_64bit_addr ) break;
+		// else fall through
 	case MEGA_MBOXCMD_LREAD64:
 	case MEGA_MBOXCMD_LWRITE64:
 	case MEGA_MBOXCMD_PASSTHRU64:
-	case MEGA_MBOXCMD_EXTPTHRU:
 		mbox64->xfer_segment_lo = mbox->xferaddr;
 		mbox64->xfer_segment_hi = 0;
 		mbox->xferaddr = 0xFFFFFFFF;
@@ -1989,6 +1995,7 @@
 	Scsi_Cmnd	*cmd = NULL;
 	mega_passthru	*pthru = NULL;
 	mbox_t	*mbox = NULL;
+	int	islogical;
 	u8	c;
 	scb_t	*scb;
 	int	cmdid;
@@ -2072,9 +2079,10 @@
 #if MEGA_HAVE_STATS
 			{
 
-			int	islogical =
adapter->logdrv_chan[cmd->channel];
 			int	logdrv = mbox->logdrv;
 
+			islogical = adapter->logdrv_chan[cmd->channel];
+
 			/*
 			 * Maintain an error counter for the logical drive.
 			 * Some application like SNMP agent need such
@@ -2110,23 +2118,21 @@
 		 * hard disk and not logical, request should return failure!
-
 		 * PJ
 		 */
-		if(cmd->cmnd[0] == INQUIRY) {
-			int islogical = adapter->logdrv_chan[cmd->channel];
+		islogical = adapter->logdrv_chan[cmd->channel];
+		if (cmd->cmnd[0] == INQUIRY && !islogical) {
 
-			if(!islogical) {
-				if( cmd->use_sg ) {
-					sgl = (struct scatterlist *)
-						cmd->request_buffer;
-					c = *(u8 *)sgl[0].address;
-				}
-				else {
-					c = *(u8 *)cmd->request_buffer;
-				}
+			if( cmd->use_sg ) {
+				sgl = (struct scatterlist *)
+					cmd->request_buffer;
+				c = *(u8 *)sgl[0].address;
+			}
+			else {
+				c = *(u8 *)cmd->request_buffer;
+			}
 
-				if(IS_RAID_CH(adapter, cmd->channel) &&
-						((c & 0x1F ) == TYPE_DISK))
{
-					status = 0xF0;
-				}
+			if(IS_RAID_CH(adapter, cmd->channel) &&
+					((c & 0x1F ) == TYPE_DISK)) {
+				status = 0xF0;
 			}
 		}
 
@@ -2243,12 +2249,11 @@
 		break;
 
 	case MEGA_BULK_DATA:
-		pci_unmap_page(adapter->host->pci_dev, scb->dma_h_bulkdata,
+		pci_unmap_page(adapter->dev, scb->dma_h_bulkdata,
 			scb->cmd->request_bufflen, scb->dma_direction);
 
 		if( scb->dma_direction == PCI_DMA_FROMDEVICE ) {
-			pci_dma_sync_single(adapter->host->pci_dev,
-					scb->dma_h_bulkdata,
+			pci_dma_sync_single(adapter->dev,
scb->dma_h_bulkdata,
 					scb->cmd->request_bufflen,
 					PCI_DMA_FROMDEVICE);
 		}
@@ -2256,12 +2261,11 @@
 		break;
 
 	case MEGA_SGLIST:
-		pci_unmap_sg(adapter->host->pci_dev,
scb->cmd->request_buffer,
+		pci_unmap_sg(adapter->dev, scb->cmd->request_buffer,
 			scb->cmd->use_sg, scb->dma_direction);
 
 		if( scb->dma_direction == PCI_DMA_FROMDEVICE ) {
-			pci_dma_sync_sg(adapter->host->pci_dev,
-					scb->cmd->request_buffer,
+			pci_dma_sync_sg(adapter->dev,
scb->cmd->request_buffer,
 					scb->cmd->use_sg,
PCI_DMA_FROMDEVICE);
 		}
 
@@ -2332,8 +2336,7 @@
 
 		offset = ((unsigned long)cmd->request_buffer & ~PAGE_MASK);
 
-		scb->dma_h_bulkdata = pci_map_page(adapter->host->pci_dev,
-						  page, offset,
+		scb->dma_h_bulkdata = pci_map_page(adapter->dev, page,
offset,
 						  cmd->request_bufflen,
 						  scb->dma_direction);
 		scb->dma_type = MEGA_BULK_DATA;
@@ -2355,7 +2358,7 @@
 		}
 
 		if( scb->dma_direction == PCI_DMA_TODEVICE ) {
-			pci_dma_sync_single(adapter->host->pci_dev,
+			pci_dma_sync_single(adapter->dev,
 					scb->dma_h_bulkdata,
 					cmd->request_bufflen,
 					PCI_DMA_TODEVICE);
@@ -2371,8 +2374,7 @@
 	 *
 	 * The number of sg elements returned must not exceed our limit
 	 */
-	sgcnt = pci_map_sg(adapter->host->pci_dev, sgl, cmd->use_sg,
-			scb->dma_direction);
+	sgcnt = pci_map_sg(adapter->dev, sgl, cmd->use_sg,
scb->dma_direction);
 
 	scb->dma_type = MEGA_SGLIST;
 
@@ -2400,8 +2402,8 @@
 	*len = (u32)cmd->request_bufflen;
 
 	if( scb->dma_direction == PCI_DMA_TODEVICE ) {
-		pci_dma_sync_sg(adapter->host->pci_dev, cmd->request_buffer,
cmd->use_sg,
-				PCI_DMA_TODEVICE);
+		pci_dma_sync_sg(adapter->dev, cmd->request_buffer,
+				cmd->use_sg, PCI_DMA_TODEVICE);
 	}
 
 	/* Return count of SG requests */
@@ -2458,7 +2460,7 @@
 {
 	adapter_t	*adapter;
 	mbox_t	*mbox;
-	u_char	raw_mbox[16];
+	u_char	raw_mbox[sizeof(mbox_t)];
 #ifdef CONFIG_PROC_FS
 	char	buf[12] = { 0 };
 #endif
@@ -2469,7 +2471,7 @@
 	printk(KERN_NOTICE "megaraid: being unloaded...");
 
 	/* Flush adapter cache */
-	memset(mbox, 0, 16);
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 	raw_mbox[0] = FLUSH_ADAPTER;
 
 	irq_disable(adapter);
@@ -2479,7 +2481,7 @@
 	issue_scb_block(adapter, raw_mbox);
 
 	/* Flush disks cache */
-	memset(mbox, 0, 16);
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 	raw_mbox[0] = FLUSH_SYSTEM;
 
 	/* Issue a blocking (interrupts disabled) command to the card */
@@ -2540,8 +2542,6 @@
 	pci_free_consistent(adapter->dev, sizeof(mbox64_t),
 			(void *)adapter->una_mbox64,
adapter->una_mbox64_dma);
 
-	kfree(adapter->ipdev);
-
 	hba_count--;
 
 	if( hba_count == 0 ) {
@@ -2723,7 +2723,7 @@
 		 */
 		if( !(iter % 1000) ) {
 			printk(
-			"megarid: Waiting for %d commands to flush:
iter:%ld\n",
+			"megaraid: Waiting for %d commands to flush:
iter:%ld\n",
 				atomic_read(&adapter->pend_cmds), iter);
 		}
 
@@ -2742,7 +2742,7 @@
 
 	if( rval == SUCCESS ) {
 		printk(KERN_INFO
-			"megaraid: abort sequence successfully
complete.\n");
+			"megaraid: abort sequence successfully
completed.\n");
 	}
 
 	return rval;
@@ -2803,7 +2803,7 @@
 		 */
 		if( !(iter % 1000) ) {
 			printk(
-			"megarid: Waiting for %d commands to flush:
iter:%ld\n",
+			"megaraid: Waiting for %d commands to flush:
iter:%ld\n",
 				atomic_read(&adapter->pend_cmds), iter);
 		}
 
@@ -2822,7 +2822,7 @@
 
 	if( rval == SUCCESS ) {
 		printk(KERN_INFO
-			"megaraid: reset sequence successfully
complete.\n");
+			"megaraid: reset sequence successfully
completed.\n");
 	}
 
 	return rval;
@@ -2953,7 +2953,7 @@
 	len += sprintf(page+len, "Base = %08lx, Irq = %d, ", adapter->base,
 			adapter->host->irq);
 
-	len += sprintf(page+len, "Logical Drives = %d, Channels = %d\n",
+	len += sprintf(page+len, "Initial Logical Drives = %d, Channels =
%d\n",
 			adapter->numldrv, adapter->product_info.nchannels);
 
 	len += sprintf(page+len, "Version =%s:%s, DRAM = %dMb\n",
@@ -3109,7 +3109,7 @@
 	struct pci_dev	*pdev;
 	int	len = 0;
 
-	pdev = adapter->ipdev;
+	pdev = adapter->dev;
 
 	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL ) {
 		*eof = 1;
@@ -3171,7 +3171,7 @@
 	char	str[256];
 	int	len = 0;
 
-	pdev = adapter->ipdev;
+	pdev = adapter->dev;
 
 	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL ) {
 		*eof = 1;
@@ -3209,22 +3209,22 @@
 
 	if(battery_status & MEGA_BATT_MODULE_MISSING)
 		strcat(str, " Module Missing");
-	
+
 	if(battery_status & MEGA_BATT_LOW_VOLTAGE)
 		strcat(str, " Low Voltage");
-	
+
 	if(battery_status & MEGA_BATT_TEMP_HIGH)
 		strcat(str, " Temperature High");
-	
+
 	if(battery_status & MEGA_BATT_PACK_MISSING)
 		strcat(str, " Pack Missing");
-	
+
 	if(battery_status & MEGA_BATT_CHARGE_INPROG)
 		strcat(str, " Charge In-progress");
-	
+
 	if(battery_status & MEGA_BATT_CHARGE_FAIL)
 		strcat(str, " Charge Fail");
-	
+
 	if(battery_status & MEGA_BATT_CYCLES_EXCEEDED)
 		strcat(str, " Cycles Exceeded");
 
@@ -3354,7 +3354,7 @@
 	char	str[80];
 	int	i;
 
-	pdev = adapter->ipdev;
+	pdev = adapter->dev;
 
 	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL ) {
 		return len;
@@ -3403,32 +3403,27 @@
 		switch( state & 0x0F ) {
 
 		case PDRV_ONLINE:
-			sprintf(str,
-			"Channel:%2d Id:%2d State: Online",
+			sprintf(str, "Channel:%2d Id:%2d State: Online",
 				channel, tgt);
 			break;
 
 		case PDRV_FAILED:
-			sprintf(str,
-			"Channel:%2d Id:%2d State: Failed",
+			sprintf(str, "Channel:%2d Id:%2d State: Failed",
 				channel, tgt);
 			break;
 
 		case PDRV_RBLD:
-			sprintf(str,
-			"Channel:%2d Id:%2d State: Rebuild",
+			sprintf(str, "Channel:%2d Id:%2d State: Rebuild",
 				channel, tgt);
 			break;
 
 		case PDRV_HOTSPARE:
-			sprintf(str,
-			"Channel:%2d Id:%2d State: Hot spare",
+			sprintf(str, "Channel:%2d Id:%2d State: Hot spare",
 				channel, tgt);
 			break;
 
 		default:
-			sprintf(str,
-			"Channel:%2d Id:%2d State: Un-configured",
+			sprintf(str, "Channel:%2d Id:%2d State:
Un-configured",
 				channel, tgt);
 			break;
 
@@ -3543,7 +3538,7 @@
  * @eof - set if no more data needs to be returned
  * @data - pointer to our soft state
  *
- * Display real time information about the logical drives 0 through 9.
+ * Display real time information about the logical drives 10 through 19.
  */
 static int
 proc_rdrv_20(char *page, char **start, off_t offset, int count, int *eof,
@@ -3566,7 +3561,7 @@
  * @eof - set if no more data needs to be returned
  * @data - pointer to our soft state
  *
- * Display real time information about the logical drives 0 through 9.
+ * Display real time information about the logical drives 20 through 29.
  */
 static int
 proc_rdrv_30(char *page, char **start, off_t offset, int count, int *eof,
@@ -3589,7 +3584,7 @@
  * @eof - set if no more data needs to be returned
  * @data - pointer to our soft state
  *
- * Display real time information about the logical drives 0 through 9.
+ * Display real time information about the logical drives 30 through 39.
  */
 static int
 proc_rdrv_40(char *page, char **start, off_t offset, int count, int *eof,
@@ -3614,7 +3609,7 @@
  * /proc/scsi/scsi interface
  */
 static int
-proc_rdrv(adapter_t *adapter, char *page, int start, int end )
+proc_rdrv(adapter_t *adapter, char *page, int start, int end)
 {
 	dma_addr_t	dma_handle;
 	logdrv_param	*lparam;
@@ -3630,7 +3625,7 @@
 	int	i;
 	u8	span8_flag = 1;
 
-	pdev = adapter->ipdev;
+	pdev = adapter->dev;
 
 	if( (inquiry = mega_allocate_inquiry(&dma_handle, pdev)) == NULL ) {
 		return len;
@@ -3650,7 +3645,7 @@
 	memset(&mc, 0, sizeof(megacmd_t));
 
 	if( adapter->flag & BOARD_40LD ) {
-		
+
 		array_sz = sizeof(disk_array_40ld);
 
 		rdrv_state = ((mega_inquiry3 *)inquiry)->ldrv_state;
@@ -3747,7 +3742,7 @@
 			else {
 				lparam = (logdrv_param*)
&((diskarray_span4_t*)
 						(disk_array))->log_drv[i];
-			}	
+			}
 		}
 
 		/*
@@ -3792,7 +3787,7 @@
 			len += sprintf(page+len,
 					", initialization in progress");
 		}
-		
+
 		len += sprintf(page+len, "\n");
 
 		len += sprintf(page+len, "Span depth:%3d, ",
@@ -3966,7 +3961,7 @@
 
 	if (blksize_size[ma])
 		block = blksize_size[ma][mi];
-		
+
 	if (!(bh = bread(MKDEV(ma,mi), 0, block)))
 		return -1;
 
@@ -4026,7 +4021,7 @@
 {
 	adapter_t *adapter;
 	struct Scsi_Host *host;
-	u8 raw_mbox[16];
+	u8 raw_mbox[sizeof(mbox_t)];
 	mbox_t *mbox;
 	int i;
 
@@ -4042,7 +4037,7 @@
 		mbox = (mbox_t *)raw_mbox;
 
 		/* Flush adapter cache */
-		memset(mbox, 0, 16);
+		memset(raw_mbox, 0, sizeof(raw_mbox));
 		raw_mbox[0] = FLUSH_ADAPTER;
 
 		irq_disable(adapter);
@@ -4055,7 +4050,7 @@
 		issue_scb_block(adapter, raw_mbox);
 
 		/* Flush disks cache */
-		memset(mbox, 0, 16);
+		memset(raw_mbox, 0, sizeof(raw_mbox));
 		raw_mbox[0] = FLUSH_SYSTEM;
 
 		issue_scb_block(adapter, raw_mbox);
@@ -4374,7 +4369,7 @@
 		 * For all internal commands, the buffer must be allocated
in
 		 * <4GB address range
 		 */
-		pdev = adapter->ipdev;
+		pdev = adapter->dev;
 
 		/* Is it a passthru command or a DCMD */
 		if( uioc.uioc_rmbox[0] == MEGA_MBOXCMD_PASSTHRU ) {
@@ -4786,13 +4781,13 @@
 static int
 mega_is_bios_enabled(adapter_t *adapter)
 {
-	unsigned char	raw_mbox[16];
+	unsigned char	raw_mbox[sizeof(mbox_t)];
 	mbox_t	*mbox;
 	int	ret;
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, 16);
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
 
@@ -4819,13 +4814,13 @@
 static void
 mega_enum_raid_scsi(adapter_t *adapter)
 {
-	unsigned char raw_mbox[16];
+	unsigned char raw_mbox[sizeof(mbox_t)];
 	mbox_t *mbox;
 	int i;
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, 16);
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 
 	/*
 	 * issue command to find out what channels are raid/scsi
@@ -4848,7 +4843,7 @@
 
 	}
 
-	for( i = 0; i < adapter->product_info.nchannels; i++ ) { 
+	for( i = 0; i < adapter->product_info.nchannels; i++ ) {
 		if( (adapter->mega_ch_class >> i) & 0x01 ) {
 			printk(KERN_INFO "megaraid: channel[%d] is raid.\n",
 					i);
@@ -4874,7 +4869,7 @@
 mega_get_boot_drv(adapter_t *adapter)
 {
 	struct private_bios_data	*prv_bios_data;
-	unsigned char	raw_mbox[16];
+	unsigned char	raw_mbox[sizeof(mbox_t)];
 	mbox_t	*mbox;
 	u16	cksum = 0;
 	u8	*cksum_p;
@@ -4883,7 +4878,7 @@
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, sizeof(raw_mbox));
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 
 	raw_mbox[0] = BIOS_PVT_DATA;
 	raw_mbox[2] = GET_BIOS_PVT_DATA;
@@ -4940,13 +4935,13 @@
 static int
 mega_support_random_del(adapter_t *adapter)
 {
-	unsigned char raw_mbox[16];
+	unsigned char raw_mbox[sizeof(mbox_t)];
 	mbox_t *mbox;
 	int rval;
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, 16);
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 
 	/*
 	 * issue command
@@ -4969,13 +4964,13 @@
 static int
 mega_support_ext_cdb(adapter_t *adapter)
 {
-	unsigned char raw_mbox[16];
+	unsigned char raw_mbox[sizeof(mbox_t)];
 	mbox_t *mbox;
 	int rval;
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, 16);
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 	/*
 	 * issue command to find out if controller supports extended CDBs.
 	 */
@@ -5053,7 +5048,9 @@
 mega_do_del_logdrv(adapter_t *adapter, int logdrv)
 {
 	int	rval;
-	u8	raw_mbox[16];
+	u8	raw_mbox[sizeof(mbox_t)];
+
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 
 	raw_mbox[0] = FC_DEL_LOGDRV;
 	raw_mbox[2] = OP_DEL_LOGDRV;
@@ -5088,12 +5085,12 @@
 static void
 mega_get_max_sgl(adapter_t *adapter)
 {
-	unsigned char	raw_mbox[16];
+	unsigned char	raw_mbox[sizeof(mbox_t)];
 	mbox_t	*mbox;
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, sizeof(raw_mbox));
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
 
@@ -5111,7 +5108,7 @@
 	}
 	else {
 		adapter->sglen = *((char *)adapter->mega_buffer);
-		
+
 		/*
 		 * Make sure this is not more than the resources we are
 		 * planning to allocate
@@ -5133,12 +5130,12 @@
 static int
 mega_support_cluster(adapter_t *adapter)
 {
-	unsigned char	raw_mbox[16];
+	unsigned char	raw_mbox[sizeof(mbox_t)];
 	mbox_t	*mbox;
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, sizeof(raw_mbox));
+	memset(raw_mbox, 0, sizeof(raw_mbox));
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
 
@@ -5183,7 +5180,7 @@
 	int		ldrv_num;
 
 	tgt = cmd->target;
-	
+
 	if ( tgt > adapter->this_id )
 		tgt--;	/* we do not get inquires for initiator id */
 
@@ -5485,7 +5482,7 @@
 	 * For all internal commands, the buffer must be allocated in <4GB
 	 * address range
 	 */
-	pdev = adapter->ipdev;
+	pdev = adapter->dev;
 
 	pthru = pci_alloc_consistent(pdev, sizeof(mega_passthru),
 			&pthru_dma_handle);
diff -Naur megaraid-linux-2.4.24/megaraid2.h megaraid-2.10.1/megaraid2.h
--- megaraid-linux-2.4.24/megaraid2.h	2004-01-13 15:57:56.000000000 -0500
+++ megaraid-2.10.1/megaraid2.h	2004-01-13 17:26:38.000000000 -0500
@@ -6,7 +6,7 @@
 
 
 #define MEGARAID_VERSION	\
-	"v2.00.9 (Release Date: Thu Sep  4 17:49:42 EDT 2003)\n"
+	"v2.10.1 (Release Date: Wed Dec  3 15:34:42 EST 2003)\n"
 
 /*
  * Driver features - change the values to enable or disable features in the
@@ -77,6 +77,9 @@
 #define PCI_DEVICE_ID_DISCOVERY		0x000E
 #define PCI_DEVICE_ID_PERC4_DI		0x000F
 #define PCI_DEVICE_ID_PERC4_QC_VERDE	0x0407
+#define PCI_DEVICE_ID_PERC4E_SI_DI	0x0013
+#define PCI_DEVICE_ID_PERC4E_DC_SC	0x0408
+#define PCI_DEVICE_ID_LSI_SATA_PCIX	0x0409
 
 /* Sub-System Vendor IDs */
 #define	AMI_SUBSYS_VID			0x101E
@@ -520,10 +523,10 @@
 
 typedef struct  {
 	unsigned char	channel;
-	unsigned char	target; 
+	unsigned char	target;
 }__attribute__ ((packed)) device_t;
 
-typedef struct { 
+typedef struct {
 	unsigned long	start_blk;
 	unsigned long	total_blks;
 	device_t	device[ MAX_STRIPES ];
@@ -537,38 +540,38 @@
 	unsigned long	size;
 }__attribute__ ((packed)) phydrv_t;
 
-typedef struct { 
+typedef struct {
 	unsigned char	span_depth;
 	unsigned char	raid;
-	unsigned char	read_ahead;	/* 0=No rdahead,1=RDAHEAD,2=adaptive
*/ 
+	unsigned char	read_ahead;	/* 0=No rdahead,1=RDAHEAD,2=adaptive
*/
 	unsigned char	stripe_sz;
 	unsigned char	status;
-	unsigned char	write_policy;	/* 0=wrthru,1=wrbak */ 
-	unsigned char	direct_io;   	/* 1=directio,0=cached */ 
+	unsigned char	write_policy;	/* 0=wrthru,1=wrbak */
+	unsigned char	direct_io;   	/* 1=directio,0=cached */
 	unsigned char	no_stripes;
 	span_t		span[ SPAN4_DEPTH ];
 }__attribute__ ((packed)) ld_span4_t;
 
-typedef struct { 
+typedef struct {
 	unsigned char	span_depth;
 	unsigned char	raid;
-	unsigned char	read_ahead;	/* 0=No rdahead,1=RDAHEAD,2=adaptive
*/ 
+	unsigned char	read_ahead;	/* 0=No rdahead,1=RDAHEAD,2=adaptive
*/
 	unsigned char	stripe_sz;
 	unsigned char	status;
-	unsigned char	write_policy;	/* 0=wrthru,1=wrbak */ 
-	unsigned char	direct_io;   	/* 1=directio,0=cached */ 
+	unsigned char	write_policy;	/* 0=wrthru,1=wrbak */
+	unsigned char	direct_io;   	/* 1=directio,0=cached */
 	unsigned char	no_stripes;
 	span_t		span[ SPAN8_DEPTH ];
 }__attribute__ ((packed)) ld_span8_t;
 
-typedef struct { 
+typedef struct {
 	unsigned char	no_log_drives;
 	unsigned char	pad[3];
 	ld_span4_t	log_drv[ MAX_LOGICAL_DRIVES_8LD ];
 	phydrv_t	phys_drv[ MAX_PHYDRVS ];
 }__attribute__ ((packed)) diskarray_span4_t;
 
-typedef struct { 
+typedef struct {
 	unsigned char	no_log_drives;
 	unsigned char	pad[3];
 	ld_span8_t	log_drv[ MAX_LOGICAL_DRIVES_8LD ];
@@ -894,9 +897,7 @@
 	volatile mbox64_t	*mbox64;/* ptr to 64-bit mailbox */
 	volatile mbox_t		*mbox;	/* ptr to standard mailbox */
 	dma_addr_t		mbox_dma;
-
-	struct pci_dev	*dev;
-	struct pci_dev	*ipdev;		/* for internal allocation */
+	struct pci_dev		*dev;
 
 	struct list_head	free_list;
 	struct list_head	pending_list;

