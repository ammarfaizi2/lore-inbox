Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSKRSG0>; Mon, 18 Nov 2002 13:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKRSGZ>; Mon, 18 Nov 2002 13:06:25 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:33809 "EHLO
	covert.iadfw.net") by vger.kernel.org with ESMTP id <S263039AbSKRSGR>;
	Mon, 18 Nov 2002 13:06:17 -0500
Date: Mon, 18 Nov 2002 12:13:14 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for drivers/scsi, take 2
Message-ID: <20021118181314.GA4589@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I screwed up the first patch I sent by deleting "{" in imm.c and ppa.c.
Grrr ...

Here's a second take ...

Art Haas

--- linux-2.5.48/drivers/scsi/NCR53c406a.c.old	2002-11-11 07:14:43.000000000 -0600
+++ linux-2.5.48/drivers/scsi/NCR53c406a.c	2002-11-18 01:11:24.000000000 -0600
@@ -1070,23 +1070,23 @@
 
 static Scsi_Host_Template driver_template = 
 {
-     proc_name:         	"NCR53c406a"		/* proc_name */,        
-     name:              	"NCR53c406a"		/* name */,             
-     detect:            	NCR53c406a_detect	/* detect */,           
-     info:              	NCR53c406a_info		/* info */,             
-     command:           	NCR53c406a_command	/* command */,          
-     queuecommand:      	NCR53c406a_queue	/* queuecommand */,     
-     eh_abort_handler:  	NCR53c406a_abort	/* abort */,            
-     eh_bus_reset_handler:      NCR53c406a_bus_reset	/* reset */,            
-     eh_device_reset_handler:   NCR53c406a_device_reset	/* reset */,            
-     eh_host_reset_handler:     NCR53c406a_host_reset	/* reset */,            
-     bios_param:        	NCR53c406a_biosparm	/* biosparm */,         
-     can_queue:         	1			/* can_queue */,        
-     this_id:           	7			/* SCSI ID of the chip */,
-     sg_tablesize:      	32			/*SG_ALL*/ /*SG_NONE*/, 
-     cmd_per_lun:       	1			/* commands per lun */, 
-     unchecked_isa_dma: 	1			/* unchecked_isa_dma */,
-     use_clustering:    	ENABLE_CLUSTERING                               
+     .proc_name         	= "NCR53c406a"		/* proc_name */,        
+     .name              	= "NCR53c406a"		/* name */,             
+     .detect            	= NCR53c406a_detect	/* detect */,           
+     .info              	= NCR53c406a_info		/* info */,             
+     .command           	= NCR53c406a_command	/* command */,          
+     .queuecommand      	= NCR53c406a_queue	/* queuecommand */,     
+     .eh_abort_handler  	= NCR53c406a_abort	/* abort */,            
+     .eh_bus_reset_handler      = NCR53c406a_bus_reset	/* reset */,            
+     .eh_device_reset_handler   = NCR53c406a_device_reset	/* reset */,            
+     .eh_host_reset_handler     = NCR53c406a_host_reset	/* reset */,            
+     .bios_param        	= NCR53c406a_biosparm	/* biosparm */,         
+     .can_queue         	= 1			/* can_queue */,        
+     .this_id           	= 7			/* SCSI ID of the chip */,
+     .sg_tablesize      	= 32			/*SG_ALL*/ /*SG_NONE*/, 
+     .cmd_per_lun       	= 1			/* commands per lun */, 
+     .unchecked_isa_dma 	= 1			/* unchecked_isa_dma */,
+     .use_clustering    	= ENABLE_CLUSTERING                               
 };
 
 #include "scsi_module.c"
--- linux-2.5.48/drivers/scsi/dpt_i2o.c.old	2002-11-18 01:02:08.000000000 -0600
+++ linux-2.5.48/drivers/scsi/dpt_i2o.c	2002-11-18 10:38:43.000000000 -0600
@@ -112,9 +112,9 @@
 static int hba_count = 0;
 
 static struct file_operations adpt_fops = {
-	ioctl: adpt_ioctl,
-	open: adpt_open,
-	release: adpt_close
+	.ioctl		= adpt_ioctl,
+	.open		= adpt_open,
+	.release	= adpt_close
 };
 
 #ifdef REBOOT_NOTIFIER
