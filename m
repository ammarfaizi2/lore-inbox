Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTESSuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTESSuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:50:20 -0400
Received: from mx1.mail.ru ([194.67.23.21]:18193 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262656AbTESSuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:50:17 -0400
Date: Sun, 18 May 2003 22:46:26 +0200 (CEST)
From: Guennadi Liakhovetski <lyakh@mail.ru>
Reply-To: Guennadi Liakhovetski <guennadi.liakhovetski@epost.de>
To: linux-kernel@vger.kernel.org
Subject: USB-Oops 2.4.20 printer, strangely involving ppp
Message-ID: <Pine.LNX.4.44.0305182226560.2438-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Knowing it most probably would be of low value / interest I still decided
to post this Oops, in case I am wrong. A short description - I generally
have problems with my USB-printer (Lexmark Z25), whereby it corrupts
images, a remedy seems to be to reload usb-modules, restart hotplug, lpd.
So, when I tried to do this on this occasion I got the Oops below. The sad
thing is it is not easily reproducible. I've had it a couple of times
before, often (if not always) in relation with ppp... But when I tried to
attack it, I couldn't get it anymore:-) So, here goes (extract from
/var/log/messages):

usb.c: USB disconnect on device 00:07.2-0 address 1
klogd 1.4.1, ---------- state change ----------
Inspecting /boot/System.map-2.4.20
Loaded 14930 symbols from /boot/System.map-2.4.20.
Symbols match kernel version 2.4.20.
Loaded 594 symbols from 38 modules.
usb.c: USB bus 1 deregistered
usb.c: USB disconnect on device 00:07.3-0 address 1
usb.c: USB bus 2 deregistered
usb.c: deregistering driver usbdevfs
usb.c: deregistering driver hub
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 20:12:08 Dec 29 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 3 for device 00:07.2
PCI: Sharing IRQ 3 with 00:07.3
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 3
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 3 for device 00:07.3
PCI: Sharing IRQ 3 with 00:07.2
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 3
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:07.2-2, assigned address 2
modprobe: Can't locate module evdev
modprobe: Can't locate module joydev
usb.c: USB device 2 (vend/prod 0x43d/0x57) is not claimed by any active driver.
usb.c: registered new driver usblp
printer.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x043D pid 0x0057
printer.c: v0.11: USB Printer Device Class driver
Using /lib/modules/2.4.20/kernel/drivers/usb/printer.o
Symbol version prefix ''
printer.c: usblp0: nonzero read/write bulk status received: -2
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
d8b6b117
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[ppp_deflate:__insmod_ppp_deflate_O/lib/modules/2.4.20/kernel/drivers/ne+-605929/96]    Not tainted
EFLAGS: 00010286
eax: d5d0fadc   ebx: 00000000   ecx: 00000001   edx: 00000001
esi: d5d0fa20   edi: c8def140   ebp: d383ff00   esp: d383fefc
ds: 0018   es: 0018   ss: 0018
Process hwscan (pid: 5389, stackpage=d383f000)
Stack: 00000000 d383ff18 d8b54ad6 00000000 d5d0fa00 d5d0fa20 d7258080 d383ff34
       d8b54cc0 d7258080 d5d0fa20 d5d0fa00 d5d0fa08 d7ffa300 d383ff40 d8b6b258
       d5d0fa20 d383ff50 d8be6305 d5d0fa20 d5d0fa00 d383ff64 d8be633b d5d0fa00
Call Trace:    [ppp_deflate:__insmod_ppp_deflate_O/lib/modules/2.4.20/kernel/drivers/ne+-697642/96] [ppp_deflate:__insmod_ppp_deflate_O/lib/modules/2.4.20/kernel/drivers/ne+-697152/96] [ppp_deflate:__insmod_ppp_deflate_O/lib/modules/2.4.20/kernel/drivers/ne+-605608/96] [ppp_deflate:__insmod_ppp_deflate_O/lib/modules/2.4.20/kernel/drivers/ne+-101627/96] [ppp_deflate:__insmod_ppp_deflate_O/lib/modules/2.4.20/kernel/drivers/ne+-101573/96]
  [fput+84/240] [filp_close+85/112] [sys_close+69/96] [system_call+51/56]

Code: ff 4b 20 0f 94 c0 84 c0 74 27 8b 83 cc 00 00 00 8b 40 1c 53
/etc/hotplug/usb.agent: line 435:  5389 Segmentation fault      /usr/sbin/hwscan --usb

Guennadi
---
Guennadi Liakhovetski


