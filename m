Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263907AbUDFQWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUDFQWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:22:06 -0400
Received: from mail.bencastricum.nl ([213.84.203.196]:26884 "EHLO
	gateway.bencastricum.nl") by vger.kernel.org with ESMTP
	id S263907AbUDFQVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:21:53 -0400
Message-ID: <002b01c41bf2$bdae2a40$0502a8c0@tragebak>
From: "Ben Castricum" <helpdeskie@bencastricum.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.5 Sensors & USB problems
Date: Tue, 6 Apr 2004 18:18:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-MailScanner-From: helpdeskie@bencastricum.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running the latest kernel has caused some problems for me since 2.6.4 up to
the current 2.6.5. I recompiled all interim releases and made a little
report of the troubles I run into. All kernels are compiled with gcc version
2.95.3 20010315 (release).

2.6.4 -> everything ok
2.6.5-rc1 -> sensors broke (ERROR: Can't get <sensor> data!)
2.6.5-rc2 -> USB broke (kernel NULL pointer dereference in khubd)
2.6.5-rc3 -> networking broke (real weird stuff)
2.6.5-final -> networking fixed again!

I am real glad that networking was fixed again, but this still leaves me
with the broken sensors and a non-functional USB Modem. This all happens on
a Asus-MEW main board with a Intel Celeron (Mendocino).


The sensor module I use are w83781d and i2c_i801 and sensor reports in the
first 2 lines

as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800

Since 2.6.5-rc1 sensors reports "Can't get data!" for all sensors while all
modules are loaded normally.


For USB (already reported earlier on lkml) I get these message on startup
with 2.6.4:

drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1f.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 9, io base 0000a400
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB
modems and ISDN adapters
hw_random hardware driver 1.0.0 loaded
usb 1-2: new full speed USB device using address 2
cdc_acm 1-2:1.0: ttyACM0: USB ACM device<6>8139too Fast Ethernet driver
0.9.27

and with 2.6.5-rc2 and up:

drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1f.2: Intel Corp. 82801AA USB
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: irq 9, io base 0000a400
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver cdc_acm
drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for USB
modems and ISDN adapters
hw_random hardware driver 1.0.0 loaded
usb 1-2: new full speed USB device using address 2
Unable to handle kernel NULL pointer dereference at virtual address 00000005
 printing eip:
c8860954
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c8860954>]    Not tainted
EFLAGS: 00010246   (2.6.5-rc2)
EIP is at acm_probe+0x9c/0x51c [cdc_acm]
eax: c7ab3cc0   ebx: 00000000   ecx: c7da0ac0   edx: 00000000
esi: c76ccd6c   edi: 00000004   ebp: c7ab3dc0   esp: c7b41e3c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 37, threadinfo=c7b40000 task=c7b43760)
Stack: c8861d40 ffffffed c7ab3dd4 c7ab3dc0 c7a03580 c02908f0 00000000
00000001
       c029a3cc c0173a7c c7a03580 c029a3e0 c7ab3cc0 c76ccd60 c769ac00
c888d049
       c7ab3dc0 c8861c80 ffffffed c8861d40 c7ab3dd4 c769acd0 c8861d20
c01d06f1
Call Trace:
 [<c0173a7c>] sysfs_add_file+0x5c/0x7c
 [<c888d049>] usb_probe_interface+0x41/0x5c [usbcore]
 [<c01d06f1>] bus_match+0x31/0x54
 [<c01d076a>] device_attach+0x56/0x8c
 [<c01d08e8>] bus_add_device+0x50/0x88
 [<c01cfa48>] device_add+0x88/0x118
 [<c01cfae9>] device_register+0x11/0x18
 [<c8892653>] usb_set_configuration+0x1bb/0x1f4 [usbcore]
 [<c888dd93>] usb_new_device+0x2d3/0x370 [usbcore]
 [<c0117330>] printk+0x12c/0x154
 [<c888f3c6>] hub_port_connect_change+0x1ce/0x254 [usbcore]
 [<c888f57d>] hub_events+0x131/0x2dc [usbcore]
 [<c888f755>] hub_thread+0x2d/0xe4 [usbcore]
 [<c888f728>] hub_thread+0x0/0xe4 [usbcore]
 [<c0113abc>] default_wake_function+0x0/0x1c
 [<c0104e75>] kernel_thread_helper+0x5/0xc

Code: 80 7a 05 0a 0f 85 52 04 00 00 80 7a 04 01 0f 86 48 04 00 00
 <6>8139too Fast Ethernet driver 0.9.27

as a bit if extra info, "lspci -v" gives me

root@gateway:~# lspci -v
00:00.0 Host bridge: Intel Corp. 82810 DC-100 GMCH [Graphics Memory
Controller Hub] (rev 02)
        Subsystem: Asustek Computer, Inc.: Unknown device 8011
        Flags: bus master, fast devsel, latency 0

00:01.0 VGA compatible controller: Intel Corp. 82810 DC-100 CGC [Chipset
Graphics Controller] (rev 02) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc.: Unknown device 8011
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 12
        Memory at e6000000 (32-bit, prefetchable) [size=32M]
        Memory at e5000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 1

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 01) (prog-if 00
[Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000b000-0000dfff
        Memory behind bridge: e4000000-e4ffffff
        Prefetchable memory behind bridge: e5800000-e5ffffff

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 01)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 01) (prog-if 80
[Master])
        Flags: bus master, medium devsel, latency 0
        I/O ports at a800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 01) (prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at a400 [size=32]

00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 01)
        Flags: medium devsel, IRQ 9
        I/O ports at e800 [size=16]

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev
01)
        Subsystem: Analog Devices: Unknown device 1043
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at e000 [size=256]
        I/O ports at e100 [size=64]

01:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 64, IRQ 12
        I/O ports at d800 [size=256]
        Memory at e4800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:09.0 Multimedia video controller: Brooktree Corporation Bt848 Video
Capture (rev 12)
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at e5800000 (32-bit, prefetchable) [disabled] [size=4K]

01:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at d400 [size=256]
        Memory at e4000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
        Subsystem: Creative Labs SBLive! Player 5.1
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at d000 [disabled] [size=32]
        Capabilities: [dc] Power Management version 1

01:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev
07)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 64
        I/O ports at b800 [disabled] [size=8]
        Capabilities: [dc] Power Management version 1

I am happy to supply more information or do tests if needed.

Kind regards,
Ben Castricum

