Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbUJ3BiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUJ3BiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263473AbUJ2Tig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:38:36 -0400
Received: from web81307.mail.yahoo.com ([206.190.37.82]:30138 "HELO
	web81307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261446AbUJ2S5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:57:55 -0400
Message-ID: <20041029185753.53517.qmail@web81307.mail.yahoo.com>
Date: Fri, 29 Oct 2004 11:57:52 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 2/4] Driver core: add driver_probe_device
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for breaking the threading...

Greg KH wrote:
> On Fri, Oct 29, 2004 at 01:24:21PM -0500, Dmitry Torokhov wrote:
> > On Friday 29 October 2004 11:37 am, Greg KH wrote:
> > > On Tue, Oct 12, 2004 at 01:31:36AM -0500, Dmitry Torokhov wrote:
> > > > #### AUTHOR dtor_core@ameritech.net
> > > > #### COMMENT START
> > > > ### Comments for ChangeSet
> > > > Driver core: rename bus_match into driver_probe_device and export
> > > >              it so subsystems can bind an individual device to a
> > > >              specific driver without getting involved with driver
> > > >              core internals.
> > >
> > > Applied, thanks.
> > >
> >
> > Greg,
> >
> > What about "bind_mode" device and driver attributes? If you are not
> going
> > to apply them then I need to rework driver_probe_device to not call
> > bus->match() function.
> 
> Hm, I'm not going to apply them, but haven't written that email yet,
> sorry.
> 
> Is things now broken with only these 2 patches applied?
> 
> > The reason is that if bind_mode is not in the core
> > then I need to check these attributes in serio's bus match function, but
> > then I will not be able to use driver_probe_device to force binding when
> > user requests it. And if I don't check bind_mode in serio_bus_match then
> > I will have to do all driver/device mathing by hand which I wanted to
> > avoid in the first place.
> 
> Heh, I understand.  I like the ideas of your next patches, but just not
> the implementation.
> 
> I really like the "driver" part in the device.  But not as a file, let's
> make it a symlink back to the driver that is bound to the device at that
> point in time.  This makes it just like the other symlinks in the sysfs
> tree.
> 
> But if we do that, we still don't have a way to implement what you are
> really trying to do (and it breaks your code as you already have a
> driver file.)  I'll work on what I propose instead in my next message
> (will be a few hours, have real work to do for a bit, sorry...)
>

Well, we can have driver as a symlink and rename my "driver" attribute
into something like "drvctl" (just an example, maybe somebody has better
name in mind, I am not fixed on the name) and make it writable only.
I think it should work well as now device and driver objects are very
symmetrical - they both similarly linked together via device->driver
and driver->device).

Also, driver problem is tangent to the bind_mode as you can play with
bind_mode even without driver attribute (f.e. you have 2 cards and 2
modules, mark one card as manual bind, load first module, change bind
mode to automatic, load another module).

Just wanted to make these two points, now I'll wait for your poroposal
later tonight.

Thanks!

-- 
Dmitry

