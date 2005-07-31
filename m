Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVGaSZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVGaSZS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVGaSZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:25:18 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:52615 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261851AbVGaSZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:25:15 -0400
X-ORBL: [69.107.32.110]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=kGYkdMXc2rSXZLzQAgkNXneEWuWiUmcWfU7M4HzhA6HGcEWqjzQoON1emkdgNAj5W
	3x9babwaI4kdRUtxITR/w==
Date: Sun, 31 Jul 2005 11:25:10 -0700
From: david-b@pacbell.net
To: iogl64nx@gmail.com, akpm@osdl.org
Subject: Re: [linux-usb-devel] Re: 2.6.13-rc4-mm1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050731020552.72623ad4.akpm@osdl.org>
 <42ECEA30.5060204@gmail.com> <20050731104214.5c0e686c.akpm@osdl.org>
In-Reply-To: <20050731104214.5c0e686c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050731182510.D11F2DB13C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If my Prolific USB-Serialadapter  plugged in on reboot
> > the ehci_hcd driver complains about a Hand-off bug in Bios.
> > 
> > -> snip
> > 
> > ehci_hcd 0000:00:1d.7: EHCI Host Controller
> > ehci_hcd 0000:00:1d.7: debug port 1
> > 
> > ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 01010001)
> > ehci_hcd 0000:00:1d.7: continuing after BIOS bug...

This is a warning, not an error, but it's one of two symptoms of
BIOS level problems on your board.

	- Try booting with the "usb-handoff" kernel parameter,
	  to kick in more specialized PCI quirk handling.

	- See if there's a BIOS setting related to USB that you
	  can change.  Sometimes they use quirky modes.

	- See if there's a BIOS update for your motherboard.

I think that "continuing" codepath came from someone at Phoenix, FWIW;
the problem is that I see the PCI quirks code has evolved even farther
from the main copy of the init code in the USB tree.  Sigh.


> > When I rebooted without plugged Prolific Adapter and plug them in the 
> > same port the kernel prints this message.
> > 
> > ->snip
> > 
> > usb 4-1: new full speed USB device using uhci_hcd and address 2
> > pl2303 4-1:1.0: PL-2303 converter detected
> > usb 4-1: PL-2303 converter now attached to ttyUSB0
> > 
> > 
> > Any Ideas what could be wrong here?

That is, you think it should always see the adapter,
not just when it's not plugged in at boot time?

Sure sounds like BIOS problems to me.

- Dave

