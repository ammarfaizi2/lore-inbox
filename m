Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbSJLRUF>; Sat, 12 Oct 2002 13:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbSJLRSz>; Sat, 12 Oct 2002 13:18:55 -0400
Received: from mx1.airmail.net ([209.196.77.98]:12807 "EHLO mx1.airmail.net")
	by vger.kernel.org with ESMTP id <S261297AbSJLRQe>;
	Sat, 12 Oct 2002 13:16:34 -0400
Date: Sat, 12 Oct 2002 11:59:01 -0500
From: Art Haas <ahaas@neosoft.com>
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 designated initializers for drivers/scsi
Message-ID: <20021012165901.GK633@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a set of patches for switching drivers/scsi to use C99 named
initializers. The patches are all against 2.5.42.

Art Haas

--- linux-2.5.42/drivers/scsi/dpt_i2o.c.old	2002-08-31 21:57:23.000000000 -0500
+++ linux-2.5.42/drivers/scsi/dpt_i2o.c	2002-10-12 09:51:39.000000000 -0500
@@ -113,9 +113,9 @@
 static int hba_count = 0;
 
 static struct file_operations adpt_fops = {
-	ioctl: adpt_ioctl,
-	open: adpt_open,
-	release: adpt_close
+	.ioctl = adpt_ioctl,
+	.open = adpt_open,
+	.release = adpt_close
 };
 
 #ifdef REBOOT_NOTIFIER
--- linux-2.5.42/drivers/scsi/ide-scsi.c.old	2002-10-12 09:46:55.000000000 -0500
+++ linux-2.5.42/drivers/scsi/ide-scsi.c	2002-10-12 09:51:32.000000000 -0500
@@ -574,29 +574,29 @@
  *	IDE subdriver functions, registered with ide.c
  */
 static ide_driver_t idescsi_driver = {
-	owner:			THIS_MODULE,
-	name:			"ide-scsi",
-	version:		IDESCSI_VERSION,
-	media:			ide_scsi,
-	busy:			0,
-	supports_dma:		1,
-	supports_dsc_overlap:	0,
-	attach:			idescsi_attach,
-	cleanup:		idescsi_cleanup,
-	standby:		NULL,
-	flushcache:		NULL,
-	do_request:		idescsi_do_request,
-	end_request:		idescsi_end_request,
-	ioctl:			idescsi_do_ioctl,
-	open:			idescsi_ide_open,
-	release:		idescsi_ide_release,
-	media_change:		NULL,
-	revalidate:		NULL,
-	pre_reset:		NULL,
-	capacity:		NULL,
-	special:		NULL,
-	proc:			NULL,
-	drives:			LIST_HEAD_INIT(idescsi_driver.drives),
+	.owner			= THIS_MODULE,
+	.name			= "ide-scsi",
+	.version		= IDESCSI_VERSION,
+	.media			= ide_scsi,
+	.busy			= 0,
+	.supports_dma		= 1,
+	.supports_dsc_overlap	= 0,
+	.attach			= idescsi_attach,
+	.cleanup		= idescsi_cleanup,
+	.standby		= NULL,
+	.flushcache		= NULL,
+	.do_request		= idescsi_do_request,
+	.end_request		= idescsi_end_request,
+	.ioctl			= idescsi_do_ioctl,
+	.open			= idescsi_ide_open,
+	.release		= idescsi_ide_release,
+	.media_change		= NULL,
+	.revalidate		= NULL,
+	.pre_reset		= NULL,
+	.capacity		= NULL,
+	.special		= NULL,
+	.proc			= NULL,
+	.drives			= LIST_HEAD_INIT(idescsi_driver.drives),
 };
 
 static int idescsi_attach(ide_drive_t *drive)
@@ -853,22 +853,22 @@
 }
 
 static Scsi_Host_Template idescsi_template = {
-	module:		THIS_MODULE,
-	name:		"idescsi",
-	detect:		idescsi_detect,
-	release:	idescsi_release,
-	info:		idescsi_info,
-	ioctl:		idescsi_ioctl,
-	queuecommand:	idescsi_queue,
-	abort:		idescsi_abort,
-	reset:		idescsi_reset,
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
+	.abort		= idescsi_abort,
+	.reset		= idescsi_reset,
+	.bios_param	= idescsi_bios,
+	.can_queue	= 10,
+	.this_id	= -1,
+	.sg_tablesize	= 256,
+	.cmd_per_lun	= 5,
+	.use_clustering	= DISABLE_CLUSTERING,
+	.emulated	= 1,
 };
 
 static int __init init_idescsi_module(void)
