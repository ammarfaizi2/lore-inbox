Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWJEU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWJEU3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWJEU3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:29:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47879 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932066AbWJEU3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:29:53 -0400
Date: Thu, 5 Oct 2006 16:29:51 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: Duncan Sands <baldrick@free.fr>, <usbatm@lists.infradead.org>,
       <linux-usb-devel@lists.sourceforge.net>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, ueagle <ueagleatm-dev@gna.org>,
       matthieu castet <castet.matthieu@free.fr>
Subject: Re: [linux-usb-devel] [PATCH 1/3] UEAGLE : be suspend friendly
In-Reply-To: <20061005181426.GA27838@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0610051621410.7144-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, Pavel Machek wrote:

> Hi!
> 
> > > > Plug/unplug should be easy enough to simulate from usb driver, no?
> > > 
> > > if a USB driver doesn't define suspend/resume methods, then the core simply
> > > unplugs it on suspend, and replugs on resume (IIRC).
> > 
> > No longer true, and IIRC it never was.  All that happens is that URB 
> > submissions fail with -EHOSTUNREACH once the device is suspended.
> 
> Could we get "old" behaviour for devices like this? "printk("please
> unplug/replug me\n")" is not a good solution.

I would much rather see this fixed in the driver itself.

For the time being, a "dummy" suspend routine could look like this:

static int foo_suspend(struct usb_interface *intf, pm_message_t msg)
{
	up(&intf->dev.sem);
	device_release_driver(&intf->dev);
	down(&intf->dev.sem);
	return 0;
}

Getting reprobed during resume would be more difficult; it would need help 
from userspace.

Maybe UEAGLE can do something a little more sensible...

Alan Stern

