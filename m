Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVFWFBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVFWFBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 01:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVFWFBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 01:01:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:42960 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262057AbVFWFAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 01:00:12 -0400
Date: Wed, 22 Jun 2005 21:59:59 -0700
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623045959.GB10386@kroah.com>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623010031.GB17453@mikebell.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 06:00:32PM -0700, Mike Bell wrote:
> On Tue, Jun 21, 2005 at 08:10:19AM -0700, Greg KH wrote:
> > There might be some complaints.  But I doubt they would be from anyone
> > running a -mm tree as those people kind of know the current status of
> > things in the kernel.  There have been numerous warnings as to the fact
> > that this was going away, and I waited a _year_ to do this.
> 
> I use -mm and I'm complaining.
> 
> Knowing it's coming isn't the same as agreeing with it. :)

I don't mean to pick on you, but this has been known for over a year
now, right?  Hasn't anyone been preparing for any alternative situation
should this happen?  I know some distros have, but it seems the embedded
people (you aren't the first to mention the "joys" of using devfs in
embedded systems) just have been hoping this wasn't going to happen.

Very odd...

> Once devfs is out, it's out for good. It is for all intents and purposes
> impossible to maintain such a thing outside of mainline.

Not true, look at how long it was maintained out of mainline to start
with.  Using the tools we have today (like quilt and git) it should be
quite easy to keep the patch going if you really need it.

> You should know that, udev's kernel infrastructure was developed
> pretty much entirely within mainline and look how long it took to get
> even the present number of drivers working with it.

I do know that, but again, just reverse the patch and keep it going if
you really want to.  All of the hard work is already done.

> > Also, no disto uses devfs only (gentoo is close, but offers users udev
> > and a static /dev also.)
> 
> It breaks a lot of my embedded setups which have read-only storage only
> and thus need /dev on devfs or tmpfs. With early-userspace-udev-on-tmpfs
> being - in my experience - still unready.

Woah, I think Red Hat's and SuSE's "enterprise" distros would prove this
statement wrong.  Also, there have been some people making some boot
images with udev in it for embedded systems that are almost a no-brainer
for someone to use (see the linux-hotplug-devel mailing list for more
info about this.)

> Not to mention the general bother of having to change dozens of
> desktop/server systems to work with udev, but I doubt you care about
> that.

I do care about this, please don't think that.  But here's my reasoning
for why it needs to go:

	- unmaintained for a number of years
	- original developer of devfs has publicly stated udev is a
	  replacement.
	- policy in the kernel.
	- no distro uses it
	- clutter and mess
	- code is broken and unfixable
	- udev is a full, and way more complete solution (it offers up
	  so much more than just a dynamic /dev.  Way more than I ever
	  dreamed of.)
	- companies are shipping, and supporting distros that use udev.
	- It has been public knowledge that it would be removed for a
	  number of years, and the date has been specifically known for
	  the past year.

Are you really going to want to update a running system that uses devfs
to a newer kernel?  If so, your distro will have a static /dev or a udev
package to replace it.  If you aren't using your own distro, a drop-in
static /dev tree is a piece of cake for the short run, and udev is
simple to get up and running after that if you really want dynamic
stuff.

And again, for embedded systems, there are packages to build it and put
it in initramfs.  People have already done the work for you.

thanks,

greg k-h
