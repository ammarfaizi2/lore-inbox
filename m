Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTJXAPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 20:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTJXAPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 20:15:05 -0400
Received: from DaVinci.coe.neu.edu ([129.10.32.95]:18419 "EHLO
	DaVinci.coe.neu.edu") by vger.kernel.org with ESMTP id S261903AbTJXAO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 20:14:59 -0400
Date: Thu, 23 Oct 2003 20:14:57 -0400 (EDT)
From: James Vega <jamessan@coe.neu.edu>
Message-Id: <200310240014.h9O0EvH02191@Seconds.coe.neu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A kernel oops was generated when I unplugged my Neuros (usb portable audio player). Let me know if you need any more information. Please keep me on the CC: list as I'm not subscribed to lkml yet.

syslog output from usb-storage detection:

hub 2-0:1.0: new USB device on port 2, assigned address 2
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: NEUROS    Model: dig. audio comp.  Rev:

  Type:   Direct-Access                      ANSI

WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
SCSI device sda: 252928 512-byte hdwr sectors (129 MB)
sda: test WP failed, assume Write Enabled
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

Here's the oops:

usb 2-2: USB disconnect, address 2
releasing anticipatory io scheduler
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
6b6b6b6b
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<6b6b6b6b>]    Not tainted VLI
EFLAGS: 00010202
EIP is at 0x6b6b6b6b
eax: f74987b0   ebx: f74966e8   ecx: 00000000   edx: f74966e8
esi: f74966f8   edi: c02c0e60   ebp: f7773e10   esp: f7773e04
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 115, threadinfo=f7772000 task=f7775900)
Stack: c01d32f5 f74966e8 f74987b0 f7773e24 c01d4c9a f74966e8 f7770de8 c02c0e48 
       f7773e38 f8990eee f74966e8 f7496994 c02c0e48 f7773e48 f8991ea2 f7770de8 
       00000000 f7773e58 c01d0808 f7770f68 f7770f90 f7773e70 c01910c7 f7770f90 
Call Trace:
 [elevator_exit+51/55] elevator_exit+0x33/0x37
 [blk_cleanup_queue+36/104] blk_cleanup_queue+0x24/0x68
 [_end+946108438/1070283048] scsi_free_sdev+0x7a/0x11a [scsi_mod]
 [_end+946112458/1070283048] scsi_device_dev_release+0x15/0x22 [scsi_mod]
 [device_release+26/95] device_release+0x1a/0x5f
 [kobject_cleanup+76/107] kobject_cleanup+0x4c/0x6b
 [_end+946113731/1070283048] scsi_remove_device+0x93/0xa7 [scsi_mod]
 [_end+946111848/1070283048] scsi_forget_host+0x16/0x26 [scsi_mod]
 [_end+946091622/1070283048] scsi_remove_host+0x1b/0x63 [scsi_mod]
 [_end+946195408/1070283048] storage_disconnect+0x2d/0x3c [usb_storage]
 [_end+945846806/1070283048] usb_unbind_interface+0x54/0x82 [usbcore]
 [device_release_driver+66/81] device_release_driver+0x42/0x51
 [bus_remove_device+78/147] bus_remove_device+0x4e/0x93
 [device_del+103/148] device_del+0x67/0x94
 [_end+945867833/1070283048] usb_disable_device+0x69/0x96 [usbcore]
 [_end+945849256/1070283048] usb_disconnect+0xa3/0xe5 [usbcore]
 [_end+945856704/1070283048] hub_port_connect_change+0x50/0x286 [usbcore]
 [_end+945857540/1070283048] hub_events+0x10e/0x2ba [usbcore]
 [_end+945857999/1070283048] hub_thread+0x1f/0xd2 [usbcore]
 [default_wake_function+0/24] default_wake_function+0x0/0x18
 [_end+945857968/1070283048] hub_thread+0x0/0xd2 [usbcore]
 [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

Code:  Bad EIP value.
