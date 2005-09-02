Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVIBPTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVIBPTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 11:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVIBPTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 11:19:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:13293 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750709AbVIBPTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 11:19:18 -0400
Date: Fri, 2 Sep 2005 11:19:17 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Reuben Farrelly <reuben-lkml@reub.net>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: 2.6.13-mm1
In-Reply-To: <20050901190413.7790b869.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0509021110480.5367-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2005, Andrew Morton wrote:

> Reuben Farrelly <reuben-lkml@reub.net> wrote:

> > I'm also observing some USB messages logged:
> > 
> > Sep  2 13:26:22 tornado kernel: usb 5-1: new full speed USB device using 
> > uhci_hcd and address 13
> > Sep  2 13:26:22 tornado kernel: drivers/usb/class/usblp.c: usblp0: USB 
> > Bidirectional printer dev 13 if 0 alt 0 proto 2 vid 0x03F0 pid 0x6204
> > Sep  2 13:26:23 tornado kernel: hub 5-0:1.0: port 1 disabled by hub (EMI?), 
> > re-enabling...

This message means pretty much what it says: noise or something else 
caused the connection to be disabled.  In theory this could be caused by a 
problem with the host controller, the cable, or the printer.  Does this 
happen consistently with 2.6.13-mm1?  Did it happen with 2.6.12?

> > Sep  2 13:26:23 tornado kernel: usb 5-1: USB disconnect, address 13
> > Sep  2 13:26:23 tornado kernel: drivers/usb/class/usblp.c: usblp0: removed
> > Sep  2 13:26:23 tornado kernel: usb 5-1: new full speed USB device using 
> > uhci_hcd and address 14
> > Sep  2 13:26:23 tornado kernel: usb 5-1: device descriptor read/64, error -71
> > Sep  2 13:26:23 tornado kernel: usb 5-1: device descriptor read/64, error -71
> > Sep  2 13:26:23 tornado kernel: usb 5-1: new full speed USB device using 
> > uhci_hcd and address 15
> > Sep  2 13:26:23 tornado kernel: usb 5-1: device descriptor read/all, error -71
> > Sep  2 13:26:23 tornado kernel: usb 5-1: new full speed USB device using 
> > uhci_hcd and address 16
> > Sep  2 13:26:23 tornado kernel: usb 5-1: can't set config #1, error -71
> > Sep  2 13:26:23 tornado kernel: usb 5-1: new full speed USB device using 
> > uhci_hcd and address 17
> > Sep  2 13:26:24 tornado kernel: usb 5-1: unable to read config index 0 
> > descriptor/start
> > Sep  2 13:26:24 tornado kernel: usb 5-1: can't read configurations, error -71

If it's not already in 2.6.13-mm1, this patch may help with the 
reinitialization:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=112551468126219&w=2

Alan Stern

