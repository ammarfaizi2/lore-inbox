Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbVI1VKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVI1VKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbVI1VKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:10:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:50601 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750923AbVI1VKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:10:43 -0400
Date: Wed, 28 Sep 2005 17:10:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: David Brownell <david-b@pacbell.net>, <rjw@sisk.pl>, <torvalds@osdl.org>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       <hugh@veritas.com>, <akpm@osdl.org>
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm2
In-Reply-To: <200509282245.30410.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.44L0.0509281706570.5193-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Daniel Ritz wrote:

> > It's handled in hcd-pci.c ... All PCI based HCDs release their IRQs
> > when they suspend.  Including OHCI.  Your diagnosis is incorrect.
> 
> would you be kind enough to tell me where?
> 
> my point is: the test patch i sent to rafael which comments out the
> free_irq-on-suspend thing in hcd-pci.c shows that something is wrong with
> USB (i think only OHCI. UHCI looks ok and about EHCI i have no data). 

There are two issues here: freeing the IRQ handler and preventing the 
device from generating interrupt requests in the first place.  Dave and I 
discussed this some time ago and agreed it was vital to stop interrupt 
generation at the source, before releasing the handler, whenever the 
device is suspended.

So the real question becomes, is your OHCI controller somehow generating 
interrupt requests at a time when it shouldn't be?  Adding debugging 
printk's to the driver's interrupt handler could answer this.

If it isn't, then the problem you see has some other cause.  ACPI often 
turns out to be the culprit.

Alan Stern

