Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVBYXCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVBYXCT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVBYXCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:02:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:54237 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262793AbVBYXCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:02:06 -0500
Date: Fri, 25 Feb 2005 14:39:27 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlink /sys/class/block to /sys/block
Message-ID: <20050225223926.GB28014@kroah.com>
References: <courier.4217CBC9.000027C1@mail.farside.org.uk> <20050222190412.GA23687@suse.de> <courier.421C5047.00003EBA@mail.farside.org.uk> <20050224233458.GB26941@suse.de> <loom.20050225T020954-395@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050225T020954-395@post.gmane.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 01:35:13AM +0000, Kay Sievers wrote:
> Greg KH <gregkh <at> suse.de> writes:
> 
> > 
> > On Wed, Feb 23, 2005 at 09:43:35AM +0000, Malcolm Rowe wrote:
> > > Greg KH writes: 
> > > 
> > > >>Following the discussion in [1], the attached patch creates 
> > > >>/sys/class/block
> > > >>as a symlink to /sys/block. The patch applies to 2.6.11-rc4-bk7.  
> > > >>
> > > >>Please cc: me on any replies - I'm not subscribed to the mailing list. 
> > > >Hm, your patch is linewrapped, and can't be applied :(
> > > 
> > > Bah, and I did send it to myself first, but I guess my mailer un-flowed it 
> > > for me .  I'll try to find a better mailer. 
> > > 
> > > >But more importantly:
> > > >>static void disk_release(struct kobject * kobj)
> > > >
> > > >Did you try to remove a disk (like a usb device) and see what happens
> > > >here?  Hint, this isn't the proper place to remove the symlink...
> > > 
> > > Er, yeah. Oops. 
> > > 
> > > *Is* there a sensible place to remove the symlink from, though?  Nobody 
> > > seems to call subsystem_unregister(&block_subsys), which is the place I'd 
> > > expect to add a call to, and I can't see anything that's otherwise 
> > > obvious... 
> > 
> > If the subsystem is never unregistered, then don't worry about undoing
> > the symlink.
> 
> This symlink will break a lot of applications out there. If there is not a
> _very_ good reason for it, we should not do that.

People seem to want it for some odd reason, I haven't seen a good reason
yet though, let alone a working patch :)

> The "dev" file unfortunately does not tell you if it's a char or block
> device node and that should be solved by something better than matching a
> magic string somewhere in the middle of a devpath.

Use the subsystem value.  If it's "block", it's a block device,
otherwise it's a char device.  Don't we already do this in udev today?

> The hotplug events will still have the /block/* devpath, so this symlink
> will give us nothing than problems.

It will not give hotplug programs issues, as the block devpath still
remains the same.

thanks,

greg k-h