--- linux-2.5.42/drivers/scsi/imm.c.old	2002-10-12 09:46:55.000000000 -0500
+++ linux-2.5.42/drivers/scsi/imm.c	2002-10-12 09:51:47.000000000 -0500
@@ -47,17 +47,17 @@
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
+{	.dev		= NULL,		\
+	.base		= -1,		\
+	.base_hi	= 0,		\
+	.mode		= IMM_AUTODETECT,	\
+	.host		= -1,		\
+	.cur_cmd	= NULL,		\
+	.jstart		= 0,		\
+	.failed		= 0,		\
+	.dp		= 0,		\
+	.rd		= 0,		\
+	.p_busy		= 0		\
 }
 
 #include "imm.h"
--- linux-2.5.42/drivers/scsi/ips.c.old	2002-10-12 09:46:56.000000000 -0500
+++ linux-2.5.42/drivers/scsi/ips.c	2002-10-12 09:51:32.000000000 -0500
@@ -318,24 +318,24 @@
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
--- linux-2.5.42/drivers/scsi/megaraid.c.old	2002-10-12 09:46:56.000000000 -0500
+++ linux-2.5.42/drivers/scsi/megaraid.c	2002-10-12 09:51:31.000000000 -0500
@@ -762,9 +762,9 @@
 /* For controller re-ordering */ 
 
 static struct file_operations megadev_fops = {
-	ioctl:megadev_ioctl_entry,
-	open:megadev_open,
-	release:megadev_close,
+	.ioctl = megadev_ioctl_entry,
+	.open = megadev_open,
+	.release = megadev_close,
 };
 
 /*
--- linux-2.5.42/drivers/scsi/nsp32.c.old	2002-10-07 15:45:43.000000000 -0500
+++ linux-2.5.42/drivers/scsi/nsp32.c	2002-10-12 09:51:48.000000000 -0500
@@ -2069,53 +2069,53 @@
 
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
--- linux-2.5.42/drivers/scsi/osst.c.old	2002-08-02 08:16:28.000000000 -0500
+++ linux-2.5.42/drivers/scsi/osst.c	2002-10-12 09:51:45.000000000 -0500
@@ -158,15 +158,15 @@
 
 struct Scsi_Device_Template osst_template =
 {
-       module:		THIS_MODULE,
-       name:		"OnStream tape",
-       tag:		"osst",
-       scsi_type:	TYPE_TAPE,
-       major:		OSST_MAJOR,
-       detect:		osst_detect,
-       init:		osst_init,
-       attach:		osst_attach,
-       detach:		osst_detach
+       .module		= THIS_MODULE,
+       .name		= "OnStream tape",
+       .tag		= "osst",
+       .scsi_type	= TYPE_TAPE,
+       .major		= OSST_MAJOR,
+       .detect		= osst_detect,
+       .init		= osst_init,
+       .attach		= osst_attach,
+       .detach		= osst_detach
 };
 
 static int osst_int_ioctl(OS_Scsi_Tape *STp, Scsi_Request ** aSRpnt, unsigned int cmd_in,unsigned long arg);
@@ -5381,12 +5381,12 @@
 
 
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
--- linux-2.5.42/drivers/scsi/pluto.c.old	2002-07-17 09:03:51.000000000 -0500
+++ linux-2.5.42/drivers/scsi/pluto.c	2002-10-12 10:44:15.000000000 -0500
@@ -91,7 +91,7 @@
 	int i, retry, nplutos;
 	fc_channel *fc;
 	Scsi_Device dev;
-	struct timer_list fc_timer = { function: pluto_detect_timeout };
+	struct timer_list fc_timer = { .function = pluto_detect_timeout };
 
 	tpnt->proc_name = "pluto";
 	fcscount = 0;
--- linux-2.5.42/drivers/scsi/ppa.c.old	2002-10-12 09:46:56.000000000 -0500
+++ linux-2.5.42/drivers/scsi/ppa.c	2002-10-12 09:51:32.000000000 -0500
@@ -38,16 +38,16 @@
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
+{	.dev		= NULL,		\
+	.base		= -1,		\
+	.mode		= PPA_AUTODETECT,	\
+	.host		= -1,		\
+	.cur_cmd	= NULL,		\
+	.ppa_tq		= { .func = ppa_interrupt },	\
+	.jstart		= 0,		\
+	.recon_tmo      = PPA_RECON_TMO,	\
+	.failed		= 0,		\
+	.p_busy		= 0		\
 }
 
 #include  "ppa.h"
--- linux-2.5.42/drivers/scsi/scsi.c.old	2002-10-12 09:46:56.000000000 -0500
+++ linux-2.5.42/drivers/scsi/scsi.c	2002-10-12 09:51:45.000000000 -0500
@@ -2684,8 +2684,8 @@
 }
 
 struct bus_type scsi_driverfs_bus_type = {
-        name: "scsi",
-        match: scsi_bus_match,
+        .name = "scsi",
+        .match = scsi_bus_match,
 };
 
 static int __init init_scsi(void)
--- linux-2.5.42/drivers/scsi/sd.c.old	2002-10-12 09:46:57.000000000 -0500
+++ linux-2.5.42/drivers/scsi/sd.c	2002-10-12 09:51:38.000000000 -0500
@@ -104,23 +104,23 @@
 static struct notifier_block sd_notifier_block = {sd_notifier, NULL, 0}; 
 
 static struct Scsi_Device_Template sd_template = {
-	module:THIS_MODULE,
-	name:"disk",
-	tag:"sd",
-	scsi_type:TYPE_DISK,
-	major:SCSI_DISK0_MAJOR,
+	.module = THIS_MODULE,
+	.name = "disk",
+	.tag = "sd",
+	.scsi_type = TYPE_DISK,
+	.major = SCSI_DISK0_MAJOR,
         /*
          * Secondary range of majors that this driver handles.
          */
