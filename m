Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUCDBD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUCDBDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:03:55 -0500
Received: from dinsnail.net ([217.160.166.159]:41374 "EHLO heinz.dinsnail.net")
	by vger.kernel.org with ESMTP id S261386AbUCDBDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:03:48 -0500
Date: Wed, 3 Mar 2004 23:53:05 +0100
From: Michael Weiser <michael@weiser.dinsnail.net>
To: Greg KH <greg@kroah.com>
Cc: Ed Tomlinson <edt@aei.ca>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040303225305.GB30608@weiser.dinsnail.net>
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net> <200403030722.17632.edt@aei.ca> <20040303151433.GC25687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303151433.GC25687@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 07:14:33AM -0800, Greg KH wrote:
> > > file creation. So my idea is to initialise /dev with some static files,
> > > for hardware I know is there but hasn't had a driver loaded yet.  My
> > > question is: Is there a nicer and more elegant way than just unpacking a
> > > tarball into /dev before starting udevd? A tarball would also break a
> > > (theoretical) use of dynamic major/minor numbers by the kernel.
> > This item keeps coming up as the one feature that devfs has and udev
> > does not.  It keeps getting dismissed.  Users seem to actually want it...
> Users need to learn that the kernel is changing models from one which
> automatically loaded modules when userspace tried to access the device,
> to one where the proper modules are loaded when the hardware is found.
Is this a general roadmap decision already made by all the developers or
a proposal? If the latter I'd very much like to advocate for the old
model.

Of course I sometimes need my kernel to adapt to new hardware and with
USB and other hot-pluggable things I more often need to do it during
runtime. But traditionally I've never had much of a problem just
recompiling the kernel with support for the new hardware and just that
new hardware before changing the machine. From this point of view I'd
only need loadable modules for hot-pluggables and then only load, not
unload.

But the main feature of modules for me has always been to keep my kernel
slim at runtime but also have modules for hardware I have in my machine
but almost never use. This includes floppy and CD-ROM drives and sound
hardware as well as meta-drivers such as ram disks or different
filesystems. Changing the module logic for all of them would mean a lot
of bloat elegantly avoided so far.

If udev support for yet undriven but present hardware is so hard to
implement I can certainly live with a partly static /dev. And I
certainly don't want to stir the already rather emontional devfs
advocacy. But this change in module sematics seems a bit too fundamental
to me.

> Note that this is a much more sane model due to removable devices, and
> instances of multiple types of the same kind of devices in the same
> system.
I have to admit - I haven't become aware of the issue until recently
when trying to switch from 2.4 to 2.6 and seeing that devfs is
depreceated now. Where do the problems lie with the current model? (I
don't mean devfs vs. udev now - I read the README.)

> So no, udev is not going to handle this "issue" except in the case of
> removable devices and their partitions.  Which is already working in
> udev today.
I don't really see the difference between a device I can physically
remove and one I can remove the driver for. For example: udev works
nicely for USB devices. But to do so the UHCI driver needs to be loaded.
But if I almost never use USB, the whole USB subsystem might be
something of a removeable device to me, only plugged into the kernel
when needed. Instead of limiting the approach to physical devices, can't
we expand our thinking to removable subsystems as done with modules
nicely and elegantly up to now?
--
bye, Micha
