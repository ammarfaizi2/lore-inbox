Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263506AbSJGXIv>; Mon, 7 Oct 2002 19:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263734AbSJGXIv>; Mon, 7 Oct 2002 19:08:51 -0400
Received: from mx2.airmail.net ([209.196.77.99]:57359 "EHLO mx2.airmail.net")
	by vger.kernel.org with ESMTP id <S263506AbSJGXHt>;
	Mon, 7 Oct 2002 19:07:49 -0400
Date: Mon, 7 Oct 2002 18:02:02 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 designated initializers for drivers/ide
Message-ID: <20021007230202.GQ9856@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a set of patches that switch drivers/ide to use C99 designated
initializers. The patches are all against 2.5.41.

Art Haas


--- linux-2.5.41/drivers/ide/ide-cd.c.old	2002-10-07 15:45:27.000000000 -0500
+++ linux-2.5.41/drivers/ide/ide-cd.c	2002-10-07 15:52:36.000000000 -0500
@@ -2563,26 +2563,26 @@
  * Device initialization.
  */
 static struct cdrom_device_ops ide_cdrom_dops = {
-	open:			ide_cdrom_open_real,
-	release:		ide_cdrom_release_real,
-	drive_status:		ide_cdrom_drive_status,
-	media_changed:		ide_cdrom_check_media_change_real,
-	tray_move:		ide_cdrom_tray_move,
-	lock_door:		ide_cdrom_lock_door,
-	select_speed:		ide_cdrom_select_speed,
-	get_last_session:	ide_cdrom_get_last_session,
-	get_mcn:		ide_cdrom_get_mcn,
-	reset:			ide_cdrom_reset,
-	audio_ioctl:		ide_cdrom_audio_ioctl,
-	dev_ioctl:		ide_cdrom_dev_ioctl,
-	capability:		CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK |
+	.open			= ide_cdrom_open_real,
+	.release		= ide_cdrom_release_real,
+	.drive_status		= ide_cdrom_drive_status,
+	.media_changed		= ide_cdrom_check_media_change_real,
+	.tray_move		= ide_cdrom_tray_move,
+	.lock_door		= ide_cdrom_lock_door,
+	.select_speed		= ide_cdrom_select_speed,
+	.get_last_session	= ide_cdrom_get_last_session,
+	.get_mcn		= ide_cdrom_get_mcn,
+	.reset			= ide_cdrom_reset,
+	.audio_ioctl		= ide_cdrom_audio_ioctl,
+	.dev_ioctl		= ide_cdrom_dev_ioctl,
+	.capability		= CDC_CLOSE_TRAY | CDC_OPEN_TRAY | CDC_LOCK |
 				CDC_SELECT_SPEED | CDC_SELECT_DISC |
 				CDC_MULTI_SESSION | CDC_MCN |
 				CDC_MEDIA_CHANGED | CDC_PLAY_AUDIO | CDC_RESET |
 				CDC_IOCTLS | CDC_DRIVE_STATUS | CDC_CD_R |
 				CDC_CD_RW | CDC_DVD | CDC_DVD_R| CDC_DVD_RAM |
 				CDC_GENERIC_PACKET,
-	generic_packet:		ide_cdrom_packet,
+	.generic_packet		= ide_cdrom_packet,
 };
 
 static int ide_cdrom_register (ide_drive_t *drive, int nslots)
