Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751642AbVJMTZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbVJMTZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbVJMTZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:25:56 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:64643 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751659AbVJMTZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:25:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=hMBSq2F57BrAKGed/2oiRSJw7Nzz6chZGKpLLUgeKc0MJD++UMOS9MOuVxng6aAths9TVxZ3InX/5I5VQkAlvq4OBYcJUnmjZWaoiGmJVUSrDtcGlpjidpER+rIexseAsbg/t+BYx7iGd6y+jzC8ZTelmFinQv6uJdN3gqihqTo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Date: Thu, 13 Oct 2005 21:28:44 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       iss_storagedev@hp.com, Jakub Jelinek <jj@ultra.linux.cz>,
       Frodo Looijaard <frodol@dds.nl>, Jean Delvare <khali@linux-fr.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Roland Dreier <rolandd@cisco.com>,
       Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pierre Ossman <drzeus-wbsd@drzeus.cx>,
       Carsten Gross <carsten@sol.wh-hms.uni-ulm.de>,
       "Greg Kroah-Hartman" <greg@kroah.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Vinh Truong <vinh.truong@eng.sun.com>,
       Mark Douglas Corner <mcorner@umich.edu>,
       Michael Downey <downey@zymeta.com>, Antonino Daplas <adaplas@pol.net>,
       Ben Gardner <bgardner@wabtec.com>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132128.45171.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the remaining misc drivers/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in misc files in drivers/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 drivers/acpi/container.c              |    6 ++----
 drivers/acpi/scan.c                   |    6 ++----
 drivers/acpi/video.c                  |   12 ++++--------
 drivers/block/DAC960.c                |   31 +++++++++++--------------------
 drivers/block/cciss.c                 |   12 ++++--------
 drivers/fc4/fc.c                      |    5 ++---
 drivers/hwmon/w83781d.c               |    6 ++----
 drivers/i2c/busses/i2c-amd756-s4882.c |    6 ++----
 drivers/ide/ide-cd.c                  |   18 ++++++------------
 drivers/ide/ide-probe.c               |    6 ++----
 drivers/ide/ide-taskfile.c            |    6 ++----
 drivers/ide/ide.c                     |    3 +--
 drivers/infiniband/core/mad.c         |    6 ++----
 drivers/input/misc/uinput.c           |   10 +++-------
 drivers/macintosh/adbhid.c            |    3 +--
 drivers/mmc/wbsd.c                    |    3 +--
 drivers/parport/probe.c               |   21 ++++++++++-----------
 drivers/parport/share.c               |   19 +++++++------------
 drivers/pci/hotplug/cpqphp_pci.c      |   15 +++++----------
 drivers/pcmcia/cistpl.c               |   12 ++++--------
 drivers/pcmcia/cs.c                   |    6 ++----
 drivers/sbus/char/envctrl.c           |   13 +++++--------
 drivers/usb/class/bluetty.c           |   18 ++++++------------
 drivers/usb/input/keyspan_remote.c    |    3 +--
 drivers/video/i810/i810_main.c        |    3 +--
 drivers/w1/w1_ds2433.c                |    6 ++----
 26 files changed, 90 insertions(+), 165 deletions(-)

