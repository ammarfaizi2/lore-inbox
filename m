Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267224AbUBMVWD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267225AbUBMVWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:22:03 -0500
Received: from mail.kroah.org ([65.200.24.183]:33979 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267224AbUBMVVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:21:55 -0500
Date: Fri, 13 Feb 2004 13:19:20 -0800
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040213211920.GH14048@kroah.com>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca> <20040210181242.GH28111@kroah.com> <20040210182943.GO4421@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210182943.GO4421@tinyvaio.nome.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 10:29:44AM -0800, Mike Bell wrote:
> On Tue, Feb 10, 2004 at 10:12:42AM -0800, Greg KH wrote:
> > No, that is not true.  devfs exports the device node itself.  It does
> > not just export the major:minor number.
> 
> That's a pretty minor difference, from the kernel's point of view. It's
> basically putting the same numbers in different fields.

Heh, that's a HUGE difference!

I think you are missing a few things here:
  - sysfs is not only for exporting device major:minor info.  It's for a
    1001 other very useful things.  You can't config out sysfs, you get
    it for "free" with 2.6.  So it isn't a "choose sysfs vs. devfs"
    argument at all.  It's a "do I want to enable devfs or not" issue.
  
 - sysfs exports loads of info about every device in your system, not
   only the major:minor info.  It exports what device this major:minor
   is assigned to, the topology of the device, the fact that it has
   vendor id FOO and product id BAR, and serial number "123".  devfs has
   none of this.

 - you get /sbin/hotplug calls for "free" too.  Yes, you can config this
   out, but the added benefits of hotplug calls far outweigh any memory
   savings you get for not enabling this option (embedded systems not
   included.)

So, if you put hotplug and sysfs together, udev can control your /dev.
And it can provide persistent device naming, which on its own, devfs can
not.

Again, the fact that udev can do everything devfs can (manage a /dev),
in userspace, and in less memory, is a big win in my eyes.

Oh, and recall that I implemented a "dynamic /dev" with LSB names almost
a year ago, in 6Kb of userspace code.  The amount of memory that this
takes for devfs to do I don't really want to imagine...

> > devfs also does not export the position within the entire device tree,
> > which sysfs does.  
> 
> devfs tried to do just that. sysfs does it better though. I don't see
> what that has to do with my point.

persistent device names...  That's the main point of udev.

> > They are two completely different filesystems, doing two completely
> > different things.  Please do not confuse them.
> 
> sysfs and devfs are very different. I said they both accomplish one
> common goal, sysfs for udev and devfs for devfsd.

Not at all.  sysfs has 1001 goals at the least.  So many different
people are using it for different things that it's really amazing to me.
It also shows how powerful and how correct the model of it is.

And as stated above, you always get sysfs in your kernel (unless you are
running the -tiny tree...)

I'm not going to try to answer all of your other questions specifically,
as I think I have covered them all now.  If you feel that you still have
some questions remaining about this, or that I have not explained
anything good enough, please let me know.

thanks,

greg k-h