@@ -3048,39 +3048,39 @@
 static int ide_cdrom_attach (ide_drive_t *drive);
 
 static ide_driver_t ide_cdrom_driver = {
-	owner:			THIS_MODULE,
-	name:			"ide-cdrom",
-	version:		IDECD_VERSION,
-	media:			ide_cdrom,
-	busy:			0,
+	.owner			= THIS_MODULE,
+	.name			= "ide-cdrom",
+	.version		= IDECD_VERSION,
+	.media			= ide_cdrom,
+	.busy			= 0,
 #ifdef CONFIG_IDEDMA_ONLYDISK
-	supports_dma:		0,
+	.supports_dma		= 0,
 #else
-	supports_dma:		1,
+	.supports_dma		= 1,
 #endif
-	supports_dsc_overlap:	1,
-	cleanup:		ide_cdrom_cleanup,
-	standby:		NULL,
-	suspend:		NULL,
-	resume:			NULL,
-	flushcache:		NULL,
-	do_request:		ide_do_rw_cdrom,
-	end_request:		NULL,
-	sense:			ide_cdrom_dump_status,
-	error:			ide_cdrom_error,
-	ioctl:			ide_cdrom_ioctl,
-	open:			ide_cdrom_open,
-	release:		ide_cdrom_release,
-	media_change:		ide_cdrom_check_media_change,
-	revalidate:		ide_cdrom_revalidate,
-	pre_reset:		NULL,
-	capacity:		ide_cdrom_capacity,
-	special:		NULL,
-	proc:			NULL,
-	attach:			ide_cdrom_attach,
-	ata_prebuilder:		NULL,
-	atapi_prebuilder:	NULL,
-	drives:			LIST_HEAD_INIT(ide_cdrom_driver.drives),
+	.supports_dsc_overlap	= 1,
+	.cleanup		= ide_cdrom_cleanup,
+	.standby		= NULL,
+	.suspend		= NULL,
+	.resume			= NULL,
+	.flushcache		= NULL,
+	.do_request		= ide_do_rw_cdrom,
+	.end_request		= NULL,
+	.sense			= ide_cdrom_dump_status,
+	.error			= ide_cdrom_error,
+	.ioctl			= ide_cdrom_ioctl,
+	.open			= ide_cdrom_open,
+	.release		= ide_cdrom_release,
+	.media_change		= ide_cdrom_check_media_change,
+	.revalidate		= ide_cdrom_revalidate,
+	.pre_reset		= NULL,
+	.capacity		= ide_cdrom_capacity,
+	.special		= NULL,
+	.proc			= NULL,
+	.attach			= ide_cdrom_attach,
+	.ata_prebuilder		= NULL,
+	.atapi_prebuilder	= NULL,
+	.drives			= LIST_HEAD_INIT(ide_cdrom_driver.drives),
 };
 
 /* options */
--- linux-2.5.41/drivers/ide/ide-disk.c.old	2002-10-07 15:45:27.000000000 -0500
+++ linux-2.5.41/drivers/ide/ide-disk.c	2002-10-07 15:52:36.000000000 -0500
@@ -1709,35 +1709,35 @@
  *      IDE subdriver functions, registered with ide.c
  */
 static ide_driver_t idedisk_driver = {
-	owner:			THIS_MODULE,
-	name:			"ide-disk",
-	version:		IDEDISK_VERSION,
-	media:			ide_disk,
-	busy:			0,
-	supports_dma:		1,
-	supports_dsc_overlap:	0,
-	cleanup:		idedisk_cleanup,
-	standby:		do_idedisk_standby,
-	suspend:		do_idedisk_suspend,
-	resume:			do_idedisk_resume,
-	flushcache:		do_idedisk_flushcache,
-	do_request:		do_rw_disk,
-	end_request:		NULL,
-	sense:			idedisk_dump_status,
-	error:			idedisk_error,
-	ioctl:			idedisk_ioctl,
-	open:			idedisk_open,
-	release:		idedisk_release,
-	media_change:		idedisk_media_change,
-	revalidate:		idedisk_revalidate,
-	pre_reset:		idedisk_pre_reset,
-	capacity:		idedisk_capacity,
-	special:		idedisk_special,
-	proc:			idedisk_proc,
-	attach:			idedisk_attach,
-	ata_prebuilder:		NULL,
-	atapi_prebuilder:	NULL,
-	drives:			LIST_HEAD_INIT(idedisk_driver.drives),
+	.owner			= THIS_MODULE,
+	.name			= "ide-disk",
+	.version		= IDEDISK_VERSION,
+	.media			= ide_disk,
+	.busy			= 0,
+	.supports_dma		= 1,
+	.supports_dsc_overlap	= 0,
+	.cleanup		= idedisk_cleanup,
+	.standby		= do_idedisk_standby,
+	.suspend		= do_idedisk_suspend,
+	.resume			= do_idedisk_resume,
+	.flushcache		= do_idedisk_flushcache,
+	.do_request		= do_rw_disk,
+	.end_request		= NULL,
+	.sense			= idedisk_dump_status,
+	.error			= idedisk_error,
+	.ioctl			= idedisk_ioctl,
+	.open			= idedisk_open,
+	.release		= idedisk_release,
+	.media_change		= idedisk_media_change,
+	.revalidate		= idedisk_revalidate,
+	.pre_reset		= idedisk_pre_reset,
+	.capacity		= idedisk_capacity,
+	.special		= idedisk_special,
+	.proc			= idedisk_proc,
+	.attach			= idedisk_attach,
+	.ata_prebuilder		= NULL,
+	.atapi_prebuilder	= NULL,
+	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
 };
 
 MODULE_DESCRIPTION("ATA DISK Driver");
