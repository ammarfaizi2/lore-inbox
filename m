Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUDXPcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUDXPcY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 11:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUDXPcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 11:32:24 -0400
Received: from mailgate5.web.de ([217.72.192.165]:11678 "EHLO mailgate5.web.de")
	by vger.kernel.org with ESMTP id S262418AbUDXPb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 11:31:57 -0400
Date: Sat, 24 Apr 2004 17:31:55 +0200
Message-Id: <1210477013@web.de>
MIME-Version: 1.0
From: "Andreas Weber" <and_weber_and@web.de>
To: linux-kernel@vger.kernel.org
Subject: usb_storage flash drive (NOKIA 5510) not working anymore in Linux 2.6
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
syncing/umount of the NOKIA 5510 mobile phone doesn't work with kernel 2.6 (last
tested with 2.6.6-rc2-mm1 and all USB fixes for 2.6.6-rc2 applied.)

If I copy small files (~40KB) a sync/umount works. When I copy larger files
(>~50KB) a umount/sync takes ages and my syslog gets filled with scsi errors.
I have also a usb flash stick that had shown the same behaviour until I applied
the uhci_hcd patch.
With 2.4 kernels things are working (last tested with 2.4.25 with uhci as well
as usb-uhci module).

Syslog from 2.6.6-rc2-mm1:
Apr 24 15:47:58 mobilin kernel: usb 1-1: new full speed USB device using address
3
Apr 24 15:47:58 mobilin kernel: SCSI subsystem initialized
Apr 24 15:47:58 mobilin kernel: Initializing USB Mass Storage driver...
Apr 24 15:47:58 mobilin kernel: scsi0 : SCSI emulation for USB Mass Storage
devices
Apr 24 15:47:58 mobilin kernel:   Vendor: Nokia     Model: 5510             
Rev: 0001
Apr 24 15:47:58 mobilin kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Apr 24 15:47:58 mobilin usb.agent[2676]:      usb-storage: loaded sucessfully
Apr 24 15:47:58 mobilin kernel: USB Mass Storage device found at 3
Apr 24 15:47:58 mobilin kernel: usbcore: registered new driver usb-storage
Apr 24 15:47:58 mobilin kernel: USB Mass Storage support registered.
Apr 24 15:47:59 mobilin scsi.agent[2710]: disk at
/devices/pci0000:00/0000:00:07.2/usb1/1-1/1-1:1.0/host0/0:0:0:0
Apr 24 15:47:59 mobilin kernel: SCSI device sda: 124896 512-byte hdwr sectors
(64 MB)
Apr 24 15:47:59 mobilin kernel: sda: assuming Write Enabled
Apr 24 15:47:59 mobilin kernel: sda: assuming drive cache: write through
Apr 24 15:47:59 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 24 15:47:59 mobilin kernel:  sda: sda1
Apr 24 15:47:59 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 24 15:47:59 mobilin kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 0, lun 0
Apr 24 15:48:00 mobilin udev[2752]: creating device node '/dev/sda'
Apr 24 15:48:00 mobilin udev[2753]: creating device node '/dev/sda1'
Apr 24 15:48:07 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 24 15:48:07 mobilin last message repeated 2 times
Apr 24 15:52:31 mobilin kernel: SCSI error : <0 0 0 0> return code = 0x6000000
Apr 24 15:52:31 mobilin kernel: end_request: I/O error, dev sda, sector 319
Apr 24 15:52:31 mobilin kernel: Buffer I/O error on device sda1, logical block
288
Apr 24 15:52:31 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:56:42 mobilin kernel: SCSI error : <0 0 0 0> return code = 0x6000000
Apr 24 15:56:42 mobilin kernel: end_request: I/O error, dev sda, sector 447
Apr 24 15:56:42 mobilin kernel: Buffer I/O error on device sda1, logical block
416
Apr 24 15:56:42 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: usb 1-1: USB disconnect, address 3
Apr 24 15:57:22 mobilin kernel: drivers/usb/core/hub.c: USB device not accepting
new address (error=-90)
Apr 24 15:57:22 mobilin kernel: scsi: Device offlined - not ready after error
recovery: host 0 channel 0 id 0 lun 0
Apr 24 15:57:22 mobilin kernel: SCSI error : <0 0 0 0> return code = 0x50000
Apr 24 15:57:22 mobilin kernel: end_request: I/O error, dev sda, sector 448
Apr 24 15:57:22 mobilin kernel: Buffer I/O error on device sda1, logical block
417
Apr 24 15:57:22 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: scsi0 (0:0): rejecting I/O to offline device
Apr 24 15:57:22 mobilin kernel: Buffer I/O error on device sda1, logical block
418
Apr 24 15:57:22 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: Buffer I/O error on device sda1, logical block
419
Apr 24 15:57:22 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: Buffer I/O error on device sda1, logical block
420
Apr 24 15:57:22 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: Buffer I/O error on device sda1, logical block
421
Apr 24 15:57:22 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: Buffer I/O error on device sda1, logical block
422
Apr 24 15:57:22 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: Buffer I/O error on device sda1, logical block
423
Apr 24 15:57:22 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: Buffer I/O error on device sda1, logical block
424
Apr 24 15:57:22 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: Buffer I/O error on device sda1, logical block
425
Apr 24 15:57:22 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: Buffer I/O error on device sda1, logical block
426
Apr 24 15:57:22 mobilin kernel: lost page write due to I/O error on sda1
Apr 24 15:57:22 mobilin kernel: scsi0 (0:0): rejecting I/O to offline device
Apr 24 15:57:22 mobilin last message repeated 54 times
Apr 24 15:57:22 mobilin kernel: SCSI error: host 0 id 0 lun 0 return code =
4000000
Apr 24 15:57:22 mobilin kernel: ^ISense class 0, sense error 0, extended sense 0
Apr 24 15:57:22 mobilin kernel: sd 0:0:0:0: Illegal state transition
offline->cancel
Apr 24 15:57:22 mobilin kernel: Badness in scsi_device_set_state at
drivers/scsi/scsi_lib.c:1640
Apr 24 15:57:22 mobilin kernel: Call Trace:
Apr 24 15:57:22 mobilin kernel:  [__crc_sock_alloc_send_pskb+256170/3691977]
scsi_device_set_state+0xbe/0x110 [scsi_mod]
Apr 24 15:57:22 mobilin kernel:  [__crc_sock_alloc_send_pskb+236830/3691977]
scsi_device_cancel+0x22/0x118 [scsi_mod]
Apr 24 15:57:22 mobilin kernel:  [__crc_sock_alloc_send_pskb+237148/3691977]
scsi_device_cancel_cb+0x0/0x10 [scsi_mod]
Apr 24 15:57:22 mobilin kernel:  [device_for_each_child+55/96]
device_for_each_child+0x37/0x60
Apr 24 15:57:22 mobilin kernel:  [__crc_sock_alloc_send_pskb+237202/3691977]
scsi_host_cancel+0x26/0xa0 [scsi_mod]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+788482/1000654]
usb_buffer_free+0x48/0x50 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_sock_alloc_send_pskb+237334/3691977]
scsi_remove_host+0xa/0x40 [scsi_mod]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+904899/1000654]
storage_disconnect+0x29/0x31 [usb_storage]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+783742/1000654]
usb_unbind_interface+0x64/0x70 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [device_release_driver+86/96]
device_release_driver+0x56/0x60
Apr 24 15:57:22 mobilin kernel:  [bus_remove_device+74/144]
bus_remove_device+0x4a/0x90
Apr 24 15:57:22 mobilin kernel:  [device_del+90/160] device_del+0x5a/0xa0
Apr 24 15:57:22 mobilin kernel:  [device_unregister+8/16]
device_unregister+0x8/0x10
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+807978/1000654]
usb_disable_device+0x60/0xa0 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+786553/1000654]
usb_disconnect+0x8f/0xe0 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+795240/1000654]
hub_port_connect_change+0x24e/0x260 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+793572/1000654]
hub_port_status+0x3a/0xb0 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+796004/1000654]
hub_events+0x2ea/0x370 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+796191/1000654]
hub_thread+0x35/0xf0 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [default_wake_function+0/16]
default_wake_function+0x0/0x10
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+796138/1000654]
hub_thread+0x0/0xf0 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
Apr 24 15:57:22 mobilin kernel: 
Apr 24 15:57:22 mobilin kernel: sd 0:0:0:0: Illegal state transition
offline->cancel
Apr 24 15:57:22 mobilin kernel: Badness in scsi_device_set_state at
drivers/scsi/scsi_lib.c:1640
Apr 24 15:57:22 mobilin kernel: Call Trace:
Apr 24 15:57:22 mobilin kernel:  [__crc_sock_alloc_send_pskb+256170/3691977]
scsi_device_set_state+0xbe/0x110 [scsi_mod]
Apr 24 15:57:22 mobilin kernel:  [__crc_sock_alloc_send_pskb+263602/3691977]
scsi_remove_device+0x16/0xa0 [scsi_mod]
Apr 24 15:57:22 mobilin kernel:  [__crc_sock_alloc_send_pskb+260847/3691977]
scsi_forget_host+0x43/0x80 [scsi_mod]
Apr 24 15:57:22 mobilin kernel:  [__crc_sock_alloc_send_pskb+237348/3691977]
scsi_remove_host+0x18/0x40 [scsi_mod]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+904899/1000654]
storage_disconnect+0x29/0x31 [usb_storage]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+783742/1000654]
usb_unbind_interface+0x64/0x70 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [device_release_driver+86/96]
device_release_driver+0x56/0x60
Apr 24 15:57:22 mobilin kernel:  [bus_remove_device+74/144]
bus_remove_device+0x4a/0x90
Apr 24 15:57:22 mobilin kernel:  [device_del+90/160] device_del+0x5a/0xa0
Apr 24 15:57:22 mobilin kernel:  [device_unregister+8/16]
device_unregister+0x8/0x10
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+807978/1000654]
usb_disable_device+0x60/0xa0 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+786553/1000654]
usb_disconnect+0x8f/0xe0 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+795240/1000654]
hub_port_connect_change+0x24e/0x260 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+793572/1000654]
hub_port_status+0x3a/0xb0 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+796004/1000654]
hub_events+0x2ea/0x370 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+796191/1000654]
hub_thread+0x35/0xf0 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [default_wake_function+0/16]
default_wake_function+0x0/0x10
Apr 24 15:57:22 mobilin kernel:  [__crc_snd_pcm_suspend_all+796138/1000654]
hub_thread+0x0/0xf0 [usbcore]
Apr 24 15:57:22 mobilin kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
Apr 24 15:57:22 mobilin kernel: 
Apr 24 15:57:22 mobilin kernel: usb 1-1: new full speed USB device using address
4
Apr 24 15:57:22 mobilin kernel: scsi1 : SCSI emulation for USB Mass Storage
devices
Apr 24 15:57:22 mobilin usb.agent[2889]:      usb-storage: already loaded
Apr 24 15:57:23 mobilin kernel:   Vendor: Nokia     Model: 5510             
Rev: 0001
Apr 24 15:57:23 mobilin kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Apr 24 15:57:23 mobilin kernel: SCSI device sdb: 124896 512-byte hdwr sectors
(64 MB)
Apr 24 15:57:23 mobilin kernel: sdb: assuming Write Enabled
Apr 24 15:57:23 mobilin kernel: sdb: assuming drive cache: write through
Apr 24 15:57:23 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 24 15:57:23 mobilin kernel:  sdb: sdb1
Apr 24 15:57:23 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 24 15:57:23 mobilin kernel: Attached scsi removable disk sdb at scsi1,
channel 0, id 0, lun 0
Apr 24 15:57:23 mobilin kernel: USB Mass Storage device found at 4
Apr 24 15:57:24 mobilin scsi.agent[2927]: disk at
/devices/pci0000:00/0000:00:07.2/usb1/1-1/1-1:1.0/host1/1:0:0:0
Apr 24 15:57:24 mobilin udev[2963]: creating device node '/dev/sdb'
Apr 24 15:57:24 mobilin udev[2964]: creating device node '/dev/sdb1'
Apr 24 16:02:28 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.

