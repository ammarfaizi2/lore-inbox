Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbUJ2St6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUJ2St6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUJ2St5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:49:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:2444 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263495AbUJ2Sej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:34:39 -0400
Date: Fri, 29 Oct 2004 13:32:15 -0500
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 2/4] Driver core: add driver_probe_device
Message-ID: <20041029183215.GA27546@kroah.com>
References: <200410062354.18885.dtor_core@ameritech.net> <200410120131.38330.dtor_core@ameritech.net> <20041029163714.GB27902@kroah.com> <200410291324.22084.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291324.22084.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:24:21PM -0500, Dmitry Torokhov wrote:
> On Friday 29 October 2004 11:37 am, Greg KH wrote:
> > On Tue, Oct 12, 2004 at 01:31:36AM -0500, Dmitry Torokhov wrote:
> > > #### AUTHOR dtor_core@ameritech.net
> > > #### COMMENT START
> > > ### Comments for ChangeSet
> > > Driver core: rename bus_match into driver_probe_device and export
> > >              it so subsystems can bind an individual device to a
> > >              specific driver without getting involved with driver
> > >              core internals.
> > 
> > Applied, thanks.
> > 
> 
> Greg,
> 
> What about "bind_mode" device and driver attributes? If you are not going
> to apply them then I need to rework driver_probe_device to not call 
> bus->match() function.

Hm, I'm not going to apply them, but haven't written that email yet,
sorry.

Is things now broken with only these 2 patches applied?

> The reason is that if bind_mode is not in the core
> then I need to check these attributes in serio's bus match function, but
> then I will not be able to use driver_probe_device to force binding when
> user requests it. And if I don't check bind_mode in serio_bus_match then
> I will have to do all driver/device mathing by hand which I wanted to
> avoid in the first place.

Heh, I understand.  I like the ideas of your next patches, but just not
the implementation.

I really like the "driver" part in the device.  But not as a file, let's
make it a symlink back to the driver that is bound to the device at that
point in time.  This makes it just like the other symlinks in the sysfs
tree.

But if we do that, we still don't have a way to implement what you are
really trying to do (and it breaks your code as you already have a
driver file.)  I'll work on what I propose instead in my next message
(will be a few hours, have real work to do for a bit, sorry...)

thanks,

greg k-h