--- linux-2.5.41/drivers/ide/ide-floppy.c.old	2002-09-22 11:22:20.000000000 -0500
+++ linux-2.5.41/drivers/ide/ide-floppy.c	2002-10-07 15:52:37.000000000 -0500
@@ -2042,39 +2042,39 @@
  *	IDE subdriver functions, registered with ide.c
  */
 static ide_driver_t idefloppy_driver = {
-	owner:			THIS_MODULE,
-	name:			"ide-floppy",
-	version:		IDEFLOPPY_VERSION,
-	media:			ide_floppy,
-	busy:			0,
+	.owner			= THIS_MODULE,
+	.name			= "ide-floppy",
+	.version		= IDEFLOPPY_VERSION,
+	.media			= ide_floppy,
+	.busy			= 0,
 #ifdef CONFIG_IDEDMA_ONLYDISK
-	supports_dma:		0,
+	.supports_dma		= 0,
 #else
-	supports_dma:		1,
+	.supports_dma		= 1,
 #endif
-	supports_dsc_overlap:	0,
-	cleanup:		idefloppy_cleanup,
-	standby:		NULL,
-	suspend:		NULL,
-	resume:			NULL,
-	flushcache:		NULL,
-	do_request:		idefloppy_do_request,
-	end_request:		idefloppy_do_end_request,
-	sense:			NULL,
-	error:			NULL,
-	ioctl:			idefloppy_ioctl,
-	open:			idefloppy_open,
-	release:		idefloppy_release,
-	media_change:		idefloppy_media_change,
-	revalidate:		idefloppy_revalidate,
-	pre_reset:		NULL,
-	capacity:		idefloppy_capacity,
-	special:		NULL,
-	proc:			idefloppy_proc,
-	attach:			idefloppy_attach,
-	ata_prebuilder:		NULL,
-	atapi_prebuilder:	NULL,
-	drives:			LIST_HEAD_INIT(idefloppy_driver.drives),
+	.supports_dsc_overlap	= 0,
+	.cleanup		= idefloppy_cleanup,
+	.standby		= NULL,
+	.suspend		= NULL,
+	.resume			= NULL,
+	.flushcache		= NULL,
+	.do_request		= idefloppy_do_request,
+	.end_request		= idefloppy_do_end_request,
+	.sense			= NULL,
+	.error			= NULL,
+	.ioctl			= idefloppy_ioctl,
+	.open			= idefloppy_open,
+	.release		= idefloppy_release,
+	.media_change		= idefloppy_media_change,
+	.revalidate		= idefloppy_revalidate,
+	.pre_reset		= NULL,
+	.capacity		= idefloppy_capacity,
+	.special		= NULL,
+	.proc			= idefloppy_proc,
+	.attach			= idefloppy_attach,
+	.ata_prebuilder		= NULL,
+	.atapi_prebuilder	= NULL,
+	.drives			= LIST_HEAD_INIT(idefloppy_driver.drives),
 };
 
 static int idefloppy_attach (ide_drive_t *drive)
--- linux-2.5.41/drivers/ide/ide-proc.c.old	2002-09-20 12:36:42.000000000 -0500
+++ linux-2.5.41/drivers/ide/ide-proc.c	2002-10-07 15:52:37.000000000 -0500
@@ -851,10 +851,10 @@
 	return seq_open(file, &ide_drivers_op);
 }
 static struct file_operations ide_drivers_operations = {
-	open:		ide_drivers_open,
-	read:		seq_read,
-	llseek:		seq_lseek,
-	release:	seq_release,
+	.open		= ide_drivers_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
 };
 
 void proc_ide_create(void)
