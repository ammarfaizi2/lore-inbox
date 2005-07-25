Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVGYUpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVGYUpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVGYUpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:45:45 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:65000 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261560AbVGYUoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:44:37 -0400
Date: Mon, 25 Jul 2005 16:44:36 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
In-Reply-To: <200507252214.06802@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507251635510.8043-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005, Michel Bouissou wrote:

> Le Lundi 25 Juillet 2005 21:18, Alan Stern a écrit :
> >
> > It seems quite clear that the EHCI controller's IRQ line is causing the
> > problems.  Just out of curiousity, what happens if you really do remove
> > the UHCI driver, keeping only the EHCI driver, and then plug in the mouse?
> > Off hand I would expect nothing much to happen -- maybe a line or two in
> > the system log, no change to the IRQ counters, and the mouse doesn't work
> > (not even erratically).
> 
> As you expect, in such a condition (with only ehci loaded), absolutely nothing 
> happens when plugging the mouse.
> 
> OTOH, a high-speed device is recognized, althouh it generates messages like:
> 
> totor kernel: usb 1-5: device not accepting address 3, error -71
> totor kernel: usb 1-5: new high speed USB device using ehci_hcd and address 4
> totor kernel: usb 1-5: device not accepting address 4, error -71
> totor kernel: usb 1-5: new high speed USB device using ehci_hcd and address 5
> 
> If plugged to any USB socket, except the two integrated to the motherboard 
> connectors plate. There only it fully succeeds without such errors.

Now that's strange.  When you plug the high-speed device into the 
integrated ports, which IRQ counter changes?  Since nothing is using IRQ 
21, it should be disabled and its counter should remain constant.  Does 
this mean the interrupts show up on IRQ 19 (used by ehci-hcd), or do they 
not show up at all (i.e., is the USB connection just being polled)?

Those -71 errors do not indicate IRQ problems -- they indicate low-level 
errors in the USB data signals.  They could be caused by problems in the 
cabling from the motherboard to the ports, problems in the electrical 
terminations, or other things.

Alan Stern

