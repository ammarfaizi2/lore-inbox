Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWASEDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWASEDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWASEDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:03:34 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:54983
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161059AbWASEDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:03:33 -0500
Date: Wed, 18 Jan 2006 20:03:18 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bos@pathscale.com, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
Message-ID: <20060119040318.GA17121@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com> <20060119025741.GC15706@kroah.com> <20060118194911.4da86c22.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118194911.4da86c22.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 07:49:11PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> 
> Sorry for sticking my head in a beehive, but.  Stand back and look at it:
> 
> > Shouldn't you just open the proper chip device and port device itself?
> > Why not just use mmap?  What's the special needs?
> > sysfs file.
> > Use poll.
> > Use netlink for subnet stuff.
> > Use debugfs.
> > Use the pci sysfs config files, don't duplicate existing functionality.
> > netlink or debugfs.
> 
> For a driver-bodging interface design, this is simply nutty.

One can rightfully argue that they are doing some huge messy things, and
deserve the extra mess if they persist in trying to do it.

> And it makes the driver developer learn a pile of extra stuff and it
> introduces lots of linkages everywhere and heaven knows what the driver's
> userspace interface description ends up looking like.
> 
> ioctl() would have to be pretty darn bad to be worse than all this random
> stuff.

It is.  It's giving any driver writer the ability to pretty much create
as many different and new and incompatible system calls directly into
the kernel, making their driver "just a little different" from every
other type of driver.  Do you really feel confident in allowing this?

I sure do not.

But if they use the interfaces that are present in the kernel (sysfs,
debugfs, netlink, firmware interface), their driver will automatically
work with the already-written userspace tools and their driver will
usually not contain nasty bugs that show up on 64->32bit issues, and
security problems where every user can mess with things they should not
(like lots of ioctls have been known to have in the past.)

We are trying very hard here to make it easier on both the users and the
driver writers (that's why we wrote that infrastructure in the first
place.)

thanks,

greg k-h
