Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWGHNAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWGHNAe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWGHNAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:00:34 -0400
Received: from soundwarez.org ([217.160.171.123]:6811 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S964807AbWGHNAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:00:33 -0400
Subject: Re: Implement class_device_update_dev() function
From: Kay Sievers <kay.sievers@vrfy.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1152350840.29506.2.camel@localhost>
References: <1152226792.29643.8.camel@localhost>
	 <20060706235745.GA13548@kroah.com>  <1152258152.3693.8.camel@localhost>
	 <1152318397.3266.130.camel@pim.off.vrfy.org>
	 <1152350840.29506.2.camel@localhost>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 15:00:34 +0200
Message-Id: <1152363634.3408.3.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 11:27 +0200, Marcel Holtmann wrote:
> > > > But userspace should also find out about this change, and this patch
> > > > prevents that from happening.  What about just tearing down the class
> > > > device and creating a new one?  That way userspace knows about the new
> > > > linkage properly, and any device naming and permission issues can be
> > > > handled anew?
> > > 
> > > This won't work for Bluetooth. We create the TTY and its class device
> > > with tty_register_device() and then the device node is present. Then at
> > > some point later we open that device and the Bluetooth connection gets
> > > established. Only when the connection has been established we know the
> > > device that represents it. So tearing down the class device and creating
> > > a new one will screw up the application that is using this device node.
> > > 
> > > Would reissuing the uevent of the class device help here?
> > 
> > How about KOBJ_ONLINE/OFFLINE?
> 
> I am not that familiar with the internals of kobject. Can you give me an
> example on how to do that?

Just send another event (but not add or remove), for the already created
object. CPU hotplug uses ONLINE/OFFLINE, and we also use it to get
notified when the device mapper table is set up (not upstream). Udev is
able to update symlinks, or run actions on "online" events if asked
for. 

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;h=52674323b14da5724bfdc4ffee830609f116d248;hb=HEAD;f=drivers/acpi/processor_core.c#l714


Kay

