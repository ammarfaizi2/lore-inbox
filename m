Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUJHVsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUJHVsr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUJHVsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:48:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:36815 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265477AbUJHVso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:48:44 -0400
Date: Fri, 8 Oct 2004 14:48:20 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: Driver core change request
Message-ID: <20041008214820.GA1096@kroah.com>
References: <200410062354.18885.dtor_core@ameritech.net> <20041007214004.GA23570@kroah.com> <200410072159.11578.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410072159.11578.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 09:59:10PM -0500, Dmitry Torokhov wrote:
> On Thursday 07 October 2004 04:40 pm, Greg KH wrote:
> > On Wed, Oct 06, 2004 at 11:54:18PM -0500, Dmitry Torokhov wrote:
> > > Hi,
> > > 
> > > I am reworking my sysfs serio patches (trying to get dynamic psmouse
> > > protocol switching) and I am wondering if we could export device_attach
> > > function. Serio system allows user to request device rescan - force current
> > > driver to let go off the device and find another suitable driver. Also user
> > > can manually request device to be disconnected/connected to a driver. By
> > > having device_attach exported I could get rid of some duplicated code.
> > 
> > driver_attach() is global, so I don't have a problem with making
> > device_attach() global either.  Just send me a patch :)
> > 
> 
> OK. BTW, while driver_attach is global it is not exported. Should I mark both
> of them EXPORT_GPL_ONLY? 

No, pci can not be a module.  Can your serio core be a module?  If not,
just make it global.  But if so, yes, EXPORT_SYMBOL_GPL() is the proper
marking.

> > > I.e driver_probe_device is exported. Does it have a chance to be accepted?
> > 
> > What's wrong with doing what the pci core does in this situation and
> > call driver_attach()?
> > 
> 
> Well, I need to be able to work with a specific port so when I am doing
> 
> 	echo -n "serio_raw" > /sys/bus/serio/devices/serio1/driver
> 
> I want only serio1 be affected, not every disconnected port that can work
> with serio_raw. driver_attach() will claim all of them. 
> 
> The difference is that serio system allows you to have several drivers
> that can drive the same hardware and user gets to chose which driver gets
> the honors. I.e given 4 PS/2 ports in the system user might want to have
> raw access to port #2 (via serio_raw) while using standard psmouse driver
> for the rest of them. With PCI if you have 2 drivers and 2 exactly same
> cards you do not have ability to bind first driver to one of the cards and
> second driver to the other.

Nice.  We want to make this kind of functionality avaiable to all
busses, and not have it be a bus only type feature.  So if you can see
any way it could be moved into the core, I'd be all for it.

thanks,

greg k-h
