Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271965AbTGYJOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 05:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271971AbTGYJOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 05:14:10 -0400
Received: from AToulouse-105-1-19-66.w80-15.abo.wanadoo.fr ([80.15.32.66]:2820
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S271965AbTGYJOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 05:14:04 -0400
Date: Fri, 25 Jul 2003 11:29:11 +0200
From: =?iso-8859-15?B?Suly9G1lIEF1Z+k=?= <eguaj@free.fr>
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.0-test1 "OHCI Unrecoverable Error" and broken "rmmod ohci_hcd"
Message-ID: <20030725092910.GA1670@satellite.workgroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: none
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I'm using an USB Alcatel Speedtouch ADSL modem connected to a 4 port
USB HUB and here is my problems:

- With kernel 2.6 I get this "OHCI Unrecoverable Error" message almost
  everytime I try to upload the firmware to the modem, while with kernel
  2.4 I rarely get it.

- Then I observed that once the OCHI controller is disabled, I can't
  unload it with 'rmmod ohci_hcd', the rmmod fails with a segfault and
  the kernel "module system" seems broken as a simple 'lsmod' hangs
  forever and display nothing.
  With kernel 2.4 I used to do a 'rmmod usb-ohci' followed by a
  'modprobe usb-ohci' to bring back the controller to life.

Here is the log messages related to USB for the "OHCI Unrecoverable
Error" and the crashing rmmod:

-->8--
Jul 25 09:53:46 satellite kernel: drivers/usb/core/usb.c: registered new driver usbfs
Jul 25 09:53:46 satellite kernel: drivers/usb/core/usb.c: registered new driver hub
Jul 25 09:53:55 satellite kernel: ohci-hcd 0000:00:0b.0: NEC Corporation USB
Jul 25 09:53:55 satellite kernel: ohci-hcd 0000:00:0b.0: irq 11, pci mem c924b000
Jul 25 09:53:55 satellite kernel: ohci-hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
Jul 25 09:53:56 satellite kernel: hub 1-0:0: USB hub found
Jul 25 09:53:56 satellite kernel: hub 1-0:0: 2 ports detected
Jul 25 09:53:56 satellite kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
Jul 25 09:53:56 satellite kernel: hub 1-0:0: new USB device on port 1, assigned address 2
Jul 25 09:53:56 satellite /etc/hotplug/usb.agent: Bad USB agent invocation
Jul 25 09:53:56 satellite kernel: hub 1-1:0: USB hub found
Jul 25 09:53:56 satellite kernel: hub 1-1:0: 4 ports detected
Jul 25 09:53:57 satellite kernel: hub 1-1:0: debounce: port 1: delay 100ms stable 4 status 0x101
Jul 25 09:53:57 satellite kernel: hub 1-1:0: new USB device on port 1, assigned address 3
#
# here I launch the firwmare upload with the 'modem_run' command ...
#
Jul 25 09:56:00 satellite kernel: drivers/usb/core/message.c: usb_control/bulk_msg: timeout
Jul 25 09:56:00 satellite kernel: usbfs: USBDEVFS_BULK failed dev 3 ep 0x85 len 512 ret -110
#
# ... and boom ...
#
Jul 25 09:56:26 satellite kernel: ohci-hcd 0000:00:0b.0: OHCI Unrecoverable Error, disabled
Jul 25 09:56:26 satellite kernel: pci_pool_destroy 0000:00:0b.0/ohci_td, c2647000 busy
Jul 25 09:56:26 satellite kernel: pci_pool_destroy 0000:00:0b.0/ohci_ed, c26ca000 busy
Jul 25 09:56:26 satellite modem_run[987]: Error reading interrupts
Jul 25 09:56:26 satellite last message repeated 6 times
Jul 25 09:56:26 satellite kernel: usbfs: process 987 (modem_run) did not claim interface 0 before use
Jul 25 09:56:26 satellite modem_run[987]: Error reading interrupts
Jul 25 09:56:28 satellite last message repeated 6812 times
Jul 25 09:56:28 satellite kernel: usbfs: usb_submit_urb returned -108
Jul 25 09:56:28 satellite modem_run[987]: Error reading interrupts
Jul 25 09:56:36 satellite last message repeated 12714 times
Jul 25 09:56:36 satellite kernel: usbfs: usb_submit_urb returned -108
Jul 25 09:56:36 satellite modem_run[987]: Error reading interrupts
Jul 25 09:56:37 satellite last message repeated 966 times
Jul 25 09:56:37 satellite kernel: usbfs: usb_submit_urb returned -108
Jul 25 09:56:37 satellite modem_run[987]: Error reading interrupts
Jul 25 09:56:37 satellite last message repeated 539 times
Jul 25 09:56:37 satellite kernel: usbfs: usb_submit_urb returned -108
Jul 25 09:56:37 satellite modem_run[987]: Error reading interrupts
Jul 25 09:56:38 satellite last message repeated 576 times
Jul 25 09:56:37 satellite kernel: usbfs: usb_submit_urb returned -108
Jul 25 09:56:38 satellite modem_run[987]: Error reading interrupts
Jul 25 09:56:38 satellite last message repeated 3 times
#
# here is the failing rmmod
#
Jul 25 09:56:38 satellite kernel: ohci-hcd 0000:00:0b.0: remove, state 0
Jul 25 09:56:38 satellite kernel: usb usb1: USB disconnect, address 1
Jul 25 09:56:38 satellite kernel: usb 1-1: USB disconnect, address 2
Jul 25 09:56:38 satellite kernel: usb 1-1.1: USB disconnect, address 3
Jul 25 09:56:38 satellite kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jul 25 09:56:38 satellite kernel:  printing eip:
Jul 25 09:56:38 satellite kernel: c01fa4ef
Jul 25 09:56:38 satellite kernel: *pde = 00000000
Jul 25 09:56:38 satellite kernel: Oops: 0000 [#1]
Jul 25 09:56:38 satellite kernel: CPU:    0
Jul 25 09:56:38 satellite kernel: EIP:    0060:[<c01fa4ef>]    Not tainted
Jul 25 09:56:38 satellite kernel: EFLAGS: 00010046
Jul 25 09:56:38 satellite kernel: EIP is at pool_find_page+0xf/0x60
Jul 25 09:56:38 satellite modem_run[987]: Error reading interrupts 
Jul 25 09:56:39 satellite kernel: eax: 00000000   ebx: 00000000   ecx: c2647200   edx: c790c8c0
Jul 25 09:56:39 satellite modem_run[987]: Device disconnected, shutting down
Jul 25 09:56:39 satellite kernel: esi: 02647200   edi: 00000046   ebp: c2091de0   esp: c2091dd4
Jul 25 09:56:39 satellite kernel: ds: 007b   es: 007b   ss: 0068
Jul 25 09:56:39 satellite kernel: Process rmmod (pid: 988, threadinfo=c2090000 task=c2c0f340)
Jul 25 09:56:39 satellite kernel: Stack: 02647200 00000000 000003e8 c2091dfc c01fa553 00000000 02647200 c790c800 
Jul 25 09:56:39 satellite kernel:        00000246 000003e8 c2091e14 c9251698 00000000 c2647200 02647200 c26ca080 
Jul 25 09:56:39 satellite kernel:        c2091e38 c9252c92 c790c800 c2647200 00000000 c790c800 00000546 00000000 
Jul 25 09:56:39 satellite kernel: Call Trace:
Jul 25 09:56:39 satellite kernel:  [<c01fa553>] pci_pool_free+0x13/0x9d
Jul 25 09:56:39 satellite kernel:  [<c9251698>] td_free+0x58/0x60 [ohci_hcd]
Jul 25 09:56:39 satellite kernel:  [<c9252c92>] ohci_endpoint_disable+0x132/0x140 [ohci_hcd]
Jul 25 09:56:39 satellite kernel:  [<c926ac01>] hcd_endpoint_disable+0xc1/0x120 [usbcore]
Jul 25 09:56:39 satellite kernel:  [<c926ab40>] hcd_endpoint_disable+0x0/0x120 [usbcore]
Jul 25 09:56:39 satellite kernel:  [<c926606e>] nuke_urbs+0x2e/0x60 [usbcore]
Jul 25 09:56:39 satellite kernel:  [<c9266ce4>] usb_disconnect+0x84/0x120 [usbcore]
Jul 25 09:56:39 satellite kernel:  [<c9266d5d>] usb_disconnect+0xfd/0x120 [usbcore]
Jul 25 09:56:39 satellite kernel:  [<c9266d5d>] usb_disconnect+0xfd/0x120 [usbcore]
Jul 25 09:56:39 satellite kernel:  [<c926dd39>] usb_hcd_pci_remove+0x79/0x160 [usbcore]
Jul 25 09:56:39 satellite kernel:  [<c01fb312>] pci_device_remove+0x32/0x40
Jul 25 09:56:39 satellite kernel:  [<c0257030>] device_release_driver+0x50/0x60
Jul 25 09:56:39 satellite kernel:  [<c025705d>] driver_detach+0x1d/0x40
Jul 25 09:56:39 satellite kernel:  [<c02572e1>] bus_remove_driver+0x41/0x80
Jul 25 09:56:39 satellite kernel:  [<c02576ee>] driver_unregister+0xe/0x37
Jul 25 09:56:39 satellite kernel:  [<c01fb5d0>] pci_unregister_driver+0x10/0x20
Jul 25 09:56:39 satellite kernel:  [<c925382d>] ohci_hcd_pci_cleanup+0xd/0xf [ohci_hcd]
Jul 25 09:56:39 satellite kernel:  [<c012cec7>] sys_delete_module+0x147/0x1c0
Jul 25 09:56:39 satellite kernel:  [<c013f209>] do_munmap+0xe9/0x120
Jul 25 09:56:40 satellite kernel:  [<c013f280>] sys_munmap+0x40/0x60
Jul 25 09:56:40 satellite kernel:  [<c0109077>] syscall_call+0x7/0xb
Jul 25 09:56:40 satellite kernel: 
Jul 25 09:56:40 satellite kernel: Code: 8b 13 8b 0a 8d 74 26 00 39 da 74 23 90 8d 74 26 00 89 d0 8b 
Jul 25 09:56:40 satellite kernel:  <7>usbfs: USBDEVFS_CONTROL failed cmd modem_run dev 3 rqt 192 rq 18 len 1 ret -19
--8<--

Regards,
Jérôme

--

