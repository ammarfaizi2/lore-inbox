Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWAZTul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWAZTul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWAZTul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:50:41 -0500
Received: from soohrt.org ([85.131.246.150]:47808 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S1751388AbWAZTuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:50:40 -0500
Date: Thu, 26 Jan 2006 20:50:38 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: linux-kernel@vger.kernel.org
Subject: Badness in vsnprintf
Message-ID: <20060126195038.GB22994@quickstop.soohrt.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since I'm testing the 2.6.16 release candidate, I'm encountering the
following problem which manifests by a reported "Badness in vsnprintf"
in dmesg. The system is still usable after this event.

Kind regards,
 Horst Schirmeier


[1.] One line summary of the problem:
Badness in vsnprintf

[2.] Full description of the problem/report:
Kernel reports "Badness in vsnprintf at lib/vsprintf.c:279" in boot
process while registering USB devices.

[3.] Keywords (i.e., modules, networking, kernel):
badness, vsnprintf, usb, lib/vsprintf.c:279

[4.] Kernel version (from /proc/version):
Linux version 2.6.16-rc1-g3ee68c4a (root@nexus) (gcc version 3.4.4
(Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 PREEMPT Thu Jan 26
19:55:01 CET 2006

[5.] Most recent kernel version which did not have the bug:
2.6.15 (vanilla)

[6.] Output of Oops
[...]
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: Logitech USB Receiver as /class/input/input2
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:04.2-1
Badness in vsnprintf at lib/vsprintf.c:279
 [<c0324f64>] vsnprintf+0x544/0x550
 [<c0324fbc>] snprintf+0x1c/0x30
 [<c03ec17a>] print_modalias_bits+0x8a/0x90
 [<c03ec213>] print_modalias+0x93/0x1d0
 [<c03ec8c0>] input_dev_uevent+0x1d0/0x4b0
 [<c0384060>] class_uevent+0xb0/0x260
 [<c0383fb0>] class_uevent+0x0/0x260
 [<c03223f1>] kobject_uevent+0x3f1/0x450
 [<c0195d94>] sysfs_create_link+0x34/0x70
 [<c038455e>] class_device_add+0x10e/0x250
 [<c03eccf9>] input_register_device+0xf9/0x260
 [<d0af2103>] hidinput_configure_usage+0x173/0x1810 [usbhid]
 [<d0af3e4c>] hidinput_connect+0x22c/0x260 [usbhid]
 [<d0af1dbd>] hid_probe+0x2d/0x1b0 [usbhid]
 [<c0194cf5>] sysfs_new_dirent+0x25/0x80
 [<c0194d6c>] sysfs_make_dirent+0x1c/0x90
 [<c0195d94>] sysfs_create_link+0x34/0x70
 [<c0195d94>] sysfs_create_link+0x34/0x70
 [<c04d207f>] __mutex_unlock_slowpath+0x5f/0x200
 [<c03d9b7f>] usb_probe_interface+0x5f/0xb0
 [<c03833c4>] driver_probe_device+0x64/0xc0
 [<c03834ea>] __driver_attach+0x5a/0x60
 [<c03829aa>] bus_for_each_dev+0x3a/0x60
 [<c0383506>] driver_attach+0x16/0x20
 [<c0383490>] __driver_attach+0x0/0x60
 [<c0382e9b>] bus_add_driver+0x7b/0xc0
 [<c03839a5>] driver_register+0x55/0x90
 [<c03d9e3e>] usb_register_driver+0x4e/0xb0
 [<d092e012>] hid_init+0x12/0x30 [usbhid]
 [<c0136986>] sys_init_module+0x116/0x1e0
 [<c0103005>] syscall_call+0x7/0xb
input: Logitech USB Receiver as /class/input/input3
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:04.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
[...]

Full dmesg output at
http://wwwcip.informatik.uni-erlangen.de/~sihoschi/vsnprintf-badness-dmesg.txt

[9.] Config file
At
http://wwwcip.informatik.uni-erlangen.de/~sihoschi/vsnprintf-badness-config.txt

OOPS Reporting Tool v.ltg1
www.wsi.edu.pl/~piotrowskim/files/ort/ltg/

-- 
PGP-Key 0xD40E0E7A
