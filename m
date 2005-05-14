Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVENUwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVENUwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 16:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVENUwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 16:52:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11138 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261484AbVENUuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 16:50:25 -0400
Date: Sat, 14 May 2005 13:50:19 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Oops on CF removal and "convert device drivers to driver-model"
Message-Id: <20050514135019.0b3252f1.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Bartlomiej:

I would be gratious to you if you expedited the push of the attached
patch from your private tree into the mainline. It was posted back in
February. The 2.6.12-rc3 still oopses upon running "cardctl eject"
with this:

cs: memory probe 0xa0000000-0xa0ffffff: excluding 0xa0000000-0xa00fffff
Probing IDE interface ide2...
hde: SAMSUNG CF/ATA, CFA DISK drive
ide2 at 0x100-0x107,0x10e on irq 3
hde: max request size: 128KiB
hde: 2041200 sectors (1045 MB) w/0KiB Cache, CHS=2025/16/63
hde: cache flushes not supported
 hde: hde1
ide-cs: hde: Vcc = 3.3, Vpp = 0.0
 hde: hde1
 hde: hde1
 hde: hde1
 hde: hde1
 hde: hde1
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c02b35a2
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: ide_cs udf ub usbmon tun crc32 radeon pcmcia sunrpc md5 ipv6 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables video thermal processor fan button battery ac yenta_socket rsrc_nonstatic pcmcia_core uhci_hcd ehci_hcd snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc tg3 ide_cd cdrom usbcore joydev evdev
CPU:    0
EIP:    0060:[<c02b35a2>]    Not tainted VLI
EFLAGS: 00210292   (2.6.12-rc3-lem) 
EIP is at ide_drive_remove+0x12/0x20
eax: c0404438   ebx: c0404544   ecx: c0404530   edx: 00000000
esi: c0404520   edi: c039a018   ebp: c04043a8   esp: c74efd8c
ds: 007b   es: 007b   ss: 0068
Process cardctl (pid: 7753, threadinfo=c74ee000 task=d9dbcaa0)
Stack: c0404438 c02982e8 c0404520 c0361df5 c0404520 c04048e0 c0404438 c029857c 
       c0404520 c0404520 c0404520 c04048e0 c029738c c0404520 c04043a8 c0404520 
       c0404448 c02973e0 c0404520 00000002 c02b0843 c0404520 daf1a254 c017c0c6 
Call Trace:
 [<c02982e8>] device_release_driver+0x68/0x80
 [<c029857c>] bus_remove_device+0x6c/0xb0
 [<c029738c>] device_del+0x5c/0xa0
 [<c02973e0>] device_unregister+0x10/0x20
 [<c02b0843>] ide_unregister+0x313/0x910
 [<c017c0c6>] __find_get_block+0x96/0xb0
 [<e09cb8e7>] ide_release+0x27/0x70 [ide_cs]
 [<e09cb9ee>] ide_event+0xbe/0xf0 [ide_cs]
 [<e09b6df2>] send_event_callback+0x52/0x60 [pcmcia]
 [<c0297e97>] __bus_for_each_dev+0x67/0xa0
 [<c0297fac>] bus_for_each_dev+0x3c/0x60
 [<e09b6da0>] send_event_callback+0x0/0x60 [pcmcia]
 [<e09b6da0>] send_event_callback+0x0/0x60 [pcmcia]
 [<e09b6e60>] send_event+0x60/0x80 [pcmcia]
 [<e09b6da0>] send_event_callback+0x0/0x60 [pcmcia]
 [<e09b6f0f>] ds_event+0x8f/0x130 [pcmcia]
 [<e0932853>] send_event+0x53/0xa0 [pcmcia_core]
 [<e09328c1>] socket_remove_drivers+0x21/0x30 [pcmcia_core]
 [<e09328e0>] socket_shutdown+0x10/0x40 [pcmcia_core]
 [<e0932e40>] socket_remove+0x10/0x40 [pcmcia_core]
 [<e09350da>] pcmcia_eject_card+0x6a/0x70 [pcmcia_core]
 [<e09b870e>] ds_ioctl+0x3be/0x730 [pcmcia]
 [<c0192241>] do_ioctl+0x81/0x90
 [<c01923b0>] vfs_ioctl+0x60/0x1f0
 [<c01925c8>] sys_ioctl+0x88/0xa0
 [<c0103c3b>] sysenter_past_esp+0x54/0x75
Code: 39 c0 89 44 24 0c b8 13 0b 36 c0 89 44 24 04 e8 75 a5 e6 ff e9 42 fe ff ff 83 ec 04 8b 44 24 08 2d e8 00 00 00 8b 50 1c 89 04 24 <ff> 52 10 31 c0 5a c3 8d b4 26 00 00 00 00 55 57 56 53 83 ec 24 

I appreciate that you spend effort on testing but keeping these fixes in
your private tree makes sure that they are not available in the mainline.

Yours,
-- Pete

diff -urp -X dontdiff linux-2.6.12-rc4/drivers/ide/ide.c linux-2.6.12-rc4-ide/drivers/ide/ide.c
--- linux-2.6.12-rc4/drivers/ide/ide.c	2005-05-14 00:02:35.000000000 -0700
+++ linux-2.6.12-rc4-ide/drivers/ide/ide.c	2005-05-14 10:10:33.000000000 -0700
@@ -196,8 +196,6 @@ ide_hwif_t ide_hwifs[MAX_HWIFS];	/* mast
 
 EXPORT_SYMBOL(ide_hwifs);
 
-static struct list_head ide_drives = LIST_HEAD_INIT(ide_drives);
-
 /*
  * Do not even *think* about calling this!
  */
@@ -358,54 +356,6 @@ static int ide_system_bus_speed(void)
 	return system_bus_speed;
 }
 
-/*
- *	drives_lock protects the list of drives, drivers_lock the
- *	list of drivers.  Currently nobody takes both at once.
- */
-
-static DEFINE_SPINLOCK(drives_lock);
-static DEFINE_SPINLOCK(drivers_lock);
-static LIST_HEAD(drivers);
-
-/* Iterator for the driver list. */
-
-static void *m_start(struct seq_file *m, loff_t *pos)
-{
-	struct list_head *p;
-	loff_t l = *pos;
-	spin_lock(&drivers_lock);
-	list_for_each(p, &drivers)
-		if (!l--)
-			return list_entry(p, ide_driver_t, drivers);
-	return NULL;
-}
-
-static void *m_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	struct list_head *p = ((ide_driver_t *)v)->drivers.next;
-	(*pos)++;
-	return p==&drivers ? NULL : list_entry(p, ide_driver_t, drivers);
-}
-
-static void m_stop(struct seq_file *m, void *v)
-{
-	spin_unlock(&drivers_lock);
-}
-
-static int show_driver(struct seq_file *m, void *v)
-{
-	ide_driver_t *driver = v;
-	seq_printf(m, "%s version %s\n", driver->name, driver->version);
-	return 0;
-}
-
-struct seq_operations ide_drivers_op = {
-	.start	= m_start,
-	.next	= m_next,
-	.stop	= m_stop,
-	.show	= show_driver
-};
-
 #ifdef CONFIG_PROC_FS
 struct proc_dir_entry *proc_ide_root;
 #endif
