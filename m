Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267712AbTGONcX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbTGONcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:32:23 -0400
Received: from mailc.telia.com ([194.22.190.4]:62404 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S267712AbTGONcV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:32:21 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Ruben Puettmann <ruben@puettmann.net>, linux-kernel@vger.kernel.org
Subject: Re: Problems with usb-ohci on 2.4.22-preX
Date: Tue, 15 Jul 2003 15:47:22 +0200
User-Agent: KMail/1.5.9
References: <20030712141431.GA3240@puettmann.net>
In-Reply-To: <20030712141431.GA3240@puettmann.net>
Cc: linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200307151547.22615.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not alone then...

On lördagen den 12 juli 2003 16.14, Ruben Puettmann wrote:
>         hy,
>
> i try to install linux on my new motherboard EPOX 8RDA3+
> with nvidia nforce2 chipset.
>
> If I try to attached some usb devices ( usb memory stick ) I got this
> errors ( 2.4.22-pre5 pre2..):

I used a Creative MuVo 64.

>
>
> PCI: Setting latency timer of device 00:02.2 to 64
> ehci_hcd 00:02.2: nVidia Corporation nForce2 USB Controller
> ehci_hcd 00:02.2: irq 20, pci mem f88eb000
> usb.c: new USB bus registered, assigned bus number 1
> PCI: 00:02.2 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
> PCI: 00:02.2 PCI cache line size corrected to 64.
> ehci_hcd 00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4

Is ehci compatible with ohci? Or does it get rejected later?

> hub.c: USB hub found
> hub.c: 6 ports detected
> PCI: Setting latency timer of device 00:02.0 to 64
> usb-ohci.c: USB OHCI at membase 0xf88f3000, IRQ 20
> usb-ohci.c: usb-00:02.0, nVidia Corporation nForce2 USB Controller
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 3 ports detected
> PCI: Setting latency timer of device 00:02.1 to 64
> usb-ohci.c: USB OHCI at membase 0xf88f5000, IRQ 22
> usb-ohci.c: usb-00:02.1, nVidia Corporation nForce2 USB Controller (#2)
> usb.c: new USB bus registered, assigned bus number 3
> hub.c: USB hub found
> hub.c: 3 ports detected

> uhci.c: USB Universal Host Controller Interface driver v1.1
> usb-uhci.c: $Revision: 1.275 $ time 15:11:40 Jul 12 2003
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver

The mix of drivers are confusing... Is usb-uhci rejected?
Check with lsmod.

> hub.c: new USB device 00:02.1-3, assigned address 2
> usb_control/bulk_msg: timeout
> usb-ohci.c: unlink URB timeout
> usb.c: USB device not accepting new address=2 (error=-110)

This is exactly what I get (2.4.20). But I use quite different hardware.
STPC Atlas (100MHz, for an embedded project)

>
> This happend's with usb-ohci and usb-ehci loaded or only with usb-ohci.
>

Our suspects:
* Power consumption of device related to how much we can drive.
  (but this should not be a problem in your case)
* BIOS/Linux memory IO mapping - cachable... e.t.c.
* Something in the driver,
  - a timing mismatch with the HW that was used to develop the driver?
  - a corrected hardware bug?
  (we got the driver to work with the USB memory unit on another PC with
   ohci - so we had almost accepted that the driver was correct... but now...)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
