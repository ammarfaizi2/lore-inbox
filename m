Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277345AbRJOJOT>; Mon, 15 Oct 2001 05:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277349AbRJOJOK>; Mon, 15 Oct 2001 05:14:10 -0400
Received: from ictmac01.ict.uni-karlsruhe.de ([129.13.127.116]:5640 "EHLO
	mail.ict.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S277345AbRJOJNw>; Mon, 15 Oct 2001 05:13:52 -0400
Message-ID: <3BCAA8EE.8535A836@ict.uni-karlsruhe.de>
Date: Mon, 15 Oct 2001 11:14:22 +0200
From: =?iso-8859-1?Q?J=F6rg?= Ziuber <ziuber@ict.uni-karlsruhe.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI/IRQ routing problem on Sony Vaio FX (i815E)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

USB on my laptop does not work, caused by an IRQ routing problem.

The laptop is a Sony Vaio FX (205/209/301/302 - all have identical
chipsets/ioports) with a i815E-chip including Intel 82820 820 (Camino 2)
for the USB, and with two accessible USB ports.
The test system is a SuSE 7.2, Kernel 2.4.4 (SuSE source) and 2.4.12
(unpatched source) both delivering the same results.

Someone out there, who can help the Sony owners ?

(If this is not the right forum or this discussion, please tell me whom
to contact.)

Bye,
--
J. Ziuber
ziuber@ict.uni-karlsruhe.de

----------------------------

The problem in detail:


Attaching any USB device to my laptop, I get a response
(/var/log/messages) in USB-debug mode:

kernel: hub.c: port 2 connection change
kernel: hub.c: port 2, portstatus 100, change 1, 12 Mb/s
kernel: hub.c: port 2 connection change
kernel: hub.c: port 2, portstatus 101, change 1, 12 Mb/s
kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
kernel: hub.c: USB new device connected on bus1/2, assigned device
number 2
kernel: usb_control/bulk_msg: timeout
kernel: hub.c: USB new device not accepting new address=2 (error=-110)
kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
kernel: hub.c: USB new device connected on bus1/2, assigned device
number 3
kernel: usb_control/bulk_msg: timeout
kernel: hub.c: USB new device not accepting new address=3 (error=-110)


Validation:
* This problem occurs under Linux with _any_ USB-device plugged to the
laptop.
* The same devices work under Linux on other computers (desktops), with
of course other chips.
* The same devices work under Windows with the laptop without any
problem.
* The tests (Linux) have been performed with usb-uhci, and uhci
(usb-ohci not starting).
=> I have no hardware problem, but a software problem.

Paul McAvoy (paulmcav@queda.net) confirmed this problem on his Sony with
other devices, as well as Leo AA ZZ (lr4ml@yahoo.com).
At this point the owner of 'usb-uhci', Johannes Erdfelt
(johannes@erdfelt.com), supposed an IRQ routing problem. 

Leo AA ZZ suggested a nasty solution:
Running KDE, the USB works, if you let the sound device (ARTs
soundserver) run, e.g. hear some good music while tranferring data from
your USB ZIP. But, of course, this cannot be the solution ! It should
work without that trick !

One question I was posed in another news-group, is for the Windows
interrupts - under Win2k they are the same: #9 for the USB hubs (see
printout below for Linux assignments).


APPENDIX

