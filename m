Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUHDVkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUHDVkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUHDVkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:40:39 -0400
Received: from the.earth.li ([193.201.200.66]:25795 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S267450AbUHDVeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:34:37 -0400
Date: Wed, 4 Aug 2004 22:34:34 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Thomas Sailer <sailer@ife.ee.ethz.ch>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: "bad: scheduling while atomic!" with uss720 driver.
Message-ID: <20040804213434.GN12179@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing the above error, with the following traceback, when my
machine loads the uss720 driver (for a Belkin F5U002).

usb 1-2.4: new full speed USB device using address 3
uss720: probe: vendor id 0x1293, device id 0x2
uss720: set inteface result 0
uss720: (C) 1999 by Thomas Sailer, <sailer@ife.ee.ethz.ch>
uss720: reg: da 0c 23 00 00 00 01
uss720: epaddr 131 interval 1
bad: scheduling while atomic!
 [<c029cfb9>] schedule+0x499/0x4a0
 [<cc8843bc>] uhci_submit_control+0x22c/0x270 [uhci_hcd]
 [<c029d088>] wait_for_completion+0x78/0xd0
 [<c01168b0>] default_wake_function+0x0/0x10
 [<cc8e1bf1>] hcd_submit_urb+0x111/0x1a0 [usbcore]
 [<c01168b0>] default_wake_function+0x0/0x10
 [<cc8e2931>] usb_start_wait_urb+0x81/0xc0 [usbcore]
 [<c011e72f>] register_proc_table+0xaf/0x110
 [<cc8e2830>] timeout_kill+0x0/0x80 [usbcore]
 [<cc8e29d2>] usb_internal_control_msg+0x62/0x80 [usbcore]
 [<cc8e2a7f>] usb_control_msg+0x8f/0xb0 [usbcore]
 [<cc8c318f>] set_1284_register+0x6f/0xb0 [uss720]
 [<cc8c35bb>] parport_uss720_restore_state+0x1b/0x50 [uss720]
 [<cc878d0e>] parport_claim+0x10e/0x210 [parport]
 [<cc87b518>] parport_open+0x98/0xf0 [parport]
 [<cc878e1f>] parport_claim_or_block+0xf/0x60 [parport]
 [<cc87c2a2>] parport_device_id+0x42/0x1a0 [parport]
 [<cc87b2c3>] parport_daisy_init+0x83/0x1d0 [parport]
 [<c0119e9f>] call_console_drivers+0x7f/0x100
 [<cc87852f>] parport_announce_port+0xf/0xd0 [parport]
 [<cc8c3c2d>] uss720_probe+0x16d/0x1a0 [uss720]
 [<cc8dd06c>] usb_probe_interface+0x4c/0x60 [usbcore]
 [<c01e3a52>] bus_match+0x32/0x60
 [<c01e3b69>] driver_attach+0x59/0x90
 [<c01a4ca2>] kobject_register+0x22/0x60
 [<c01e400c>] bus_add_driver+0x8c/0xb0
 [<c01e4538>] driver_register+0x28/0x30
 [<cc8dd12a>] usb_register+0x3a/0xa0 [usbcore]
 [<cc88a011>] uss720_init+0x11/0x36 [uss720]
 [<c012ea88>] sys_init_module+0xe8/0x1f0
 [<c0103fab>] syscall_call+0x7/0xb

And also similar errors when I try to print using the port. It /is/
working to some extent as parport can detect the printer type ok:

parport0: Printer, EPSON Stylus COLOR 480

but it doesn't seem to be that happy about printing.

This is with 2.6.8-rc3, config at:

http://the.earth.li/~noodles/uss720/config-2.6.8-rc3

Complete dmesg is at:

http://the.earth.li/~noodles/uss720/dmesg.super

And details of all the tracebacks at:

http://the.earth.li/~noodles/uss720/trace.uss

The driver doesn't seem to have been touched much in the past few years
and I can't find any recent reports of it being used. Is anyone out
there successfully using it? What about interrupt handling - the comment
at the top indicates there was a problem with ohci; could this possibly
be fixed now?

J.

-- 
What's the worse that could happen?  Smoke. - Anonymous HWHacker