--- linux-2.5.48/drivers/scsi/ide-scsi.c.old	2002-11-05 09:33:43.000000000 -0600
+++ linux-2.5.48/drivers/scsi/ide-scsi.c	2002-11-18 01:10:40.000000000 -0600
@@ -859,20 +859,20 @@
 }
 
 static Scsi_Host_Template idescsi_template = {
-	module:		THIS_MODULE,
-	name:		"idescsi",
-	detect:		idescsi_detect,
-	release:	idescsi_release,
-	info:		idescsi_info,
-	ioctl:		idescsi_ioctl,
-	queuecommand:	idescsi_queue,
-	bios_param:	idescsi_bios,
-	can_queue:	10,
-	this_id:	-1,
-	sg_tablesize:	256,
-	cmd_per_lun:	5,
-	use_clustering:	DISABLE_CLUSTERING,
-	emulated:	1,
+	.module		= THIS_MODULE,
+	.name		= "idescsi",
+	.detect		= idescsi_detect,
+	.release	= idescsi_release,
+	.info		= idescsi_info,
+	.ioctl		= idescsi_ioctl,
+	.queuecommand	= idescsi_queue,
+	.bios_param	= idescsi_bios,
+	.can_queue	= 10,
+	.this_id	= -1,
+	.sg_tablesize	= 256,
+	.cmd_per_lun	= 5,
+	.use_clustering	= DISABLE_CLUSTERING,
+	.emulated	= 1,
 };
 
 static int __init init_idescsi_module(void)
--- linux-2.5.48/drivers/scsi/imm.c.old	2002-10-31 16:20:05.000000000 -0600
+++ linux-2.5.48/drivers/scsi/imm.c	2002-11-18 12:09:48.000000000 -0600
@@ -47,17 +47,9 @@
 } imm_struct;
 
 #define IMM_EMPTY \
