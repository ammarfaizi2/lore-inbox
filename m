Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVGKXoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVGKXoU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVGKXma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 19:42:30 -0400
Received: from usbb-lacimss1.unisys.com ([192.63.108.51]:39693 "EHLO
	usbb-lacimss1.unisys.com") by vger.kernel.org with ESMTP
	id S262256AbVGKXlI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 19:41:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [NOT solved] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 18:41:02 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C4E@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [NOT solved] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Thread-Index: AcWGZBRnh9PPW8VlRJaiK7xBT9YnaAAAiwKQ
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Michel Bouissou" <michel@bouissou.net>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Alan Stern" <stern@rowland.harvard.edu>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Jul 2005 23:41:03.0296 (UTC) FILETIME=[FFEB3C00:01C58671]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Michel,
> >When you get chance, maybe you could boot the OS that used to work
for you (you mentioned 2.4) and provide the boot trace and
/proc/interrupts for comparison.
> # cat /proc/interrupts - 2.4:
>            CPU0
>   0:      32095    IO-APIC-edge  timer
>   1:        968    IO-APIC-edge  keyboard
>   2:          0          XT-PIC  cascade
>   4:        890    IO-APIC-edge  serial
>   7:          2    IO-APIC-edge  parport0
>   8:          1    IO-APIC-edge  rtc
>  14:         10    IO-APIC-edge  ide4
>  15:         42    IO-APIC-edge  ide5
>  18:       1714   IO-APIC-level  eth0, eth1
>  19:      13108   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd
>  21:        751   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci
>  22:          0   IO-APIC-level  VIA8233
> NMI:          0
> LOC:      32049
> ERR:          0
> MIS:         33
> 

One difference between the above and the 2.6 one you sent before is that
you don't seem to have rtc employed on 2.6:
           CPU0
  0:     626375    IO-APIC-edge  timer
  1:       1599    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:       1708    IO-APIC-edge  serial
  7:          2    IO-APIC-edge  parport0
 14:      19858    IO-APIC-edge  ide2
 15:       5220    IO-APIC-edge  ide3
 16:      30711   IO-APIC-level  nvidia
 18:       1799   IO-APIC-level  eth0, eth1
 19:     103365   IO-APIC-level  ide0, ide1, ehci_hcd:usb4, aic7xxx
 21:      47273   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2,
uhci_hcd:usb3
 22:       2782   IO-APIC-level  VIA8233

I don't expect this to be of any significance, but as Alan said you
never know... Another thing is that you are getting large number of
interrupts on the VIA device, whereas there is no any on 2.4. Does the
chipset get enabled differently? I wish I new VIA chipset, or had it,
will probably have to finally get some documentation on it. 

> And what should be relevant to USB in the boot log...:
> 
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.275 $ time 11:23:26 Jan  2 2005
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: USB UHCI at I/O 0xcc00, IRQ 21
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 21
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 21
> usb-uhci.c: Detected 2 ports

Here I see that no fixups were applied to the chipset, and it seemed to
work just fine without them. I would experiment and turn fixups off, but
since this is a production system... Hmmm. 

Your previous trace for 2.6 with fixups:

USB Universal Host Controller Interface driver v2.2
PCI: Via IRQ fixup for 0000:00:10.0, from 10 to 5 uhci_hcd 0000:00:10.0:
VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller uhci_hcd
0000:00:10.0: new USB bus registered, assigned bus number 1 uhci_hcd
0000:00:10.0: irq 21, io base 0x0000cc00 hub 1-0:1.0: USB hub found hub
1-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.1, from 10 to 5 uhci_hcd 0000:00:10.1:
VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2) uhci_hcd
0000:00:10.1: new USB bus registered, assigned bus number 2 uhci_hcd
0000:00:10.1: irq 21, io base 0x0000d000 hub 2-0:1.0: USB hub found hub
2-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5 uhci_hcd 0000:00:10.2:
VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3) usb 1-1:
new low speed USB device using uhci_hcd and address 2 uhci_hcd
0000:00:10.2: new USB bus registered, assigned bus number 3 uhci_hcd
0000:00:10.2: irq 21, io base 0x0000d400 hub 3-0:1.0: USB hub found hub
3-0:1.0: 2 ports detected
PCI: Via IRQ fixup for 0000:00:10.3, from 11 to 3 ehci_hcd 0000:00:10.3:
VIA Technologies, Inc. USB 2.0 ehci_hcd 0000:00:10.3: new USB bus
registered, assigned bus number 4 ehci_hcd 0000:00:10.3: irq 19, io mem
0xe3009000 ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver
10 Dec 2004
usbcore: registered new driver hiddev
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
usbhid: probe of 1-1:1.0 failed with error -5
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver irq 21: nobody
cared!

Seeing actual IO-APIC setup in both cases would help, the ones you get
with apic=verbose, and you might have to provide full traces (as
attachment for example). It is somewhat comforting for me to know that
my patch is not affecting the outcome. But it is important to crack this
case of course. I think we need higher authority here, such as Bjorn, or
Alan...

Cheers,
--Natalie
> --
> Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
> 
