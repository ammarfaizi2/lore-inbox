Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTJGVtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 17:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTJGVtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 17:49:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:34501 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262906AbTJGVtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 17:49:00 -0400
Date: Tue, 7 Oct 2003 14:48:48 -0700
From: Greg KH <greg@kroah.com>
To: Chris Meadors <clubneon@hereintown.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs and udev
Message-ID: <20031007214848.GC3095@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <200310072128.09666.insecure@mail.od.ua> <20031007194124.GA2670@kroah.com> <200310072347.41749.insecure@mail.od.ua> <20031007205244.GA2978@kroah.com> <1065561443.840.76.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065561443.840.76.camel@clubneon.priv.hereintown.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 05:17:23PM -0400, Chris Meadors wrote:
> On Tue, 2003-10-07 at 16:52, Greg KH wrote:
> > On Tue, Oct 07, 2003 at 11:47:41PM +0300, insecure wrote:
> > > It seems that we have a bit of misunderstanding here.
> > > 
> > > I just don't want to go back to /dev being actually placed on
> > > real, on-disk fs.
> > > 
> > > I won't mind if naming scheme will change as long
> > > as device names start with '/dev/' and appear
> > > there (semi-)automagically. That's what I call devfs.
> > > If udev can do this, I am all for that.
> > 
> > udev can do this.  Is there some documentation that you read that has
> > suggested otherwise?
> 
> Lets see if I can make this clear, devfs is a virtual file system.

I know that, please give me some credit here.  I've used devfs before,
and rutted around in all of it's dirt for a long time.  It's not like
I'm suddenly creating some wild, hair brained scheme out of thin air
here.  I've been working toward this solution for a number of years now
(see the proposal from Pat Mochel and myself at the kernel summit two
years ago, and my 5 minute talk this year), and it hasn't exactly been
in private.  There have been a number of discussions in public places
(two different kernel summits, OLS papers, and lots of linux-kernel and
linux-hotplug-devel mail traffic), so this shouldn't be that much of a
shock to the devfs lovers out there.

And remember, _I_ did not submit that patch to the kernel marking devfs
obsolete.  Other kernel developers did.  And for good reasons, which
have all been explained before.  Even if udev wasn't even written yet,
it would have been done.

> If I mount my root drive without mounting devfs, the /dev directory is
> empty.  udev is not like this, it is like the normal /dev that can be
> built with mknod, special files in a real filesystem.  But udev is told
> by the kernel what files to make and remove.  So it is still a dynamic
> filesystem, just in userland with kernel notifications rather than a
> filesystem that is entirely in kernel space.

Again:
	mount -t ramfs none /dev

There, empty filesystem.  No persistance.  Happy?

> devfsd could use a "/dev-state" (or similar) directory to preserve the
> state of any changes made to the virtual filesystem using normal
> userland tools are mirrored in that directory.

See the OLS paper for how this will be handled.

> I am also a huge devfs fan.  I was building 2.2.x kernels with Richard's
> patches before 2.4.0 was released.  I like just having an empty /dev and
> knowing the kernel will take care of everything I need at boot.

Great.  I hope you have enjoyed your security problems, and race
conditions too.  :)

> I'm thinking this will not exactly work with udev, as you will need a
> few seed nodes to get to userland so udev can be started.  Then udev
> will create the entries for devices that actually exist on the machine,
> and then these entries will still be present at the next boot.  So it
> will just be a problem for initial installs.
> 
> Right?

Look at the boot process today.  We "seed" a ramfs with some initial
/dev entries in order to boot the kernel from initramfs.  udev will take
off from there and keep creating new entries as devices are discovered,
long before init and the rest of userspace starts up.

> I can handle all of this.  I'm flexible.  Just make it work.  :)

Patches are always gladly accepted.


People, come on, please read the existing documentation before coming up
with some half-baked ideas about what udev is.  Yes, there is a gap with
the existing documentation, and some people have very nicely pointed
this out.  But if I have to spend my time answering questions that are
already answered, I'll never have the time to flush out these gaps, and
actually do some udev programming...

greg k-h