-{	dev:		NULL,		\
-	base:		-1,		\
-	base_hi:	0,		\
-	mode:		IMM_AUTODETECT,	\
-	host:		-1,		\
-	cur_cmd:	NULL,		\
-	jstart:		0,		\
-	failed:		0,		\
-	dp:		0,		\
-	rd:		0,		\
-	p_busy:		0		\
+{	.base		= -1,		\
+	.mode		= IMM_AUTODETECT,	\
+	.host		= -1,		\
 }
 
 #include "imm.h"
--- linux-2.5.48/drivers/scsi/ips.c.old	2002-10-31 16:20:05.000000000 -0600
+++ linux-2.5.48/drivers/scsi/ips.c	2002-11-18 01:10:38.000000000 -0600
@@ -317,24 +317,24 @@
    static void __devexit ips_remove_device(struct pci_dev *pci_dev);
    
    struct pci_driver ips_pci_driver = {
-       name:		ips_hot_plug_name,
-       id_table:	ips_pci_table,
-       probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       .name		= ips_hot_plug_name,
+       .id_table	= ips_pci_table,
+       .probe		= ips_insert_device,
+       .remove		= __devexit_p(ips_remove_device),
    }; 
            
    struct pci_driver ips_pci_driver_5i = {
-       name:		ips_hot_plug_name,
-       id_table:	ips_pci_table_5i,
-       probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       .name		= ips_hot_plug_name,
+       .id_table	= ips_pci_table_5i,
+       .probe		= ips_insert_device,
+       .remove		= __devexit_p(ips_remove_device),
    };
 
    struct pci_driver ips_pci_driver_i960 = {
-       name:		ips_hot_plug_name,
-       id_table:	ips_pci_table_i960,
-       probe:		ips_insert_device,
-       remove:		__devexit_p(ips_remove_device),
+       .name		= ips_hot_plug_name,
+       .id_table	= ips_pci_table_i960,
+       .probe		= ips_insert_device,
+       .remove		= __devexit_p(ips_remove_device),
    };
 
 #endif
--- linux-2.5.48/drivers/scsi/nsp32.c.old	2002-10-31 16:20:06.000000000 -0600
+++ linux-2.5.48/drivers/scsi/nsp32.c	2002-11-18 01:11:31.000000000 -0600
@@ -2066,53 +2066,53 @@
 
 static struct pci_device_id nsp32_pci_table[] __devinitdata = {
 	{
-		vendor:      PCI_VENDOR_ID_IODATA,
-		device:      PCI_DEVICE_ID_NINJASCSI_32BI_CBSC_II,
-		subvendor:   PCI_ANY_ID,
-		subdevice:   PCI_ANY_ID,
-		driver_data: MODEL_IODATA,
+		.vendor      = PCI_VENDOR_ID_IODATA,
+		.device      = PCI_DEVICE_ID_NINJASCSI_32BI_CBSC_II,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = MODEL_IODATA,
 	},
 	{
-		vendor:      PCI_VENDOR_ID_WORKBIT,
-		device:      PCI_DEVICE_ID_NINJASCSI_32BI_KME,
-		subvendor:   PCI_ANY_ID,
-		subdevice:   PCI_ANY_ID,
-		driver_data: MODEL_KME,
+		.vendor      = PCI_VENDOR_ID_WORKBIT,
+		.device      = PCI_DEVICE_ID_NINJASCSI_32BI_KME,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = MODEL_KME,
 	},
 	{
-		vendor:      PCI_VENDOR_ID_WORKBIT,
-		device:      PCI_DEVICE_ID_NINJASCSI_32BI_WBT,
-		subvendor:   PCI_ANY_ID,
-		subdevice:   PCI_ANY_ID,
-		driver_data: MODEL_WORKBIT,
+		.vendor      = PCI_VENDOR_ID_WORKBIT,
+		.device      = PCI_DEVICE_ID_NINJASCSI_32BI_WBT,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = MODEL_WORKBIT,
 	},
 	{
-		vendor:      PCI_VENDOR_ID_WORKBIT,
-		device:      PCI_DEVICE_ID_WORKBIT_STANDARD,
-		subvendor:   PCI_ANY_ID,
-		subdevice:   PCI_ANY_ID,
-		driver_data: MODEL_PCI_WORKBIT,
+		.vendor      = PCI_VENDOR_ID_WORKBIT,
+		.device      = PCI_DEVICE_ID_WORKBIT_STANDARD,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = MODEL_PCI_WORKBIT,
 	},
 	{
-		vendor:      PCI_VENDOR_ID_WORKBIT,
-		device:      PCI_DEVICE_ID_NINJASCSI_32BI_LOGITEC,
-		subvendor:   PCI_ANY_ID,
-		subdevice:   PCI_ANY_ID,
-		driver_data: MODEL_EXT_ROM,
+		.vendor      = PCI_VENDOR_ID_WORKBIT,
+		.device      = PCI_DEVICE_ID_NINJASCSI_32BI_LOGITEC,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = MODEL_EXT_ROM,
 	},
 	{
-		vendor:      PCI_VENDOR_ID_WORKBIT,
-		device:      PCI_DEVICE_ID_NINJASCSI_32BIB_LOGITEC,
-		subvendor:   PCI_ANY_ID,
-		subdevice:   PCI_ANY_ID,
-		driver_data: MODEL_PCI_LOGITEC,
+		.vendor      = PCI_VENDOR_ID_WORKBIT,
+		.device      = PCI_DEVICE_ID_NINJASCSI_32BIB_LOGITEC,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = MODEL_PCI_LOGITEC,
 	},
 	{
-		vendor:      PCI_VENDOR_ID_WORKBIT,
-		device:      PCI_DEVICE_ID_NINJASCSI_32UDE_MELCO,
-		subvendor:   PCI_ANY_ID,
-		subdevice:   PCI_ANY_ID,
-		driver_data: MODEL_PCI_MELCO,
+		.vendor      = PCI_VENDOR_ID_WORKBIT,
+		.device      = PCI_DEVICE_ID_NINJASCSI_32UDE_MELCO,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = MODEL_PCI_MELCO,
 	},
 	{0,0,},
 };
--- linux-2.5.48/drivers/scsi/osst.c.old	2002-11-18 01:02:09.000000000 -0600
+++ linux-2.5.48/drivers/scsi/osst.c	2002-11-18 01:11:03.000000000 -0600
@@ -160,13 +160,13 @@
 
 struct Scsi_Device_Template osst_template =
 {
-       module:		THIS_MODULE,
-       list:		LIST_HEAD_INIT(osst_template.list),
-       name:		"OnStream tape",
-       tag:		"osst",
-       scsi_type:	TYPE_TAPE,
-       attach:		osst_attach,
-       detach:		osst_detach
+       .module		= THIS_MODULE,
+       .list		= LIST_HEAD_INIT(osst_template.list),
+       .name		= "OnStream tape",
+       .tag		= "osst",
+       .scsi_type	= TYPE_TAPE,
+       .attach		= osst_attach,
+       .detach		= osst_detach
 };
 
 static int osst_int_ioctl(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, unsigned int cmd_in,unsigned long arg);
@@ -5354,12 +5354,12 @@
 
 
 static struct file_operations osst_fops = {
-	read:		osst_read,
-	write:		osst_write,
-	ioctl:		osst_ioctl,
-	open:		os_scsi_tape_open,
-	flush:		os_scsi_tape_flush,
-	release:	os_scsi_tape_close,
+	.read		= osst_read,
+	.write		= osst_write,
+	.ioctl		= osst_ioctl,
+	.open		= os_scsi_tape_open,
+	.flush		= os_scsi_tape_flush,
+	.release	= os_scsi_tape_close,
 };
 
 static int osst_supports(Scsi_Device * SDp)
--- linux-2.5.48/drivers/scsi/ppa.c.old	2002-10-31 16:20:07.000000000 -0600
+++ linux-2.5.48/drivers/scsi/ppa.c	2002-11-18 12:09:55.000000000 -0600
@@ -38,16 +38,11 @@
 } ppa_struct;
 
 #define PPA_EMPTY	\
