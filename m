Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUINXIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUINXIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267921AbUINXH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:07:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:56773 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266705AbUINXE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:04:59 -0400
Date: Tue, 14 Sep 2004 16:04:09 -0700
From: Greg KH <greg@kroah.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: "Marco d'Itri" <md@Linux.IT>, "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040914230409.GA23474@kroah.com>
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914224731.GF3365@dualathlon.random>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 12:47:31AM +0200, Andrea Arcangeli wrote:
> On Tue, Sep 14, 2004 at 02:51:22PM -0700, Greg KH wrote:
> > True, so sit and spin and sleep until you see the device node.  That's
> > how a number of distros have fixed the fsck startup issue.
> 
> that's more a band-aid than a fix (I can imagine a userspace hang if the
> device isn't created for whatever reason), if there's no way to do
> better than this if you've to run fsck (or if it's not the best to run
> the fsck inside the dev.d scripts), then probably this needs better
> fixing. is such a big problem to execute a sys_wait4 to wait the udev
> userspace to return before returning from the insmod syscall?

But how do you know what to wait for?

If you modprobe a usb-storage driver, and the usb bus is not done
discovering devices, the insmod will instantly return, and only some
time later will the device node be created after the device is
discovered by the bus and then passed to the module you already loaded.

Sitting and waiting is a band-aid, I agree.  That's why we created the
/etc/dev.d/ notifier system to fix this issue (that is there for systems
that don't even use udev.)

thanks,

greg k-h
