Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbUCCPTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbUCCPTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:19:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:62363 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262480AbUCCPTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:19:42 -0500
Date: Wed, 3 Mar 2004 07:14:33 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <edt@aei.ca>
Cc: Michael Weiser <michael@weiser.dinsnail.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040303151433.GC25687@kroah.com>
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net> <200403030722.17632.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403030722.17632.edt@aei.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 07:22:17AM -0500, Ed Tomlinson wrote:
> On March 03, 2004 04:56 am, Michael Weiser wrote:
> > Normally with static /dev one has a /dev/dsp device for example. As soon
> > as an application tries to open it the kernel would try to load a module
> > "sound" or "char-major-something" if sound support isn't compiled into
> > it. Now with udev I'll never get /dev/dsp in the first place and there's
> > no mechanism like devfs's file open monitoring and subsequent device
> > file creation. So my idea is to initialise /dev with some static files,
> > for hardware I know is there but hasn't had a driver loaded yet. My
> > question is: Is there a nicer and more elegant way than just unpacking a
> > tarball into /dev before starting udevd? A tarball would also break a
> > (theoretical) use of dynamic major/minor numbers by the kernel.
> 
> Would it be possible to have something in the module itself?  i.e. We create
> a new macro to add info that a script can use.  This info could live in a new file 
> in lib/modules or in the actual module.  This could be used to create the static 
> setup dynamicly.
> 
> This item keeps coming up as the one feature that devfs has and udev 
> does not.  It keeps getting dismissed.  Users seem to actually want it...

Users need to learn that the kernel is changing models from one which
automatically loaded modules when userspace tried to access the device,
to one where the proper modules are loaded when the hardware is found.

Note that this is a much more sane model due to removable devices, and
instances of multiple types of the same kind of devices in the same
system.

So no, udev is not going to handle this "issue" except in the case of
removable devices and their partitions.  Which is already working in
udev today.

thanks,

greg k-h
