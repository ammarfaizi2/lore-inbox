Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422845AbWBNWcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422845AbWBNWcD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422846AbWBNWcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:32:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:28365 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422845AbWBNWcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:32:00 -0500
Date: Tue, 14 Feb 2006 14:24:28 -0800
From: Greg KH <greg@kroah.com>
To: Olivier Galibert <galibert@pobox.com>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060214222428.GA357@kroah.com>
References: <43D7C1DF.1070606@gmx.de> <20060213175046.GA20952@kroah.com> <20060213195322.GB89006@dspnet.fr.eu.org> <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060214104003.GA97714@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214104003.GA97714@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 11:40:04AM +0100, Olivier Galibert wrote:
> On Tue, Feb 14, 2006 at 12:23:15AM -0500, Andrew James Wade wrote:
> > On Monday 13 February 2006 14:53, Olivier Galibert wrote:
> > > Problem: finding and talking to all the devices which have capability
> > > <x>, as long as the system administrator allows.
> > ... 
> > > At that point, we get several answers:
> > ...
> > > 4- sysfs has all the information you need, just read it
> > ...
> > > Answer 4 would be very nice if it was correct.  sysfs is pretty much
> > > mandatory at that point, and modulo some fixable incompleteness
> > > provides all the capability information and model names and everything
> > > needed to find the useful devices.  What it does not provide is the
> > > mapping between a device as found in sysfs, and a device node you can
> > > open to talk to the device. You get the major/minor, which allows you 
> > > to create a temporary device node iff you're root.  Or you can scan
> > > all the nodes in /dev to find the one to open, which is kinda
> > > ridiculous and inefficient.  Or you have to go back to udev/hal to ask
> > > for the sysfs node/device node path mapping, and then why use sysfs in
> > > the first place.
> >      They're providing different things. Enumerating devices (as the kernel
> > sees them) is sysfs's business. Providing device nodes is not the kernel's
> > business, and should not be. (The kernel doesn't know the appropriate
> > permissions). And while it can be used to enumerate devices, that's not
> > really the function of /dev. It's providing the device nodes with the
> > appropriate permissions, and hopefully with names that are meaningful
> > to the users. So you really need both sysfs and /dev.
> 
> Indeed.
> 
> 
> > The difficulty is the mapping between sysfs and /dev.
> 
> Which is what I say each time.
> 
> 
> > That mapping should not live in sysfs,
> > /dev is none of the kernel's business and sysfs is the kernel's playground.
> 
> Why not have udev and whatever comes after tell the kernel so that a
> symlink is done in sysfs?  The kernel not deciding policy do not
> prevent it from storing and giving back userland-provided information.
> You get the best of both worlds, complete device information including
> how to talk with it in sysfs, and complete naming and policy setting
> in userspace.

Because if you have to have udev push the names back into the kernel,
why not just ask udev in the first place what they were?  It's just
pointless to add this to the kernel.  It doesn't belong there at all.

Anyway, udev isn't the tool to rely on for this stuff anyway, that's
what HAL is for.  If you don't like how HAL is working out, then go take
it up with those developers.  And if you have specific udev issues,
please, bring it up on the linux-hotplug-devel mailing list.

Either way, again, it's not a kernel issue.

> I guess you didn't bother to read the "answer 3" paragraph of my
> email.  Do you trust udev to still exist two years from now, given
> that hotplug died in less than that?

Huh?  Do you know when hotplug showed up?  2.3.99-something.  And it
still works just fine today if you want to use it.  It hasn't gone away
at all.  All that is changed is how the distros use that interface.  The
fact that some distros have depreciated how it is used has nothing to do
with the kernel.  Take it up with those distros, nothing the kernel
developers can do here.

> Do you trust udevinfo to have the same interface two years from now
> given that the current interface is already incompatible with a not
> even two-years old one (udev 039, 15-Oct-2004 according to kernel.org)
> which is widely deployed as part of fedora core 3?

Again, use HAL, not udev for this stuff.  FC3 is also out of date for
lots of things becides udev, so why refer to it?

> Of course I can always go the ALSA way, hardcode the device names and
> tell udev (and the user) to fuck off.

As is your right.  Have fun.

greg k-h
