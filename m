Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbVHRGuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbVHRGuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVHRGug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:50:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50704 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750859AbVHRGug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:50:36 -0400
Date: Thu, 18 Aug 2005 07:50:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, James.Smart@Emulex.Com,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] add transport class symlink to device object
Message-ID: <20050818075027.D2365@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
	James.Smart@Emulex.Com, Andrew Morton <akpm@osdl.org>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD35@xbl3.ma.emulex.com> <20050813213955.GB19235@kroah.com> <20050814150231.GA9466@parcelfarce.linux.theplanet.co.uk> <20050814232525.A27481@flint.arm.linux.org.uk> <20050815004303.GB9466@parcelfarce.linux.theplanet.co.uk> <20050815093244.A19811@flint.arm.linux.org.uk> <20050818052156.GC29301@kroah.com> <20050818073049.B2365@flint.arm.linux.org.uk> <20050818064129.GA2280@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050818064129.GA2280@kroah.com>; from greg@kroah.com on Wed, Aug 17, 2005 at 11:41:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 11:41:29PM -0700, Greg KH wrote:
> On Thu, Aug 18, 2005 at 07:30:50AM +0100, Russell King wrote:
> > On Wed, Aug 17, 2005 at 10:21:56PM -0700, Greg KH wrote:
> > > On Mon, Aug 15, 2005 at 09:32:44AM +0100, Russell King wrote:
> > > > On Mon, Aug 15, 2005 at 01:43:03AM +0100, Matthew Wilcox wrote:
> > > > > On Sun, Aug 14, 2005 at 11:25:25PM +0100, Russell King wrote:
> > > > > > Eww.  Do you really want one struct device per tty with all the
> > > > > > memory each one eats?
> > > > > > 
> > > > > > If that's really what you want you need to talk to Alan and not me.
> > > > > > Alan looks after tty level stuff, I look after serial level stuff.
> > > > > > The above is a tty level issue not a serial level issue.
> > > > > 
> > > > > mmm.  I don't know whether it's really a tty level issue or a serial
> > > > > issue.  The only tty classes with corresponding devices are the serial
> > > > > ones, at least on my system.  If this is the case, then the right fix
> > > > > would seem to be something like creating a new struct device for each
> > > > > serial port, then making that the uart_port->dev instead of the pci_dev
> > > > > or whatever.
> > > > 
> > > > What's the reason for enforcing one struct device per struct class_dev ?
> > > > I thought one of the points of class_dev was that you could have multiple
> > > > of them per struct device.
> > > 
> > > No such enforcement is needed at all, and not encouraged.
> > 
> > The complaint is that serial is registering several different class_devs
> > for the same class and device.
> 
> That's because they are unique class devices, right?  I don't see a
> problem here at all.

They are class devices called ttyS0, ttyS1, ttyS2 so you can say
they're uniquely named.

The problem is that Matthew wants to add a symlink from the device
device to the class device to complement the class device to device
symlink, since we end up with multiple symlinks in the devices subdir
all called the same.

This causes serial a problem because we have multiple class devices
per device.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
