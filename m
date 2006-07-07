Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWGGAGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWGGAGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWGGAGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:06:21 -0400
Received: from ns1.suse.de ([195.135.220.2]:2500 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750889AbWGGAGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:06:20 -0400
Date: Thu, 6 Jul 2006 17:02:33 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] change netdevice to use struct device instead of struct class_device
Message-ID: <20060707000233.GA13921@kroah.com>
References: <20060703224719.GA14176@kroah.com> <1152109763.4260.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152109763.4260.19.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 04:29:23PM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > The patch needs some other changes to the driver core that are also in
> > my git tree, and included in the -mm release.  Specifically these
> > patches are needed:
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/device-groups.patch
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/device-class-parent.patch
> 
> while converting the Bluetooth subsystem from class devices to real
> devices, I had some similar situation with devices without parent. I
> actually used a Bluetooth platform device as parent for virtual or
> serial based devices.

The problem with that is you get a bunch of symlinks to that parent
device that you really don't want to have, when we have a device that is
associated with a class.

I was thinking of creating a /sys/devices/virtual/ to put these
unassociated devices into, and I'll play around with that a bit.  I
don't know if we will hit some namespace issues with all of the
different devices that aren't associated with a "real" device if we lump
them all together into one directory...

thanks,

greg k-h
