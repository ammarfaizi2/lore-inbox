Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270664AbTHAEz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 00:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270666AbTHAEz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 00:55:28 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:52636 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270664AbTHAEzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 00:55:16 -0400
Date: Thu, 31 Jul 2003 21:54:49 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: udok@caramail.com
Subject: [Bug 1021] New: Some "Badness in ... Call Trace ..." when I unplug an usb drive.
Message-ID: <68440000.1059713689@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1021

           Summary: Some "Badness in ... Call Trace ..." when I unplug an
                    usb drive.
    Kernel Version: 2.6.0-test2-mm2
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: udok@caramail.com


Distribution: Debian sid
Hardware Environment: amd xp-2600+, nforce2 (nvnet(patched)+alsa(i8x0)+ohci),
gforceTI4600 (nvidia drivers 4496 + minion.de patch)
Software Environment: sid with no broken dependency
Problem Description:


When I unplugged my usb drive, I got an error in syslog file (although I
unmounted it before)
bellow is the part of my syslog file, since I plugged my usb drive, until I
unplugged it :

Aug  1 03:16:31 client kernel: hub 2-0:0: debounce: port 2: delay 100ms stable 4
status 0x101
Aug  1 03:16:31 client kernel: hub 2-0:0: new USB device on port 2, assigned
address 2
Aug  1 03:16:31 client kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Aug  1 03:16:31 client kernel:   Vendor: TwinMOS   Model: MOBILE Disk       Rev:
1.11
Aug  1 03:16:31 client kernel:   Type:   Direct-Access                      ANSI
SCSI revision: 02
Aug  1 03:16:31 client kernel: SCSI device sda: 129024 512-byte hdwr sectors (66 MB)
Aug  1 03:16:31 client kernel: sda: test WP failed, assume Write Enabled
Aug  1 03:16:32 client kernel: sda: asking for cache data failed
Aug  1 03:16:32 client kernel: sda: assuming drive cache: write through
Aug  1 03:16:32 client kernel:  /dev/scsi/host0/bus0/target0/lun0: p1
Aug  1 03:16:32 client kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 0, lun 0
Aug  1 03:16:32 client kernel: Attached scsi generic sg0 at scsi0, channel 0, id
0, lun 0,  type 0
Aug  1 03:16:32 client kernel: WARNING: USB Mass Storage data integrity not assured
Aug  1 03:16:32 client kernel: USB Mass Storage device found at 2
Aug  1 03:17:44 client modprobe: FATAL: Module /dev/scd0 not found.
Aug  1 03:18:15 client last message repeated 2 times
Aug  1 03:18:15 client modprobe: FATAL: Module /dev/scd0 not found.
Aug  1 03:21:38 client kernel: usb 2-2: USB disconnect, address 2
Aug  1 03:21:38 client kernel: Device class '0:0:0:0' does not have a release()
function, it is broken and mus
t be fixed.
Aug  1 03:21:38 client kernel: Badness in class_dev_release at
drivers/base/class.c:201
Aug  1 03:21:38 client kernel: Call Trace:
Aug  1 03:21:38 client kernel:  [kobject_cleanup+131/144] kobject_cleanup+0x83/0x90
Aug  1 03:21:38 client kernel:  [class_device_unregister+19/48]
class_device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [_end+559509099/1070142156]
scsi_device_unregister+0x1f/0x30 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559506491/1070142156]
scsi_remove_device+0xf/0x20 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559506997/1070142156]
scsi_forget_host+0x19/0x30 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559484931/1070142156]
scsi_remove_host+0x37/0x50 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559324218/1070142156]
storage_disconnect+0x7e/0xa3 [usb_storage]
Aug  1 03:21:38 client kernel:  [usb_device_remove+119/128]
usb_device_remove+0x77/0x80
Aug  1 03:21:38 client kernel:  [device_release_driver+98/112]
device_release_driver+0x62/0x70
Aug  1 03:21:38 client kernel:  [bus_remove_device+94/176]
bus_remove_device+0x5e/0xb0
Aug  1 03:21:38 client kernel:  [device_del+93/160] device_del+0x5d/0xa0
Aug  1 03:21:38 client kernel:  [device_unregister+19/48]
device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [usb_disconnect+169/272] usb_disconnect+0xa9/0x110
Aug  1 03:21:38 client kernel:  [hub_port_connect_change+789/800]
hub_port_connect_change+0x315/0x320
Aug  1 03:21:38 client kernel:  [hub_port_status+61/176] hub_port_status+0x3d/0xb0
Aug  1 03:21:38 client kernel:  [hub_events+720/848] hub_events+0x2d0/0x350
Aug  1 03:21:38 client kernel:  [hub_thread+42/224] hub_thread+0x2a/0xe0
Aug  1 03:21:38 client kernel:  [default_wake_function+0/48]
default_wake_function+0x0/0x30
Aug  1 03:21:38 client kernel:  [hub_thread+0/224] hub_thread+0x0/0xe0
Aug  1 03:21:38 client kernel:  [kernel_thread_helper+5/12]
kernel_thread_helper+0x5/0xc
Aug  1 03:21:38 client kernel:
Aug  1 03:21:38 client kernel: kobject 'class_obj' does not have a release()
function, it is broken and must b
e fixed.
Aug  1 03:21:38 client kernel: Badness in kobject_cleanup at lib/kobject.c:402
Aug  1 03:21:38 client kernel: Call Trace:
Aug  1 03:21:38 client kernel:  [kobject_cleanup+95/144] kobject_cleanup+0x5f/0x90
Aug  1 03:21:38 client kernel:  [_end+559509099/1070142156]
scsi_device_unregister+0x1f/0x30 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559506491/1070142156]
scsi_remove_device+0xf/0x20 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559506997/1070142156]
scsi_forget_host+0x19/0x30 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559484931/1070142156]
scsi_remove_host+0x37/0x50 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559324218/1070142156]
storage_disconnect+0x7e/0xa3 [usb_storage]
Aug  1 03:21:38 client kernel:  [usb_device_remove+119/128]
usb_device_remove+0x77/0x80
Aug  1 03:21:38 client kernel:  [device_release_driver+98/112]
device_release_driver+0x62/0x70
Aug  1 03:21:38 client kernel:  [bus_remove_device+94/176]
bus_remove_device+0x5e/0xb0
Aug  1 03:21:38 client kernel:  [device_del+93/160] device_del+0x5d/0xa0
Aug  1 03:21:38 client kernel:  [device_unregister+19/48]
device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [usb_disconnect+169/272] usb_disconnect+0xa9/0x110
Aug  1 03:21:38 client kernel:  [hub_port_connect_change+789/800]
hub_port_connect_change+0x315/0x320
Aug  1 03:21:38 client kernel:  [hub_port_status+61/176] hub_port_status+0x3d/0xb0
Aug  1 03:21:38 client kernel:  [hub_events+720/848] hub_events+0x2d0/0x350
Aug  1 03:21:38 client kernel:  [hub_thread+42/224] hub_thread+0x2a/0xe0
Aug  1 03:21:38 client kernel:  [default_wake_function+0/48]
default_wake_function+0x0/0x30
Aug  1 03:21:38 client kernel:  [hub_thread+0/224] hub_thread+0x0/0xe0
Aug  1 03:21:38 client kernel:  [kernel_thread_helper+5/12]
kernel_thread_helper+0x5/0xc
Aug  1 03:21:38 client kernel:
Aug  1 03:21:38 client kernel: kobject 'sda1' does not have a release()
function, it is broken and must be fix
ed.
Aug  1 03:21:38 client kernel: Badness in kobject_cleanup at lib/kobject.c:402
Aug  1 03:21:38 client kernel: Call Trace:
Aug  1 03:21:38 client kernel:  [kobject_cleanup+95/144] kobject_cleanup+0x5f/0x90
Aug  1 03:21:38 client kernel:  [delete_partition+139/176]
delete_partition+0x8b/0xb0
Aug  1 03:21:38 client kernel:  [del_gendisk+43/224] del_gendisk+0x2b/0xe0
Aug  1 03:21:38 client kernel:  [_end+559085836/1070142156] sd_remove+0x20/0x70
[sd_mod]
Aug  1 03:21:38 client kernel:  [device_release_driver+98/112]
device_release_driver+0x62/0x70
Aug  1 03:21:38 client kernel:  [bus_remove_device+94/176]
bus_remove_device+0x5e/0xb0
Aug  1 03:21:38 client kernel:  [device_del+93/160] device_del+0x5d/0xa0
Aug  1 03:21:38 client kernel:  [device_unregister+19/48]
device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [_end+559506491/1070142156]
scsi_remove_device+0xf/0x20 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559506997/1070142156]
scsi_forget_host+0x19/0x30 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559484931/1070142156]
scsi_remove_host+0x37/0x50 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559324218/1070142156]
storage_disconnect+0x7e/0xa3 [usb_storage]
Aug  1 03:21:38 client kernel:  [usb_device_remove+119/128]
usb_device_remove+0x77/0x80
Aug  1 03:21:38 client kernel:  [device_release_driver+98/112]
device_release_driver+0x62/0x70
Aug  1 03:21:38 client kernel:  [bus_remove_device+94/176]
bus_remove_device+0x5e/0xb0
Aug  1 03:21:38 client kernel:  [device_del+93/160] device_del+0x5d/0xa0
Aug  1 03:21:38 client kernel:  [device_unregister+19/48]
device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [usb_disconnect+169/272] usb_disconnect+0xa9/0x110
Aug  1 03:21:38 client kernel:  [hub_port_connect_change+789/800]
hub_port_connect_change+0x315/0x320
Aug  1 03:21:38 client kernel:  [hub_port_status+61/176] hub_port_status+0x3d/0xb0
Aug  1 03:21:38 client kernel:  [hub_events+720/848] hub_events+0x2d0/0x350
Aug  1 03:21:38 client kernel:  [hub_thread+42/224] hub_thread+0x2a/0xe0
Aug  1 03:21:38 client kernel:  [default_wake_function+0/48]
default_wake_function+0x0/0x30
Aug  1 03:21:38 client kernel:  [hub_thread+0/224] hub_thread+0x0/0xe0
Aug  1 03:21:38 client kernel:  [kernel_thread_helper+5/12]
kernel_thread_helper+0x5/0xc
Aug  1 03:21:38 client kernel:
Aug  1 03:21:38 client kernel: kobject 'iosched' does not have a release()
function, it is broken and must be
fixed.
Aug  1 03:21:38 client kernel: Badness in kobject_cleanup at lib/kobject.c:402
Aug  1 03:21:38 client kernel: Call Trace:
Aug  1 03:21:38 client kernel:  [kobject_cleanup+95/144] kobject_cleanup+0x5f/0x90
Aug  1 03:21:38 client kernel:  [elv_unregister_queue+26/64]
elv_unregister_queue+0x1a/0x40
Aug  1 03:21:38 client kernel:  [blk_unregister_queue+30/80]
blk_unregister_queue+0x1e/0x50
Aug  1 03:21:38 client kernel:  [unlink_gendisk+33/144] unlink_gendisk+0x21/0x90
Aug  1 03:21:38 client kernel:  [del_gendisk+88/224] del_gendisk+0x58/0xe0
Aug  1 03:21:38 client kernel:  [_end+559085836/1070142156] sd_remove+0x20/0x70
[sd_mod]
Aug  1 03:21:38 client kernel:  [device_release_driver+98/112]
device_release_driver+0x62/0x70
Aug  1 03:21:38 client kernel:  [bus_remove_device+94/176]
bus_remove_device+0x5e/0xb0
Aug  1 03:21:38 client kernel:  [device_del+93/160] device_del+0x5d/0xa0
Aug  1 03:21:38 client kernel:  [device_unregister+19/48]
device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [_end+559506491/1070142156]
scsi_remove_device+0xf/0x20 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559506997/1070142156]
scsi_forget_host+0x19/0x30 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559484931/1070142156]
scsi_remove_host+0x37/0x50 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559324218/1070142156]
storage_disconnect+0x7e/0xa3 [usb_storage]
Aug  1 03:21:38 client kernel:  [usb_device_remove+119/128]
usb_device_remove+0x77/0x80
Aug  1 03:21:38 client kernel:  [device_release_driver+98/112]
device_release_driver+0x62/0x70
Aug  1 03:21:38 client kernel:  [bus_remove_device+94/176]
bus_remove_device+0x5e/0xb0
Aug  1 03:21:38 client kernel:  [device_del+93/160] device_del+0x5d/0xa0
Aug  1 03:21:38 client kernel:  [device_unregister+19/48]
device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [usb_disconnect+169/272] usb_disconnect+0xa9/0x110
Aug  1 03:21:38 client kernel:  [hub_port_connect_change+789/800]
hub_port_connect_change+0x315/0x320
Aug  1 03:21:38 client kernel:  [hub_port_status+61/176] hub_port_status+0x3d/0xb0
Aug  1 03:21:38 client kernel:  [hub_events+720/848] hub_events+0x2d0/0x350
Aug  1 03:21:38 client kernel:  [hub_thread+42/224] hub_thread+0x2a/0xe0
Aug  1 03:21:38 client kernel:  [default_wake_function+0/48]
default_wake_function+0x0/0x30
Aug  1 03:21:38 client kernel:  [hub_thread+0/224] hub_thread+0x0/0xe0
Aug  1 03:21:38 client kernel:  [kernel_thread_helper+5/12]
kernel_thread_helper+0x5/0xc
Aug  1 03:21:38 client kernel:
Aug  1 03:21:38 client kernel: kobject 'queue' does not have a release()
function, it is broken and must be fi
xed.
Aug  1 03:21:38 client kernel: Badness in kobject_cleanup at lib/kobject.c:402
Aug  1 03:21:38 client kernel: Call Trace:
Aug  1 03:21:38 client kernel:  [kobject_cleanup+95/144] kobject_cleanup+0x5f/0x90
Aug  1 03:21:38 client kernel:  [blk_unregister_queue+44/80]
blk_unregister_queue+0x2c/0x50
Aug  1 03:21:38 client kernel:  [unlink_gendisk+33/144] unlink_gendisk+0x21/0x90
Aug  1 03:21:38 client kernel:  [del_gendisk+88/224] del_gendisk+0x58/0xe0
Aug  1 03:21:38 client kernel:  [_end+559085836/1070142156] sd_remove+0x20/0x70
[sd_mod]
Aug  1 03:21:38 client kernel:  [device_release_driver+98/112]
device_release_driver+0x62/0x70
Aug  1 03:21:38 client kernel:  [bus_remove_device+94/176]
bus_remove_device+0x5e/0xb0
Aug  1 03:21:38 client kernel:  [device_del+93/160] device_del+0x5d/0xa0
Aug  1 03:21:38 client kernel:  [device_unregister+19/48]
device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [_end+559506491/1070142156]
scsi_remove_device+0xf/0x20 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559506997/1070142156]
scsi_forget_host+0x19/0x30 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559484931/1070142156]
scsi_remove_host+0x37/0x50 [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559324218/1070142156]
storage_disconnect+0x7e/0xa3 [usb_storage]
Aug  1 03:21:38 client kernel:  [usb_device_remove+119/128]
usb_device_remove+0x77/0x80
Aug  1 03:21:38 client kernel:  [device_release_driver+98/112]
device_release_driver+0x62/0x70
Aug  1 03:21:38 client kernel:  [bus_remove_device+94/176]
bus_remove_device+0x5e/0xb0
Aug  1 03:21:38 client kernel:  [device_del+93/160] device_del+0x5d/0xa0
Aug  1 03:21:38 client kernel:  [device_unregister+19/48]
device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [usb_disconnect+169/272] usb_disconnect+0xa9/0x110
Aug  1 03:21:38 client kernel:  [hub_port_connect_change+789/800]
hub_port_connect_change+0x315/0x320
Aug  1 03:21:38 client kernel:  [hub_port_status+61/176] hub_port_status+0x3d/0xb0
Aug  1 03:21:38 client kernel:  [hub_events+720/848] hub_events+0x2d0/0x350
Aug  1 03:21:38 client kernel:  [hub_thread+42/224] hub_thread+0x2a/0xe0
Aug  1 03:21:38 client kernel:  [default_wake_function+0/48]
default_wake_function+0x0/0x30
Aug  1 03:21:38 client kernel:  [hub_thread+0/224] hub_thread+0x0/0xe0
Aug  1 03:21:38 client kernel:  [kernel_thread_helper+5/12]
kernel_thread_helper+0x5/0xc
Aug  1 03:21:38 client kernel:
Aug  1 03:21:38 client kernel: Device class 'host0' does not have a release()
function, it is broken and must
be fixed.
Aug  1 03:21:38 client kernel: Badness in class_dev_release at
drivers/base/class.c:201
Aug  1 03:21:38 client kernel: Call Trace:
Aug  1 03:21:38 client kernel:  [kobject_cleanup+131/144] kobject_cleanup+0x83/0x90
Aug  1 03:21:38 client kernel:  [device_del+104/160] device_del+0x68/0xa0
Aug  1 03:21:38 client kernel:  [_end+559486139/1070142156]
scsi_host_put+0x1f/0x2f [scsi_mod]
Aug  1 03:21:38 client kernel:  [_end+559323684/1070142156]
usb_stor_release_resources+0xc8/0xd0 [usb_storage]
Aug  1 03:21:38 client kernel:  [usb_device_remove+119/128]
usb_device_remove+0x77/0x80
Aug  1 03:21:38 client kernel:  [device_release_driver+98/112]
device_release_driver+0x62/0x70
Aug  1 03:21:38 client kernel:  [bus_remove_device+94/176]
bus_remove_device+0x5e/0xb0
Aug  1 03:21:38 client kernel:  [device_del+93/160] device_del+0x5d/0xa0
Aug  1 03:21:38 client kernel:  [device_unregister+19/48]
device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [usb_disconnect+169/272] usb_disconnect+0xa9/0x110
Aug  1 03:21:38 client kernel:  [hub_port_connect_change+789/800]
hub_port_connect_change+0x315/0x320
Aug  1 03:21:38 client kernel:  [hub_port_status+61/176] hub_port_status+0x3d/0xb0
Aug  1 03:21:38 client kernel:  [hub_events+720/848] hub_events+0x2d0/0x350
Aug  1 03:21:38 client kernel:  [hub_thread+42/224] hub_thread+0x2a/0xe0
Aug  1 03:21:38 client kernel:  [default_wake_function+0/48]
default_wake_function+0x0/0x30
Aug  1 03:21:38 client kernel:  [hub_thread+0/224] hub_thread+0x0/0xe0
Aug  1 03:21:38 client kernel:  [kernel_thread_helper+5/12]
kernel_thread_helper+0x5/0xc
Aug  1 03:21:38 client kernel:
Aug  1 03:21:38 client kernel: Device '2-2:0' does not have a release()
function, it is broken and must be fix
ed.
Aug  1 03:21:38 client kernel: Badness in device_release at drivers/base/core.c:84
Aug  1 03:21:38 client kernel: Call Trace:
Aug  1 03:21:38 client kernel:  [kobject_cleanup+131/144] kobject_cleanup+0x83/0x90
Aug  1 03:21:38 client kernel:  [device_unregister+19/48]
device_unregister+0x13/0x30
Aug  1 03:21:38 client kernel:  [usb_disconnect+169/272] usb_disconnect+0xa9/0x110
Aug  1 03:21:38 client kernel:  [hub_port_connect_change+789/800]
hub_port_connect_change+0x315/0x320
Aug  1 03:21:38 client kernel:  [hub_port_status+61/176] hub_port_status+0x3d/0xb0
Aug  1 03:21:38 client kernel:  [hub_events+720/848] hub_events+0x2d0/0x350
Aug  1 03:21:38 client kernel:  [hub_thread+42/224] hub_thread+0x2a/0xe0
Aug  1 03:21:38 client kernel:  [default_wake_function+0/48]
default_wake_function+0x0/0x30
Aug  1 03:21:38 client kernel:  [hub_thread+0/224] hub_thread+0x0/0xe0
Aug  1 03:21:38 client kernel:  [kernel_thread_helper+5/12]
kernel_thread_helper+0x5/0xc


sorry, it's very long


Steps to reproduce:
unplug an usb drive