-{	dev:		NULL,		\
-	base:		-1,		\
-	mode:		PPA_AUTODETECT,	\
-	host:		-1,		\
-	cur_cmd:	NULL,		\
-	ppa_tq:		{ func: ppa_interrupt },	\
-	jstart:		0,		\
-	recon_tmo:      PPA_RECON_TMO,	\
-	failed:		0,		\
-	p_busy:		0		\
+{	.base		= -1,		\
+	.mode		= PPA_AUTODETECT,	\
+	.host		= -1,		\
+	.ppa_tq		= { .func = ppa_interrupt },	\
+	.recon_tmo      = PPA_RECON_TMO,	\
 }
 
 #include  "ppa.h"
--- linux-2.5.48/drivers/scsi/scsi.c.old	2002-11-18 01:02:09.000000000 -0600
+++ linux-2.5.48/drivers/scsi/scsi.c	2002-11-18 10:42:42.000000000 -0600
@@ -2199,8 +2199,8 @@
 }
 
 struct bus_type scsi_driverfs_bus_type = {
-        name: "scsi",
-        match: scsi_bus_match,
+        .name	= "scsi",
+        .match	= scsi_bus_match,
 };
 
 static int __init init_scsi(void)
--- linux-2.5.48/drivers/scsi/tmscsim.c.old	2002-11-18 01:02:10.000000000 -0600
+++ linux-2.5.48/drivers/scsi/tmscsim.c	2002-11-18 10:43:07.000000000 -0600
@@ -276,10 +276,10 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,99)
 static struct pci_device_id tmscsim_pci_tbl[] __initdata = {
 	{
-		vendor: PCI_VENDOR_ID_AMD,
-		device: PCI_DEVICE_ID_AMD53C974,
-		subvendor: PCI_ANY_ID,
-		subdevice: PCI_ANY_ID,
+		.vendor		= PCI_VENDOR_ID_AMD,
+		.device		= PCI_DEVICE_ID_AMD53C974,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
 	},
 	{ }		/* Terminating entry */
 };
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
