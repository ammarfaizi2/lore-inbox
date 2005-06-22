Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbVFVIWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVFVIWC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVFVISv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:18:51 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:24900 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262816AbVFVIO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:14:29 -0400
Date: Wed, 22 Jun 2005 01:14:12 -0700
From: Greg KH <gregkh@suse.de>
To: Cornelia Huck <COHUCK@de.ibm.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, mochel@digitalimplant.org
Subject: Re: [patch 1/16] s390: klist bus_find_device & driver_find_device callback.
Message-ID: <20050622081411.GA30791@suse.de>
References: <20050622062627.GA29759@kroah.com> <OF6148E781.C94AF99A-ON42257028.002925D7-42257028.002AF389@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6148E781.C94AF99A-ON42257028.002925D7-42257028.002AF389@de.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 09:48:02AM +0200, Cornelia Huck wrote:
> Greg KH <greg@kroah.com> wrote on 22.06.2005 08:26:27:
> 
> > What's wrong with just using bus_for_each_dev() instead?  You have to
> > supply a "match" type function anyway, so the caller doesn't have an
> > easier time using this function instead.
> 
> Maybe it's just too early in the morning, but I don't see how I could
> achive what I want to do with bus_for_each_dev(). The idea behind
> bus_find_device() is to scan the bus for a device matching some
> criterium and to return a pointer to it with which the caller can
> continue to work. bus_for_each_dev() calls the match function for
> every device until we abort, but I don't see how I can grab a reference
> to a specific device for later use.

Ah, now I get it.  "later use" is the key point here.  I was thinking
you could do whatever you want within the callback.  But if you want to
do something later on with this pointer, that would be very tough.

Hm, I could use this kind of function, as I had to jump through a few
hoops when iterating over all devices on a bus, when I just wanted to
find a specific device (it involved creating a temp structure on the
stack and doing my logic in the callback function itself, for details
see
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/driver-bind.patch
for a patch that adds manual binding of drivers to devices from
userspace through sysfs.  With this function it should get even smaller.)

> > You also don't increment the reference properly when you return the
> > pointer, so you better document that... :(
> 
> You're right, this should be done in the base code and not by the
> caller...

Care to fix this up and resend it?

Sorry for the misunderstanding.

thanks,

greg k-h
