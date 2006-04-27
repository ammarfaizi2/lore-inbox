Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751791AbWD0WCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWD0WCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWD0WCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:02:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:54468 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751809AbWD0WCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:02:50 -0400
Date: Thu, 27 Apr 2006 15:01:22 -0700
From: Greg KH <gregkh@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       greg@kroah.com, kay.sievers@suse.de
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation (try 2)
Message-ID: <20060427220122.GA9039@suse.de>
References: <20060427211012.GA1719@kroah.com> <20060427143528.ddd304c8.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427143528.ddd304c8.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 02:35:28PM -0700, Randy.Dunlap wrote:
> On Thu, 27 Apr 2006 14:10:12 -0700 Greg KH wrote:
> 
> > In short, we really need a way to document the different interfaces that
> > the kernel has between userspace and kernelspace.  Traditionally this
> > has only been with the syscall interface, and a few odd proc files and
> > sysctls.  In recent years that interface has grown to accommodate a
> > variety of ram-based filesystems, and other fun ways to get data in and
> > out of the kernel (netlink, connector, etc.)
> > 
> > This patch proposes that _all_ kernel interfaces between userspace and
> > the kernel be documented in some manner.  Now this doesn't mean that the
> > man-pages for the different syscalls need to be included here, but we
> > really need to try to get a handle of what is changing and what will be
> > affected if we do change things.
> 
> Yes.  Thank you.
> 
> > --------------
> > 
> > --- /dev/null
> > +++ gregkh-2.6/Documentation/ABI/README
> > @@ -0,0 +1,77 @@
> > +This directory attempts to document the ABI between the Linux kernel and
> > +userspace, and the relative stability of these interfaces.  Due to the
> > +ever changing nature of Linux, and the differing maturity levels, these
>    everchanging

Fixed.

> > +interfaces should be used by userspace programs in different ways.
> > +
> > +We have four different levels of ABI stability, as shown by the four
> > +different subdirectorys in this location.  Interfaces may change levels
>              subdirectories

Fixed.

> > +of stability according to the rules described below.
> > +
> > +The different levels of stability are:
> > +
> > +  stable/
> > +	This directory documents the interfaces that have the developer
>                                                 that the developer

Fixed.

> > +	has defined to be stable.  Userspace programs are free to use
> > +	these interfaces with no restrictions, and backward
> > +	compatibility for them will be guaranteed for at least 2 years.
> > +	Most simple interfaces (like syscalls) are expected to never
> > +	change and always be available.
> 
> IMO "Most simple interfaces" isn't explicit enough.  We could argue
> all day on which interfaces are simple and which are not.

Great point, I've dropped the "simple" word now.

> > +What:		Short description of the interface
> > +Date:		Date created
> > +KernelVersion:	Kernel version this feature first showed up in.
> > +Contact:	Primary contact for this interface (may be a mailing list)
> > +Description:	Long description of the interface and how to use it.
> > +Users:		All users of this interface who wish to be notified for
> drop ending "for"

Dropped.

> > +		when it changes.  This is very important for interfaces in
> > +		the "testing" stage, so that kernel developers can work
> > +		with userspace developers to ensure that things do not
> > +		break in ways that are unacceptable.  It is also important
> > +		to get feedback for these interfaces to make sure they are
> > +		working in a proper way and do not need to be changed
> > +		further.
> > +
> > +
> > +How things move between states:
> 
> s/states/levels/

Changed.

> > +Interfaces in stable may move to obsolete, as long as the proper
> > +notification is given.
> > +
> > +Interfaces may be removed from obsolete and the kernel as long as the
> > +documented amount of time has gone by.
> > +
> > +Interfaces in the testing state can move to the stable state when the
> > +developers feel they are finished.  They can not be removed from the
> 
> "cannot"

Fixed.

> > +kernel tree without going through the obsolete state first.
> > +
> > +It's up to the developer to place their interface in the category they
> 
> s/their/an/
> better:  s/their interface/interfaces/

I like the "better" change.

> > --- /dev/null
> > +++ gregkh-2.6/Documentation/ABI/stable/syscalls
> > @@ -0,0 +1,10 @@
> > +What:		The kernel syscall interface
> > +Description:
> > +	This interface matches much of the POSIX interface and is based
> > +	on it and other Unix based interfaces.  It will only be added to
> > +	over time, and not have things removed from it.
> > +
> > +	Note that this interface is different for every architecture
> > +	that Linux supports.  Please see the arch specific documentation
> 
> "arch-specific" or "architecture-specific"

Fixed.

> > --- /dev/null
> > +++ gregkh-2.6/Documentation/ABI/stable/sysfs-module
> > @@ -0,0 +1,29 @@
> > +What:		/sys/module
> > +Description:
> > +	The /sys/module tree consists of the following structure:
> > +
> > +	/sys/module/MODULENAME
> > +		The name of the module that is in the kernel.
> > +		This module name will show up both if the module is built
> s/both/either/

Fixed.

> > +		directly into the kernel, or if it is loaded as a dyanmic
> > +		module.
> > +
> > +	/sys/module/MODULENAME/parameters
> > +		This directory contains individual files that are each
> > +		individual parameters into the module that are are able to be
> drop one "are"
> s/into/of/

Fixed.

> > +		changed at runtime.  See the individual module documentation as
> > +		to the contents of these parameters and what they accomplish.
> > +
> > +		Note: The individual parameter names and values are not
> > +		considered stable, only the fact that they will be placed into
> s/into/in/

Fixed.

> > --- /dev/null
> > +++ gregkh-2.6/Documentation/ABI/testing/sysfs-devices
> > @@ -0,0 +1,25 @@
> > +What:		/sys/devices
> > +Date:		February 2006
> > +Contact:	Greg Kroah-Hartman <gregkh@suse.de>
> > +Description:
> > +		The /sys/devices tree contains a snapshot of the
> > +		internal state of the kernel device tree.  Devices will
> > +		be added and removed dynamically as the machine runs,
> > +		and between different kernel versions, the layout of the
> > +		devices within this tree will change.
> > +
> > +		Please do not rely on the format of this tree because of
> > +		this.  If a program wishes to find different things in
> > +		the tree, please use the /sys/class structure and rely
> > +		on the symlinks there to point to the proper location
> > +		within the /sys/devices tree of the individual devices.
> > +		Or rely on the uevent messages to notify programs of
> > +		devices being added and removed from this tree to find
> > +		the location of those devices.
> > +
> > +		Note that sometimes not all devices along the directory
> > +		chain will have emitted uevent messages, so userspace
> > +		programs must be able to handle such occurances.
> "occurrences"

Fixed.

> So where is the uevent message interface documented?

It will go into Documentation/ABI/stable/uevent when this tree is set up
:)

thanks a lot for the fixes.

greg k-h
