Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWBOOyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWBOOyX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWBOOyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:54:23 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:21511 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932121AbWBOOyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:54:22 -0500
Date: Wed, 15 Feb 2006 15:54:21 +0100
From: Olivier Galibert <galibert@pobox.com>
To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060215145421.GA89078@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
	linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060214104003.GA97714@dspnet.fr.eu.org> <200602150842.41975.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602150842.41975.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 08:42:41AM -0500, Andrew James Wade wrote:
> On Tuesday 14 February 2006 05:40, Olivier Galibert wrote:
> > On Tue, Feb 14, 2006 at 12:23:15AM -0500, Andrew James Wade wrote:
> 
> > > The difficulty is the mapping between sysfs and /dev.
> > > That mapping should not live in sysfs,
> > > /dev is none of the kernel's business and sysfs is the kernel's playground.
> > 
> > Why not have udev and whatever comes after tell the kernel so that a
> > symlink is done in sysfs?  The kernel not deciding policy do not
> > prevent it from storing and giving back userland-provided information.
> > You get the best of both worlds, complete device information including
> > how to talk with it in sysfs, and complete naming and policy setting
> > in userspace.
> 
> Well, as Rob Landley pointed out, /dev is not necessarily the same across
> the entire system. I don't know if this is a problem (is sysfs going to be
> visible in a chrooted environment anyway?), but I take it as an indication
> that /dev shouldn't be any of the kernel's business.

That's true, but OTOH devices are definitively the kernel's business.
It's not an easy problem, and it really looks like it is not going to
be solved for a while at that point.  Hotplug has existed for a long
time, but now the users expect the applications to do the right thing
by default when there isn't an ambiguity.


> It is rather ugly to duplicate the directory tree. But it is better
> than mission-creep of sysfs. And userspace has to maintain its own view
> (or views) of devices anyway: GUIs may want to allow users to assign icons
> to devices, or descriptive strings, or who knows what else. That
> definitely shouldn't live in sysfs.

I agree with that.  But being able to find the device through sysfs
and not being able to talk to it (if allowed by the sysadmin) is
frustrating.  I suspect the situation is a side effect of the
existence, and fight with, devfs.  There has been some throwing of the
baby with the bathwater going on there.


> No I don't trust udevinfo to have a stable interface. And that would be
> a useful thing to have even if HAL is the only consumer. I suspect it would
> be nice for all udev-like solutions to share the same interface. I'm just
> hesitant to put forward my suggestion as the right interface.
> 
> I'd suggest answer 2 for the problem -- Hal knows it, ask him -- though
> that's easy enough to say when I'm not writing the hypothetical program.
> Hal can then worry about finding and integrating information about devices
> in disparate places. If Hal doesn't provide a suitable interface, that
> should be fixed.

The problem with having Hal as a the interface to device discovery is
that at that point the Hal and Dbus developpers says themselves that
they do not consider the interfaces stable yet.  Which is nice and
dandy, I don't have a problem with that, but means I won't do anything
I consider important using them yet.  In practice dbus is close,
they're finishing the bindings APIs, and they said clearly that they
will be careful with compatibility after 1.0 which should be soon, but
hal isn't yet.

  OG.

