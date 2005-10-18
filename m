Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVJRFq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVJRFq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 01:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVJRFq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 01:46:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:43907 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932322AbVJRFqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 01:46:25 -0400
Date: Mon, 17 Oct 2005 22:26:17 -0700
From: Greg KH <gregkh@suse.de>
To: Adam Belay <ambx1@neo.rr.com>, Kay Sievers <kay.sievers@vrfy.org>,
       dtor_core@ameritech.net, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051018052617.GA10263@suse.de>
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com> <20051015150855.GA7625@vrfy.org> <20051017214430.GA5193@suse.de> <20051017232430.GA32655@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017232430.GA32655@neo.rr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 07:24:30PM -0400, Adam Belay wrote:
> 
> Sounds good to me.  The changes to driver model internals may be substantial.
> For example, because buses and classes will share more code, it's
> reasonable to allow drivers to bind to any "device" object, even class
> devices.  Of course this would be limited to classes that choose to
> implement driver matching etc.  We are doing this now with the pci express
> port driver.

That's a bus, not a class device.  Drivers bind to devices through a
bus.  That's why we have busses.

> It also may make sense to move bus_types to the "class" interface.  The
> layered classes suggestion is especially useful here because we can have a
> "hardware" or "bus" class that acts as a parent for "pci", "usb", etc.

Hm, I don't really know...

> Also, we could make driver objects a "class" and represent them in the
> global device tree, giving each driver instance its own unique namespace.

Huh?  How would you do that?  Also, we really don't have different
driver "instances", so trying to represent something like that in sysfs
would probably be more work than it's worth.

> > Oh, one tiny problem.  "virtual devices" are not currently represented
> > in our device tree, but are in the class tree.  Things like the
> > different vc and ttys and misc devices are examples of this.  I'll just
> > put them on the "platform" bus if no one minds.
> 
> I think we should be trying to kill off the platform bus (it's artifical and
> doesn't show the real relationships between these devices).  Instead, just
> hang them off the root of the tree.

Everything that's currently a platform device go to the root?  No,
that's not going to happen, sorry.

> If the device doesn't have any parents or dependencies, then that's
> logically where it belongs.

We do have a real platform "bus" that devices hang off of.  Where else
is that keyboard controller at :)

thanks,

greg k-h