--- linux-2.5.41/drivers/ide/ide-tape.c.old	2002-09-16 09:33:58.000000000 -0500
+++ linux-2.5.41/drivers/ide/ide-tape.c	2002-10-07 15:52:36.000000000 -0500
@@ -6184,51 +6184,51 @@
  *	IDE subdriver functions, registered with ide.c
  */
 static ide_driver_t idetape_driver = {
-	owner:			THIS_MODULE,
-	name:			"ide-tape",
-	version:		IDETAPE_VERSION,
-	media:			ide_tape,
-	busy:			1,
+	.owner			= THIS_MODULE,
+	.name			= "ide-tape",
+	.version		= IDETAPE_VERSION,
+	.media			= ide_tape,
+	.busy			= 1,
 #ifdef CONFIG_IDEDMA_ONLYDISK
-	supports_dma:		0,
+	.supports_dma		= 0,
 #else
-	supports_dma:		1,
+	.supports_dma		= 1,
 #endif
-	supports_dsc_overlap: 	1,
-	cleanup:		idetape_cleanup,
-	standby:		NULL,
-	suspend:		NULL,
-	resume:			NULL,
-	flushcache:		NULL,
-	do_request:		idetape_do_request,
-	end_request:		idetape_end_request,
-	sense:			NULL,
-	error:			NULL,
-	ioctl:			idetape_blkdev_ioctl,
-	open:			idetape_blkdev_open,
-	release:		idetape_blkdev_release,
-	media_change:		NULL,
-	revalidate:		NULL,
-	pre_reset:		idetape_pre_reset,
-	capacity:		NULL,
-	special:		NULL,
-	proc:			idetape_proc,
-	attach:			idetape_attach,
-	ata_prebuilder:		NULL,
-	atapi_prebuilder:	NULL,
-	drives:			LIST_HEAD_INIT(idetape_driver.drives),
+	.supports_dsc_overlap 	= 1,
+	.cleanup		= idetape_cleanup,
+	.standby		= NULL,
+	.suspend		= NULL,
+	.resume			= NULL,
+	.flushcache		= NULL,
+	.do_request		= idetape_do_request,
+	.end_request		= idetape_end_request,
+	.sense			= NULL,
+	.error			= NULL,
+	.ioctl			= idetape_blkdev_ioctl,
+	.open			= idetape_blkdev_open,
+	.release		= idetape_blkdev_release,
+	.media_change		= NULL,
+	.revalidate		= NULL,
+	.pre_reset		= idetape_pre_reset,
+	.capacity		= NULL,
+	.special		= NULL,
+	.proc			= idetape_proc,
+	.attach			= idetape_attach,
+	.ata_prebuilder		= NULL,
+	.atapi_prebuilder	= NULL,
+	.drives			= LIST_HEAD_INIT(idetape_driver.drives),
 };
 
 /*
  *	Our character device supporting functions, passed to register_chrdev.
  */
 static struct file_operations idetape_fops = {
-	owner:		THIS_MODULE,
-	read:		idetape_chrdev_read,
-	write:		idetape_chrdev_write,
-	ioctl:		idetape_chrdev_ioctl,
-	open:		idetape_chrdev_open,
-	release:	idetape_chrdev_release,
+	.owner		= THIS_MODULE,
+	.read		= idetape_chrdev_read,
+	.write		= idetape_chrdev_write,
+	.ioctl		= idetape_chrdev_ioctl,
+	.open		= idetape_chrdev_open,
+	.release	= idetape_chrdev_release,
 };
 
 static int idetape_attach (ide_drive_t *drive)
--- linux-2.5.41/drivers/ide/ide.c.old	2002-10-07 15:45:28.000000000 -0500
+++ linux-2.5.41/drivers/ide/ide.c	2002-10-07 15:52:36.000000000 -0500
@@ -1689,10 +1689,10 @@
 	return 0;
 }
 struct seq_operations ide_drivers_op = {
-	start:	m_start,
-	next:	m_next,
-	stop:	m_stop,
-	show:	show_driver
+	.start	= m_start,
+	.next	= m_next,
+	.stop	= m_stop,
+	.show	= show_driver
 };
 
 #ifdef CONFIG_PROC_FS
@@ -3446,12 +3446,12 @@
 EXPORT_SYMBOL(ide_unregister_driver);
 
 struct block_device_operations ide_fops[] = {{
-	owner:			THIS_MODULE,
-	open:			ide_open,
-	release:		ide_release,
-	ioctl:			ide_ioctl,
-	check_media_change:	ide_check_media_change,
-	revalidate:		ide_revalidate_disk
+	.owner			= THIS_MODULE,
+	.open			= ide_open,
+	.release		= ide_release,
+	.ioctl			= ide_ioctl,
+	.check_media_change	= ide_check_media_change,
+	.revalidate		= ide_revalidate_disk
 }};
 
 EXPORT_SYMBOL(ide_fops);
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
