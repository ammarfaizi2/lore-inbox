Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUINXg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUINXg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUINXg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:36:58 -0400
Received: from trantor.org.uk ([213.146.130.142]:47805 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S264286AbUINXft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:35:49 -0400
Subject: Re: udev is too slow creating devices
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Greg KH <greg@kroah.com>, "Marco d'Itri" <md@Linux.IT>,
       "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040914232011.GG3365@dualathlon.random>
References: <41473972.8010104@debian.org>
	 <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com>
	 <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com>
	 <20040914214552.GA13879@wonderland.linux.it>
	 <20040914215122.GA22782@kroah.com>
	 <20040914224731.GF3365@dualathlon.random>
	 <20040914230409.GA23474@kroah.com>
	 <20040914232011.GG3365@dualathlon.random>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 00:34:40 +0100
Message-Id: <1095204880.8493.153.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 01:20 +0200, Andrea Arcangeli wrote:
> On Tue, Sep 14, 2004 at 04:04:09PM -0700, Greg KH wrote:
> > On Wed, Sep 15, 2004 at 12:47:31AM +0200, Andrea Arcangeli wrote:
> > > On Tue, Sep 14, 2004 at 02:51:22PM -0700, Greg KH wrote:
> > > > True, so sit and spin and sleep until you see the device node.  That's
> > > > how a number of distros have fixed the fsck startup issue.
> > > 
> > > that's more a band-aid than a fix (I can imagine a userspace hang if the
> > > device isn't created for whatever reason), if there's no way to do
> > > better than this if you've to run fsck (or if it's not the best to run
> > > the fsck inside the dev.d scripts), then probably this needs better
> > > fixing. is such a big problem to execute a sys_wait4 to wait the udev
> > > userspace to return before returning from the insmod syscall?
> > 
> > But how do you know what to wait for?
> 
> the kernel sure can know about it, by passing a waitqueue into the
> registration routine and calling wake_up once the discovery is over.
> 
> > Sitting and waiting is a band-aid, I agree.  That's why we created the
> > /etc/dev.d/ notifier system to fix this issue (that is there for systems
> > that don't even use udev.)
> 
> if the fsck can run from there ok, if for some reason it's not feasible
> to run it from there (like if it would create a bus congestion by
> running all the fsck in parallel if you attach multiple devices at the
> same time), and/or you need some other seriaization, then probably
> having a way to run things serially without a
> spin-and-sleep-and-risk-to-hang could be needed. I guess in the worst
> case one could serialize things by using file locking in /var/run
> and by creating an API between the dev.d and the init.d scripts, is that
> how the long term is supposed to work?
> 
> So it's more a question if the current interface is complete for all
> usages, and if the fsck spin-and-sleep is just a temporary band-aid, or
> if the spin-and-sleep is supposed to last longer than a few month
> release cycle.

Surely fsck can be done on top of /etc/dev.d/ by just writing to a FIFO?
That'll serialize up the fsck caller...

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

