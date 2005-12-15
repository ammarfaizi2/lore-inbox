Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVLOQy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVLOQy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVLOQy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:54:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:60550 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750794AbVLOQy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:54:26 -0500
Date: Thu, 15 Dec 2005 08:53:57 -0800
From: Greg KH <greg@kroah.com>
To: Jeremy Katz <katzj@redhat.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: "block" symlink in sysfs for a multifunction device
Message-ID: <20051215165357.GA15016@kroah.com>
References: <20051212134904.225dcc5d.zaitcev@redhat.com> <20051214055019.GA23036@kroah.com> <20051214152615.13b6b105.zaitcev@redhat.com> <20051214234255.GA3275@kroah.com> <1134622055.2864.21.camel@bree.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134622055.2864.21.camel@bree.local.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 11:47:35PM -0500, Jeremy Katz wrote:
> On Wed, 2005-12-14 at 15:42 -0800, Greg KH wrote:
> > On Wed, Dec 14, 2005 at 03:26:15PM -0800, Pete Zaitcev wrote:
> > > On Tue, 13 Dec 2005 21:50:19 -0800, Greg KH <greg@kroah.com> wrote:
> > > > $ ls -l /sys/block/uba/device/
> > > > -r--r--r--  1 root root 4096 Dec 13 21:31 bNumEndpoints
> > > > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:uba -> ../../../../../../block/uba
> > > > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubb -> ../../../../../../block/ubb
> > > > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubc -> ../../../../../../block/ubc
> > > > lrwxrwxrwx  1 root root    0 Dec 13 21:31 block:ubd -> ../../../../../../block/ubd
> > > 
> > > Greg, Jeremy is not happy about this.
> > > 
> > > > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175563
> > > > ------- Additional Comments From katzj@redhat.com  2005-12-14 18:05 EST -------
> > > > Actually, this is problematic.  It makes it so that the single device directory
> > > > corresponds to more than one device which we can't handle with kudzu :-(
> > 
> > Well, how do you handle it for class devices then?
> 
> We don't have any where we need to handle it at present.  
> 
> > And if this isn't acceptable, what would be?
> 
> By going this route, it really feels like you're hacking around your own
> rule of a single value per file :-)  Except that instead of having a
> file that I read five values from, it's five files with naming
> heuristics to get five values.  Which is, in a lot of ways, worse.

What?  These are symlinks, not files.  Why would you want to read the
name of the block device from a file and then go have to look that
location up, instead of just following the symlink?

> I'd much rather see the fact that there are multiple devices be handled
> by having each device with its own unique directory.  This then keeps
> all of the abstractions which currently exist.

Those devices do have their own unique directory.  Look at the pointer
above :)

The point here is that multiple class devices and block devices can bind
to a single "real device" in the system, and we need to handle that
representation properly.  We have had the symlink for a while now, and I
just forgot to put the proper name on the block device one, to match up
with the class device naming.

thanks,

greg k-h
