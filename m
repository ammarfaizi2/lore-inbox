Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbUBAVbf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265634AbUBAVbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:31:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:5298 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265615AbUBAVbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:31:31 -0500
Date: Sun, 1 Feb 2004 13:28:03 -0800
From: Greg KH <greg@kroah.com>
To: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which interface: sysfs, proc, devfs?
Message-ID: <20040201212802.GA16301@kroah.com>
References: <20040129222813.3b22b2c8.diemer@gmx.de> <20040129230250.GA9988@kroah.com> <20040201215721.737ef5a3.diemer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201215721.737ef5a3.diemer@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 09:57:21PM +0100, Jonas Diemer wrote:
> On Thu, 29 Jan 2004 15:02:50 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > What about not writing a kernel driver at all and just using
> > libusb/usbfs?  Any reason you have to have a kernel driver for your
> > device?
> 
> 
> Well, I have just looked into libusb 0.1.x... I would like to have
> asynchronous (non-blocking) access to my device, which libusb doesn't
> currently support.

You mean "submit a urb and be notified when it was completed?"  I
thought libusb supported that with signals.

> Also I don't like the way libusb finds devices - manually scanning all
> busses doesn't seem very handy.

What other way can a userspace library do this?  It doesn't take very
long at all, what is the problem with this?

> Thus I will probably go for a kernel module, using sysfs to interface
> with the user. Thanks for all the help anyways-

Remember that sysfs is "1 value per file".  If that works for your
device, then I suggest you look at the usbled driver, as that is a tiny
usb driver that only uses sysfs.  Nothing like a 4kb kernel driver :)

Good luck,

greg k-h
