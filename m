Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVBGWnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVBGWnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBGWny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:43:54 -0500
Received: from main.gmane.org ([80.91.229.2]:46299 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261291AbVBGWkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:40:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [linux-usb-devel] 2.6: USB disk unusable level of data corruption
Date: Mon, 7 Feb 2005 23:39:12 +0100
Message-ID: <MPG.1c716150e09cf2f989713@news.gmane.org>
References: <1107519382.1703.7.camel@localhost.localdomain> <16900.5586.511772.651559@smtp.charter.net> <MPG.1c7037c9d0a0407989711@news.gmane.org> <200502062001.59546.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-104-149.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
X-Gmane-MailScanner: Found to be clean
Cc: linux-usb-devel@lists.sourceforge.net
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: s
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> On Sunday 06 February 2005 7:59 am, Giuseppe Bilotta wrote:
> > 
> > I have a MAGNEX/ViPower USB/FirWire external HD enclosure. I 
> > found that it works pretty fine (albeit slowly) when connected 
> > to the USB 1.1 ports built in my Dell Inspiron 8200, but trying 
> > to connect it via the Hamlet PCMCIA USB2 Card Adapter doesn't 
> > work (it seems it gets assigned minors 1,2,3,4,5,6,... and so 
> > on forever until I unplug it).
> 
> What do you mean "minors"?  Addresses or actual /dev/sdN numbers?
> 
> If it's addresses, that would be an an enumeration problem.  Some
> recent changes have caused prolems there, 2.6.11-rc3-mm2 ought to
> have a patch making it better.  (Well, working around one of the
> two problems that'd suggest.)

Sorry, it's addresses.

usb 5-1: new high speed USB device using ehci_hcd and address 4
usb 5-1: new high speed USB device using ehci_hcd and address 5
usb 5-1: new high speed USB device using ehci_hcd and address 6

blah blah blah, neverending. So yes, it's probably the 
enumeration problem.

Also, when I plug in the PCMCIA card I get (sorry for the 
wrapping, Gravity sucks)

PCI: Enabling device 0000:07:00.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:07:00.0[A] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:07:00.0: NEC Corporation USB
PCI: Setting latency timer of device 0000:07:00.0 to 64
ohci_hcd 0000:07:00.0: irq 11, pci mem 0x29000000
ohci_hcd 0000:07:00.0: new USB bus registered, assigned bus 
number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
PCI: Enabling device 0000:07:00.1 (0000 -> 0002)
ACPI: PCI interrupt 0000:07:00.1[B] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:07:00.1: NEC Corporation USB (#2)
PCI: Setting latency timer of device 0000:07:00.1 to 64
ohci_hcd 0000:07:00.1: irq 11, pci mem 0x29001000
ohci_hcd 0000:07:00.1: new USB bus registered, assigned bus 
number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Enabling device 0000:07:00.2 (0000 -> 0002)
ACPI: PCI interrupt 0000:07:00.2[C] -> GSI 11 (level, low) -> 
IRQ 11
ehci_hcd 0000:07:00.2: NEC Corporation USB 2.0
ehci_hcd 0000:07:00.2: irq 11, pci mem 0x29002000
ehci_hcd 0000:07:00.2: new USB bus registered, assigned bus 
number 5
ehci_hcd 0000:07:00.2: USB 2.0 initialized, EHCI 0.95, driver 
26 Oct 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 5 ports detected 

The card only has 2 USB ports .. why 5 ports here? Is this the 
same bug?

Another interesting tidbit is that I get:

USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> 
IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0xbf80
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus 
number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> 
IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0xbf20
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus 
number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected 

for the built-in ports ... I only have two USB ports on this 
machine though, why does it see 4 of them?

(Do you also need the lspci and/or lsusb and/or dmesg of the 
error that happens when I disable the EHCI driver and only let 
the OHCI manage the PCMCIA card?)

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