@@ -630,7 +580,7 @@ void ide_unregister(unsigned int index)
 	ide_hwif_t *hwif, *g;
 	static ide_hwif_t tmp_hwif; /* protected by ide_cfg_sem */
 	ide_hwgroup_t *hwgroup;
-	int irq_count = 0, unit, i;
+	int irq_count = 0, unit;
 
 	BUG_ON(index >= MAX_HWIFS);
 
@@ -643,23 +593,22 @@ void ide_unregister(unsigned int index)
 		goto abort;
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
-		if (!drive->present)
+		if (!drive->present) {
+			if (drive->devfs_name[0] != '\0') {
+				devfs_remove(drive->devfs_name);
+				drive->devfs_name[0] = '\0';
+			}
 			continue;
-		if (drive->usage || DRIVER(drive)->busy)
-			goto abort;
-		drive->dead = 1;
+		}
+		spin_unlock_irq(&ide_lock);
+		device_unregister(&drive->gendev);
+		down(&drive->gendev_rel_sem);
+		spin_lock_irq(&ide_lock);
 	}
 	hwif->present = 0;
 
 	spin_unlock_irq(&ide_lock);
 
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
-		drive = &hwif->drives[unit];
-		if (!drive->present)
-			continue;
-		DRIVER(drive)->cleanup(drive);
-	}
-
 	destroy_proc_ide_interface(hwif);
 
 	hwgroup = hwif->hwgroup;
@@ -687,44 +636,6 @@ void ide_unregister(unsigned int index)
 	 * Remove us from the hwgroup, and free
 	 * the hwgroup if we were the only member
 	 */
-	for (i = 0; i < MAX_DRIVES; ++i) {
-		drive = &hwif->drives[i];
-		if (drive->devfs_name[0] != '\0') {
-			devfs_remove(drive->devfs_name);
-			drive->devfs_name[0] = '\0';
-		}
-		if (!drive->present)
-			continue;
-		if (drive == drive->next) {
-			/* special case: last drive from hwgroup. */
-			BUG_ON(hwgroup->drive != drive);
-			hwgroup->drive = NULL;
-		} else {
-			ide_drive_t *walk;
-
-			walk = hwgroup->drive;
-			while (walk->next != drive)
-				walk = walk->next;
-			walk->next = drive->next;
-			if (hwgroup->drive == drive) {
-				hwgroup->drive = drive->next;
-				hwgroup->hwif = HWIF(hwgroup->drive);
-			}
-		}
-		BUG_ON(hwgroup->drive == drive);
-		if (drive->id != NULL) {
-			kfree(drive->id);
-			drive->id = NULL;
-		}
-		drive->present = 0;
-		/* Messed up locking ... */
-		spin_unlock_irq(&ide_lock);
-		blk_cleanup_queue(drive->queue);
-		device_unregister(&drive->gendev);
-		down(&drive->gendev_rel_sem);
-		spin_lock_irq(&ide_lock);
-		drive->queue = NULL;
-	}
 	if (hwif->next == hwif) {
 		BUG_ON(hwgroup->hwif != hwif);
 		kfree(hwgroup);
@@ -1304,73 +1215,6 @@ int system_bus_clock (void)
 
 EXPORT_SYMBOL(system_bus_clock);
 
-/*
- *	Locking is badly broken here - since way back.  That sucker is
- * root-only, but that's not an excuse...  The real question is what
- * exclusion rules do we want here.
- */
-int ide_replace_subdriver (ide_drive_t *drive, const char *driver)
-{
-	if (!drive->present || drive->usage || drive->dead)
-		goto abort;
-	if (DRIVER(drive)->cleanup(drive))
-		goto abort;
-	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
-	if (ata_attach(drive)) {
-		spin_lock(&drives_lock);
-		list_del_init(&drive->list);
-		spin_unlock(&drives_lock);
-		drive->driver_req[0] = 0;
-		ata_attach(drive);
-	} else {
-		drive->driver_req[0] = 0;
-	}
-	if (drive->driver && !strcmp(drive->driver->name, driver))
-		return 0;
-abort:
-	return 1;
-}
-
-/**
- *	ata_attach		-	attach an ATA/ATAPI device
- *	@drive: drive to attach
- *
- *	Takes a drive that is as yet not assigned to any midlayer IDE
- *	driver (or is assigned to the default driver) and figures out
- *	which driver would like to own it. If nobody claims the drive
- *	then it is automatically attached to the default driver used for
- *	unclaimed objects.
- *
- *	A return of zero indicates attachment to a driver, of one
- *	attachment to the default driver.
- *
- *	Takes drivers_lock.
- */
-
-int ata_attach(ide_drive_t *drive)
-{
-	struct list_head *p;
-	spin_lock(&drivers_lock);
-	list_for_each(p, &drivers) {
-		ide_driver_t *driver = list_entry(p, ide_driver_t, drivers);
-		if (!try_module_get(driver->owner))
-			continue;
-		spin_unlock(&drivers_lock);
-		if (driver->attach(drive) == 0) {
-			module_put(driver->owner);
-			drive->gendev.driver = &driver->gen_driver;
-			return 0;
-		}
-		spin_lock(&drivers_lock);
-		module_put(driver->owner);
-	}
-	drive->gendev.driver = NULL;
-	spin_unlock(&drivers_lock);
-	if (ide_register_subdriver(drive, NULL))
-		panic("ide: default attach failed");
-	return 1;
-}
-
 static int generic_ide_suspend(struct device *dev, pm_message_t state)
 {
 	ide_drive_t *drive = dev->driver_data;
@@ -2013,27 +1857,11 @@ static void __init probe_for_hwifs (void
 #endif
 }
 
-int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
+void ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	if (!drive->present || drive->driver != NULL ||
-	    drive->usage || drive->dead) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return 1;
-	}
-	drive->driver = driver;
-	spin_unlock_irqrestore(&ide_lock, flags);
-	spin_lock(&drives_lock);
-	list_add_tail(&drive->list, driver ? &driver->drives : &ide_drives);
-	spin_unlock(&drives_lock);
-//	printk(KERN_INFO "%s: attached %s driver.\n", drive->name, driver->name);
 #ifdef CONFIG_PROC_FS
-	if (driver)
-		ide_add_proc_entries(drive->proc, driver->proc, drive);
+	ide_add_proc_entries(drive->proc, driver->proc, drive);
 #endif
-	return 0;
 }
 
 EXPORT_SYMBOL(ide_register_subdriver);
