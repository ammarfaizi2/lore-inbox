Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWJFRsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWJFRsN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWJFRsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:48:13 -0400
Received: from mx2.rowland.org ([192.131.102.7]:50183 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1751211AbWJFRsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:48:12 -0400
Date: Fri, 6 Oct 2006 13:48:11 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] error to be returned while suspended
In-Reply-To: <200610060921.52186.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0610061342290.1311-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006, Oliver Neukum wrote:

> Am Donnerstag, 5. Oktober 2006 23:45 schrieb Alan Stern:
> > On Thu, 5 Oct 2006, Oliver Neukum wrote:
> > 
> > > I have a few observations, but no solution either:
> > > - if root tells a device to suspend, it shall do so
> > 
> > Probably everyone will agree on that.
> 
> But should it stay suspended until explictely resumed? Do we have
> consensus on that?

If remote wakeup is disabled, the device will remain suspended until 
something tells it to wake up.

> > > - there should be a common API for all devices
> > 
> > It would be nice, wouldn't it?  But we _already_ have several vastly
> > different power-management APIs.  Consider for example DPMI and IDE 
> > spindown.
> 
> No reason to make matters worse.

Yes, there is.  Consider that in many cases (think especially of embedded 
platforms) devices have more than 2 power states, on or suspended.  That's 
true even for PCI and ATA.  Each sort of bus has its own set of possible 
power states, and it's hopeless to try and unify them.

> > > - there's no direct connection between power save and open()
> > 
> > Why shouldn't a device always be put into a power-saving mode whenever it 
> > isn't open?  Agreed, you might want to reduce its power usage at times 
> > even when it is open...
> 
> That and you are putting the latency/power choice into kernel space.
> I've seen GPS recievers that need 30 seconds to get a fix. Autosuspend
> needs to be in kernel space. But that doesn't mean that it is sufficient
> as a mechanism nor that it doesn't need parameters supplied from
> user space.

Like I said, drivers need to make their own individual choices.  
Suspending during "close" may not always be best for all devices.  But for
many it is acceptable and a lot better than nothing.

Alan Stern

