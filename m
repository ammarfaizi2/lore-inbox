Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbTIOOoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbTIOOoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:44:08 -0400
Received: from dsl-46020.solcon.nl ([212.45.46.20]:63129 "HELO taos-it.nl")
	by vger.kernel.org with SMTP id S261439AbTIOOoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:44:00 -0400
Message-ID: <006e01c37b98$6580a140$0301a8c0@bpo.nl>
From: "M.S. Lucas" <mslucas@taos-it.nl>
To: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <apcupsd-devel@apcupsd.com>
Subject: [USB] control queue full when using 2.6.0-test5 and apcupsd
Date: Mon, 15 Sep 2003 16:48:15 +0200
Organization: TAOS-IT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having problems with my APC UPS using an USB cable and the 2.6.0-test5
kernel

I hope somebody can help me?

root@orion:/etc/apcupsd $ uname -a
Linux orion 2.6.0-test5 #4 SMP Sun Sep 14 20:06:21 CEST 2003 i686 GNU/Linux

root@orion:/etc/apcupsd $ lspci -v
02:08.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 807d:0035
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at f7000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2

02:08.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 807d:0035
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at f6800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2

02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
        Subsystem: Unknown device 807d:1043
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at f6000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

Using
root@orion:/etc/apcupsd $ apcupsd --version
apcupsd 3.10.6 (05 August 2003) debian

(apcupsd-devel_3.10.6.20030805-05Aug03-3_i386.deb)


After
root@orion:/etc/apcupsd $ modprobe hid
This is in my logfiles
Sep 15 15:56:14 orion kernel: drivers/usb/core/usb.c: registered new driver
hub
Sep 15 15:56:14 orion kernel: drivers/usb/core/usb.c: registered new driver
hiddev
Sep 15 15:56:14 orion kernel: drivers/usb/core/usb.c: registered new driver
hid
Sep 15 15:56:14 orion kernel: drivers/usb/input/hid-core.c: v2.0:USB HID
core driver
Sep 15 15:56:22 orion last message repeated 3 times


After
root@orion:/etc/apcupsd $ modprobe ohci-hcd
This is in my logfiles
Sep 15 15:57:22 orion kernel: ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host
Controller (OHCI) Driver (PCI)
Sep 15 15:57:22 orion kernel: ohci-hcd: block sizes: ed 64 td 64
Sep 15 15:57:22 orion kernel: ohci-hcd 0000:02:08.0: OHCI Host Controller
Sep 15 15:57:23 orion kernel: ohci-hcd 0000:02:08.0: irq 19, pci mem
f0c43000
Sep 15 15:57:23 orion kernel: ohci-hcd 0000:02:08.0: new USB bus registered,
assigned bus number 1
Sep 15 15:57:23 orion kernel: hub 1-0:0: USB hub found
Sep 15 15:57:23 orion kernel: hub 1-0:0: 3 ports detected
Sep 15 15:57:23 orion kernel: ohci-hcd 0000:02:08.1: OHCI Host Controller
Sep 15 15:57:24 orion kernel: ohci-hcd 0000:02:08.1: irq 16, pci mem
f0c45000
Sep 15 15:57:24 orion kernel: ohci-hcd 0000:02:08.1: new USB bus registered,
assigned bus number 2
Sep 15 15:57:24 orion kernel: hub 2-0:0: USB hub found
Sep 15 15:57:24 orion kernel: hub 2-0:0: 2 ports detected
Sep 15 15:57:24 orion kernel: hub 2-0:0: debounce: port 2: delay 100ms
stable 4 status 0x301
Sep 15 15:57:24 orion kernel: hub 2-0:0: new USB device on port 2, assigned
address 2
Sep 15 15:57:26 orion kernel: hiddev96: USB HID v1.10 Device [American Power
Conversion Smart-UPS 750 XL FW:630.3.I USB FW:1.] on usb-0000:02:08.1-2
Sep 15 15:57:30 orion last message repeated 3 times

root@orion:/etc/apcupsd $ ls -al /dev/usb/hid/hiddev0
crw-r--r--    1 root     root     180,  96 Jan  1  1970 /dev/usb/hid/hiddev0


in my /etc/apcupsd/apcupsd.conf i configured the following lines for my UPS
UPSCABLE usb
UPSTYPE usb

after
root@orion:/etc/apcupsd $ /etc/init.d/apcupsd-devel start
Starting APC UPS power management: apcupsd-devel.
This is in my logfiles
Sep 15 16:00:06 orion apcupsd[21908]: apcupsd 3.10.6 (05 August 2003) debian
startup succeeded
Sep 15 16:00:07 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:00:38 orion last message repeated 148089 times
Sep 15 16:00:53 orion last message repeated 84977 times
Sep 15 16:00:53 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:00:53 orion last message repeated 3163 times
Sep 15 16:00:53 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:00:53 orion last message repeated 731 times
Sep 15 16:00:53 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:00:54 orion last message repeated 2922 times
Sep 15 16:00:54 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:00:59 orion last message repeated 61195 times
Sep 15 16:00:59 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:00:59 orion last message repeated 13 times
Sep 15 16:00:59 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:01:00 orion last message repeated 11786 times
Sep 15 16:01:00 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:01:00 orion last message repeated 11 times
Sep 15 16:01:00 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:01:00 orion last message repeated 636 times
Sep 15 16:01:00 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:01:00 orion last message repeated 404 times
Sep 15 16:01:00 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:01:00 orion last message repeated 282 times
Sep 15 16:01:00 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:01:01 orion last message repeated 1409 times
Sep 15 16:01:01 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:01:01 orion last message repeated 284 times
Sep 15 16:01:01 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:01:01 orion last message repeated 749 times
Sep 15 16:01:01 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:01:01 orion last message repeated 14 times
Sep 15 16:01:01 orion kernel: drivers/usb/input/hid-core.c: control queue
full
Sep 15 16:01:03 orion last message repeated 20233 times
Sep 15 16:01:03 orion kernel: ue full

Can somebody please give me a hint where to look.

Thanks in advance

Maurice Lucas