@@ -2041,136 +1869,51 @@ EXPORT_SYMBOL(ide_register_subdriver);
 /**
  *	ide_unregister_subdriver	-	disconnect drive from driver
  *	@drive: drive to unplug
+ *	@driver: driver
  *
  *	Disconnect a drive from the driver it was attached to and then
  *	clean up the various proc files and other objects attached to it.
  *
- *	Takes ide_setting_sem, ide_lock and drives_lock.
+ *	Takes ide_setting_sem and ide_lock.
  *	Caller must hold none of the locks.
- *
- *	No locking versus subdriver unload because we are moving to the
- *	default driver anyway. Wants double checking.
  */
 
-int ide_unregister_subdriver (ide_drive_t *drive)
+void ide_unregister_subdriver(ide_drive_t *drive, ide_driver_t *driver)
 {
 	unsigned long flags;
 	
 	down(&ide_setting_sem);
 	spin_lock_irqsave(&ide_lock, flags);
-	if (drive->usage || drive->driver == NULL || DRIVER(drive)->busy) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		up(&ide_setting_sem);
-		return 1;
-	}
 #ifdef CONFIG_PROC_FS
-	ide_remove_proc_entries(drive->proc, DRIVER(drive)->proc);
+	ide_remove_proc_entries(drive->proc, driver->proc);
 #endif
 	auto_remove_settings(drive);
-	drive->driver = NULL;
 	spin_unlock_irqrestore(&ide_lock, flags);
 	up(&ide_setting_sem);
-	spin_lock(&drives_lock);
-	list_del_init(&drive->list);
-	spin_unlock(&drives_lock);
-	/* drive will be added to &ide_drives in ata_attach() */
-	return 0;
 }
 
 EXPORT_SYMBOL(ide_unregister_subdriver);
 
-static int ide_drive_remove(struct device * dev)
-{
-	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
-	DRIVER(drive)->cleanup(drive);
-	return 0;
-}
-
-/**
- *	ide_register_driver	-	register IDE device driver
- *	@driver: the IDE device driver
- *
- *	Register a new device driver and then scan the devices
- *	on the IDE bus in case any should be attached to the
- *	driver we have just registered.  If so attach them.
- *
- *	Takes drivers_lock and drives_lock.
- */
-
-int ide_register_driver(ide_driver_t *driver)
-{
-	struct list_head list;
-	struct list_head *list_loop;
-	struct list_head *tmp_storage;
-
-	spin_lock(&drivers_lock);
-	list_add(&driver->drivers, &drivers);
-	spin_unlock(&drivers_lock);
-
-	INIT_LIST_HEAD(&list);
-	spin_lock(&drives_lock);
-	list_splice_init(&ide_drives, &list);
-	spin_unlock(&drives_lock);
-
-	list_for_each_safe(list_loop, tmp_storage, &list) {
-		ide_drive_t *drive = container_of(list_loop, ide_drive_t, list);
-		list_del_init(&drive->list);
-		if (drive->present)
-			ata_attach(drive);
-	}
-	driver->gen_driver.name = (char *) driver->name;
-	driver->gen_driver.bus = &ide_bus_type;
-	driver->gen_driver.remove = ide_drive_remove;
-	return driver_register(&driver->gen_driver);
-}
-
-EXPORT_SYMBOL(ide_register_driver);
-
-/**
- *	ide_unregister_driver	-	unregister IDE device driver
- *	@driver: the IDE device driver
- *
- *	Called when a driver module is being unloaded. We reattach any
- *	devices to whatever driver claims them next (typically the default
- *	driver).
- *
- *	Takes drivers_lock and called functions will take ide_setting_sem.
- */
-
-void ide_unregister_driver(ide_driver_t *driver)
-{
-	ide_drive_t *drive;
-
-	spin_lock(&drivers_lock);
-	list_del(&driver->drivers);
-	spin_unlock(&drivers_lock);
-
-	driver_unregister(&driver->gen_driver);
-
-	while(!list_empty(&driver->drives)) {
-		drive = list_entry(driver->drives.next, ide_drive_t, list);
-		if (driver->cleanup(drive)) {
-			printk(KERN_ERR "%s: cleanup_module() called while still busy\n", drive->name);
-			BUG();
-		}
-		ata_attach(drive);
-	}
-}
-
-EXPORT_SYMBOL(ide_unregister_driver);
-
 /*
  * Probe module
  */
 
 EXPORT_SYMBOL(ide_lock);
 
+static int ide_bus_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
 struct bus_type ide_bus_type = {
 	.name		= "ide",
+	.match		= ide_bus_match,
 	.suspend	= generic_ide_suspend,
 	.resume		= generic_ide_resume,
 };
 
+EXPORT_SYMBOL_GPL(ide_bus_type);
+
 /*
  * This is gets invoked once during initialization, to set *everything* up
  */
diff -urp -X dontdiff linux-2.6.12-rc4/drivers/ide/ide-cd.c linux-2.6.12-rc4-ide/drivers/ide/ide-cd.c
--- linux-2.6.12-rc4/drivers/ide/ide-cd.c	2005-05-14 00:02:35.000000000 -0700
+++ linux-2.6.12-rc4-ide/drivers/ide/ide-cd.c	2005-05-14 09:54:34.000000000 -0700
@@ -3255,16 +3255,12 @@ sector_t ide_cdrom_capacity (ide_drive_t
 	return capacity * sectors_per_frame;
 }
 
