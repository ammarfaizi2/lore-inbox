Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbULVAFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbULVAFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbULVAFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:05:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:22682 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261912AbULVAFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:05:24 -0500
Date: Tue, 21 Dec 2004 16:05:09 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, willy@debian.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] add legacy resources to sysfs
Message-ID: <20041222000509.GA12595@kroah.com>
References: <200412211247.44883.jbarnes@engr.sgi.com> <20041221214623.GB10362@kroah.com> <200412211405.09536.jbarnes@engr.sgi.com> <200412211542.47997.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412211542.47997.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 03:42:47PM -0800, Jesse Barnes wrote:
> On Tuesday, December 21, 2004 2:05 pm, Jesse Barnes wrote:
> > On Tuesday, December 21, 2004 1:46 pm, Greg KH wrote:
> > > You are passing the wrong things around :)
> > >
> > > A struct pci_bus is a struct class_device, not a struct device.  I think
> > > you need to rethink your goal of putting the files into the pci device
> > > directory, or just put the files into the proper /sys/class/pci_bus/*
> > > directory as your code assumes is happening.
> >
> > Something like this then?  I added bin file support to class.c and use that
> > instead from probe.c.  I also fixed the container_of stuff in pci-sysfs.c.
> 
> Here it is w/o the ia64 stuff.  That way people can buy off on the API and not 
> worry about the platform stuff.  I can send that to Tony separately if 
> there's agreement on this part.  I'd like to create a symlink 
> from /sys/class/pci_bus/<bus>/legacy_* to /sys/devices/pci<foo>/legacy_* too, 
> how do I do that?

You can make a symlink to a kobject, not a attribute.  We already have a
symlink in that directory to the device, so do you really need another
one?

>  drivers/base/class.c    |   16 ++++++++++

Hm, how about splitting this further, one for the driver core stuff (you
forgot the device.h change here too...) and the other for the PCI stuff?

thanks,

greg k-h
