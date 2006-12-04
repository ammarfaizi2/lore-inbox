Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937199AbWLDXFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937199AbWLDXFW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937448AbWLDXFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:05:22 -0500
Received: from cantor.suse.de ([195.135.220.2]:40567 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937199AbWLDXFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:05:21 -0500
Date: Mon, 4 Dec 2006 15:05:11 -0800
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 32/36] driver core: Introduce device_move(): move a device to a new parent.
Message-ID: <20061204230511.GA9382@kroah.com>
References: <11650154123942-git-send-email-greg@kroah.com> <1165015415131-git-send-email-greg@kroah.com> <11650154181661-git-send-email-greg@kroah.com> <11650154221716-git-send-email-greg@kroah.com> <11650154251022-git-send-email-greg@kroah.com> <11650154282911-git-send-email-greg@kroah.com> <11650154311175-git-send-email-greg@kroah.com> <1165163163.19590.62.camel@localhost> <20061204195859.GB29637@kroah.com> <1165266903.12640.35.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165266903.12640.35.camel@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 10:15:03PM +0100, Marcel Holtmann wrote:
> Hi Greg,
> 
> > > > Provide a function device_move() to move a device to a new parent device. Add
> > > > auxilliary functions kobject_move() and sysfs_move_dir().
> > > > kobject_move() generates a new uevent of type KOBJ_MOVE, containing the
> > > > previous path (DEVPATH_OLD) in addition to the usual values. For this, a new
> > > > interface kobject_uevent_env() is created that allows to add further
> > > > environmental data to the uevent at the kobject layer.
> > > 
> > > has this one been tested? I don't get it working. I always get an EINVAL
> > > when trying to move the TTY device of a Bluetooth RFCOMM link around.
> > 
> > I relied on Cornelia to test this.  I think some s390 patches depend on
> > this change, right?
> 
> my pre-condition is that the TTY device has no parent and then we move
> it to a Bluetooth ACL link as child. This however is not working or the
> TTY change to use device instead of class_device has broken something.

Hm, I don't think the class_device stuff has broken anything, but if you
think so, please let me know.

> > > And shouldn't device_move(dev, NULL) re-attach it to the virtual device
> > > tree instead of failing?
> > 
> > Yes, that would be good to have.
> 
> Cornelia, please fix this, because otherwise we can't detach a device
> from its parent. Storing the current virtual parent looks racy to me.

You can always restore the previous "virtual" parent from the
information given to you in the device itself.  That is what the code
does when it first registers the device.

And yes, I too think it should be fixed.

thanks,

greg k-h
