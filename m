Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129339AbRCEPn1>; Mon, 5 Mar 2001 10:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129355AbRCEPnS>; Mon, 5 Mar 2001 10:43:18 -0500
Received: from cristal.i-quake.com ([213.244.4.226]:13063 "EHLO
	cristal.i-quake.com") by vger.kernel.org with ESMTP
	id <S129339AbRCEPnJ>; Mon, 5 Mar 2001 10:43:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Michel Bouissou <michel@bouissou.net>
Organization: Completely desorganized
To: linux-kernel@vger.kernel.org
Subject: VIA KT133 chipset PCI crazyness...
Date: Mon, 5 Mar 2001 16:43:13 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01030516133300.01050@totor.bouissou.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've seen in this M.L a message from Linus, dated 2001/01/07, talking about 
possible problems in the PCI IRQ management with some VIA chipsets.

Unfortunately, I seem to suffer from this problem as well (which incidentally 
tends to confirm that it exists).

I've recently upgraded my system by putting a MSI K7T Pro2-A motherboard in 
it, that includes the VIA KT133 chipset (VT8363 system controller + VT82C686B 
PCI bridge.

With this new motherboard and a 2.4.0 kernel, I first noticed that system was 
purely and simply badly hanging everytime I tried to shut it down or reboot 
it. Just as if I had used some other too-well-known operating system :-(((
When not shutting it down, it was working good anyway, but didn't like me 
trying to shut it down...

Having a look in the system log, I discovered the following message about IRQ 
problems with the USB ports:

<<IRQ routing conflict in pirq table! Try 'pci=autoirq'>>

Well, the only thing I could find that solved this system hanging problem was 
to purely disable completely my USB controller in BIOS :-(((
Then, the system wouldn't hang anymore.

Today, to try and fix it, I compiled and installed a 2.4.2 kernel, and, even 
though it seems that I don't have this shutdown-hanging anymore, even with 
the USB activated, I notice in my "dmesg" much more IRQ related errors than 
what I previously had with 2.4.0...

I get a number of messages like:

spurious 8259A interrupt: IRQ7.

SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:09.0
IRQ routing conflict in pirq table for device 00:07.5
PCI: The same IRQ used for device 00:0d.0
(scsi0) <Adaptec AHA-2940A Ultra SCSI host adapter> found at PCI 0/9/0

Via 686a audio driver 1.1.14a
PCI: Found IRQ 10 for device 00:07.5
IRQ routing conflict in pirq table for device 00:07.5
PCI: The same IRQ used for device 00:09.0
PCI: The same IRQ used for device 00:0d.0
ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (ICE1232)
via82cxxx: board #1 at 0xCC00, IRQ 11

PCI: Found IRQ 10 for device 00:0d.0
IRQ routing conflict in pirq table for device 00:07.5
PCI: The same IRQ used for device 00:09.0
eth1: RealTek RTL8139 Fast Ethernet at 0xd185f000, 00:ee:b0:00:e7:f0, IRQ 10
eth1:  Identified 8139 chip type 'RTL-8139C'

0x378: possible IRQ conflict!
[...]
0x378: ECP settings irq=<none or set by other means> dma=<none or set by 
other means>
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,ECP,DMA]
[...]
parport_pc: Via 686A parallel port: io=0x378, irq=7, dma=3
lp0: using parport0 (interrupt-driven).

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 14:21:34 Mar  5 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:07.2
IRQ routing conflict in pirq table for device 00:07.2
IRQ routing conflict in pirq table for device 00:07.3
usb-uhci.c: USB UHCI at I/O 0xc400, IRQ 9
usb-uhci.c: Detected 2 ports
[...]

PCI: Found IRQ 11 for device 00:07.3
IRQ routing conflict in pirq table for device 00:07.2
IRQ routing conflict in pirq table for device 00:07.3
usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 9
usb-uhci.c: Detected 2 ports


Well, a real IRQ mess isn't it ? I'm quite surprised my system seems to be 
working...

[michel@totor michel]$ cat /proc/interrupts
           CPU0
  0:     123724          XT-PIC  timer
  1:       7083          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:       2044          XT-PIC  serial
  5:        163          XT-PIC  eth0
  7:         92          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:         70          XT-PIC  usb-uhci, usb-uhci
 10:       1724          XT-PIC  aic7xxx, eth1
 11:      52663          XT-PIC  via82cxxx
 12:      22537          XT-PIC  PS/2 Mouse
 14:       8217          XT-PIC  ide0
NMI:        139
LOC:     123681
ERR:         40

But now, it seems that some of the IRQs have been reaffected to other values 
than those which the system was complaining about.

The system was complaining about the Audio being at IRQ 10... Now it seems to 
have been moved at IRQ 11.

The system looked unhappy with 2 USB controllers being at IRQ 11... Now they 
have moved to IRQ 9...

What the hell is going on on this machine ? 8~\

Again, the very surprising thing is that, besides these error messages, 
everything seems to be actually working...

Go figure...

-- 
Michel Bouissou - OpenPGP DH/DSS ID 0x5C2BEE8F
michel@bouissou.net

