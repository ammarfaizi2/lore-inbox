Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbUKPU0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUKPU0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbUKPUZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:25:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:21906 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261809AbUKPUYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:24:03 -0500
Date: Tue, 16 Nov 2004 12:22:37 -0800
From: Greg KH <greg@kroah.com>
To: ambx1@neo.rr.com, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org, Tejun Heo <tj@home-tj.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Message-ID: <20041116202236.GB11069@kroah.com>
References: <20041109223729.GB7416@kroah.com> <200411092249.44561.dtor_core@ameritech.net> <20041116061315.GG29574@neo.rr.com> <200411160137.57402.dtor_core@ameritech.net> <20041116070413.GJ29574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116070413.GJ29574@neo.rr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 02:04:13AM -0500, Adam Belay wrote:
> 
> These additional features bring up another issue that we may want the driver
> model to handle.  Basically, I think we should allow devices to be started and
> stopped.

You mean like the power management people want?  :)

> 	int	(*start)	(struct device * dev); <-----
> 	int	(*stop)		(struct device * dev); <-----

Ick, no.  Use the power interface for this.  If you aren't already on
the new linux-pm mailing list (hosted by osdl.org) you might want to be,
as people are discussing this there.

> "*probe"
> - determine if this driver is able to handle this device
> - if so create data structures that can store information about the device
> - bind the device to the driver and display additional config attributes.
> 
> At this point userspace can set up the configuration of this specific binding
> instance.  The configuration options would primarily be things that cannot be
> modified while the device is in use.  It can be loaded from a cache so that it
> is consistent between reboots, hotplugs etc.  This would sort of replace
> module parameters.

But now that module paramaters are able to be passed as command line
arguments, doesn't that solve the issue?  :)

Anyway, I think people are working on making those kind of values
persistant in a way, see the patches on lkml for something like this
(from what I can tell, I haven't really been paying attention though...)

> Now that the user has specific his or her config preferences we can go to
> "*start"
> 
> "*start"
> - parse resource information
> - fill in device/driver data structures with information
> - prepare the device to actually be used
> 
> From this point the device would be completely usable.
> 
> Then at a later time, when the device...
> - is no longer needed
> - resources need to be rebalanced
> - the user wants to remove the device in the near future
> 
> "*stop"
> - safely stop the upper class layer
> - free resources, and reset device specific data
> 
> And we're ready for the next step. (which may even include another *start)
> 
> This would easily allow for things like "reconnect", which would simply be a
> "*stop" follow by a "*start".
> 
> Comments?

You are forcing the user to do too much work in order for their devices
to start working :)

I understand the issue you are trying to solve, but what about something
like the "persistant device tree" issue that we've all been talking
about over the past few years?  That would let systems where we can not
probe for devices to be created all at once (like on most embedded
systems) and I think would solve your resource issues too, right?

thanks,

greg k-h
