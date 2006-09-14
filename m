Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWINOJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWINOJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWINOJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:09:28 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:53463 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750762AbWINOJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:09:27 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
Date: Thu, 14 Sep 2006 16:08:45 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0609131749230.8180-100000@iolanthe.rowland.org> <200609141514.49527.rjw@sisk.pl>
In-Reply-To: <200609141514.49527.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141608.45884.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 14 September 2006 15:14, Rafael J. Wysocki wrote:
> On Wednesday, 13 September 2006 23:55, Alan Stern wrote:
> > On Wed, 13 Sep 2006, Rafael J. Wysocki wrote:
> > 
> > > > Try this patch instead.  It looks for problems occurring a little earlier 
> > > > in the call chain.
> > > 
> > > I've applied both patches at a time (I hope they don't conflict).
> > > 
> > > The dmesg output is attached.
> > 
> > The dmesg output shows the root-hub device state is set wrong.
> > 
> > I have to leave now, so I can't give you another patch to try.  You can 
> > experiment as follows...
> > 
> > Look in drivers/usb/host/ehci-pci.c, at ehci_pci_resume().  The part of 
> > interest is everything following the "restart:" statement label.
> > 
> > Try adding some ehci_dbg() lines in there (copy the form of the line just
> > after restart:).  We want to follow the value of
> > hcd->self.root_hub->state.  Initially it should be equal to
> > USB_STATE_SUSPENDED (= 8), and it shouldn't change.  But somewhere it is
> > getting set to USB_STATE_CONFIGURED (= 7).  I don't know where, but almost 
> > certainly somewhere in this routine.  If you can find out where that 
> > happens, I'd appreciate it.
> 
> Done, but it shows hcd->self.root_hub->state is already 7 right after restart.

BTW, all of the systems on which the problem shows up seem to be 64-bit.

If you can't reproduce it on a 32-bit system, some type casting may be wrong
somewhere.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
