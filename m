Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUKWAAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUKWAAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 19:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUKVX7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:59:09 -0500
Received: from mid-1.inet.it ([213.92.5.18]:63908 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S262468AbUKVX4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:56:43 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2-mm3
Date: Tue, 23 Nov 2004 00:56:11 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20041121223929.40e038b2.akpm@osdl.org>
In-Reply-To: <20041121223929.40e038b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411230056.11646.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 07:39, lunedì 22 novembre 2004, Andrew Morton ha scritto:

> 2.6.10-rc2-mm3

Well; I've tested mm3 with my usb flash key; the behaviour is changed and 
improved, but as expected by reading the previous thread there is some 
issues; I'm reporting it, just in case.

Now, after some tries (as before, it takes some tries to have the device 
identified by the kernel, maybe some tight timeout...), as always I get a 
kobject problem but on removal I can  see a "BUG: atomic counter underflow 
at:"; anyway the box survives quite well and when device is inserted (and 
identified by the kernel, of course), is possible to mount and use it, 
whitout usb subsystem lock on removal.


The (timeout?) problem is still here:

Nov 23 00:09:32 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 23 00:09:32 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov 23 00:09:32 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov 23 00:09:32 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov 23 00:09:32 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 23 00:09:32 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 23 00:09:32 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 3
Nov 23 00:09:32 kefk kernel: ehci_hcd 0000:00:1d.7: devpath 3 ep0in 3strikes
Nov 23 00:09:32 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 full speed --> 
companion
Nov 23 00:09:32 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
003801 POWER OWNER sig=j  CONNECT
Nov 23 00:09:32 kefk kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Nov 23 00:09:32 kefk kernel: hub 2-0:1.0: state 5 ports 2 chg fffc evt 0002
Nov 23 00:09:32 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0083,00
Nov 23 00:09:32 kefk kernel: hub 2-0:1.0: port 1, status 0101, change 0001, 12 
Mb/s
Nov 23 00:09:32 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x101
Nov 23 00:09:32 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 2
Nov 23 00:09:32 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 23 00:09:32 kefk kernel: [f7a73240] link (37a731b2) element (37ab2040)
Nov 23 00:09:32 kefk kernel:   0: [f7ab2040] link (37ab2080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=36edfba0)
Nov 23 00:09:32 kefk kernel:   1: [f7ab2080] link (37ab20c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=36252980)
Nov 23 00:09:32 kefk kernel:   2: [f7ab20c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov 23 00:09:32 kefk kernel:
Nov 23 00:09:32 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 23 00:09:32 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 23 00:09:32 kefk kernel: [f7a73240] link (37a731b2) element (37ab2040)
Nov 23 00:09:32 kefk kernel:   0: [f7ab2040] link (37ab2080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=36edfba0)
Nov 23 00:09:32 kefk kernel:   1: [f7ab2080] link (37ab20c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=36252980)
Nov 23 00:09:32 kefk kernel:   2: [f7ab20c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov 23 00:09:32 kefk kernel:
Nov 23 00:09:33 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 23 00:09:33 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 3
Nov 23 00:09:33 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 23 00:09:33 kefk kernel: [f7a73240] link (37a731b2) element (37ab2040)
Nov 23 00:09:33 kefk kernel:   0: [f7ab2040] link (37ab2080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=36edfba0)
Nov 23 00:09:33 kefk kernel:   1: [f7ab2080] link (37ab20c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=36252980)
Nov 23 00:09:33 kefk kernel:   2: [f7ab20c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov 23 00:09:33 kefk kernel:
Nov 23 00:09:33 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 23 00:09:33 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 23 00:09:33 kefk kernel: [f7a73240] link (37a731b2) element (37ab2040)
Nov 23 00:09:33 kefk kernel:   0: [f7ab2040] link (37ab2080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=36edfba0)
Nov 23 00:09:33 kefk kernel:   1: [f7ab2080] link (37ab20c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=36252980)
Nov 23 00:09:33 kefk kernel:   2: [f7ab20c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov 23 00:09:33 kefk kernel:
Nov 23 00:09:33 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 23 00:09:33 kefk kernel: hub 2-0:1.0: state 5 ports 2 chg fffc evt 0002
Nov 23 00:09:38 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 23 00:09:38 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Nov 23 00:09:38 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Nov 23 00:09:38 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x100
Nov 23 00:09:38 kefk kernel: hub 2-0:1.0: state 5 ports 2 chg fffc evt 0002
Nov 23 00:09:38 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0082,00
Nov 23 00:09:38 kefk kernel: hub 2-0:1.0: port 1, status 0100, change 0001, 12 
Mb/s
Nov 23 00:09:38 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x100
Nov 23 00:09:39 kefk kernel: uhci_hcd 0000:00:1d.1: suspend_hc
[...]
=========
After some tries, now it almost works (still double entry for sdb1 in logs):
Nov 23 00:10:11 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 23 00:10:11 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov 23 00:10:11 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov 23 00:10:11 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov 23 00:10:11 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 23 00:10:11 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 23 00:10:11 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 7
Nov 23 00:10:11 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 23 00:10:11 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 23 00:10:11 kefk kernel: usb 5-3: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Nov 23 00:10:11 kefk kernel: usb 5-3: default language 0x0409
Nov 23 00:10:11 kefk kernel: usb 5-3: Product: Mass storage
Nov 23 00:10:11 kefk kernel: usb 5-3: Manufacturer: USB
Nov 23 00:10:11 kefk kernel: usb 5-3: SerialNumber: 142E19413C2FCA34
Nov 23 00:10:11 kefk kernel: usb 5-3: hotplug
Nov 23 00:10:11 kefk kernel: usb 5-3: adding 5-3:1.0 (config #1, interface 0)
Nov 23 00:10:11 kefk kernel: usb 5-3:1.0: hotplug
Nov 23 00:10:11 kefk kernel: Initializing USB Mass Storage driver...
Nov 23 00:10:11 kefk kernel: usb-storage 5-3:1.0: usb_probe_interface
Nov 23 00:10:11 kefk kernel: usb-storage 5-3:1.0: usb_probe_interface - got id
Nov 23 00:10:11 kefk kernel: scsi3 : SCSI emulation for USB Mass Storage 
devices
Nov 23 00:10:11 kefk kernel: usbcore: registered new driver usb-storage
Nov 23 00:10:11 kefk kernel: USB Mass Storage support registered.
Nov 23 00:10:11 kefk kernel: usb-storage: device found at 7
Nov 23 00:10:11 kefk kernel: usb-storage: waiting for device to settle before 
scanning
Nov 23 00:10:16 kefk kernel:   Vendor: 512MB     Model: USB2.0FlashDrive  Rev: 
2.00
Nov 23 00:10:16 kefk kernel:   Type:   Direct-Access                      ANSI 
SCSI revision: 02
Nov 23 00:10:16 kefk kernel: sdb: Unit Not Ready, sense:
Nov 23 00:10:16 kefk kernel: : Current: sense key=0x6
Nov 23 00:10:16 kefk kernel:     ASC=0x28 ASCQ=0x0
Nov 23 00:10:17 kefk kernel: sdb : READ CAPACITY failed.
Nov 23 00:10:17 kefk kernel: sdb : status=1, message=00, host=0, driver=08
Nov 23 00:10:17 kefk kernel: sd: Current: sense key=0x6
Nov 23 00:10:17 kefk kernel:     ASC=0x28 ASCQ=0x0
Nov 23 00:10:17 kefk kernel: sdb: test WP failed, assume Write Enabled
Nov 23 00:10:17 kefk kernel: sdb: assuming drive cache: write through
Nov 23 00:10:17 kefk kernel: sdb: Unit Not Ready, sense:
Nov 23 00:10:17 kefk kernel: : Current: sense key=0x6
Nov 23 00:10:17 kefk kernel:     ASC=0x28 ASCQ=0x0
Nov 23 00:10:17 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov 23 00:10:17 kefk kernel: sdb: Write Protect is off
Nov 23 00:10:17 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov 23 00:10:17 kefk kernel: sdb: assuming drive cache: write through
Nov 23 00:10:17 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov 23 00:10:17 kefk kernel: sdb: Write Protect is off
Nov 23 00:10:17 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov 23 00:10:17 kefk kernel: sdb: assuming drive cache: write through
Nov 23 00:10:17 kefk kernel:  sdb: sdb1
Nov 23 00:10:17 kefk kernel:  sdb: sdb1
Nov 23 00:10:17 kefk kernel: kobject_register failed for sdb1 (-17)
Nov 23 00:10:17 kefk kernel:  [bitmap_scnlistprintf+191/292] 
kobject_register+0x51/0x5f
Nov 23 00:10:17 kefk kernel:  [<c01f28eb>] kobject_register+0x51/0x5f
Nov 23 00:10:17 kefk kernel:  [stat_open+45/154] add_partition+0xbb/0xf0
Nov 23 00:10:17 kefk kernel:  [<c0185208>] add_partition+0xbb/0xf0
Nov 23 00:10:17 kefk kernel:  [cmdline_read_proc+9/103] 
register_disk+0xee/0x11d
Nov 23 00:10:17 kefk kernel:  [<c0185380>] register_disk+0xee/0x11d
Nov 23 00:10:17 kefk kernel:  [unregister_blkdev+144/232] add_disk+0x36/0x41
Nov 23 00:10:17 kefk kernel:  [<c02577d6>] add_disk+0x36/0x41
Nov 23 00:10:17 kefk kernel:  [unregister_blkdev+70/232] exact_match+0x0/0x7
Nov 23 00:10:17 kefk kernel:  [<c025778c>] exact_match+0x0/0x7
Nov 23 00:10:17 kefk kernel:  [unregister_blkdev+77/232] exact_lock+0x0/0xd
Nov 23 00:10:17 kefk kernel:  [<c0257793>] exact_lock+0x0/0xd
Nov 23 00:10:17 kefk kernel:  [sd_remove+76/82] sd_probe+0x224/0x32f
Nov 23 00:10:17 kefk kernel:  [<c02982c5>] sd_probe+0x224/0x32f
Nov 23 00:10:17 kefk kernel:  [msdos_partition+391/804] 
sysfs_make_dirent+0x1c/0x89
Nov 23 00:10:17 kefk kernel:  [<c0186927>] sysfs_make_dirent+0x1c/0x89
Nov 23 00:10:17 kefk kernel:  [__lock_text_end+370/4802] _spin_lock+0x23/0x5e
Nov 23 00:10:17 kefk kernel:  [<c031f36c>] _spin_lock+0x23/0x5e
Nov 23 00:10:17 kefk kernel:  [__bus_for_each_drv+81/114] 
driver_probe_device+0x29/0x6a
Nov 23 00:10:17 kefk kernel:  [<c024efa0>] driver_probe_device+0x29/0x6a
Nov 23 00:10:17 kefk kernel:  [bus_for_each_drv+28/74] device_attach+0x46/0xaa
Nov 23 00:10:17 kefk kernel:  [<c024f027>] device_attach+0x46/0xaa
Nov 23 00:10:17 kefk kernel:  [fcntl_setlk+333/707] dput+0x76/0x209
Nov 23 00:10:17 kefk kernel:  [<c0168de2>] dput+0x76/0x209
Nov 23 00:10:17 kefk kernel:  [device_add_attrs+32/161] 
bus_add_device+0x55/0x97
Nov 23 00:10:17 kefk kernel:  [<c024f2ee>] bus_add_device+0x55/0x97
Nov 23 00:10:17 kefk kernel:  [device_remove_file+12/61] device_add+0xb9/0x15c
Nov 23 00:10:17 kefk kernel:  [<c024e2ee>] device_add+0xb9/0x15c
Nov 23 00:10:17 kefk kernel:  [scsi_sysfs_add_sdev+651/777] 
scsi_sysfs_add_sdev+0xa0/0x309
Nov 23 00:10:17 kefk kernel:  [<c0276649>] scsi_sysfs_add_sdev+0xa0/0x309
Nov 23 00:10:17 kefk kernel:  [scsi_probe_and_add_lun+292/425] 
scsi_add_lun+0x2d9/0x32f
Nov 23 00:10:17 kefk kernel:  [<c02751fc>] scsi_add_lun+0x2d9/0x32f
Nov 23 00:10:17 kefk kernel:  [scsi_sequential_lun_scan+142/239] 
scsi_probe_and_add_lun+0xbd/0x1c2
Nov 23 00:10:17 kefk kernel:  [<c027530f>] scsi_probe_and_add_lun+0xbd/0x1c2
Nov 23 00:10:17 kefk kernel:  [scsi_scan_host_selected+180/199] 
scsi_scan_target+0x9a/0x106
Nov 23 00:10:17 kefk kernel:  [<c0275a89>] scsi_scan_target+0x9a/0x106
Nov 23 00:10:17 kefk kernel:  [scsi_free_host_dev+51/64] 
scsi_scan_channel+0x7c/0x9a
Nov 23 00:10:17 kefk kernel:  [<c0275b71>] scsi_scan_channel+0x7c/0x9a
Nov 23 00:10:17 kefk kernel:  [check_set+39/139] 
scsi_scan_host_selected+0x6e/0xc7
Nov 23 00:10:17 kefk kernel:  [<c0275bfd>] scsi_scan_host_selected+0x6e/0xc7
Nov 23 00:10:17 kefk kernel:  [scsi_scan+22/193] scsi_scan_host+0x21/0x25
Nov 23 00:10:17 kefk kernel:  [<c0275c77>] scsi_scan_host+0x21/0x25
Nov 23 00:10:17 kefk kernel:  [pg0+946558698/1069159424] 
usb_stor_scan_thread+0x13a/0x14b [usb_storage]
Nov 23 00:10:17 kefk kernel:  [<f8b126ea>] usb_stor_scan_thread+0x13a/0x14b 
[usb_storage]
Nov 23 00:10:17 kefk kernel:  [do_timer_gettime+232/297] 
autoremove_wake_function+0x0/0x43
Nov 23 00:10:17 kefk kernel:  [<c012d031>] autoremove_wake_function+0x0/0x43
Nov 23 00:10:17 kefk kernel:  [copy_thread+542/592] ret_from_fork+0x6/0x14
Nov 23 00:10:17 kefk kernel:  [<c0102506>] ret_from_fork+0x6/0x14
Nov 23 00:10:17 kefk kernel:  [do_timer_gettime+232/297] 
autoremove_wake_function+0x0/0x43
Nov 23 00:10:17 kefk kernel:  [<c012d031>] autoremove_wake_function+0x0/0x43
Nov 23 00:10:17 kefk kernel:  [pg0+946558384/1069159424] 
usb_stor_scan_thread+0x0/0x14b [usb_storage]
Nov 23 00:10:17 kefk kernel:  [<f8b125b0>] usb_stor_scan_thread+0x0/0x14b 
[usb_storage]
Nov 23 00:10:17 kefk kernel:  [huft_build+637/1249] 
kernel_thread_helper+0x5/0xb
Nov 23 00:10:17 kefk kernel:  [<c01008a5>] kernel_thread_helper+0x5/0xb
Nov 23 00:10:17 kefk kernel: Attached scsi removable disk sdb at scsi3, 
channel 0, id 0, lun 0
Nov 23 00:10:17 kefk kernel: Attached scsi generic sg4 at scsi3, channel 0, id 
0, lun 0,  type 0
Nov 23 00:10:17 kefk kernel: usb-storage: device scan complete
Nov 23 00:10:17 kefk scsi.agent[7398]: disk 
at /devices/pci0000:00/0000:00:1d.7/usb5/5-3/5-3:1.0/host3/target3:0:0/3:0:0:0

============
device removal:
Nov 23 00:10:26 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 23 00:10:26 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Nov 23 00:10:26 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Nov 23 00:10:26 kefk kernel: usb 5-3: USB disconnect, address 7
Nov 23 00:10:26 kefk kernel: usb 5-3: usb_disable_device nuking all URBs
Nov 23 00:10:26 kefk kernel: usb 5-3: unregistering interface 5-3:1.0
Nov 23 00:10:26 kefk kernel: BUG: atomic counter underflow at:
Nov 23 00:10:26 kefk kernel:  [create_dir+25/68] kref_put+0x48/0x92
Nov 23 00:10:26 kefk kernel:  [<c01f33aa>] kref_put+0x48/0x92
Nov 23 00:10:26 kefk kernel:  [storenote+15/185] del_gendisk+0x1d/0xd5
Nov 23 00:10:26 kefk kernel:  [<c0185588>] del_gendisk+0x1d/0xd5
Nov 23 00:10:26 kefk kernel:  [sr_media_change+27/157] sd_remove+0x17/0x52
Nov 23 00:10:26 kefk kernel:  [<c02983e7>] sd_remove+0x17/0x52
Nov 23 00:10:26 kefk kernel:  [device_attach+108/170] 
device_release_driver+0x6d/0x6f
Nov 23 00:10:26 kefk kernel:  [<c024f17d>] device_release_driver+0x6d/0x6f
Nov 23 00:10:26 kefk kernel:  [device_remove_attrs+20/90] 
bus_remove_device+0x53/0x90
Nov 23 00:10:26 kefk kernel:  [<c024f383>] bus_remove_device+0x53/0x90
Nov 23 00:10:26 kefk kernel:  [device_add+177/348] device_del+0x54/0x91
Nov 23 00:10:26 kefk kernel:  [<c024e416>] device_del+0x54/0x91
Nov 23 00:10:26 kefk kernel:  [scsi_sysfs_add_host+233/303] 
scsi_remove_device+0x4e/0xab
Nov 23 00:10:26 kefk kernel:  [<c0276900>] scsi_remove_device+0x4e/0xab
Nov 23 00:10:26 kefk kernel:  [scsi_scan+71/193] scsi_forget_host+0x2d/0x4f
Nov 23 00:10:26 kefk kernel:  [<c0275ca8>] scsi_forget_host+0x2d/0x4f
Nov 23 00:10:26 kefk kernel:  [scsi_device_lookup+63/106] 
scsi_remove_host+0x8/0x7c
Nov 23 00:10:26 kefk kernel:  [<c026fbbb>] scsi_remove_host+0x8/0x7c
Nov 23 00:10:26 kefk kernel:  [pg0+946559379/1069159424] 
storage_disconnect+0x7b/0x8d [usb_storage]
Nov 23 00:10:26 kefk kernel:  [<f8b12993>] storage_disconnect+0x7b/0x8d 
[usb_storage]
Nov 23 00:10:26 kefk kernel:  [usb_epnum_to_ep_desc+74/145] 
usb_unbind_interface+0x5e/0x60
Nov 23 00:10:26 kefk kernel:  [<c02a415d>] usb_unbind_interface+0x5e/0x60
Nov 23 00:10:26 kefk kernel:  [device_attach+108/170] 
device_release_driver+0x6d/0x6f
Nov 23 00:10:26 kefk kernel:  [<c024f17d>] device_release_driver+0x6d/0x6f
Nov 23 00:10:26 kefk kernel:  [device_remove_attrs+20/90] 
bus_remove_device+0x53/0x90
Nov 23 00:10:26 kefk kernel:  [<c024f383>] bus_remove_device+0x53/0x90
Nov 23 00:10:26 kefk kernel:  [device_add+177/348] device_del+0x54/0x91
Nov 23 00:10:26 kefk kernel:  [<c024e416>] device_del+0x54/0x91
Nov 23 00:10:26 kefk kernel:  [usb_set_interface+31/431] 
usb_disable_device+0xda/0x147
Nov 23 00:10:26 kefk kernel:  [<c02abf27>] usb_disable_device+0xda/0x147
Nov 23 00:10:26 kefk kernel:  [show_string+24/170] usb_disconnect+0xa8/0x188
Nov 23 00:10:26 kefk kernel:  [<c02a6969>] usb_disconnect+0xa8/0x188
Nov 23 00:10:26 kefk kernel:  [hub_events+52/1270] 
hub_port_connect_change+0x344/0x477
Nov 23 00:10:26 kefk kernel:  [<c02a7e1e>] hub_port_connect_change+0x344/0x477
Nov 23 00:10:26 kefk kernel:  [led_work+187/369] clear_port_feature+0x48/0x4d
Nov 23 00:10:26 kefk kernel:  [<c02a5100>] clear_port_feature+0x48/0x4d
Nov 23 00:10:26 kefk kernel:  [hub_events+1169/1270] hub_events+0x32a/0x4f6
Nov 23 00:10:26 kefk kernel:  [<c02a827b>] hub_events+0x32a/0x4f6
Nov 23 00:10:26 kefk kernel:  [usb_hub_cleanup+35/40] hub_thread+0x35/0x10e
Nov 23 00:10:26 kefk kernel:  [<c02a847c>] hub_thread+0x35/0x10e
Nov 23 00:10:26 kefk kernel:  [do_timer_gettime+232/297] 
autoremove_wake_function+0x0/0x43
Nov 23 00:10:26 kefk kernel:  [<c012d031>] autoremove_wake_function+0x0/0x43
Nov 23 00:10:26 kefk kernel:  [copy_thread+542/592] ret_from_fork+0x6/0x14
Nov 23 00:10:26 kefk kernel:  [<c0102506>] ret_from_fork+0x6/0x14
Nov 23 00:10:26 kefk kernel:  [do_timer_gettime+232/297] 
autoremove_wake_function+0x0/0x43
Nov 23 00:10:26 kefk kernel:  [<c012d031>] autoremove_wake_function+0x0/0x43
Nov 23 00:10:26 kefk kernel:  [usb_hub_init+89/107] hub_thread+0x0/0x10e
Nov 23 00:10:26 kefk kernel:  [<c02a8447>] hub_thread+0x0/0x10e
Nov 23 00:10:26 kefk kernel:  [huft_build+637/1249] 
kernel_thread_helper+0x5/0xb
Nov 23 00:10:26 kefk kernel:  [<c01008a5>] kernel_thread_helper+0x5/0xb
Nov 23 00:10:26 kefk kernel: usb 5-3:1.0: hotplug
Nov 23 00:10:26 kefk kernel: usb 5-3: unregistering device
Nov 23 00:10:26 kefk kernel: usb 5-3: hotplug
Nov 23 00:10:26 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x100

HTH


-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