Probably useful outputs for further validation (on a system, NOT running
the sound trick):
------------------------------
/proc/interrupts:
CPU0 
0: 76421 XT-PIC timer
1: 773 XT-PIC keyboard
2: 0 XT-PIC cascade
9: 0 XT-PIC usb-uhci, usb-uhci
12: 2615 XT-PIC PS/2 Mouse
14: 8973 XT-PIC ide0
15: 1 XT-PIC ide1
NMI: 0 
ERR: 0
------------------------------
lsmod:
Module Size Used by
agpgart 14272 4 (autoclean)
usb-uhci 21840 0 (unused)
usbcore 50416 1 [usb-uhci]
ipv6 122368 -1 (autoclean)
serial 43760 0 (autoclean)
isa-pnp 27920 0 (autoclean) [serial]
------------------------------
hwinfo:
...
19: PCI 1f.2: 0c03 USB Controller (UHCI)
[Created at pci.64]
Unique ID: wKXy._c5rmM0GlbC
Vendor: 8086 "Intel Corporation"
Model: 2442 "82820 820 (Camino 2) Chipset USB (Hub A)"
SubVendor: 104d "Sony Corporation"
SubDevice: 80df "?"
Revision: 0x03
I/O Ports: 0x1820-??? (rw)
IRQ: 9 (no events)
...
21: PCI 1f.4: 0c03 USB Controller (UHCI)
[Created at pci.64]
Unique ID: 57bR.0S_KkVFgoMD
Vendor: 8086 "Intel Corporation"
Model: 2444 "82820 820 (Camino 2) Chipset USB (Hub B)"
SubVendor: 104d "Sony Corporation"
SubDevice: 80df "?"
Revision: 0x03
I/O Ports: 0x1840-??? (rw)
IRQ: 9 (no events)
...
32: USB 101.0: 10a00 Hub
[Created at usb.88]
Unique ID: Xfjy.prH9cGYq27D
Vendor: 8086 "Intel Corporation"
Model: "USB UHCI Root Hub"
Serial ID: "1820"
USB Device status: driver active ("hub")
Speed: 1.5 Mbps
Attached to: #21 (USB Controller (UHCI))
...
33: USB 201.0: 10a00 Hub
[Created at usb.88]
Unique ID: R4yY.sS2kj8r7RV9
Model: "USB UHCI Root Hub"
Serial ID: "1840"
USB Device status: driver active ("hub")
Speed: 1.5 Mbps
------------------------------
/proc/ioports:
...
1800-180f : PCI device 8086:244a (Intel Corporation)
1800-1807 : ide0
1808-180f : ide1
1810-181f : Intel Corporation 82820 820 (Camino 2) Chipset SMBus
1820-183f : Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A)
1820-183f : usb-uhci
1840-185f : Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub B)
1840-185f : usb-uhci
1880-18bf : PCI device 8086:2445 (Intel Corporation)
1c00-1cff : PCI device 8086:2445 (Intel Corporation)
2000-207f : PCI device 8086:2446 (Intel Corporation)
2400-24ff : PCI device 8086:2446 (Intel Corporation)
...
------------------------------
/var/log/messages (initialization):
usbmgr[271]: start 0.4.6
modprobe: modprobe: Can't locate module mousedev
shep usbmgr[273]: "hid" was loaded
usbmgr[273]: "mousedev" was loaded
usbmgr[273]: "usb-uhci" was loaded
usbmgr[289]: mount /proc/bus/usb
...
kernel: usb.c: registered new driver usbdevfs
kernel: usb.c: registered new driver hub
kernel: usb-uhci.c: $Revision: 1.259 $ time 18:46:05 Oct 6 2001
kernel: usb-uhci.c: High bandwidth mode enabled
...
usbmgr[273]: class:0x9 subclass:0x0 protocol:0x0
kernel: PCI: Setting latency timer of device 00:1f.2 to 64
kernel: usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 9
kernel: usb-uhci.c: Detected 2 ports
kernel: usb.c: new USB bus registered, assigned bus number 1
kernel: usb.c: kmalloc IF cea94220, numif 1
kernel: usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
kernel: usb.c: USB device number 1 default language ID 0x0
kernel: Product: USB UHCI Root Hub
kernel: SerialNumber: 1820
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: hub.c: standalone hub
kernel: hub.c: ganged power switching
kernel: hub.c: global over-current protection
kernel: hub.c: power on to power good time: 2ms
kernel: hub.c: hub controller current requirement: 0mA
kernel: hub.c: port removable status: RR
kernel: hub.c: local power source is good
kernel: hub.c: no over-current condition exists
kernel: hub.c: enabling power on all ports
kernel: usb.c: hub driver claimed interface cea94220
kernel: usb.c: kusbd: /sbin/hotplug add 1
kernel: usb.c: kusbd policy returned 0xfffffffe
kernel: PCI: Found IRQ 9 for device 00:1f.4
kernel: PCI: Setting latency timer of device 00:1f.4 to 64
kernel: usb-uhci.c: USB UHCI at I/O 0x1840, IRQ 9
kernel: usb-uhci.c: Detected 2 ports
kernel: usb.c: new USB bus registered, assigned bus number 2
kernel: usb.c: kmalloc IF cf36e1e0, numif 1
kernel: usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
kernel: usb.c: USB device number 1 default language ID 0x0
kernel: Product: USB UHCI Root Hub
kernel: SerialNumber: 1840
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: hub.c: standalone hub
kernel: hub.c: ganged power switching
kernel: hub.c: global over-current protection
kernel: hub.c: power on to power good time: 2ms
kernel: hub.c: hub controller current requirement: 0mA
kernel: hub.c: port removable status: RR
kernel: hub.c: local power source is good
kernel: hub.c: no over-current condition exists
kernel: hub.c: enabling power on all ports
kernel: usb.c: hub driver claimed interface cf36e1e0
kernel: usb.c: kusbd: /sbin/hotplug add 1
kernel: usb.c: kusbd policy returned 0xfffffffe
usbmgr[273]: USB device is matched the configuration
usbmgr[273]: "none" isn't loaded
------------------------------
