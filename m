Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVINXOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVINXOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 19:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbVINXOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 19:14:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:24976 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965091AbVINXOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 19:14:43 -0400
Date: Wed, 14 Sep 2005 16:06:26 -0700
From: Greg KH <gregkh@suse.de>
To: Mike Bell <mike@mikebell.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050914230626.GA28492@suse.de>
References: <20050909214542.GA29200@kroah.com> <20050910082732.GR13742@mikebell.org> <20050910215254.GA15645@suse.de> <20050910230310.GS13742@mikebell.org> <20050911050906.GA6635@suse.de> <20050914200048.GB15017@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914200048.GB15017@mikebell.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 01:00:49PM -0700, Mike Bell wrote:
> On Sat, Sep 10, 2005 at 10:09:06PM -0700, Greg KH wrote:
> > Said people who like devfs are lazy and don't like running userspace
> > programs. 
> 
> I hardly consider myself lazy or a hater of user space programs. I've
> been an early adopter running unstable series kernels and testing out
> new features since long before devfs went into the kernel. In the past
> I've been quick to switch over to new ways of doing things as they came
> into the kernel, even when it required a fair bit of time and effort to
> migrate.
> 
> What I don't like is when someone arbitrarily declares that their
> half-finished project obsoletes a working one, and yet even a full year
> later with a massive development community using the latest kernel
> features (sometimes added specifically for that project) it isn't a full
> replacement for a project that has been - in your own words -
> unmaintained for years and years.

What part of devfs does udev not support?  From what I remember, the
first version of udev, a binary about 5k in size, pretty much
implemented all of what devfs did.

Remember that the main goal of udev is persistant names, which devfs can
not do at all.

> > They pretty much also are pretty restricted to embedded systems.
> > That's all I have been able to determine so far.  Care to help flush
> > this profile out some?
> 
> Probably because they're the people building linux systems from scratch
> and caring about the size and speed of the result?

Size is smaller with udev, you have a userspace program, no unswapable
kernel memory.  Speed is probably even faster, have you tried udev using
the netlink interface?

> > My applogies, I used the OSS compatible module for ALSA when I tested
> > this out. 
> 
> And while some input subsystem users force you to specify a device node,
> this method is incompatible with hotplugging so the more advanced ones
> rely on finding the input device nodes where they're supposed to be, as
> they should.

I don't understand the problem here.  input devices work just fine with
ndevfs, you just have to point your program to the proper node, as
ndevfs does not support subdirectories.

> > Hm, ok, ALSA will not work.  Can you point to anything else? 
> 
> See above.

You didn't point out any specific devices that ndevfs doesn't support.

> And of course ndevfs doesn't create the device nodes that udev
> doesn't support (yes, even in 2.6.12 devfs still supported more devices
> than udev on my test system).

What devices are lacking udev support?  I don't know of any in-kernel
devices, with the exception of isdn (for which the maintainer of that
subsystem is working on it, along with a major rewrite).

> Those are just the things that bit me on the one system I tried ndevfs
> on before deciding there was no way to make it work without adding
> sysfs attributes.

Again, which devices do not have sysfs support?  I'll fix that up.

> > Who cares about sound on embedded systems anyway...
> 
> People who make audio players, SIP phones, PMPs, multimedia displays,
> information kiosks, set top boxes, security monitoring devices and PA
> systems, to give just a few examples of embedded systems that need sound
> and are currently made with linux. And even though embedded linux is
> still in its infancy, I would guess that it's responsible for more linux
> systems in people's hands than most distributions.

That was a joke...

> > I'm claiming that the people who insisted that keeping the devfs
> > patchset outside of the mainline kernel was impossible.  I show how to
> > do this with 3 calls to "add a node" and three calls to "remove a node",
> > in a total of only 2 different kernel files.  Such a patch is _easily_
> > maintainable for pretty much forever outside the kernel tree.  Distros
> > maintain patches _way_ more complex and rough than that all the time.
> 
> How is that anything of the sort? ndevfs doesn't work, and isn't even
> remotely compatible with devfs. Yes, ndevfs is easy to maintain out of
> the kernel tree. But since ndevfs has absolutely nothing to do with
> devfs, that doesn't change the fact that devfs can't be maintained out
> of the kernel tree. Your reasoning makes no sense.

My reasoning was that people who insisted that maintaining something
like devfs outside of the kernel was impossible.  I showed that this is
not true with the 3-hour hack of ndevfs.  If you, or anyone else wants
to turn it into a "true" devfs replacement, feel free.  That was my
point.

> Anyway, if things continue the way they are with intentional
> devfs-breakage having moved from out-of-tree drivers to in-tree drivers,
> you'll get your wish soon enough when backhanded devfs removal makes the
> in-tree version useless.

Yeah, I have noticed this, my devfs-removal patch is getting smaller and
smaller every release.

Remember, devfs was marked OBSOLETE way over a year ago (and not by me).
And way back in July of 2004 I stated that it would be removed in July
of 2005.  That gave everyone over a year.  How much longer do you expect
me to wait?

thanks,

greg k-h
