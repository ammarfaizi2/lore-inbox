Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWFAQqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWFAQqF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWFAQqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:46:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:26249 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030236AbWFAQqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:46:04 -0400
Date: Thu, 1 Jun 2006 09:43:27 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, David Liontooth <liontooth@cogweb.net>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: USB devices fail unnecessarily on unpowered hubs
Message-ID: <20060601164327.GB29176@kroah.com>
References: <20060601030140.172239b0.akpm@osdl.org> <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 10:58:43AM -0400, Alan Stern wrote:
> On Thu, 1 Jun 2006, Andrew Morton wrote:
> 
> > On Thu, 01 Jun 2006 02:18:20 -0700
> > David Liontooth <liontooth@cogweb.net> wrote:
> > 
> > > Starting with 2.6.16, some USB devices fail unnecessarily on unpowered
> > > hubs. Alan Stern explains,
> > > 
> > > "The idea is that the kernel now keeps track of USB power budgets.  When a 
> > > bus-powered device requires more current than its upstream hub is capable 
> > > of providing, the kernel will not configure it.
> > > 
> > > Computers' USB ports are capable of providing a full 500 mA, so devices
> > > plugged directly into the computer will work okay.  However unpowered hubs
> > > can provide only 100 mA to each port.  Some devices require (or claim they
> > > require) more current than that.  As a result, they don't get configured
> > > when plugged into an unpowered hub."
> > > 
> > > http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg43480.html
> > > 
> > > This is generating a lot of grief and appears to be unnecessarily
> > > strict. Common USB sticks with a MaxPower value just above 100mA, for
> > > instance, typically work fine on unpowered hubs supplying 100mA.
> > > 
> > > Is a more user-friendly solution possible? Could the shortfall
> > > information be passed to udev, which would allow rules to be written per
> > > device?
> 
> I'm not sure whether we create a udev event when a new USB device is
> connected.

Yes we do.  It's of the class "usb_device" and you can write a single
udev rule to override the power test if you really want to.

Of course I don't recommend someone doing this, as it is violating the
USB power rules, and it is a good thing that we are finally testing for
them.

thanks,

greg k-h