--- linux-2.6.14-rc4-orig/drivers/w1/w1_ds2433.c	2005-10-11 22:41:21.000000000 +0200
+++ linux-2.6.14-rc4/drivers/w1/w1_ds2433.c	2005-10-12 15:39:04.000000000 +0200
@@ -299,10 +299,8 @@ static int w1_f23_add_slave(struct w1_sl
 static void w1_f23_remove_slave(struct w1_slave *sl)
 {
 #ifdef CONFIG_W1_F23_CRC
-	if (sl->family_data) {
-		kfree(sl->family_data);
-		sl->family_data = NULL;
-	}
+	kfree(sl->family_data);
+	sl->family_data = NULL;
 #endif	/* CONFIG_W1_F23_CRC */
 	sysfs_remove_bin_file(&sl->dev.kobj, &w1_f23_bin_attr);
 }
--- linux-2.6.14-rc4-orig/drivers/i2c/busses/i2c-amd756-s4882.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/busses/i2c-amd756-s4882.c	2005-10-12 15:39:24.000000000 +0200
@@ -245,10 +245,8 @@ static void __exit amd756_s4882_exit(voi
 		kfree(s4882_adapter);
 		s4882_adapter = NULL;
 	}
-	if (s4882_algo) {
-		kfree(s4882_algo);
-		s4882_algo = NULL;
-	}
+	kfree(s4882_algo);
+	s4882_algo = NULL;
 
 	/* Restore physical bus */
 	if (i2c_add_adapter(&amd756_smbus))
--- linux-2.6.14-rc4-orig/drivers/fc4/fc.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/fc4/fc.c	2005-10-12 15:40:40.000000000 +0200
@@ -558,8 +558,8 @@ int fcp_initialize(fc_channel *fcchain, 
 	l->logi = kmalloc (count * 3 * sizeof(logi), GFP_KERNEL);
 	l->fcmds = kmalloc (count * sizeof(fcp_cmnd), GFP_KERNEL);
 	if (!l->logi || !l->fcmds) {
-		if (l->logi) kfree (l->logi);
-		if (l->fcmds) kfree (l->fcmds);
+		kfree (l->logi);
+		kfree (l->fcmds);
 		kfree (l);
 		printk ("FC: Cannot allocate DMA memory for initialization\n");
 		return -ENOMEM;
@@ -680,7 +680,6 @@ int fcp_forceoffline(fc_channel *fcchain
 	atomic_set (&l.todo, count);
 	l.fcmds = kmalloc (count * sizeof(fcp_cmnd), GFP_KERNEL);
 	if (!l.fcmds) {
-		kfree (l.fcmds);
 		printk ("FC: Cannot allocate memory for forcing offline\n");
 		return -ENOMEM;
 	}
--- linux-2.6.14-rc4-orig/drivers/ide/ide.c	2005-10-11 22:41:09.000000000 +0200
+++ linux-2.6.14-rc4/drivers/ide/ide.c	2005-10-12 15:41:05.000000000 +0200
@@ -889,8 +889,7 @@ static int __ide_add_setting(ide_drive_t
 	return 0;
 abort:
 	up(&ide_setting_sem);
-	if (setting)
-		kfree(setting);
+	kfree(setting);
 	return -1;
 }
 
--- linux-2.6.14-rc4-orig/drivers/ide/ide-cd.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/ide/ide-cd.c	2005-10-12 15:41:53.000000000 +0200
@@ -3286,12 +3286,9 @@ static void ide_cd_release(struct kref *
 	ide_drive_t *drive = info->drive;
 	struct gendisk *g = info->disk;
 
-	if (info->buffer != NULL)
-		kfree(info->buffer);
-	if (info->toc != NULL)
-		kfree(info->toc);
-	if (info->changer_info != NULL)
-		kfree(info->changer_info);
+	kfree(info->buffer);
+	kfree(info->toc);
+	kfree(info->changer_info);
 	if (devinfo->handle == drive && unregister_cdrom(devinfo))
 		printk(KERN_ERR "%s: %s failed to unregister device from the cdrom "
 				"driver.\n", __FUNCTION__, drive->name);
@@ -3483,12 +3480,9 @@ static int ide_cd_probe(struct device *d
 	if (ide_cdrom_setup(drive)) {
 		struct cdrom_device_info *devinfo = &info->devinfo;
 		ide_unregister_subdriver(drive, &ide_cdrom_driver);
-		if (info->buffer != NULL)
-			kfree(info->buffer);
-		if (info->toc != NULL)
-			kfree(info->toc);
-		if (info->changer_info != NULL)
-			kfree(info->changer_info);
+		kfree(info->buffer);
+		kfree(info->toc);
+		kfree(info->changer_info);
 		if (devinfo->handle == drive && unregister_cdrom(devinfo))
 			printk (KERN_ERR "%s: ide_cdrom_cleanup failed to unregister device from the cdrom driver.\n", drive->name);
 		kfree(info);
--- linux-2.6.14-rc4-orig/drivers/ide/ide-taskfile.c	2005-10-11 22:41:09.000000000 +0200
+++ linux-2.6.14-rc4/drivers/ide/ide-taskfile.c	2005-10-12 15:42:15.000000000 +0200
@@ -649,10 +649,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	}
 abort:
 	kfree(req_task);
-	if (outbuf != NULL)
-		kfree(outbuf);
-	if (inbuf != NULL)
-		kfree(inbuf);
+	kfree(outbuf);
+	kfree(inbuf);
 
 //	printk("IDE Taskfile ioctl ended. rc = %i\n", err);
 
--- linux-2.6.14-rc4-orig/drivers/ide/ide-probe.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/ide/ide-probe.c	2005-10-12 15:42:40.000000000 +0200
@@ -1316,10 +1316,8 @@ static void drive_release_dev (struct de
 		drive->devfs_name[0] = '\0';
 	}
 	ide_remove_drive_from_hwgroup(drive);
-	if (drive->id != NULL) {
-		kfree(drive->id);
-		drive->id = NULL;
-	}
+	kfree(drive->id);
+	drive->id = NULL;
 	drive->present = 0;
 	/* Messed up locking ... */
 	spin_unlock_irq(&ide_lock);
--- linux-2.6.14-rc4-orig/drivers/mmc/wbsd.c	2005-10-11 22:41:10.000000000 +0200
+++ linux-2.6.14-rc4/drivers/mmc/wbsd.c	2005-10-12 15:43:04.000000000 +0200
@@ -1595,8 +1595,7 @@ static void __devexit wbsd_release_dma(s
 	if (host->dma_addr)
 		dma_unmap_single(host->mmc->dev, host->dma_addr, WBSD_DMA_SIZE,
 			DMA_BIDIRECTIONAL);
-	if (host->dma_buffer)
-		kfree(host->dma_buffer);
+	kfree(host->dma_buffer);
 	if (host->dma >= 0)
 		free_dma(host->dma);
 
--- linux-2.6.14-rc4-orig/drivers/pci/hotplug/cpqphp_pci.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/pci/hotplug/cpqphp_pci.c	2005-10-12 16:27:34.000000000 +0200
@@ -259,8 +259,7 @@ static int PCI_GetBusDevHelper(struct co
 	       sizeof(struct irq_routing_table)) / sizeof(struct irq_info);
 	// Make sure I got at least one entry
 	if (len == 0) {
-		if (PCIIRQRoutingInfoLength != NULL)
-			kfree(PCIIRQRoutingInfoLength );
+		kfree(PCIIRQRoutingInfoLength );
 		return -1;
 	}
 
@@ -275,8 +274,7 @@ static int PCI_GetBusDevHelper(struct co
 			ctrl->pci_bus->number = tbus;
 			pci_bus_read_config_dword (ctrl->pci_bus, *dev_num, PCI_VENDOR_ID, &work);
 			if (!nobridge || (work == 0xffffffff)) {
-				if (PCIIRQRoutingInfoLength != NULL)
-					kfree(PCIIRQRoutingInfoLength );
+				kfree(PCIIRQRoutingInfoLength );
 				return 0;
 			}
 
@@ -289,20 +287,17 @@ static int PCI_GetBusDevHelper(struct co
 				dbg("Scan bus for Non Bridge: bus %d\n", tbus);
 				if (PCI_ScanBusForNonBridge(ctrl, tbus, dev_num) == 0) {
 					*bus_num = tbus;
-					if (PCIIRQRoutingInfoLength != NULL)
-						kfree(PCIIRQRoutingInfoLength );
+					kfree(PCIIRQRoutingInfoLength );
 					return 0;
 				}
 			} else {
-				if (PCIIRQRoutingInfoLength != NULL)
-					kfree(PCIIRQRoutingInfoLength );
+				kfree(PCIIRQRoutingInfoLength );
 				return 0;
 			}
 
 		}
 	}
-	if (PCIIRQRoutingInfoLength != NULL)
-		kfree(PCIIRQRoutingInfoLength );
+	kfree(PCIIRQRoutingInfoLength );
 	return -1;
 }
 
--- linux-2.6.14-rc4-orig/drivers/usb/class/bluetty.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/usb/class/bluetty.c	2005-10-12 16:28:54.000000000 +0200
@@ -1131,16 +1131,13 @@ static int usb_bluetooth_probe (struct u
 probe_error:
 	if (bluetooth->read_urb)
 		usb_free_urb (bluetooth->read_urb);
-	if (bluetooth->bulk_in_buffer)
-		kfree (bluetooth->bulk_in_buffer);
+	kfree (bluetooth->bulk_in_buffer);
 	if (bluetooth->interrupt_in_urb)
 		usb_free_urb (bluetooth->interrupt_in_urb);
-	if (bluetooth->interrupt_in_buffer)
-		kfree (bluetooth->interrupt_in_buffer);
+	kfree (bluetooth->interrupt_in_buffer);
 	for (i = 0; i < NUM_CONTROL_URBS; ++i) 
 		if (bluetooth->control_urb_pool[i]) {
-			if (bluetooth->control_urb_pool[i]->transfer_buffer)
-				kfree (bluetooth->control_urb_pool[i]->transfer_buffer);
+			kfree (bluetooth->control_urb_pool[i]->transfer_buffer);
 			usb_free_urb (bluetooth->control_urb_pool[i]);
 		}
 
@@ -1168,23 +1165,20 @@ static void usb_bluetooth_disconnect(str
 			usb_kill_urb (bluetooth->read_urb);
 			usb_free_urb (bluetooth->read_urb);
 		}
-		if (bluetooth->bulk_in_buffer)
-			kfree (bluetooth->bulk_in_buffer);
+		kfree (bluetooth->bulk_in_buffer);
 
 		if (bluetooth->interrupt_in_urb) {
 			usb_kill_urb (bluetooth->interrupt_in_urb);
 			usb_free_urb (bluetooth->interrupt_in_urb);
 		}
-		if (bluetooth->interrupt_in_buffer)
-			kfree (bluetooth->interrupt_in_buffer);
+		kfree (bluetooth->interrupt_in_buffer);
 
 		tty_unregister_device (bluetooth_tty_driver, bluetooth->minor);
 
 		for (i = 0; i < NUM_CONTROL_URBS; ++i) {
 			if (bluetooth->control_urb_pool[i]) {
 				usb_kill_urb (bluetooth->control_urb_pool[i]);
-				if (bluetooth->control_urb_pool[i]->transfer_buffer)
-					kfree (bluetooth->control_urb_pool[i]->transfer_buffer);
+				kfree (bluetooth->control_urb_pool[i]->transfer_buffer);
 				usb_free_urb (bluetooth->control_urb_pool[i]);
 			}
 		}
--- linux-2.6.14-rc4-orig/drivers/usb/input/keyspan_remote.c	2005-10-11 22:41:21.000000000 +0200
+++ linux-2.6.14-rc4/drivers/usb/input/keyspan_remote.c	2005-10-12 16:29:31.000000000 +0200
@@ -557,8 +557,7 @@ error:
 	if (remote->in_buffer)
 		usb_buffer_free(remote->udev, RECV_SIZE, remote->in_buffer, remote->in_dma);
 
-	if (remote)
-		kfree(remote);
+	kfree(remote);
 
 	return retval;
 }
--- linux-2.6.14-rc4-orig/drivers/acpi/scan.c	2005-10-11 22:41:05.000000000 +0200
+++ linux-2.6.14-rc4/drivers/acpi/scan.c	2005-10-12 16:29:59.000000000 +0200
@@ -28,8 +28,7 @@ static int acpi_bus_trim(struct acpi_dev
 static void acpi_device_release(struct kobject *kobj)
 {
 	struct acpi_device *dev = container_of(kobj, struct acpi_device, kobj);
-	if (dev->pnp.cid_list)
-		kfree(dev->pnp.cid_list);
+	kfree(dev->pnp.cid_list);
 	kfree(dev);
 }
 
@@ -1117,8 +1116,7 @@ acpi_add_single_object(struct acpi_devic
 	if (!result)
 		*child = device;
 	else {
-		if (device->pnp.cid_list)
-			kfree(device->pnp.cid_list);
+		kfree(device->pnp.cid_list);
 		kfree(device);
 	}
 
--- linux-2.6.14-rc4-orig/drivers/acpi/video.c	2005-10-11 22:41:05.000000000 +0200
+++ linux-2.6.14-rc4/drivers/acpi/video.c	2005-10-12 16:30:49.000000000 +0200
@@ -334,8 +334,7 @@ acpi_video_device_lcd_query_levels(struc
 	return_VALUE(0);
 
       err:
-	if (buffer.pointer)
-		kfree(buffer.pointer);
+	kfree(buffer.pointer);
 
 	return_VALUE(status);
 }
@@ -1488,8 +1487,7 @@ static int acpi_video_device_enumerate(s
 	}
 	active_device_list[count].value.int_val = ACPI_VIDEO_HEAD_END;
 
-	if (video->attached_array)
-		kfree(video->attached_array);
+	kfree(video->attached_array);
 
 	video->attached_array = active_device_list;
 	video->attached_count = count;
@@ -1645,8 +1643,7 @@ static int acpi_video_bus_put_devices(st
 			printk(KERN_WARNING PREFIX
 			       "hhuuhhuu bug in acpi video driver.\n");
 
-		if (data->brightness)
-			kfree(data->brightness);
+		kfree(data->brightness);
 
 		kfree(data);
 	}
@@ -1831,8 +1828,7 @@ static int acpi_video_bus_remove(struct 
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
 
-	if (video->attached_array)
-		kfree(video->attached_array);
+	kfree(video->attached_array);
 	kfree(video);
 
 	return_VALUE(0);
--- linux-2.6.14-rc4-orig/drivers/acpi/container.c	2005-10-11 22:41:04.000000000 +0200
+++ linux-2.6.14-rc4/drivers/acpi/container.c	2005-10-12 16:31:11.000000000 +0200
@@ -118,11 +118,9 @@ static int acpi_container_remove(struct 
 {
 	acpi_status status = AE_OK;
 	struct acpi_container *pc = NULL;
-	pc = (struct acpi_container *)acpi_driver_data(device);
-
-	if (pc)
-		kfree(pc);
 
+	pc = (struct acpi_container *)acpi_driver_data(device);
+	kfree(pc);
 	return status;
 }
 
--- linux-2.6.14-rc4-orig/drivers/sbus/char/envctrl.c	2005-10-11 22:41:13.000000000 +0200
+++ linux-2.6.14-rc4/drivers/sbus/char/envctrl.c	2005-10-12 17:08:15.000000000 +0200
@@ -1125,10 +1125,9 @@ out_deregister:
 	misc_deregister(&envctrl_dev);
 out_iounmap:
 	iounmap(i2c);
-	for (i = 0; i < ENVCTRL_MAX_CPU * 2; i++) {
-		if (i2c_childlist[i].tables)
-			kfree(i2c_childlist[i].tables);
-	}
+	for (i = 0; i < ENVCTRL_MAX_CPU * 2; i++)
+		kfree(i2c_childlist[i].tables);
+
 	return err;
 }
 
@@ -1141,10 +1140,8 @@ static void __exit envctrl_cleanup(void)
 	iounmap(i2c);
 	misc_deregister(&envctrl_dev);
 
-	for (i = 0; i < ENVCTRL_MAX_CPU * 2; i++) {
-		if (i2c_childlist[i].tables)
-			kfree(i2c_childlist[i].tables);
-	}
+	for (i = 0; i < ENVCTRL_MAX_CPU * 2; i++)
+		kfree(i2c_childlist[i].tables);
 }
 
 module_init(envctrl_init);
--- linux-2.6.14-rc4-orig/drivers/infiniband/core/mad.c	2005-10-11 22:41:09.000000000 +0200
+++ linux-2.6.14-rc4/drivers/infiniband/core/mad.c	2005-10-12 17:37:50.000000000 +0200
@@ -510,8 +510,7 @@ static void unregister_mad_agent(struct 
 	wait_event(mad_agent_priv->wait,
 		   !atomic_read(&mad_agent_priv->refcount));
 
-	if (mad_agent_priv->reg_req)
-		kfree(mad_agent_priv->reg_req);
+	kfree(mad_agent_priv->reg_req);
 	ib_dereg_mr(mad_agent_priv->agent.mr);
 	kfree(mad_agent_priv);
 }
@@ -2544,8 +2543,7 @@ error:
 static void destroy_mad_qp(struct ib_mad_qp_info *qp_info)
 {
 	ib_destroy_qp(qp_info->qp);
-	if (qp_info->snoop_table)
-		kfree(qp_info->snoop_table);
+	kfree(qp_info->snoop_table);
 }
 
 /*
--- linux-2.6.14-rc4-orig/drivers/block/DAC960.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/block/DAC960.c	2005-10-12 17:41:51.000000000 +0200
@@ -417,14 +417,12 @@ static void DAC960_DestroyAuxiliaryStruc
             * Remember the beginning of the group, but don't free it
 	    * until we've reached the beginning of the next group.
 	    */
-	   if (CommandGroup != NULL)
-		kfree(CommandGroup);
-	    CommandGroup = Command;
+	   kfree(CommandGroup);
+	   CommandGroup = Command;
       }
       Controller->Commands[i] = NULL;
     }
-  if (CommandGroup != NULL)
-      kfree(CommandGroup);
+  kfree(CommandGroup);
 
   if (Controller->CombinedStatusBuffer != NULL)
     {
@@ -435,30 +433,23 @@ static void DAC960_DestroyAuxiliaryStruc
 
   if (ScatterGatherPool != NULL)
   	pci_pool_destroy(ScatterGatherPool);
-  if (Controller->FirmwareType == DAC960_V1_Controller) return;
+  if (Controller->FirmwareType == DAC960_V1_Controller)
+  	return;
 
   if (RequestSensePool != NULL)
 	pci_pool_destroy(RequestSensePool);
 
-  for (i = 0; i < DAC960_MaxLogicalDrives; i++)
-    if (Controller->V2.LogicalDeviceInformation[i] != NULL)
-      {
+  for (i = 0; i < DAC960_MaxLogicalDrives; i++) {
 	kfree(Controller->V2.LogicalDeviceInformation[i]);
 	Controller->V2.LogicalDeviceInformation[i] = NULL;
-      }
+  }
 
   for (i = 0; i < DAC960_V2_MaxPhysicalDevices; i++)
     {
-      if (Controller->V2.PhysicalDeviceInformation[i] != NULL)
-	{
-	  kfree(Controller->V2.PhysicalDeviceInformation[i]);
-	  Controller->V2.PhysicalDeviceInformation[i] = NULL;
-	}
-      if (Controller->V2.InquiryUnitSerialNumber[i] != NULL)
-	{
-	  kfree(Controller->V2.InquiryUnitSerialNumber[i]);
-	  Controller->V2.InquiryUnitSerialNumber[i] = NULL;
-	}
+      kfree(Controller->V2.PhysicalDeviceInformation[i]);
+      Controller->V2.PhysicalDeviceInformation[i] = NULL;
+      kfree(Controller->V2.InquiryUnitSerialNumber[i]);
+      Controller->V2.InquiryUnitSerialNumber[i] = NULL;
     }
 }
 
--- linux-2.6.14-rc4-orig/drivers/block/cciss.c	2005-10-11 22:41:05.000000000 +0200
+++ linux-2.6.14-rc4/drivers/block/cciss.c	2005-10-12 17:43:18.000000000 +0200
@@ -1096,14 +1096,11 @@ static int cciss_ioctl(struct inode *ino
 cleanup1:
 		if (buff) {
 			for(i=0; i<sg_used; i++)
-				if(buff[i] != NULL)
-					kfree(buff[i]);
+				kfree(buff[i]);
 			kfree(buff);
 		}
-		if (buff_size)
-			kfree(buff_size);
-		if (ioc)
-			kfree(ioc);
+		kfree(buff_size);
+		kfree(ioc);
 		return(status);
 	}
 	default:
@@ -3034,8 +3031,7 @@ static int __devinit cciss_init_one(stru
 	return(1);
 
 clean4:
-	if(hba[i]->cmd_pool_bits)
-               	kfree(hba[i]->cmd_pool_bits);
+	kfree(hba[i]->cmd_pool_bits);
 	if(hba[i]->cmd_pool)
 		pci_free_consistent(hba[i]->pdev,
 			NR_CMDS * sizeof(CommandList_struct),
--- linux-2.6.14-rc4-orig/drivers/hwmon/w83781d.c	2005-10-11 22:41:08.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/w83781d.c	2005-10-13 10:27:19.000000000 +0200
@@ -979,11 +979,9 @@ w83781d_detect_subclients(struct i2c_ada
 ERROR_SC_3:
 	i2c_detach_client(data->lm75[0]);
 ERROR_SC_2:
-	if (data->lm75[1])
-		kfree(data->lm75[1]);
+	kfree(data->lm75[1]);
 ERROR_SC_1:
-	if (data->lm75[0])
-		kfree(data->lm75[0]);
+	kfree(data->lm75[0]);
 ERROR_SC_0:
 	return err;
 }
--- linux-2.6.14-rc4-orig/drivers/input/misc/uinput.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/input/misc/uinput.c	2005-10-13 10:28:20.000000000 +0200
@@ -271,8 +271,7 @@ static int uinput_alloc_device(struct fi
 		goto exit;
 	}
 
-	if (dev->name)
-		kfree(dev->name);
+	kfree(dev->name);
 
 	size = strnlen(user_dev->name, UINPUT_MAX_NAME_SIZE) + 1;
 	dev->name = name = kmalloc(size, GFP_KERNEL);
@@ -372,11 +371,8 @@ static int uinput_burn_device(struct uin
 	if (test_bit(UIST_CREATED, &udev->state))
 		uinput_destroy_device(udev);
 
-	if (udev->dev->name)
-		kfree(udev->dev->name);
-	if (udev->dev->phys)
-		kfree(udev->dev->phys);
-
+	kfree(udev->dev->name);
+	kfree(udev->dev->phys);
 	kfree(udev->dev);
 	kfree(udev);
 
--- linux-2.6.14-rc4-orig/drivers/video/i810/i810_main.c	2005-10-11 22:41:21.000000000 +0200
+++ linux-2.6.14-rc4/drivers/video/i810/i810_main.c	2005-10-13 10:34:11.000000000 +0200
@@ -2066,8 +2066,7 @@ static void i810fb_release_resource(stru
 		iounmap(par->mmio_start_virtual);
 	if (par->aperture.virtual)
 		iounmap(par->aperture.virtual);
-	if (par->edid)
-		kfree(par->edid);
+	kfree(par->edid);
 	if (par->res_flags & FRAMEBUFFER_REQ)
 		release_mem_region(par->aperture.physical,
 				   par->aperture.size);
--- linux-2.6.14-rc4-orig/drivers/pcmcia/cs.c	2005-10-11 22:41:12.000000000 +0200
+++ linux-2.6.14-rc4/drivers/pcmcia/cs.c	2005-10-13 10:36:53.000000000 +0200
@@ -331,10 +331,8 @@ static void shutdown_socket(struct pcmci
 	cb_free(s);
 #endif
 	s->functions = 0;
-	if (s->config) {
-		kfree(s->config);
-		s->config = NULL;
-	}
+	kfree(s->config);
+	s->config = NULL;
 
 	{
 		int status;
--- linux-2.6.14-rc4-orig/drivers/pcmcia/cistpl.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/pcmcia/cistpl.c	2005-10-13 10:38:56.000000000 +0200
@@ -334,10 +334,8 @@ void destroy_cis_cache(struct pcmcia_soc
 	/*
 	 * If there was a fake CIS, destroy that as well.
 	 */
-	if (s->fake_cis) {
-		kfree(s->fake_cis);
-		s->fake_cis = NULL;
-	}
+	kfree(s->fake_cis);
+	s->fake_cis = NULL;
 }
 EXPORT_SYMBOL(destroy_cis_cache);
 
@@ -386,10 +384,8 @@ int verify_cis_cache(struct pcmcia_socke
 
 int pcmcia_replace_cis(struct pcmcia_socket *s, cisdump_t *cis)
 {
-    if (s->fake_cis != NULL) {
-	kfree(s->fake_cis);
-	s->fake_cis = NULL;
-    }
+    kfree(s->fake_cis);
+    s->fake_cis = NULL;
     if (cis->Length > CISTPL_MAX_CIS_SIZE)
 	return CS_BAD_SIZE;
     s->fake_cis = kmalloc(cis->Length, GFP_KERNEL);
--- linux-2.6.14-rc4-orig/drivers/parport/share.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/parport/share.c	2005-10-13 10:39:56.000000000 +0200
@@ -202,16 +202,11 @@ static void free_port (struct parport *p
 	list_del(&port->full_list);
 	spin_unlock(&full_list_lock);
 	for (d = 0; d < 5; d++) {
-		if (port->probe_info[d].class_name)
-			kfree (port->probe_info[d].class_name);
-		if (port->probe_info[d].mfr)
-			kfree (port->probe_info[d].mfr);
-		if (port->probe_info[d].model)
-			kfree (port->probe_info[d].model);
-		if (port->probe_info[d].cmdset)
-			kfree (port->probe_info[d].cmdset);
-		if (port->probe_info[d].description)
-			kfree (port->probe_info[d].description);
+		kfree(port->probe_info[d].class_name);
+		kfree(port->probe_info[d].mfr);
+		kfree(port->probe_info[d].model);
+		kfree(port->probe_info[d].cmdset);
+		kfree(port->probe_info[d].description);
 	}
 
 	kfree(port->name);
@@ -618,9 +613,9 @@ parport_register_device(struct parport *
 	return tmp;
 
  out_free_all:
-	kfree (tmp->state);
+	kfree(tmp->state);
  out_free_pardevice:
-	kfree (tmp);
+	kfree(tmp);
  out:
 	parport_put_port (port);
 	module_put(port->ops->owner);
--- linux-2.6.14-rc4-orig/drivers/parport/probe.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/parport/probe.c	2005-10-13 10:41:38.000000000 +0200
@@ -78,17 +78,15 @@ static void parse_data(struct parport *p
 				u++;
 			}
 			if (!strcmp(p, "MFG") || !strcmp(p, "MANUFACTURER")) {
-				if (info->mfr)
-					kfree (info->mfr);
+				kfree(info->mfr);
 				info->mfr = kstrdup(sep, GFP_KERNEL);
 			} else if (!strcmp(p, "MDL") || !strcmp(p, "MODEL")) {
-				if (info->model)
-					kfree (info->model);
+				kfree(info->model);
 				info->model = kstrdup(sep, GFP_KERNEL);
 			} else if (!strcmp(p, "CLS") || !strcmp(p, "CLASS")) {
 				int i;
-				if (info->class_name)
-					kfree (info->class_name);
+
+				kfree(info->class_name);
 				info->class_name = kstrdup(sep, GFP_KERNEL);
 				for (u = sep; *u; u++)
 					*u = toupper(*u);
@@ -102,21 +100,22 @@ static void parse_data(struct parport *p
 				info->class = PARPORT_CLASS_OTHER;
 			} else if (!strcmp(p, "CMD") ||
 				   !strcmp(p, "COMMAND SET")) {
-				if (info->cmdset)
-					kfree (info->cmdset);
+				kfree(info->cmdset);
 				info->cmdset = kstrdup(sep, GFP_KERNEL);
 				/* if it speaks printer language, it's
 				   probably a printer */
 				if (strstr(sep, "PJL") || strstr(sep, "PCL"))
 					guessed_class = PARPORT_CLASS_PRINTER;
 			} else if (!strcmp(p, "DES") || !strcmp(p, "DESCRIPTION")) {
-				if (info->description)
-					kfree (info->description);
+				kfree(info->description);
 				info->description = kstrdup(sep, GFP_KERNEL);
 			}
 		}
 	rock_on:
-		if (q) p = q+1; else p=NULL;
+		if (q)
+			p = q + 1;
+		else
+			p = NULL;
 	}
 
 	/* If the device didn't tell us its class, maybe we have managed to
--- linux-2.6.14-rc4-orig/drivers/macintosh/adbhid.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/macintosh/adbhid.c	2005-10-13 10:41:57.000000000 +0200
@@ -846,8 +846,7 @@ adbhid_input_register(int id, int defaul
 static void adbhid_input_unregister(int id)
 {
 	input_unregister_device(&adbhid[id]->input);
-	if (adbhid[id]->keycode)
-		kfree(adbhid[id]->keycode);
+	kfree(adbhid[id]->keycode);
 	kfree(adbhid[id]);
 	adbhid[id] = NULL;
 }