-static
-int ide_cdrom_cleanup(ide_drive_t *drive)
+static int ide_cd_remove(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	struct cdrom_info *info = drive->driver_data;
 
-	if (ide_unregister_subdriver(drive)) {
-		printk(KERN_ERR "%s: %s: failed to ide_unregister_subdriver\n",
-			__FUNCTION__, drive->name);
-		return 1;
-	}
+	ide_unregister_subdriver(drive, info->driver);
 
 	del_gendisk(info->disk);
 
@@ -3297,7 +3293,7 @@ static void ide_cd_release(struct kref *
 	kfree(info);
 }
 
-static int ide_cdrom_attach (ide_drive_t *drive);
+static int ide_cd_probe(struct device *);
 
 #ifdef CONFIG_PROC_FS
 static int proc_idecd_read_capacity
@@ -3320,19 +3316,20 @@ static ide_proc_entry_t idecd_proc[] = {
 
 static ide_driver_t ide_cdrom_driver = {
 	.owner			= THIS_MODULE,
-	.name			= "ide-cdrom",
+	.gen_driver = {
+		.name		= "ide-cdrom",
+		.bus		= &ide_bus_type,
+		.probe		= ide_cd_probe,
+		.remove		= ide_cd_remove,
+	},
 	.version		= IDECD_VERSION,
 	.media			= ide_cdrom,
-	.busy			= 0,
 	.supports_dsc_overlap	= 1,
-	.cleanup		= ide_cdrom_cleanup,
 	.do_request		= ide_do_rw_cdrom,
 	.end_request		= ide_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idecd_proc,
-	.attach			= ide_cdrom_attach,
-	.drives			= LIST_HEAD_INIT(ide_cdrom_driver.drives),
 };
 
 static int idecd_open(struct inode * inode, struct file * file)
@@ -3418,8 +3415,9 @@ static char *ignore = NULL;
 module_param(ignore, charp, 0400);
 MODULE_DESCRIPTION("ATAPI CD-ROM Driver");
 
-static int ide_cdrom_attach (ide_drive_t *drive)
+static int ide_cd_probe(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	struct cdrom_info *info;
 	struct gendisk *g;
 	struct request_sense sense;
@@ -3453,11 +3451,8 @@ static int ide_cdrom_attach (ide_drive_t
 
 	ide_init_disk(g, drive);
 
-	if (ide_register_subdriver(drive, &ide_cdrom_driver)) {
-		printk(KERN_ERR "%s: Failed to register the driver with ide.c\n",
-			drive->name);
-		goto out_put_disk;
-	}
+	ide_register_subdriver(drive, &ide_cdrom_driver);
+
 	memset(info, 0, sizeof (struct cdrom_info));
 
 	kref_init(&info->kref);
@@ -3470,7 +3465,6 @@ static int ide_cdrom_attach (ide_drive_t
 
 	drive->driver_data = info;
 
-	DRIVER(drive)->busy++;
 	g->minors = 1;
 	snprintf(g->devfs_name, sizeof(g->devfs_name),
 			"%s/cd", drive->devfs_name);
@@ -3478,8 +3472,7 @@ static int ide_cdrom_attach (ide_drive_t
 	g->flags = GENHD_FL_CD | GENHD_FL_REMOVABLE;
 	if (ide_cdrom_setup(drive)) {
 		struct cdrom_device_info *devinfo = &info->devinfo;
-		DRIVER(drive)->busy--;
-		ide_unregister_subdriver(drive);
+		ide_unregister_subdriver(drive, &ide_cdrom_driver);
 		if (info->buffer != NULL)
 			kfree(info->buffer);
 		if (info->toc != NULL)
@@ -3492,7 +3485,6 @@ static int ide_cdrom_attach (ide_drive_t
 		drive->driver_data = NULL;
 		goto failed;
 	}
-	DRIVER(drive)->busy--;
 
 	cdrom_read_toc(drive, &sense);
 	g->fops = &idecd_ops;
@@ -3500,8 +3492,6 @@ static int ide_cdrom_attach (ide_drive_t
 	add_disk(g);
 	return 0;
 
-out_put_disk:
-	put_disk(g);
 out_free_cd:
 	kfree(info);
 failed:
@@ -3510,13 +3500,12 @@ failed:
 
 static void __exit ide_cdrom_exit(void)
 {
-	ide_unregister_driver(&ide_cdrom_driver);
+	driver_unregister(&ide_cdrom_driver.gen_driver);
 }
  
 static int ide_cdrom_init(void)
 {
-	ide_register_driver(&ide_cdrom_driver);
-	return 0;
+	return driver_register(&ide_cdrom_driver.gen_driver);
 }
 
 module_init(ide_cdrom_init);
diff -urp -X dontdiff linux-2.6.12-rc4/drivers/ide/ide-disk.c linux-2.6.12-rc4-ide/drivers/ide/ide-disk.c
--- linux-2.6.12-rc4/drivers/ide/ide-disk.c	2005-05-14 00:02:35.000000000 -0700
+++ linux-2.6.12-rc4-ide/drivers/ide/ide-disk.c	2005-05-14 09:48:06.000000000 -0700
@@ -1024,14 +1024,16 @@ static void ide_cacheflush_p(ide_drive_t
 		printk(KERN_INFO "%s: wcache flush failed!\n", drive->name);
 }
 
-static int idedisk_cleanup (ide_drive_t *drive)
+static int ide_disk_remove(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	struct ide_disk_obj *idkp = drive->driver_data;
 	struct gendisk *g = idkp->disk;
 
 	ide_cacheflush_p(drive);
-	if (ide_unregister_subdriver(drive))
-		return 1;
+
+	ide_unregister_subdriver(drive, idkp->driver);
+
 	del_gendisk(g);
 
 	ide_disk_put(idkp);
@@ -1052,7 +1054,7 @@ static void ide_disk_release(struct kref
 	kfree(idkp);
 }
 
-static int idedisk_attach(ide_drive_t *drive);
+static int ide_disk_probe(struct device *dev);
 
 static void ide_device_shutdown(struct device *dev)
 {
@@ -1082,27 +1084,23 @@ static void ide_device_shutdown(struct d
 	dev->bus->suspend(dev, PMSG_SUSPEND);
 }
 
-/*
- *      IDE subdriver functions, registered with ide.c
- */
 static ide_driver_t idedisk_driver = {
 	.owner			= THIS_MODULE,
 	.gen_driver = {
+		.name		= "ide-disk",
+		.bus		= &ide_bus_type,
+		.probe		= ide_disk_probe,
+		.remove		= ide_disk_remove,
 		.shutdown	= ide_device_shutdown,
 	},
-	.name			= "ide-disk",
 	.version		= IDEDISK_VERSION,
 	.media			= ide_disk,
-	.busy			= 0,
 	.supports_dsc_overlap	= 0,
-	.cleanup		= idedisk_cleanup,
 	.do_request		= ide_do_rw_disk,
 	.end_request		= ide_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idedisk_proc,
-	.attach			= idedisk_attach,
-	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
 };
 
 static int idedisk_open(struct inode *inode, struct file *filp)
@@ -1199,8 +1197,9 @@ static struct block_device_operations id
 
 MODULE_DESCRIPTION("ATA DISK Driver");
 
-static int idedisk_attach(ide_drive_t *drive)
+static int ide_disk_probe(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	struct ide_disk_obj *idkp;
 	struct gendisk *g;
 
@@ -1222,10 +1221,7 @@ static int idedisk_attach(ide_drive_t *d
 
 	ide_init_disk(g, drive);
 
-	if (ide_register_subdriver(drive, &idedisk_driver)) {
-		printk (KERN_ERR "ide-disk: %s: Failed to register the driver with ide.c\n", drive->name);
-		goto out_put_disk;
-	}
+	ide_register_subdriver(drive, &idedisk_driver);
 
 	memset(idkp, 0, sizeof(*idkp));
 
@@ -1239,7 +1235,6 @@ static int idedisk_attach(ide_drive_t *d
 
 	drive->driver_data = idkp;
 
-	DRIVER(drive)->busy++;
 	idedisk_setup(drive);
 	if ((!drive->head || drive->head > 16) && !drive->select.b.lba) {
 		printk(KERN_ERR "%s: INVALID GEOMETRY: %d PHYSICAL HEADS?\n",
@@ -1247,7 +1242,7 @@ static int idedisk_attach(ide_drive_t *d
 		drive->attach = 0;
 	} else
 		drive->attach = 1;
-	DRIVER(drive)->busy--;
+
 	g->minors = 1 << PARTN_BITS;
 	strcpy(g->devfs_name, drive->devfs_name);
 	g->driverfs_dev = &drive->gendev;
@@ -1257,8 +1252,6 @@ static int idedisk_attach(ide_drive_t *d
 	add_disk(g);
 	return 0;
 
-out_put_disk:
-	put_disk(g);
 out_free_idkp:
 	kfree(idkp);
 failed:
@@ -1267,12 +1260,12 @@ failed:
 
 static void __exit idedisk_exit (void)
 {
-	ide_unregister_driver(&idedisk_driver);
+	driver_unregister(&idedisk_driver.gen_driver);
 }
 
 static int idedisk_init (void)
 {
-	return ide_register_driver(&idedisk_driver);
+	return driver_register(&idedisk_driver.gen_driver);
 }
 
 module_init(idedisk_init);
diff -urp -X dontdiff linux-2.6.12-rc4/drivers/ide/ide-floppy.c linux-2.6.12-rc4-ide/drivers/ide/ide-floppy.c
--- linux-2.6.12-rc4/drivers/ide/ide-floppy.c	2005-05-14 00:02:35.000000000 -0700
+++ linux-2.6.12-rc4-ide/drivers/ide/ide-floppy.c	2005-05-14 09:48:06.000000000 -0700
@@ -1865,13 +1865,13 @@ static void idefloppy_setup (ide_drive_t
 	idefloppy_add_settings(drive);
 }
 
-static int idefloppy_cleanup (ide_drive_t *drive)
+static int ide_floppy_remove(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	idefloppy_floppy_t *floppy = drive->driver_data;
 	struct gendisk *g = floppy->disk;
 
-	if (ide_unregister_subdriver(drive))
-		return 1;
+	ide_unregister_subdriver(drive, floppy->driver);
 
 	del_gendisk(g);
 
@@ -1916,26 +1916,24 @@ static ide_proc_entry_t idefloppy_proc[]
 
 #endif	/* CONFIG_PROC_FS */
 
-static int idefloppy_attach(ide_drive_t *drive);
+static int ide_floppy_probe(struct device *);
 
-/*
- *	IDE subdriver functions, registered with ide.c
- */
 static ide_driver_t idefloppy_driver = {
 	.owner			= THIS_MODULE,
-	.name			= "ide-floppy",
+	.gen_driver = {
+		.name		= "ide-floppy",
+		.bus		= &ide_bus_type,
+		.probe		= ide_floppy_probe,
+		.remove		= ide_floppy_remove,
+	},
 	.version		= IDEFLOPPY_VERSION,
 	.media			= ide_floppy,
-	.busy			= 0,
 	.supports_dsc_overlap	= 0,
-	.cleanup		= idefloppy_cleanup,
 	.do_request		= idefloppy_do_request,
 	.end_request		= idefloppy_do_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idefloppy_proc,
-	.attach			= idefloppy_attach,
-	.drives			= LIST_HEAD_INIT(idefloppy_driver.drives),
 };
 
 static int idefloppy_open(struct inode *inode, struct file *filp)
@@ -2122,8 +2120,9 @@ static struct block_device_operations id
 	.revalidate_disk= idefloppy_revalidate_disk
 };
 
-static int idefloppy_attach (ide_drive_t *drive)
+static int ide_floppy_probe(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	idefloppy_floppy_t *floppy;
 	struct gendisk *g;
 
@@ -2152,10 +2151,7 @@ static int idefloppy_attach (ide_drive_t
 
 	ide_init_disk(g, drive);
 
-	if (ide_register_subdriver(drive, &idefloppy_driver)) {
-		printk (KERN_ERR "ide-floppy: %s: Failed to register the driver with ide.c\n", drive->name);
-		goto out_put_disk;
-	}
+	ide_register_subdriver(drive, &idefloppy_driver);
 
 	memset(floppy, 0, sizeof(*floppy));
 
@@ -2169,9 +2165,8 @@ static int idefloppy_attach (ide_drive_t
 
 	drive->driver_data = floppy;
 
-	DRIVER(drive)->busy++;
 	idefloppy_setup (drive, floppy);
-	DRIVER(drive)->busy--;
+
 	g->minors = 1 << PARTN_BITS;
 	g->driverfs_dev = &drive->gendev;
 	strcpy(g->devfs_name, drive->devfs_name);
@@ -2181,8 +2176,6 @@ static int idefloppy_attach (ide_drive_t
 	add_disk(g);
 	return 0;
 
-out_put_disk:
-	put_disk(g);
 out_free_floppy:
 	kfree(floppy);
 failed:
@@ -2193,7 +2186,7 @@ MODULE_DESCRIPTION("ATAPI FLOPPY Driver"
 
 static void __exit idefloppy_exit (void)
 {
-	ide_unregister_driver(&idefloppy_driver);
+	driver_unregister(&idefloppy_driver.gen_driver);
 }
 
 /*
@@ -2202,8 +2195,7 @@ static void __exit idefloppy_exit (void)
 static int idefloppy_init (void)
 {
 	printk("ide-floppy driver " IDEFLOPPY_VERSION "\n");
-	ide_register_driver(&idefloppy_driver);
-	return 0;
+	return driver_register(&idefloppy_driver.gen_driver);
 }
 
 module_init(idefloppy_init);
diff -urp -X dontdiff linux-2.6.12-rc4/drivers/ide/ide-probe.c linux-2.6.12-rc4-ide/drivers/ide/ide-probe.c
--- linux-2.6.12-rc4/drivers/ide/ide-probe.c	2005-05-14 00:02:35.000000000 -0700
+++ linux-2.6.12-rc4-ide/drivers/ide/ide-probe.c	2005-05-14 09:48:06.000000000 -0700
@@ -47,6 +47,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
+#include <linux/devfs_fs_kernel.h>
 #include <linux/spinlock.h>
 #include <linux/kmod.h>
 #include <linux/pci.h>
@@ -918,7 +919,7 @@ int probe_hwif_init_with_fixup(ide_hwif_
 			   want them on default or a new "empty" class
 			   for hotplug reprobing ? */
 			if (drive->present) {
-				ata_attach(drive);
+				device_register(&drive->gendev);
 			}
 		}
 	}
@@ -1279,10 +1280,51 @@ void ide_init_disk(struct gendisk *disk,
 
 EXPORT_SYMBOL_GPL(ide_init_disk);
 
+static void ide_remove_drive_from_hwgroup(ide_drive_t *drive)
+{
+	ide_hwgroup_t *hwgroup = drive->hwif->hwgroup;
+
+	if (drive == drive->next) {
+		/* special case: last drive from hwgroup. */
+		BUG_ON(hwgroup->drive != drive);
+		hwgroup->drive = NULL;
+	} else {
+		ide_drive_t *walk;
+
+		walk = hwgroup->drive;
+		while (walk->next != drive)
+			walk = walk->next;
+		walk->next = drive->next;
+		if (hwgroup->drive == drive) {
+			hwgroup->drive = drive->next;
+			hwgroup->hwif = hwgroup->drive->hwif;
+		}
+	}
+	BUG_ON(hwgroup->drive == drive);
+}
+
 static void drive_release_dev (struct device *dev)
 {
 	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
 
+	spin_lock_irq(&ide_lock);
+	if (drive->devfs_name[0] != '\0') {
+		devfs_remove(drive->devfs_name);
+		drive->devfs_name[0] = '\0';
+	}
+	ide_remove_drive_from_hwgroup(drive);
+	if (drive->id != NULL) {
+		kfree(drive->id);
+		drive->id = NULL;
+	}
+	drive->present = 0;
+	/* Messed up locking ... */
+	spin_unlock_irq(&ide_lock);
+	blk_cleanup_queue(drive->queue);
+	spin_lock_irq(&ide_lock);
+	drive->queue = NULL;
+	spin_unlock_irq(&ide_lock);
+
 	up(&drive->gendev_rel_sem);
 }
 
@@ -1306,7 +1348,6 @@ static void init_gendisk (ide_hwif_t *hw
 		drive->gendev.driver_data = drive;
 		drive->gendev.release = drive_release_dev;
 		if (drive->present) {
-			device_register(&drive->gendev);
 			sprintf(drive->devfs_name, "ide/host%d/bus%d/target%d/lun%d",
 				(hwif->channel && hwif->mate) ?
 				hwif->mate->index : hwif->index,
@@ -1412,7 +1453,7 @@ int ideprobe_init (void)
 				hwif->chipset = ide_generic;
 			for (unit = 0; unit < MAX_DRIVES; ++unit)
 				if (hwif->drives[unit].present)
-					ata_attach(&hwif->drives[unit]);
+					device_register(&hwif->drives[unit].gendev);
 		}
 	}
 	return 0;
diff -urp -X dontdiff linux-2.6.12-rc4/drivers/ide/ide-proc.c linux-2.6.12-rc4-ide/drivers/ide/ide-proc.c
--- linux-2.6.12-rc4/drivers/ide/ide-proc.c	2005-05-14 00:02:35.000000000 -0700
+++ linux-2.6.12-rc4-ide/drivers/ide/ide-proc.c	2005-05-14 09:48:06.000000000 -0700
@@ -307,17 +307,41 @@ static int proc_ide_read_driver
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t	*driver = drive->driver;
+	struct device	*dev = &drive->gendev;
+	ide_driver_t	*ide_drv;
 	int		len;
 
-	if (driver) {
+	down_read(&dev->bus->subsys.rwsem);
+	if (dev->driver) {
+		ide_drv = container_of(dev->driver, ide_driver_t, gen_driver);
 		len = sprintf(page, "%s version %s\n",
-				driver->name, driver->version);
+				dev->driver->name, ide_drv->version);
 	} else
 		len = sprintf(page, "ide-default version 0.9.newide\n");
+	up_read(&dev->bus->subsys.rwsem);
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
+static int ide_replace_subdriver(ide_drive_t *drive, const char *driver)
+{
+	struct device *dev = &drive->gendev;
+	int ret = 1;
+
+	down_write(&dev->bus->subsys.rwsem);
+	device_release_driver(dev);
+	/* FIXME: device can still be in use by previous driver */
+	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
+	device_attach(dev);
+	drive->driver_req[0] = 0;
+	if (dev->driver == NULL)
+		device_attach(dev);
+	if (dev->driver && !strcmp(dev->driver->name, driver))
+		ret = 0;
+	up_write(&dev->bus->subsys.rwsem);
+
+	return ret;
+}
+
 static int proc_ide_write_driver
 	(struct file *file, const char __user *buffer, unsigned long count, void *data)
 {
@@ -488,16 +512,32 @@ void destroy_proc_ide_interface(ide_hwif
 	}
 }
 
-extern struct seq_operations ide_drivers_op;
+static int proc_print_driver(struct device_driver *drv, void *data)
+{
+	ide_driver_t *ide_drv = container_of(drv, ide_driver_t, gen_driver);
+	struct seq_file *s = data;
+
+	seq_printf(s, "%s version %s\n", drv->name, ide_drv->version);
+
+	return 0;
+}
+
+static int ide_drivers_show(struct seq_file *s, void *p)
+{
+	bus_for_each_drv(&ide_bus_type, NULL, s, proc_print_driver);
+	return 0;
+}
+
 static int ide_drivers_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ide_drivers_op);
+	return single_open(file, &ide_drivers_show, NULL);
 }
+
 static struct file_operations ide_drivers_operations = {
 	.open		= ide_drivers_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= single_release,
 };
 
 void proc_ide_create(void)
diff -urp -X dontdiff linux-2.6.12-rc4/drivers/ide/ide-tape.c linux-2.6.12-rc4-ide/drivers/ide/ide-tape.c
--- linux-2.6.12-rc4/drivers/ide/ide-tape.c	2005-05-14 00:02:35.000000000 -0700
+++ linux-2.6.12-rc4-ide/drivers/ide/ide-tape.c	2005-05-14 09:48:06.000000000 -0700
@@ -4681,21 +4681,12 @@ static void idetape_setup (ide_drive_t *
 	idetape_add_settings(drive);
 }
 
-static int idetape_cleanup (ide_drive_t *drive)
+static int ide_tape_remove(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	idetape_tape_t *tape = drive->driver_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
-	if (test_bit(IDETAPE_BUSY, &tape->flags) || drive->usage ||
-	    tape->first_stage != NULL || tape->merge_stage_size) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return 1;
-	}
-
-	spin_unlock_irqrestore(&ide_lock, flags);
-	DRIVER(drive)->busy = 0;
-	(void) ide_unregister_subdriver(drive);
+	ide_unregister_subdriver(drive, tape->driver);
 
 	ide_unregister_region(tape->disk);
 
@@ -4710,6 +4701,8 @@ static void ide_tape_release(struct kref
 	ide_drive_t *drive = tape->drive;
 	struct gendisk *g = tape->disk;
 
+	BUG_ON(tape->first_stage != NULL || tape->merge_stage_size);
+
 	drive->dsc_overlap = 0;
 	drive->driver_data = NULL;
 	devfs_remove("%s/mt", drive->devfs_name);
@@ -4747,26 +4740,24 @@ static ide_proc_entry_t idetape_proc[] =
 
 #endif
 
-static int idetape_attach(ide_drive_t *drive);
+static int ide_tape_probe(struct device *);
 
-/*
- *	IDE subdriver functions, registered with ide.c
- */
 static ide_driver_t idetape_driver = {
 	.owner			= THIS_MODULE,
-	.name			= "ide-tape",
+	.gen_driver = {
+		.name		= "ide-tape",
+		.bus		= &ide_bus_type,
+		.probe		= ide_tape_probe,
+		.remove		= ide_tape_remove,
+	},
 	.version		= IDETAPE_VERSION,
 	.media			= ide_tape,
-	.busy			= 1,
 	.supports_dsc_overlap 	= 1,
-	.cleanup		= idetape_cleanup,
 	.do_request		= idetape_do_request,
 	.end_request		= idetape_end_request,
 	.error			= __ide_error,
 	.abort			= __ide_abort,
 	.proc			= idetape_proc,
-	.attach			= idetape_attach,
-	.drives			= LIST_HEAD_INIT(idetape_driver.drives),
 };
 
 /*
@@ -4829,8 +4820,9 @@ static struct block_device_operations id
 	.ioctl		= idetape_ioctl,
 };
 
-static int idetape_attach (ide_drive_t *drive)
+static int ide_tape_probe(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	idetape_tape_t *tape;
 	struct gendisk *g;
 	int minor;
@@ -4865,10 +4857,7 @@ static int idetape_attach (ide_drive_t *
 
 	ide_init_disk(g, drive);
 
-	if (ide_register_subdriver(drive, &idetape_driver)) {
-		printk(KERN_ERR "ide-tape: %s: Failed to register the driver with ide.c\n", drive->name);
-		goto out_put_disk;
-	}
+	ide_register_subdriver(drive, &idetape_driver);
 
 	memset(tape, 0, sizeof(*tape));
 
@@ -4902,8 +4891,7 @@ static int idetape_attach (ide_drive_t *
 	ide_register_region(g);
 
 	return 0;
-out_put_disk:
-	put_disk(g);
+
 out_free_tape:
 	kfree(tape);
 failed:
@@ -4915,7 +4903,7 @@ MODULE_LICENSE("GPL");
 
 static void __exit idetape_exit (void)
 {
-	ide_unregister_driver(&idetape_driver);
+	driver_unregister(&idetape_driver.gen_driver);
 	unregister_chrdev(IDETAPE_MAJOR, "ht");
 }
 
@@ -4928,8 +4916,7 @@ static int idetape_init (void)
 		printk(KERN_ERR "ide-tape: Failed to register character device interface\n");
 		return -EBUSY;
 	}
-	ide_register_driver(&idetape_driver);
-	return 0;
+	return driver_register(&idetape_driver.gen_driver);
 }
 
 module_init(idetape_init);
diff -urp -X dontdiff linux-2.6.12-rc4/drivers/scsi/ide-scsi.c linux-2.6.12-rc4-ide/drivers/scsi/ide-scsi.c
--- linux-2.6.12-rc4/drivers/scsi/ide-scsi.c	2005-05-14 00:02:44.000000000 -0700
+++ linux-2.6.12-rc4-ide/drivers/scsi/ide-scsi.c	2005-05-14 09:48:06.000000000 -0700
@@ -713,7 +713,6 @@ static void idescsi_add_settings(ide_dri
  */
 static void idescsi_setup (ide_drive_t *drive, idescsi_scsi_t *scsi)
 {
-	DRIVER(drive)->busy++;
 	if (drive->id && (drive->id->config & 0x0060) == 0x20)
 		set_bit (IDESCSI_DRQ_INTERRUPT, &scsi->flags);
 	set_bit(IDESCSI_TRANSFORM, &scsi->transform);
@@ -722,17 +721,16 @@ static void idescsi_setup (ide_drive_t *
 	set_bit(IDESCSI_LOG_CMD, &scsi->log);
 #endif /* IDESCSI_DEBUG_LOG */
 	idescsi_add_settings(drive);
-	DRIVER(drive)->busy--;
 }
 
-static int idescsi_cleanup (ide_drive_t *drive)
+static int ide_scsi_remove(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	struct Scsi_Host *scsihost = drive->driver_data;
 	struct ide_scsi_obj *scsi = scsihost_to_idescsi(scsihost);
 	struct gendisk *g = scsi->disk;
 
-	if (ide_unregister_subdriver(drive))
-		return 1;
+	ide_unregister_subdriver(drive, scsi->driver);
 
 	ide_unregister_region(g);
 
@@ -746,7 +744,7 @@ static int idescsi_cleanup (ide_drive_t 
 	return 0;
 }
 
-static int idescsi_attach(ide_drive_t *drive);
+static int ide_scsi_probe(struct device *);
 
 #ifdef CONFIG_PROC_FS
 static ide_proc_entry_t idescsi_proc[] = {
@@ -757,24 +755,22 @@ static ide_proc_entry_t idescsi_proc[] =
 # define idescsi_proc	NULL
 #endif
 
-/*
- *	IDE subdriver functions, registered with ide.c
- */
 static ide_driver_t idescsi_driver = {
 	.owner			= THIS_MODULE,
-	.name			= "ide-scsi",
+	.gen_driver = {
+		.name		= "ide-scsi",
+		.bus		= &ide_bus_type,
+		.probe		= ide_scsi_probe,
+		.remove		= ide_scsi_remove,
+	},
 	.version		= IDESCSI_VERSION,
 	.media			= ide_scsi,
-	.busy			= 0,
 	.supports_dsc_overlap	= 0,
 	.proc			= idescsi_proc,
-	.attach			= idescsi_attach,
-	.cleanup		= idescsi_cleanup,
 	.do_request		= idescsi_do_request,
 	.end_request		= idescsi_end_request,
 	.error                  = idescsi_atapi_error,
 	.abort                  = idescsi_atapi_abort,
-	.drives			= LIST_HEAD_INIT(idescsi_driver.drives),
 };
 
 static int idescsi_ide_open(struct inode *inode, struct file *filp)
@@ -821,8 +817,6 @@ static struct block_device_operations id
 	.ioctl		= idescsi_ide_ioctl,
 };
 
-static int idescsi_attach(ide_drive_t *drive);
-
 static int idescsi_slave_configure(struct scsi_device * sdp)
 {
 	/* Configure detected device */
@@ -1095,8 +1089,9 @@ static struct scsi_host_template idescsi
 	.proc_name		= "ide-scsi",
 };
 
-static int idescsi_attach(ide_drive_t *drive)
+static int ide_scsi_probe(struct device *dev)
 {
+	ide_drive_t *drive = to_ide_device(dev);
 	idescsi_scsi_t *idescsi;
 	struct Scsi_Host *host;
 	struct gendisk *g;
@@ -1138,7 +1133,8 @@ static int idescsi_attach(ide_drive_t *d
 	idescsi->host = host;
 	idescsi->disk = g;
 	g->private_data = &idescsi->driver;
-	err = ide_register_subdriver(drive, &idescsi_driver);
+	ide_register_subdriver(drive, &idescsi_driver);
+	err = 0;
 	if (!err) {
 		idescsi_setup (drive, idescsi);
 		g->fops = &idescsi_ops;
@@ -1150,7 +1146,7 @@ static int idescsi_attach(ide_drive_t *d
 		}
 		/* fall through on error */
 		ide_unregister_region(g);
-		ide_unregister_subdriver(drive);
+		ide_unregister_subdriver(drive, &idescsi_driver);
 	}
 
 	put_disk(g);
@@ -1161,12 +1157,12 @@ out_host_put:
 
 static int __init init_idescsi_module(void)
 {
-	return ide_register_driver(&idescsi_driver);
+	return driver_register(&idescsi_driver.gen_driver);
 }
 
 static void __exit exit_idescsi_module(void)
 {
-	ide_unregister_driver(&idescsi_driver);
+	driver_unregister(&idescsi_driver.gen_driver);
 }
 
 module_init(init_idescsi_module);
diff -urp -X dontdiff linux-2.6.12-rc4/include/linux/ide.h linux-2.6.12-rc4-ide/include/linux/ide.h
--- linux-2.6.12-rc4/include/linux/ide.h	2005-05-14 00:03:02.000000000 -0700
+++ linux-2.6.12-rc4-ide/include/linux/ide.h	2005-05-14 09:48:06.000000000 -0700
@@ -664,7 +664,6 @@ typedef struct ide_drive_s {
 
 	struct request		*rq;	/* current request */
 	struct ide_drive_s 	*next;	/* circular list of hwgroup drives */
-	struct ide_driver_s	*driver;/* (ide_driver_t *) */
 	void		*driver_data;	/* extra driver data */
 	struct hd_driveid	*id;	/* drive model identification info */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
@@ -758,6 +757,8 @@ typedef struct ide_drive_s {
 	struct semaphore gendev_rel_sem;	/* to deal with device release() */
 } ide_drive_t;
 
+#define to_ide_device(dev)container_of(dev, ide_drive_t, gendev)
+
 #define IDE_CHIPSET_PCI_MASK	\
     ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
 #define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
@@ -1086,28 +1087,20 @@ enum {
  */
 typedef struct ide_driver_s {
 	struct module			*owner;
-	const char			*name;
 	const char			*version;
 	u8				media;
-	unsigned busy			: 1;
 	unsigned supports_dsc_overlap	: 1;
-	int		(*cleanup)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, sector_t);
 	int		(*end_request)(ide_drive_t *, int, int);
 	ide_startstop_t	(*error)(ide_drive_t *, struct request *rq, u8, u8);
 	ide_startstop_t	(*abort)(ide_drive_t *, struct request *rq);
 	int		(*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
 	ide_proc_entry_t	*proc;
-	int		(*attach)(ide_drive_t *);
 	void		(*ata_prebuilder)(ide_drive_t *);
 	void		(*atapi_prebuilder)(ide_drive_t *);
 	struct device_driver	gen_driver;
-	struct list_head drives;
-	struct list_head drivers;
 } ide_driver_t;
 
-#define DRIVER(drive)		((drive)->driver)
-
 int generic_ide_ioctl(ide_drive_t *, struct file *, struct block_device *, unsigned, unsigned long);
 
 /*
@@ -1328,8 +1321,6 @@ extern void ide_init_subdrivers(void);
 
 void ide_init_disk(struct gendisk *, ide_drive_t *);
 
-extern int ata_attach(ide_drive_t *);
-
 extern int ideprobe_init(void);
 
 extern void ide_scan_pcibus(int scan_direction) __init;
@@ -1342,11 +1333,8 @@ extern void default_hwif_iops(ide_hwif_t
 extern void default_hwif_mmiops(ide_hwif_t *);
 extern void default_hwif_transport(ide_hwif_t *);
 
-int ide_register_driver(ide_driver_t *driver);
-void ide_unregister_driver(ide_driver_t *driver);
-int ide_register_subdriver(ide_drive_t *, ide_driver_t *);
-int ide_unregister_subdriver (ide_drive_t *drive);
-int ide_replace_subdriver(ide_drive_t *drive, const char *driver);
+void ide_register_subdriver(ide_drive_t *, ide_driver_t *);
+void ide_unregister_subdriver(ide_drive_t *, ide_driver_t *);
 
 #define ON_BOARD		1
 #define NEVER_BOARD		0
