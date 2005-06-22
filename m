Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVFVQWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVFVQWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVFVQWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:22:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:48067 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261612AbVFVQRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:17:51 -0400
Date: Wed, 22 Jun 2005 09:17:36 -0700
From: Greg KH <greg@kroah.com>
To: Stelian Pop <stelian@popies.net>, hare@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] usb sysfs intf files no longer created when probe fails
Message-ID: <20050622161735.GA2274@kroah.com>
References: <1119448257.4587.2.camel@localhost.localdomain> <1119449231.4594.14.camel@localhost.localdomain> <1119452190.4794.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119452190.4794.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 04:56:30PM +0200, Stelian Pop wrote:
> Le mercredi 22 juin 2005 ?? 16:07 +0200, Stelian Pop a ??crit :
> > Le mercredi 22 juin 2005 ?? 15:50 +0200, Stelian Pop a ??crit :
> > 
> > > I use the 'atp' input driver from http://popies.net/atp/ to drive this
> > > touchpad. When removing the driver I also get an oops, possibly related
> > > to the previous failure to create the sysfs file:
> 
> Ok, there are two separate problems here:
> 
> 1. The sysfs intf entry is not created, and this causes the oops later
> when trying to remove the entry, etc.
> 
>    I've tracked this problem back to this patch: 
> 	[PATCH] driver core: fix error handling in bus_add_device
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ca2b94ba12f3c36fd3d6ed9d38b3798d4dad0d8b
> 
>    Once the patch above is reverted, I have no more oops, my driver can
> be loaded/unloaded just fine, and the /sys/devices/.../ is present.

Thanks for tracking this down.

Hm, we must be actually checking the return value somewhere, and dying
because of it.  Let me dig deeper and find out.

Oh, can you enable debugging for the driver core (it's a config option)
and the USB core and without that patch reverted, let me know what the
syslog shows when the probe fails?

>    However, I'm not really sure if the problem comes from the above
> patch or from my driver which should manually call
> usb_create_sysfs_intf_files() or something equivalent.

No, you should not have to call that from your driver.  In looking at
your code, I don't see anything obviously wrong.  It works just fine
with 2.6.12, right?

> 2. There is still a problem with the early loading of the driver. If
> loaded at boot, it won't work. If I rmmod/insmod it later it does.

Does that also work with 2.6.12?

thanks,

greg k-h
