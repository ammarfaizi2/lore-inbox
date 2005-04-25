Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVDYVMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVDYVMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDYVMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:12:41 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:1408 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261206AbVDYVMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:12:13 -0400
Date: Mon, 25 Apr 2005 17:12:09 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alexander Nyberg <alexn@dsv.su.se>
cc: Greg KH <greg@kroah.com>, Amit Gud <gud@eth.net>,
       <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <akpm@osdl.org>, <jgarzik@pobox.com>, <cramerj@intel.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
In-Reply-To: <1114462323.983.45.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0504251700560.4896-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, Alexander Nyberg wrote:

> > Do I understand your argument correctly?  You seem to be saying that 
> > because this new facility sometimes won't work (the kexec-on-panic case) 
> > it shouldn't be added at all.  What about all the other times when it will 
> > work?
> 
> No, I was saying that this approach doesn't solve all problems that
> exist with kexec and kexec-on-panic is a very important coming
> functionality. If there is going to be prepatory work for its coming we
> might as well at least try to consider all the problems that are at
> hand.
> Otherwise the same problems will just appear again when kexec-on-panic
> starts to get used in the real world.

I doubt anything can solve _all_ problems that exist with kexec.  :-)

Do you have any suggestions for a better way to stop a device from issuing
IRQs and doing DMA at any point between the time when the old kernel
panics and the time when the new kernel loads the device's driver?

I looked into the possibility of having the PCI core disable interrupt
generation and DMA on each new device as it is discovered.  Unfortunately
there is no dependable, universal way to do this for IRQs.  (A notable gap
in the original PCI specification, IMHO.)  Another problem with this
approach is that on some platforms the initial console is a PCI device
driven by the firmware, but the firmware won't tell Linux which device it
is!  Disable the wrong device and away goes your screen display.

Alan Stern

