Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUIUIKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUIUIKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 04:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUIUIKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 04:10:31 -0400
Received: from styx.suse.cz ([82.119.242.94]:62080 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S266741AbUIUIK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 04:10:29 -0400
Date: Tue, 21 Sep 2004 10:10:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure with 2.6.9-rc2-bk latest in usb/hid-core.c
Message-ID: <20040921081047.GA10757@ucw.cz>
References: <1095610092.10887.16.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095610092.10887.16.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 12:08:04PM -0400, James Bottomley wrote:

> I get this out of the machine (an ia64 zx2000 with connected USB
> keyboard and mouse):

> usb usb1: Product: NEC Corporation USB
> usb usb1: Manufacturer: Linux 2.6.9-rc2 ohci_hcd
> usb usb2: Product: NEC Corporation USB (#2)
> usb usb2: Manufacturer: Linux 2.6.9-rc2 ohci_hcd
> usb 1-2: Product: Standard USB Keyboard 
> usb 1-2: Manufacturer: Silitek
> usbcore: registered new driver hiddev
> input: USB HID v1.00 Keyboard [Silitek Standard USB Keyboard ] on usb-0000:a0:01.0-2
> usb 2-2: Product: N48
> usb 2-2: Manufacturer: Logitech
> input: USB HID v1.00 Mouse [Logitech N48] on usb-0000:a0:01.1-2

> ACPI: PCI interrupt 0000:a0:01.2[C] -> GSI 40 (level, low) -> IRQ 59
> ehci_hcd 0000:a0:01.2: NEC Corporation USB 2.0
> ehci_hcd 0000:a0:01.2: USB 2.0 enabled, EHCI 0.95, driver 2004-May-10
> drivers/usb/input/hid-core.c: input irq status -110 received
> drivers/usb/input/hid-core.c: input irq status -110 received
> [the last message repeats forever]

> It boots just fine with 2.6.9-rc2 and the only difference to the usb
> input subsystem appears to be your latest merge.

There were changes in the function that prints the above message,
however they were indentation only. I really doubt it could be the HID
changes I did.

It looks like there is either a problem with ACPI IRQ routing that when
enabling the EHCI controller IRQ does something bad to the OHCI
controllers, or the EHCI driver itself does something bad to the OHCI
controllers. (Afte all, the controllers share their ports.)

Try disabling EHCI in your config to confirm my theory.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
