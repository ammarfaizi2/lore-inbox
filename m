Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269011AbUHMHHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269011AbUHMHHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 03:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269012AbUHMHHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 03:07:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:17598 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269011AbUHMHHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 03:07:01 -0400
Date: Fri, 13 Aug 2004 00:06:43 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Glow <sglow@embeddedintelligence.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to generate hotplug events in drivers?
Message-ID: <20040813070643.GA6785@kroah.com>
References: <411C1EC0.3010302@embeddedintelligence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411C1EC0.3010302@embeddedintelligence.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 09:52:00PM -0400, Stephen Glow wrote:
> 
> I'm in the process of porting a device driver from the 2.4 kernel to the
> 2.6 kernel.  In the older version of the drivers I was using the devfs
> system to create the device files.  I've decided to rip this out and
> move everything to udev since this seems to be the preferred method now.
> 
> The problem I'm having with this port is that I can't get the udev
> system to create a device file when I install the module.  As far as I
> can tell, no hotplug events are being generated when I insmod the device
> driver.  In other respects the driver seems to be loading correctly;
> I'm able to request the PCI regions, enable, and start the PCI device,
> and allocate a dynamic device major number.  I can also see an entry
> create in the /sys/bus/pci/drivers directory.

udev needs to see a file called "dev" in the proper structure show up in
the sysfs tree in either /sys/class/* or /sys/block/*.  So, you need to
either use the misc char device interface, the block interface, some
other char interface that already has sysfs support, or add your own.
If you need to add your own, I suggest looking into the class_simple
interface, as that's a lot easier to work with to start out with.

Hope this helps,

greg k-h