-	min_major:SCSI_DISK1_MAJOR,
-	max_major:SCSI_DISK7_MAJOR,
-	blk:1,
-	detect:sd_detect,
-	init:sd_init,
-	finish:sd_finish,
-	attach:sd_attach,
-	detach:sd_detach,
-	init_command:sd_init_command,
+	.min_major = SCSI_DISK1_MAJOR,
+	.max_major = SCSI_DISK7_MAJOR,
+	.blk = 1,
+	.detect = sd_detect,
+	.init = sd_init,
+	.finish = sd_finish,
+	.attach = sd_attach,
+	.detach = sd_detach,
+	.init_command = sd_init_command,
 };
 
 static void sd_rw_intr(Scsi_Cmnd * SCpnt);
@@ -585,12 +585,12 @@
 
 static struct block_device_operations sd_fops =
 {
-	owner:			THIS_MODULE,
-	open:			sd_open,
-	release:		sd_release,
-	ioctl:			sd_ioctl,
-	check_media_change:	check_scsidisk_media_change,
-	revalidate:		sd_revalidate
+	.owner			= THIS_MODULE,
+	.open			= sd_open,
+	.release		= sd_release,
+	.ioctl			= sd_ioctl,
+	.check_media_change	= check_scsidisk_media_change,
+	.revalidate		= sd_revalidate
 };
 
 /**
--- linux-2.5.42/drivers/scsi/sr.c.old	2002-10-12 09:46:57.000000000 -0500
+++ linux-2.5.42/drivers/scsi/sr.c	2002-10-12 09:51:39.000000000 -0500
@@ -73,18 +73,18 @@
 
 static struct Scsi_Device_Template sr_template =
 {
-	module:THIS_MODULE,
-	name:"cdrom",
-	tag:"sr",
-	scsi_type:TYPE_ROM,
-	major:SCSI_CDROM_MAJOR,
-	blk:1,
-	detect:sr_detect,
-	init:sr_init,
-	finish:sr_finish,
-	attach:sr_attach,
-	detach:sr_detach,
-	init_command:sr_init_command
+	.module = THIS_MODULE,
+	.name = "cdrom",
+	.tag = "sr",
+	.scsi_type = TYPE_ROM,
+	.major = SCSI_CDROM_MAJOR,
+	.blk = 1,
+	.detect = sr_detect,
+	.init = sr_init,
+	.finish = sr_finish,
+	.attach = sr_attach,
+	.detach = sr_detach,
+	.init_command = sr_init_command
 };
 
 static Scsi_CD *scsi_CDs;
@@ -111,26 +111,26 @@
 
 static struct cdrom_device_ops sr_dops =
 {
-	open:			sr_open,
-	release:		sr_release,
-	drive_status:		sr_drive_status,
-	media_changed:		sr_media_change,
-	tray_move:		sr_tray_move,
-	lock_door:		sr_lock_door,
-	select_speed:		sr_select_speed,
-	get_last_session:	sr_get_last_session,
-	get_mcn:		sr_get_mcn,
-	reset:			sr_reset,
-	audio_ioctl:		sr_audio_ioctl,
-	dev_ioctl:		sr_dev_ioctl,
-	capability:		CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK |
+	.open			= sr_open,
+	.release		= sr_release,
+	.drive_status		= sr_drive_status,
+	.media_changed		= sr_media_change,
+	.tray_move		= sr_tray_move,
+	.lock_door		= sr_lock_door,
+	.select_speed		= sr_select_speed,
+	.get_last_session	= sr_get_last_session,
+	.get_mcn		= sr_get_mcn,
+	.reset			= sr_reset,
+	.audio_ioctl		= sr_audio_ioctl,
+	.dev_ioctl		= sr_dev_ioctl,
+	.capability		= CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK |
 				CDC_SELECT_SPEED | CDC_SELECT_DISC |
 				CDC_MULTI_SESSION | CDC_MCN |
 				CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO |
 				CDC_RESET | CDC_IOCTLS | CDC_DRIVE_STATUS |
 				CDC_CD_R | CDC_CD_RW | CDC_DVD | CDC_DVD_R |
 				CDC_DVD_RAM | CDC_GENERIC_PACKET,
-	generic_packet:		sr_packet,
+	.generic_packet		= sr_packet,
 };
 
 /*
@@ -390,11 +390,11 @@
 
 struct block_device_operations sr_bdops =
 {
-	owner:			THIS_MODULE,
-	open:			cdrom_open,
-	release:		cdrom_release,
-	ioctl:			cdrom_ioctl,
-	check_media_change:	cdrom_media_changed,
+	.owner			= THIS_MODULE,
+	.open			= cdrom_open,
+	.release		= cdrom_release,
+	.ioctl			= cdrom_ioctl,
+	.check_media_change	= cdrom_media_changed,
 };
 
 static int sr_open(struct cdrom_device_info *cdi, int purpose)
--- linux-2.5.42/drivers/scsi/st.c.old	2002-10-07 15:45:44.000000000 -0500
+++ linux-2.5.42/drivers/scsi/st.c	2002-10-12 09:51:45.000000000 -0500
@@ -3642,13 +3642,13 @@
 
 static struct file_operations st_fops =
 {
-	owner:		THIS_MODULE,
-	read:		st_read,
-	write:		st_write,
-	ioctl:		st_ioctl,
-	open:		st_open,
-	flush:		st_flush,
-	release:	st_release,
+	.owner		= THIS_MODULE,
+	.read		= st_read,
+	.write		= st_write,
+	.ioctl		= st_ioctl,
+	.open		= st_open,
+	.flush		= st_flush,
+	.release	= st_release,
 };
 
 static int st_attach(Scsi_Device * SDp)
--- linux-2.5.42/drivers/scsi/tmscsim.c.old	2002-07-24 19:42:31.000000000 -0500
+++ linux-2.5.42/drivers/scsi/tmscsim.c	2002-10-12 09:51:45.000000000 -0500
@@ -276,10 +276,10 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,99)
 static struct pci_device_id tmscsim_pci_tbl[] __initdata = {
 	{
-		vendor: PCI_VENDOR_ID_AMD,
-		device: PCI_DEVICE_ID_AMD53C974,
-		subvendor: PCI_ANY_ID,
-		subdevice: PCI_ANY_ID,
+		.vendor = PCI_VENDOR_ID_AMD,
+		.device = PCI_DEVICE_ID_AMD53C974,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
 	},
 	{ }		/* Terminating entry */
 };
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
