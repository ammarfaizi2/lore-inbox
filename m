Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTLJCJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTLJCJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:09:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:38622 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263378AbTLJCI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:08:57 -0500
Date: Tue, 9 Dec 2003 17:49:02 -0800
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Message-ID: <20031210014902.GR2279@kroah.com>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312091149.27629.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312091149.27629.baldrick@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 11:49:27AM +0100, Duncan Sands wrote:
> > I didn't note the reason for the oops.  Was it a segmentation violation?
> > The usb_device memory isn't deallocated until the reference count goes to
> > 0.  Maybe something was doing an extra usb_put_dev.
> 
> Maybe this is related to "oopses in kobjects in 2.6.0-test11 (was Re: kobject patch)"?
> My call to usb_put_dev in usbdev_release is releasing the kobject,
> which shows that the reference count was not already zero.  However
> it dereferences a NULL pointer in here:
> 
> static void hcd_pci_release(struct usb_bus *bus)
> {
>         struct usb_hcd *hcd = bus->hcpriv;
> 
>         if (hcd)
>                 hcd->driver->hcd_free(hcd);
> }
> 
> which suggests that the hcd was already released.  Maybe Greg can comment?

Does not look like the kobject oops.  This looks like something else is
messing up the hcd pointer.

thanks,

greg k-h
