Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUKJLla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUKJLla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 06:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbUKJLla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 06:41:30 -0500
Received: from 4s.enrico.unife.it ([192.167.219.82]:20452 "EHLO
	quatresse.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S261706AbUKJLkm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 06:40:42 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm4
Date: Wed, 10 Nov 2004 12:40:37 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20041109074909.3f287966.akpm@osdl.org>
In-Reply-To: <20041109074909.3f287966.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200411101240.37882.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 16:49, martedì 9 novembre 2004, Andrew Morton ha scritto:

> - A process matter: I'm now tracking any regressions since 2.6.9, with the
>   intention that we not release 2.6.10 until they're all fixed.  (Where
>   "tracking" means shoving them into a folder called "bugs").  So if anyone
> is aware of any post-2.6.9 regressions, please make sure that I have a copy
> of the email.

usb storage has some problems; IIRC 2.6.9 is OK, the problem is only in mm 
series; I can test other versions but it will take some time :)
Maybe it's a minor bug, but it can freeze usb subsystem...

Short description: inserting usb storage device causes problems and device is 
not created; this happens with or without ub driver.
I've already reported this, but not for mm4, maybe something is different,
The device works just fine with 2.6.8.1 as provided with mdk cooker (12mdk), 
without ub module, the flash pen is seen as sda1.
tests made without ub configured/compiled. Inseting the device, the usual 
behaviour is that it is not seen, only error occurs (see below for full 
syslog report). Sometimes (say, after 5/6 insertion/removal cycles) the pen 
is seen but scsi layer seem to see it twice, then kobject fails. 
In this situation, the removal of the device causes a kernel oops and usb 
subsystem is gone, with herratic behaviour.
As said, same device is OK with 2.6.8.1 (and anyway, it should cause not harm 
even if it is not working, imho...)

