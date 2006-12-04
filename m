Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967203AbWLDVPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967203AbWLDVPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967220AbWLDVPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:15:10 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:52107 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967203AbWLDVPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:15:07 -0500
Subject: Re: [PATCH 32/36] driver core: Introduce device_move(): move a
	device to a new parent.
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <20061204195859.GB29637@kroah.com>
References: <11650154032080-git-send-email-greg@kroah.com>
	 <11650154071138-git-send-email-greg@kroah.com>
	 <11650154123942-git-send-email-greg@kroah.com>
	 <1165015415131-git-send-email-greg@kroah.com>
	 <11650154181661-git-send-email-greg@kroah.com>
	 <11650154221716-git-send-email-greg@kroah.com>
	 <11650154251022-git-send-email-greg@kroah.com>
	 <11650154282911-git-send-email-greg@kroah.com>
	 <11650154311175-git-send-email-greg@kroah.com>
	 <1165163163.19590.62.camel@localhost>  <20061204195859.GB29637@kroah.com>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 22:15:03 +0100
Message-Id: <1165266903.12640.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > > Provide a function device_move() to move a device to a new parent device. Add
> > > auxilliary functions kobject_move() and sysfs_move_dir().
> > > kobject_move() generates a new uevent of type KOBJ_MOVE, containing the
> > > previous path (DEVPATH_OLD) in addition to the usual values. For this, a new
> > > interface kobject_uevent_env() is created that allows to add further
> > > environmental data to the uevent at the kobject layer.
> > 
> > has this one been tested? I don't get it working. I always get an EINVAL
> > when trying to move the TTY device of a Bluetooth RFCOMM link around.
> 
> I relied on Cornelia to test this.  I think some s390 patches depend on
> this change, right?

my pre-condition is that the TTY device has no parent and then we move
it to a Bluetooth ACL link as child. This however is not working or the
TTY change to use device instead of class_device has broken something.

> > And shouldn't device_move(dev, NULL) re-attach it to the virtual device
> > tree instead of failing?
> 
> Yes, that would be good to have.

Cornelia, please fix this, because otherwise we can't detach a device
from its parent. Storing the current virtual parent looks racy to me.

Regards

Marcel


