Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVBQGqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVBQGqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 01:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVBQGqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 01:46:21 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:27997 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262242AbVBQGqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 01:46:16 -0500
From: Michael Tokarev <mjt@corpit.ru>
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
To: Greg KH <gregkh@suse.de>, Roman Kagan <rkagan@mail.ru>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux Hotplug <linux-hotplug-devel@lists.sourceforge.net>
References: <20050211211028.GB21512@suse.de>
Message-Id: <20050217064615.7E32E80E1@paltus.tls.msk.ru>
Date: Thu, 17 Feb 2005 09:46:15 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Feb 11, 2005 at 11:46:27PM +0300, Roman Kagan wrote:
> > On Fri, Feb 11, 2005 at 11:36:27AM -0800, Greg KH wrote:
> > > Do one thing, and do it well.
> > > 
> > > udev is for naming devices, not loading modules.
> > 
> > Well currently udev is doing a lot more: serializing, waiting for sysfs
> > dir to appear, etc.  Not that I disagree with your first statement,
> > though.
> > 
> > > Why, each type of autoload program needs to know how to handle the
> > > different bus types.  So again, a single program doing a single thing
> > > well.
> > 
> > udev already pokes enough in sysfs and has quite a lot of
> > subsystem-specific knowledge, so adding module name generation is not
> > too much of extra functionality.
> 
> If you look at the hotplug scripts, they really don't need to touch
> sysfs at all.  (Note that the scsi one does, but I think we can fix the
> scsi hotplug event to solve this issue...)
> 
> So module autoload has really nothing to do with sysfs.

I tend to disagree, with two points.

1.  Well yes, module autoloading may be done without sysfs just fine
 (but see below).  Yet, module autoloading isn't the only "usage" of
 hotplug subsystem, right?  Ie, in 99.9% of times when a hotplug
 event is emitted, there will be other scripts executed to handle
 the event, and that scripts will depend on sysfs information.

2. And even for module autoloading, $DEVPATH/driver symlink is very-very
 handy, as it's the only (and good) way to check whenever we really want
 to mess with all the module stuff for this device at all: if the symlink
 is present, just do nothing.  Modprobe - if we're moving this functionality
 into modprobe which seems to be a good idea - while loading matching modules
 one by one, can check $DEVPATH/driver to see whenever it should stop walking
 the list.

/mjt