Log report:
plugging in/out the device:
====Nov 10 01:18:14 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 
0008
Nov 10 01:18:14 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Nov 10 01:18:14 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Nov 10 01:18:14 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x100
Nov 10 01:18:14 kefk kernel: hub 2-0:1.0: state 5 ports 2 chg fffc evt 0002
Nov 10 01:18:14 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0082,00
Nov 10 01:18:14 kefk kernel: hub 2-0:1.0: port 1, status 0100, change 0001, 12 
Mb/s
Nov 10 01:18:14 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x100
Nov 10 01:18:15 kefk kernel: uhci_hcd 0000:00:1d.1: suspend_hc
Nov 10 01:18:19 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 10 01:18:19 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov 10 01:18:19 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov 10 01:18:19 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov 10 01:18:19 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 10 01:18:19 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 10 01:18:19 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 6
Nov 10 01:18:19 kefk kernel: ehci_hcd 0000:00:1d.7: devpath 3 ep0in 3strikes
Nov 10 01:18:19 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 full speed --> 
companion
Nov 10 01:18:19 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
003801 POWER OWNER sig=j  CONNECT
Nov 10 01:18:19 kefk kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Nov 10 01:18:19 kefk kernel: hub 2-0:1.0: state 5 ports 2 chg fffc evt 0002
Nov 10 01:18:19 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0083,00
Nov 10 01:18:19 kefk kernel: hub 2-0:1.0: port 1, status 0101, change 0001, 12 
Mb/s
Nov 10 01:18:19 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x101
Nov 10 01:18:19 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 6
Nov 10 01:18:19 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 10 01:18:19 kefk kernel: [f79d6240] link (379d61b2) element (37a65040)
Nov 10 01:18:19 kefk kernel:   0: [f7a65040] link (37a65080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2
d(SETUP) (buf=3527a400)
Nov 10 01:18:19 kefk kernel:   1: [f7a65080] link (37a650c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN)
(buf=351fa1c0)
Nov 10 01:18:19 kefk kernel:   2: [f7a650c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT
) (buf=00000000)
Nov 10 01:18:19 kefk kernel:
Nov 10 01:18:19 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 10 01:18:19 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 10 01:18:19 kefk kernel: [f79d6240] link (379d61b2) element (37a65040)
Nov 10 01:18:19 kefk kernel:   0: [f7a65040] link (37a65080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2
d(SETUP) (buf=3527a400)
Nov 10 01:18:19 kefk kernel:   1: [f7a65080] link (37a650c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN)
(buf=351fa1c0)
Nov 10 01:18:19 kefk kernel:   2: [f7a650c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT
) (buf=00000000)
Nov 10 01:18:19 kefk kernel:
Nov 10 01:18:20 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 10 01:18:20 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 7
Nov 10 01:18:20 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 10 01:18:20 kefk kernel: [f79d6240] link (379d61b2) element (37a65040)
Nov 10 01:18:20 kefk kernel:   0: [f7a65040] link (37a65080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2
d(SETUP) (buf=3527a400)
Nov 10 01:18:20 kefk kernel:   1: [f7a65080] link (37a650c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=351fa1c0)
Nov 10 01:18:20 kefk kernel:   2: [f7a650c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov 10 01:18:20 kefk kernel:
Nov 10 01:18:20 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 10 01:18:20 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 10 01:18:20 kefk kernel: [f79d6240] link (379d61b2) element (37a65040)
(snip)
===========
(no oopses so far)


Now, plugging in aftere several tries:
Nov 10 01:19:44 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 10 01:19:44 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov 10 01:19:44 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov 10 01:19:44 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov 10 01:19:44 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 10 01:19:44 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 10 01:19:44 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 8
Nov 10 01:19:44 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 10 01:19:44 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 10 01:19:44 kefk kernel: usb 5-3: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Nov 10 01:19:44 kefk kernel: usb 5-3: default language 0x0409
Nov 10 01:19:44 kefk kernel: usb 5-3: Product: Mass storage
Nov 10 01:19:44 kefk kernel: usb 5-3: Manufacturer: USB
Nov 10 01:19:44 kefk kernel: usb 5-3: SerialNumber: 142E19413C2FCA34
Nov 10 01:19:44 kefk kernel: usb 5-3: hotplug
Nov 10 01:19:44 kefk kernel: usb 5-3: adding 5-3:1.0 (config #1, interface 0)
Nov 10 01:19:44 kefk kernel: usb 5-3:1.0: hotplug
Nov 10 01:19:44 kefk kernel: Initializing USB Mass Storage driver...
Nov 10 01:19:44 kefk kernel: usb-storage 5-3:1.0: usb_probe_interface
Nov 10 01:19:44 kefk kernel: usb-storage 5-3:1.0: usb_probe_interface - got id
Nov 10 01:19:44 kefk kernel: scsi3 : SCSI emulation for USB Mass Storage 
devices
Nov 10 01:19:44 kefk kernel: usbcore: registered new driver usb-storage
Nov 10 01:19:44 kefk kernel: USB Mass Storage support registered.
Nov 10 01:19:44 kefk kernel: usb-storage: device found at 8
Nov 10 01:19:44 kefk kernel: usb-storage: waiting for device to settle before 
scanning
Nov 10 01:19:49 kefk kernel:   Vendor: 512MB     Model: USB2.0FlashDrive  Rev: 
2.00
Nov 10 01:19:49 kefk kernel:   Type:   Direct-Access                      ANSI 
SCSI revision: 02
Nov 10 01:19:49 kefk kernel: sdb: Unit Not Ready, sense:
Nov 10 01:19:49 kefk kernel: Current : sense = 70  6
Nov 10 01:19:49 kefk kernel: ASC=28 ASCQ= 0
Nov 10 01:19:49 kefk kernel: Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 
0x0a 0x00 0x00 0x00 0x00 0x28 0x00 0x00 0x00 0x00 0x00
Nov 10 01:19:49 kefk kernel: sdb : READ CAPACITY failed.
Nov 10 01:19:49 kefk kernel: sdb : status=1, message=00, host=0, driver=08
Nov 10 01:19:49 kefk kernel: Current sd: sense = 70  6
Nov 10 01:19:49 kefk kernel: ASC=28 ASCQ= 0
Nov 10 01:19:49 kefk kernel: Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 
0x0a 0x00 0x00 0x00 0x00 0x28 0x00 0x00 0x00
0x00 0x00
Nov 10 01:19:49 kefk kernel: sdb: test WP failed, assume Write Enabled
Nov 10 01:19:49 kefk kernel: sdb: assuming drive cache: write through
Nov 10 01:19:49 kefk kernel: sdb: Unit Not Ready, sense:
Nov 10 01:19:49 kefk kernel: Current : sense = 70  6
Nov 10 01:19:49 kefk kernel: ASC=28 ASCQ= 0
Nov 10 01:19:49 kefk kernel: Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 
0x0a 0x00 0x00 0x00 0x00 0x28 0x00 0x00 0x00
0x00 0x00
Nov 10 01:19:49 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov 10 01:19:49 kefk kernel: sdb: Write Protect is off
Nov 10 01:19:49 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov 10 01:19:49 kefk kernel: sdb: assuming drive cache: write through
Nov 10 01:19:49 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov 10 01:19:49 kefk kernel: sdb: Write Protect is off
Nov 10 01:19:49 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov 10 01:19:49 kefk kernel: sdb: assuming drive cache: write through
Nov 10 01:19:49 kefk kernel:  sdb: sdb1
Nov 10 01:19:49 kefk kernel:  sdb: sdb1
Nov 10 01:19:49 kefk kernel: kobject_register failed for <NULL> (-17)
Nov 10 01:19:49 kefk kernel:  [.text.lock.kobject+4/100] 
kobject_register+0x51/0x5f
Nov 10 01:19:49 kefk kernel:  [<c01f3a3c>] kobject_register+0x51/0x5f
Nov 10 01:19:49 kefk kernel:  [del_gendisk+25/213] add_partition+0xbb/0xf0
Nov 10 01:19:49 kefk kernel:  [<c0186448>] add_partition+0xbb/0xf0
Nov 10 01:19:49 kefk kernel:  [parse_extended+188/662] 
register_disk+0xee/0x11d
Nov 10 01:19:49 kefk kernel:  [<c01865c0>] register_disk+0xee/0x11d
Nov 10 01:19:49 kefk kernel:  [invalidate_partition+52/66] add_disk+0x36/0x41
Nov 10 01:19:49 kefk kernel:  [<c02585c6>] add_disk+0x36/0x41
Nov 10 01:19:49 kefk kernel:  [bdev_read_only+10/32] exact_match+0x0/0x7
Nov 10 01:19:49 kefk kernel:  [<c025857c>] exact_match+0x0/0x7
Nov 10 01:19:49 kefk kernel:  [bdev_read_only+17/32] exact_lock+0x0/0xd
Nov 10 01:19:49 kefk kernel:  [<c0258583>] exact_lock+0x0/0xd
Nov 10 01:19:49 kefk kernel:  [get_sectorsize+91/527] sd_probe+0x224/0x32f
Nov 10 01:19:49 kefk kernel:  [<c0298dba>] sd_probe+0x224/0x32f
Nov 10 01:19:49 kefk kernel:  [sysfs_lookup+10/199] 
sysfs_make_dirent+0x1c/0x84
Nov 10 01:19:49 kefk kernel:  [<c0187b6c>] sysfs_make_dirent+0x1c/0x84
Nov 10 01:19:49 kefk kernel:  [sysfs_lookup+10/199] 
sysfs_make_dirent+0x1c/0x84
Nov 10 01:19:49 kefk kernel:  [<c0187b6c>] sysfs_make_dirent+0x1c/0x84
Nov 10 01:19:49 kefk kernel:  [class_register+51/108] 
driver_probe_device+0x29/0x6a
Nov 10 01:19:49 kefk kernel:  [<c024fde4>] driver_probe_device+0x29/0x6a
Nov 10 01:19:49 kefk kernel:  [class_device_dev_link+24/26] 
device_attach+0x46/0xaa
Nov 10 01:19:49 kefk kernel:  [<c024fe6b>] device_attach+0x46/0xaa
Nov 10 01:19:49 kefk kernel:  [d_prune_aliases+59/145] dput+0x76/0x209
Nov 10 01:19:49 kefk kernel:  [<c016a092>] dput+0x76/0x209
Nov 10 01:19:49 kefk kernel:  [class_device_add_attrs+40/153] 
bus_add_device+0x55/0x97
Nov 10 01:19:49 kefk kernel:  [<c0250132>] bus_add_device+0x55/0x97
Nov 10 01:19:49 kefk kernel:  [device_attach+33/170] device_add+0xb9/0x15c
Nov 10 01:19:49 kefk kernel:  [<c024f132>] device_add+0xb9/0x15c
Nov 10 01:19:49 kefk kernel:  [proc_scsi_devinfo_read+72/169] 
scsi_sysfs_add_sdev+0xa0/0x309
Nov 10 01:19:49 kefk kernel:  [<c02770aa>] scsi_sysfs_add_sdev+0xa0/0x309
Nov 10 01:19:49 kefk kernel:  [scsi_scan+109/193] scsi_add_lun+0x2d9/0x32f
Nov 10 01:19:49 kefk kernel:  [<c0275cce>] scsi_add_lun+0x2d9/0x32f
Nov 10 01:19:49 kefk kernel:  [show_sg_tablesize+41/42] 
scsi_probe_and_add_lun+0xbd/0x1a9
Nov 10 01:19:49 kefk kernel:  [<c0275de1>] scsi_probe_and_add_lun+0xbd/0x1a9
Nov 10 01:19:49 kefk kernel:  [scsi_sysfs_add_sdev+349/777] 
scsi_scan_target+0x9a/0x106
Nov 10 01:19:49 kefk kernel:  [<c027651b>] scsi_scan_target+0x9a/0x106
Nov 10 01:19:49 kefk kernel:  [scsi_sysfs_add_sdev+581/777] 
scsi_scan_channel+0x7c/0x9a
Nov 10 01:19:49 kefk kernel:  [<c0276603>] scsi_scan_channel+0x7c/0x9a
Nov 10 01:19:49 kefk kernel:  [scsi_sysfs_add_sdev+721/777] 
scsi_scan_host_selected+0x6e/0xc7
Nov 10 01:19:49 kefk kernel:  [<c027668f>] scsi_scan_host_selected+0x6e/0xc7
Nov 10 01:19:49 kefk kernel:  [scsi_remove_device+66/153] 
scsi_scan_host+0x21/0x25
Nov 10 01:19:49 kefk kernel:  [<c0276709>] scsi_scan_host+0x21/0x25
Nov 10 01:19:49 kefk kernel:  [pg0+946468872/1069159424] 
usb_stor_scan_thread+0x134/0x145 [usb_storage]
Nov 10 01:19:49 kefk kernel:  [<f8afc808>] usb_stor_scan_thread+0x134/0x145 
[usb_storage]
Nov 10 01:19:49 kefk kernel:  [wake_up_bit+24/38] 
autoremove_wake_function+0x0/0x43
Nov 10 01:19:49 kefk kernel:  [<c012e761>] autoremove_wake_function+0x0/0x43
Nov 10 01:19:49 kefk kernel:  [ret_from_intr+1/27] ret_from_fork+0x6/0x14
Nov 10 01:19:49 kefk kernel:  [<c0103caa>] ret_from_fork+0x6/0x14
Nov 10 01:19:49 kefk kernel:  [wake_up_bit+24/38] 
autoremove_wake_function+0x0/0x43
Nov 10 01:19:49 kefk kernel:  [<c012e761>] autoremove_wake_function+0x0/0x43
Nov 10 01:19:49 kefk kernel:  [pg0+946468564/1069159424] 
usb_stor_scan_thread+0x0/0x145 [usb_storage]
Nov 10 01:19:49 kefk kernel:  [<f8afc6d4>] usb_stor_scan_thread+0x0/0x145 
[usb_storage]
Nov 10 01:19:49 kefk kernel:  [kernel_thread+10/156] 
kernel_thread_helper+0x5/0xb
Nov 10 01:19:49 kefk kernel:  [<c0102035>] kernel_thread_helper+0x5/0xb
Nov 10 01:19:49 kefk kernel: Attached scsi removable disk sdb at scsi3, 
channel 0, id 0, lun 0
Nov 10 01:19:49 kefk kernel: Attached scsi generic sg4 at scsi3, channel 0, id 
0, lun 0,  type 0
Nov 10 01:19:49 kefk kernel: usb-storage: device scan complete
Nov 10 01:19:49 kefk scsi.agent[7407]: disk 
at /devices/pci0000:00/0000:00:1d.7/usb5/5-3/5-3:1.0/host3/target3:0:0/3:0:0:0
=====================================

Finally, the kernel oops on device removal:


Nov 10 01:20:12 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 10 01:20:12 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Nov 10 01:20:12 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Nov 10 01:20:12 kefk kernel: usb 5-3: USB disconnect, address 8
Nov 10 01:20:12 kefk kernel: usb 5-3: usb_disable_device nuking all URBs
Nov 10 01:20:12 kefk kernel: usb 5-3: unregistering interface 5-3:1.0
Nov 10 01:20:12 kefk kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000050
Nov 10 01:20:12 kefk kernel:  printing eip:
Nov 10 01:20:12 kefk kernel: c01880b4
Nov 10 01:20:12 kefk kernel: *pde = 00000000
Nov 10 01:20:12 kefk kernel: Oops: 0000 [#1]
Nov 10 01:20:12 kefk kernel: PREEMPT SMP
Nov 10 01:20:12 kefk kernel: Modules linked in: usb_storage tun lp parport_pc 
md5 ipv6 rfcomm l2cap bluetooth snd_seq_oss snd_seq_midi_event snd_seq 
snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd 
soundcore ipt_REJECT iptable_filter ip_tables loop nls_utf8 ide_cd i2c_dev 
w83781d i2c_sensor i2c_isa i2c_i801 isofs zlib_inflate e1000 ppa parport 
ehci_hcd usblp uhci_hcd genrtc
Nov 10 01:20:12 kefk kernel: CPU:    0
Nov 10 01:20:12 kefk kernel: EIP:    0060:[sysfs_readdir+164/622]    Tainted: 
P      VLI
Nov 10 01:20:12 kefk kernel: EIP:    0060:[<c01880b4>]    Tainted: P      VLI
Nov 10 01:20:12 kefk kernel: EFLAGS: 00010246   (2.6.10-rc1-mm4)
Nov 10 01:20:12 kefk kernel: EIP is at sysfs_remove_dir+0x1d/0x10b
Nov 10 01:20:12 kefk kernel: eax: f5277588   ebx: f5277588   ecx: f7927b40   
edx: 00000002
Nov 10 01:20:12 kefk kernel: esi: f527a920   edi: 00000000   ebp: f70d1124   
esp: c1bbfdd8
Nov 10 01:20:12 kefk kernel: ds: 007b   es: 007b   ss: 0068
Nov 10 01:20:12 kefk kernel: Process khubd (pid: 139, threadinfo=c1bbf000 
task=c1b8b530)
Nov 10 01:20:12 kefk kernel: Stack: f78a4b74 00000000 f5277588 f527a920 
00000001 f70d1124 c01f3b4c f5277588
Nov 10 01:20:12 kefk kernel:        c01f3b5c f5182980 c01867c8 f7967994 
f527a920 c03bf224 f70d1124 c0298edc
Nov 10 01:20:12 kefk kernel:        f79679b8 f7967994 c024ffc1 f7967994 
f7a92404 f7840800 c02501c7 f7967994
Nov 10 01:20:12 kefk kernel: Call Trace:
Nov 10 01:20:12 kefk kernel:  [send_uevent+125/398] kobject_del+0x14/0x1c
Nov 10 01:20:12 kefk kernel:  [<c01f3b4c>] kobject_del+0x14/0x1c
Nov 10 01:20:12 kefk kernel:  [send_uevent+141/398] 
kobject_unregister+0x8/0x10
Nov 10 01:20:12 kefk kernel:  [<c01f3b5c>] kobject_unregister+0x8/0x10
Nov 10 01:20:12 kefk kernel:  [msdos_partition+40/804] del_gendisk+0x1d/0xd5
Nov 10 01:20:12 kefk kernel:  [<c01867c8>] del_gendisk+0x1d/0xd5
Nov 10 01:20:12 kefk kernel:  [get_sectorsize+381/527] sd_remove+0x17/0x52
Nov 10 01:20:12 kefk kernel:  [<c0298edc>] sd_remove+0x17/0x52
Nov 10 01:20:12 kefk kernel:  [class_hotplug+20/349] 
device_release_driver+0x6d/0x6f
Nov 10 01:20:12 kefk kernel:  [<c024ffc1>] device_release_driver+0x6d/0x6f
Nov 10 01:20:12 kefk kernel:  [class_device_remove_attrs+36/85] 
bus_remove_device+0x53/0x90
Nov 10 01:20:12 kefk kernel:  [<c02501c7>] bus_remove_device+0x53/0x90
Nov 10 01:20:12 kefk kernel:  [device_release_driver+26/111] 
device_del+0x54/0x91
Nov 10 01:20:12 kefk kernel:  [<c024f25a>] device_del+0x54/0x91
Nov 10 01:20:12 kefk kernel:  [scsi_proc_hostdir_add+18/116] 
scsi_remove_device+0x4e/0x99
Nov 10 01:20:12 kefk kernel:  [<c0277361>] scsi_remove_device+0x4e/0x99
Nov 10 01:20:12 kefk kernel:  [scsi_remove_device+115/153] 
scsi_forget_host+0x2d/0x4f
Nov 10 01:20:12 kefk kernel:  [<c027673a>] scsi_forget_host+0x2d/0x4f
Nov 10 01:20:12 kefk kernel:  [scsi_ioctl_send_command+746/755] 
scsi_remove_host+0x8/0x59
Nov 10 01:20:12 kefk kernel:  [<c0270a3b>] scsi_remove_host+0x8/0x59
Nov 10 01:20:12 kefk kernel:  [pg0+946469553/1069159424] 
storage_disconnect+0x7b/0x8d [usb_storage]
Nov 10 01:20:12 kefk kernel:  [<f8afcab1>] storage_disconnect+0x7b/0x8d 
[usb_storage]
Nov 10 01:20:12 kefk kernel:  [usb_buffer_free+57/65] 
usb_unbind_interface+0x5e/0x60
Nov 10 01:20:12 kefk kernel:  [<c02a4bdd>] usb_unbind_interface+0x5e/0x60
Nov 10 01:20:12 kefk kernel:  [class_hotplug+20/349] 
device_release_driver+0x6d/0x6f
Nov 10 01:20:12 kefk kernel:  [<c024ffc1>] device_release_driver+0x6d/0x6f
Nov 10 01:20:12 kefk kernel:  [class_device_remove_attrs+36/85] 
bus_remove_device+0x53/0x90
Nov 10 01:20:12 kefk kernel:  [<c02501c7>] bus_remove_device+0x53/0x90
Nov 10 01:20:12 kefk kernel:  [device_release_driver+26/111] 
device_del+0x54/0x91
Nov 10 01:20:12 kefk kernel:  [<c024f25a>] device_del+0x54/0x91
Nov 10 01:20:12 kefk kernel:  [usb_parse_interface+293/855] 
usb_disable_device+0xda/0x147
Nov 10 01:20:12 kefk kernel:  [<c02ac9e3>] usb_disable_device+0xda/0x147
Nov 10 01:20:12 kefk kernel:  [hub_port_init+472/1396] 
usb_disconnect+0xa8/0x188
Nov 10 01:20:12 kefk kernel:  [<c02a73e5>] usb_disconnect+0xa8/0x188
Nov 10 01:20:12 kefk kernel:  [usb_reset_device+612/1048] 
hub_port_connect_change+0x344/0x477
Nov 10 01:20:12 kefk kernel:  [<c02a88af>] hub_port_connect_change+0x344/0x477
Nov 10 01:20:12 kefk kernel:  [hub_configure+768/2327] 
clear_port_feature+0x48/0x4d
Nov 10 01:20:12 kefk kernel:  [<c02a5b7c>] clear_port_feature+0x48/0x4d
Nov 10 01:20:12 kefk kernel:  [rh_call_control+178/1137] 
hub_events+0x32a/0x4f6
Nov 10 01:20:12 kefk kernel:  [<c02a8d0c>] hub_events+0x32a/0x4f6
Nov 10 01:20:12 kefk kernel:  [rh_call_control+691/1137] hub_thread+0x35/0x10e
Nov 10 01:20:12 kefk kernel:  [<c02a8f0d>] hub_thread+0x35/0x10e
Nov 10 01:20:12 kefk kernel:  [wake_up_bit+24/38] 
autoremove_wake_function+0x0/0x43
Nov 10 01:20:12 kefk kernel:  [<c012e761>] autoremove_wake_function+0x0/0x43
Nov 10 01:20:12 kefk kernel:  [ret_from_intr+1/27] ret_from_fork+0x6/0x14
Nov 10 01:20:12 kefk kernel:  [<c0103caa>] ret_from_fork+0x6/0x14
Nov 10 01:20:12 kefk kernel:  [wake_up_bit+24/38] 
autoremove_wake_function+0x0/0x43
Nov 10 01:20:12 kefk kernel:  [<c012e761>] autoremove_wake_function+0x0/0x43
Nov 10 01:20:12 kefk kernel:  [rh_call_control+638/1137] hub_thread+0x0/0x10e
Nov 10 01:20:12 kefk kernel:  [<c02a8ed8>] hub_thread+0x0/0x10e
Nov 10 01:20:12 kefk kernel:  [kernel_thread+10/156] 
kernel_thread_helper+0x5/0xb
Nov 10 01:20:12 kefk kernel:  [<c0102035>] kernel_thread_helper+0x5/0xb
Nov 10 01:20:12 kefk kernel: Code: 12 1e 33 c0 e9 39 ff ff ff e9 0e ff ff ff 
55 57 56 53 83 ec 08 8b 78 30 85 ff 74 0d 8b 07
 85 c0 0f 84 e6 00 00 00 f0 ff 07 85 ff <8b> 4f 50 0f 84 ab 00 00 00 8b 57 10 
f0 ff 4a 78 0f 88 03 07 00


More details on request :)





-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
