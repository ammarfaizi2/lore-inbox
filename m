Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTKKW1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTKKW1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:27:39 -0500
Received: from web40912.mail.yahoo.com ([66.218.78.209]:41268 "HELO
	web40912.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263772AbTKKW1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:27:37 -0500
Message-ID: <20031111222731.72833.qmail@web40912.mail.yahoo.com>
Date: Tue, 11 Nov 2003 14:27:31 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Badness in atomic_dec_and_test in 2.6.0-test9-mm2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I sent a previous version of this e-mail to the linux-scsi and usb-storage
mailinglists mentioned in MAINTAINERS, but received no response)

When I unplug my USB Mass Storage device after unmounting it, I get the following
badness message:

usb 1-1.2: USB disconnect, address 4
Badness in atomic_dec_and_test at include/asm/atomic.h:150
Call Trace:
 [<c02184f0>] kobject_put+0x7e/0x80
 [<e4cc7adb>] scsi_remove_host+0x104/0x1a0 [scsi_mod]
 [<e4cbbe5f>] dissociate_dev+0x55/0xd2 [usb_storage]
 [<e4cbc269>] storage_disconnect+0x38/0x48 [usb_storage]
 [<c02c311d>] usb_unbind_interface+0xa4/0xa6
 [<c02845ee>] device_release_driver+0x64/0x66
 [<c028474e>] bus_remove_device+0x73/0xb8
 [<c02836dd>] device_del+0x6c/0xa0
 [<c02cba42>] usb_disable_device+0x71/0xac
 [<c02c3ee7>] usb_disconnect+0xc3/0x10e
 [<c02c6ee9>] hub_port_connect_change+0x339/0x33e
 [<c02c67e9>] hub_port_status+0x3c/0xa7
 [<c02c72d5>] hub_events+0x3e7/0x565
 [<c02c7480>] hub_thread+0x2d/0xe3
 [<c03b8c0e>] ret_from_fork+0x6/0x14
 [<c0120d8c>] default_wake_function+0x0/0x2e
 [<c02c7453>] hub_thread+0x0/0xe3
 [<c01092a9>] kernel_thread_helper+0x5/0xb

The device is a 256MB flash disk with an OTi controller chip. When I insert it
it is detected like this, and works perfectly fine:

hub 1-1:1.0: new USB device on port 2, assigned address 4
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: STF       Model: Flash Drive       Rev: 1.89
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
sda: Unit Not Ready, sense:
Current : sense = 70  6
ASC=28 ASCQ= 0
Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x28 0x00
0x00 0x00 0x00 0x00
SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
sda: Write Protect is off
sda: Mode Sense: 00 06 94 00
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

I have the SCSI core, the SCSI disk core and USB storage compiled as modules.
The badness message is 100% repeatable; it occurs every time this particular
device is unplugged.

TIA

Brad

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