For comparison syslog from 2.4.25:
Apr 24 16:27:07 mobilin kernel: hub.c: new USB device 00:07.2-1, assigned
address 3
Apr 24 16:27:07 mobilin kernel: usb.c: USB device 3 (vend/prod 0x421/0x404) is
not claimed by any active driver.
Apr 24 16:27:11 mobilin kernel: SCSI subsystem driver Revision: 1.00
Apr 24 16:27:11 mobilin kernel: Initializing USB Mass Storage driver...
Apr 24 16:27:11 mobilin kernel: usb.c: registered new driver usb-storage
Apr 24 16:27:16 mobilin kernel: usb_control/bulk_msg: timeout
Apr 24 16:27:16 mobilin kernel: scsi0 : SCSI emulation for USB Mass Storage
devices
Apr 24 16:27:16 mobilin kernel:   Vendor: Nokia     Model: 5510             
Rev: 0001
Apr 24 16:27:16 mobilin kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Apr 24 16:27:16 mobilin kernel: WARNING: USB Mass Storage data integrity not
assured
Apr 24 16:27:16 mobilin kernel: USB Mass Storage device found at 3
Apr 24 16:27:16 mobilin kernel: USB Mass Storage support registered.
Apr 24 16:27:16 mobilin usb.agent[915]:      usb-storage: loaded sucessfully
Apr 24 16:27:26 mobilin kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 0, lun 0
Apr 24 16:27:26 mobilin kernel: SCSI device sda: 124896 512-byte hdwr sectors
(64 MB)
Apr 24 16:27:26 mobilin kernel: sda: test WP failed, assume Write Enabled
Apr 24 16:27:26 mobilin kernel:  sda: sda1
Apr 24 16:27:26 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 24 16:27:57 mobilin last message repeated 3 times


Any ideas?
Andreas Weber
____________________________________________________________________
Der WEB.DE Virenschutz schuetzt Ihr Postfach vor dem Wurm Sober.A-F!
Kostenfrei fuer FreeMail Nutzer. http://f.web.de/?mc=021158

