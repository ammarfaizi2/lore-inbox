Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTIARlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTIARlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:41:10 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:57360 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263178AbTIARk2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:40:28 -0400
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Date: Tue, 2 Sep 2003 01:39:08 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309020139.08248.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PL2303 is used to connect the serial console on a classic serial port 
of a test machine. HW nandshaking is used
The test machine reboots once a minute and dumps lots of messages

Frequently:
- driver hangs 
- userspace (cu) can't be stopped
- pl2303 and/or usbserial can't be unloaded 
- USB interrupts stop
- problems result in requiring a reboot.


- None of these problems seen before fixes such as "send break"
  (which works) were made
- Feels like buffer heads get out of synch at times
- Changing Baudrates from 115200 to 38400 or 9600 has no effect 
- It seems to be worse than ever even with oopses _now_ as it 
   has been used for many months and none were seen

- 2.4.21,22 behave essentially the same

Regards
Michael

Aug 31 11:39:40 mhfl2 kernel: Linux version 2.6.0-test4-mhf60 (mhf@mhfl4) (gcc version 2.95.3 20010315 (release)) #5 Sun Aug 31 09:37:06 HKT 2003

[]

Sep  1 18:24:01 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver usbfs
Sep  1 18:24:01 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver hub
Sep  1 18:24:02 mhfl2 kernel: ohci-hcd 0000:00:14.0: OHCI Host Controller
Sep  1 18:24:02 mhfl2 kernel: ohci-hcd 0000:00:14.0: irq 11, pci mem cf8a4000
Sep  1 18:24:02 mhfl2 kernel: ohci-hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
Sep  1 18:24:02 mhfl2 kernel: usb usb1: Product: OHCI Host Controller
Sep  1 18:24:02 mhfl2 kernel: usb usb1: Manufacturer: Linux 2.6.0-test4-mhf60 ohci-hcd
Sep  1 18:24:02 mhfl2 kernel: usb usb1: SerialNumber: 0000:00:14.0
Sep  1 18:24:02 mhfl2 kernel: hub 1-0:0: USB hub found
Sep  1 18:24:02 mhfl2 kernel: hub 1-0:0: 2 ports detected
Sep  1 18:24:03 mhfl2 kernel: SCSI subsystem initialized
Sep  1 18:24:03 mhfl2 kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
Sep  1 18:24:03 mhfl2 kernel: hub 1-0:0: new USB device on port 2, assigned address 2
Sep  1 18:24:03 mhfl2 kernel: Initializing USB Mass Storage driver...
Sep  1 18:24:03 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Sep  1 18:24:03 mhfl2 kernel: USB Mass Storage support registered.
Sep  1 18:24:03 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
Sep  1 18:24:03 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver usbserial
Sep  1 18:24:03 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Sep  1 18:24:03 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
Sep  1 18:24:03 mhfl2 kernel: pl2303 1-2:0: PL-2303 converter detected
Sep  1 18:24:03 mhfl2 kernel: usb 1-2: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Sep  1 18:24:03 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver pl2303
Sep  1 18:24:03 mhfl2 kernel: drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.10
Sep  1 18:24:04 mhfl2 kernel: lp: driver loaded but no devices found
Sep  1 18:24:21 mhfl2 rpc.mountd: authenticated unmount request from mhfl4:997 for / (/) 
Sep  1 18:27:43 mhfl2 httpd: httpd startup succeeded
Sep  1 10:39:48 mhfl2 named[446]: no longer listening on 203.151.225.157#53
Sep  1 18:42:46 mhfl2 kernel: usb 1-2: USB disconnect, address 2
Sep  1 18:42:46 mhfl2 kernel: usb 1-2: pl2303_write_bulk_callback - failed resubmitting write urb, error -19
Sep  1 18:42:46 mhfl2 kernel: pl2303 1-2:0: device disconnected
Sep  1 18:42:50 mhfl2 kernel: drivers/usb/core/usb.c: deregistering driver usb-storage
Sep  1 18:42:50 mhfl2 kernel: ohci-hcd 0000:00:14.0: remove, state 3
Sep  1 18:42:50 mhfl2 kernel: usb usb1: USB disconnect, address 1
Sep  1 18:42:50 mhfl2 kernel: ohci-hcd 0000:00:14.0: USB bus 1 deregistered
Sep  1 18:43:06 mhfl2 kernel: PL-2303 ttyUSB0: PL-2303 converter now disconnected from ttyUSB0
Sep  1 18:43:06 mhfl2 kernel: Unable to handle kernel paging request at virtual address cf8b61a8
Sep  1 18:43:06 mhfl2 kernel:  printing eip:
Sep  1 18:43:06 mhfl2 kernel: cf890d94
Sep  1 18:43:06 mhfl2 kernel: *pde = 012b4067
Sep  1 18:43:06 mhfl2 kernel: *pte = 00000000
Sep  1 18:43:06 mhfl2 kernel: Oops: 0000 [#1]
Sep  1 18:43:06 mhfl2 kernel: CPU:    0
Sep  1 18:43:06 mhfl2 kernel: EIP:    0060:[<cf890d94>]    Not tainted
Sep  1 18:43:06 mhfl2 kernel: EFLAGS: 00010282
Sep  1 18:43:06 mhfl2 kernel: EIP is at hcd_pci_release+0x14/0x20 [usbcore]
Sep  1 18:43:06 mhfl2 kernel: eax: cf8b6180   ebx: c0396ec0   ecx: cf8a0240   edx: c8d0e634
Sep  1 18:43:06 mhfl2 kernel: esi: 00000001   edi: cb3abf00   ebp: cb667de4   esp: cb667de0
Sep  1 18:43:06 mhfl2 kernel: ds: 007b   es: 007b   ss: 0068
Sep  1 18:43:06 mhfl2 kernel: Process cu (pid: 6269, threadinfo=cb666000 task=c7e39900)
Sep  1 18:43:06 mhfl2 kernel: Stack: c8d0e634 cb667df0 cf88d3c6 c8d0e634 cb667dfc c0233360 c8d0e67c cb667e0c 
Sep  1 18:43:06 mhfl2 kernel:        c01d2498 c8d0e684 ca0a7400 cb667e18 c01d24ca c8d0e684 cb667e24 c02336cf 
Sep  1 18:43:06 mhfl2 kernel:        c8d0e684 cb667e30 cf88d3ab c8d0e67c cb667e44 cf8897ee c8d0e634 ca0a7400 
Sep  1 18:43:06 mhfl2 kernel: Call Trace:
Sep  1 18:43:06 mhfl2 kernel:  [<cf88d3c6>] usb_host_release+0x16/0x1c [usbcore]
Sep  1 18:43:06 mhfl2 kernel:  [<c0233360>] class_dev_release+0x18/0x50
Sep  1 18:43:06 mhfl2 kernel:  [<c01d2498>] kobject_cleanup+0x28/0x44
Sep  1 18:43:06 mhfl2 kernel:  [<c01d24ca>] kobject_put+0x16/0x1c
Sep  1 18:43:06 mhfl2 kernel:  [<c02336cf>] class_device_put+0xf/0x14
Sep  1 18:43:06 mhfl2 kernel:  [<cf88d3ab>] usb_bus_put+0x13/0x18 [usbcore]
Sep  1 18:43:06 mhfl2 kernel:  [<cf8897ee>] usb_release_dev+0x3a/0x48 [usbcore]
Sep  1 18:43:06 mhfl2 kernel:  [<c0231b0a>] device_release+0x16/0x50
Sep  1 18:43:06 mhfl2 kernel:  [<c01d2498>] kobject_cleanup+0x28/0x44
Sep  1 18:43:06 mhfl2 kernel:  [<c01d24ca>] kobject_put+0x16/0x1c
Sep  1 18:43:06 mhfl2 kernel:  [<c0231ddb>] put_device+0xf/0x14
Sep  1 18:43:06 mhfl2 kernel:  [<cf889931>] usb_put_dev+0x15/0x1c [usbcore]
Sep  1 18:43:06 mhfl2 kernel:  [<cf9100b6>] destroy_serial+0x16e/0x180 [usbserial]
Sep  1 18:43:06 mhfl2 kernel:  [<c01d2498>] kobject_cleanup+0x28/0x44
Sep  1 18:43:06 mhfl2 kernel:  [<c01d24ca>] kobject_put+0x16/0x1c
Sep  1 18:43:06 mhfl2 kernel:  [<cf90f31c>] __serial_close+0x84/0x8c [usbserial]
Sep  1 18:43:06 mhfl2 kernel:  [<cf90f3b7>] serial_close+0x93/0xb0 [usbserial]
Sep  1 18:43:06 mhfl2 kernel:  [<c02199ac>] release_dev+0x23c/0x5c8
Sep  1 18:43:06 mhfl2 kernel:  [<c0121258>] update_process_times+0x2c/0x38
Sep  1 18:43:06 mhfl2 kernel:  [<c0121136>] update_wall_time+0xe/0x38
Sep  1 18:43:06 mhfl2 kernel:  [<c021a058>] tty_release+0xc/0x14
Sep  1 18:43:06 mhfl2 kernel:  [<c014705f>] __fput+0x43/0xd8
Sep  1 18:43:06 mhfl2 kernel:  [<c0147016>] fput+0x16/0x1c
Sep  1 18:43:06 mhfl2 kernel:  [<c0145daf>] filp_close+0x97/0xa4
Sep  1 18:43:06 mhfl2 kernel:  [<c0145e07>] sys_close+0x4b/0x60
Sep  1 18:43:06 mhfl2 kernel:  [<c010adc7>] syscall_call+0x7/0xb
Sep  1 18:43:06 mhfl2 kernel: 
Sep  1 18:43:06 mhfl2 kernel: Code: 8b 40 28 ff d0 89 ec 5d c3 8d 76 00 55 89 e5 83 ec 20 8d 45 
Sep  1 18:43:42 mhfl2 kernel:  <6>drivers/usb/core/usb.c: deregistering driver pl2303
Sep  1 18:43:42 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial deregistering driver PL-2303
Sep  1 18:44:08 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
Sep  1 18:44:08 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver pl2303
Sep  1 18:44:08 mhfl2 kernel: drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.10
Sep  1 18:45:24 mhfl2 kernel: drivers/usb/core/usb.c: deregistering driver pl2303
Sep  1 18:45:24 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial deregistering driver PL-2303
Sep  1 18:45:50 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial deregistering driver Generic
Sep  1 18:45:50 mhfl2 kernel: drivers/usb/core/usb.c: deregistering driver usbserial
Sep  1 18:46:02 mhfl2 kernel: drivers/usb/core/usb.c: deregistering driver usbfs
Sep  1 18:46:02 mhfl2 kernel: drivers/usb/core/usb.c: deregistering driver hub
Sep  1 18:46:07 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver usbfs
Sep  1 18:46:07 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver hub
Sep  1 18:46:07 mhfl2 kernel: ohci-hcd 0000:00:14.0: OHCI Host Controller
Sep  1 18:46:07 mhfl2 kernel: ohci-hcd 0000:00:14.0: irq 11, pci mem cf8a4000
Sep  1 18:46:07 mhfl2 kernel: ohci-hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
Sep  1 18:46:08 mhfl2 kernel: usb usb1: Product: OHCI Host Controller
Sep  1 18:46:08 mhfl2 kernel: usb usb1: Manufacturer: Linux 2.6.0-test4-mhf60 ohci-hcd
Sep  1 18:46:08 mhfl2 kernel: usb usb1: SerialNumber: 0000:00:14.0
Sep  1 18:46:08 mhfl2 kernel: hub 1-0:0: USB hub found
Sep  1 18:46:08 mhfl2 kernel: hub 1-0:0: 2 ports detected
Sep  1 18:46:08 mhfl2 kernel: SCSI subsystem initialized
Sep  1 18:46:08 mhfl2 kernel: Initializing USB Mass Storage driver...
Sep  1 18:46:08 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Sep  1 18:46:08 mhfl2 kernel: USB Mass Storage support registered.
Sep  1 18:46:08 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
Sep  1 18:46:08 mhfl2 kernel: drivers/usb/serial/usb-serial.c: usb_serial_init - tty_register_driver failed
Sep  1 18:46:08 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial deregistering driver Generic
Sep  1 18:46:08 mhfl2 kernel: drivers/usb/serial/usb-serial.c: usb_serial_init - returning with error -16
Sep  1 18:46:08 mhfl2 kernel: pl2303: Unknown symbol usb_serial_disconnect
Sep  1 18:46:08 mhfl2 kernel: pl2303: Unknown symbol usb_serial_probe
Sep  1 18:46:08 mhfl2 kernel: pl2303: Unknown symbol usb_serial_register
Sep  1 18:46:08 mhfl2 kernel: pl2303: Unknown symbol usb_serial_deregister
Sep  1 18:46:08 mhfl2 kernel: lp: driver loaded but no devices found

