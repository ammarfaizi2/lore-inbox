Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWINPEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWINPEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWINPEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:04:50 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:7944 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750736AbWINPEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:04:49 -0400
Date: Thu, 14 Sep 2006 11:04:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Robert Hancock <hancockr@shaw.ca>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <200609141608.45884.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609141100580.8471-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Rafael J. Wysocki wrote:

> > > Try adding some ehci_dbg() lines in there (copy the form of the line just
> > > after restart:).  We want to follow the value of
> > > hcd->self.root_hub->state.  Initially it should be equal to
> > > USB_STATE_SUSPENDED (= 8), and it shouldn't change.  But somewhere it is
> > > getting set to USB_STATE_CONFIGURED (= 7).  I don't know where, but almost 
> > > certainly somewhere in this routine.  If you can find out where that 
> > > happens, I'd appreciate it.
> > 
> > Done, but it shows hcd->self.root_hub->state is already 7 right after restart.
> 
> BTW, all of the systems on which the problem shows up seem to be 64-bit.
> 
> If you can't reproduce it on a 32-bit system, some type casting may be wrong
> somewhere.

I realized last night what the problem must be.  It's extremely obvious in 
retrospect, but I happen to have a blind spot in this particular area.

All you guys must have CONFIG_USB_SUSPEND turned off.  Mattis certainly 
does; I checked his .config.  Now I hardly ever do any testing without 
CONFIG_USB_SUSPEND, since there's not much point working on power 
management code if your kernel isn't set up to actually suspend devices.
As a result I missed seeing the problems caused by the autosuspend 
changes.

Now of course, the autosuspend stuff has to work properly no matter what 
the kernel configuration is.  I'll go back and rebuild the drivers with 
USB_SUSPEND turned off and see what happens.  With any luck I'll have a 
fix ready in the near future.

Alan Stern

