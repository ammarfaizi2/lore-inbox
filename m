Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUGEUbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUGEUbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 16:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUGEUbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 16:31:49 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:54234 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S262006AbUGEUbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 16:31:45 -0400
Subject: Re: 2.6.7-mm3 USB ehci IRQ problem
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1089058581.2496.9.camel@paragon.slim>
References: <A6974D8E5F98D511BB910002A50A6647615FEF3E@hdsmsx403.hd.intel.com>
	 <1089054167.15653.51.camel@dhcppc4>  <1089058581.2496.9.camel@paragon.slim>
Content-Type: text/plain
Message-Id: <1089059612.3589.5.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 05 Jul 2004 22:33:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 22:16, Jurgen Kramer wrote:
> On Mon, 2004-07-05 at 21:02, Len Brown wrote:
> > On Sun, 2004-06-27 at 08:02, Jurgen Kramer wrote:
> > > With 2.6.7-mm3 I am missing my USB 2.0 memory stick. It doesn't show
> > > up in the usb device listing. But when I unplug it I get:
> > > 
> > > irq 23: nobody cared!
> > >  [<c0108106>] __report_bad_irq+0x2a/0x8b
> > >  [<c01081f0>] note_interrupt+0x6f/0x9f
> > >  [<c0108473>] do_IRQ+0x10c/0x10e
> > >  [<c0106850>] common_interrupt+0x18/0x20
> > > handlers:
> > > [<f9d0f65c>] (snd_emu10k1_interrupt+0x0/0x3c4 [snd_emu10k1])
> > > Disabling IRQ #23
> > > 
> > > The soundcard is still usable but there are no new interrupts.
> > > 
> > > When I try to reload the ehci module I get:
> > > 
> > > ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
> > > ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI
> > > Controller
> > > ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
> > > ehci_hcd 0000:00:1d.7: can't reset
> > > ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
> > > ehci_hcd: probe of 0000:00:1d.7 failed with error -95
> > > 
> > > IRQ23 is normally shared between emu10k1 and the ehci controller
> > > without problems.
> > 
> > it worked normally in 2.6.7 vanilla?
> 
> Haven't actually tried vanilly 2.6.7, compiling as we speak. Will report
> the results later.

2.6.7 vanilly results are in. The results are...it works..

<snip>
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f881dc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected

Yes! So the USB memory stick is also back again, output from lsusb:

Bus 005 Device 001: ID 0000:0000
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 002: ID 0c0b:27cb Dura Micro, Inc. (Acomdata) 6-in-1
Flash Reader and Writer
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 002: ID 046d:c505 Logitech, Inc. Cordless Mouse+Keyboard
Receiver
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 002: ID 1005:b113 Apacer Technology, Inc. Handy Steno 2.0
(256MB)
Bus 001 Device 001: ID 0000:0000

What changed in the -mm series which makes the EHCI controller
disappear? I reckon more owners of i875p boards should have this
problem(?).

Jurgen


