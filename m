Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUIOQSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUIOQSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUIOQRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:17:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:4772 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266775AbUIOQQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:16:56 -0400
Date: Wed, 15 Sep 2004 09:15:41 -0700
From: Greg KH <greg@kroah.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: "Marco d'Itri" <md@Linux.IT>, "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040915161541.GD21971@kroah.com>
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <20040914232011.GG3365@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914232011.GG3365@dualathlon.random>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 01:20:11AM +0200, Andrea Arcangeli wrote:
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

But the low level driver (like a USB driver for example), has no way of
knowing when the "device discovery" process is over.  Actually the USB
core never knows this either, as devices come and go all the time.

That's why we had to move to the "probe" and "release" way of writing
drivers.  The bus cores notify the driver when they find something, as
the driver never knows when a device is found.

So the kernel can not know what or when to wait for something it doesn't
know is going to ever happen in the future.

Does that make more sense now?

Remember, this isn't your old "static device tree" unix-like kernel that
people grew up with, anymore. :)

thanks,

greg k-h
