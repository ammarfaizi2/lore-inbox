Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271133AbTGPVmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271134AbTGPVlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:41:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:47077 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271133AbTGPVlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:41:04 -0400
Date: Wed, 16 Jul 2003 14:54:52 -0700
From: Greg KH <greg@kroah.com>
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input layer demand loading
Message-ID: <20030716215452.GB2773@kroah.com>
References: <200307131839.49112.fredrik@dolda2000.cjb.net> <200307161457.42862.fredrik@dolda2000.cjb.net> <20030716162639.GB7513@kroah.com> <200307162323.31836.fredrik@dolda2000.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307162323.31836.fredrik@dolda2000.cjb.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 11:23:31PM +0200, Fredrik Tolf wrote:
> On Wednesday 16 July 2003 18.26, Greg KH wrote:
> > On Wed, Jul 16, 2003 at 02:57:42PM +0200, Fredrik Tolf wrote:
> > > On Wednesday 16 July 2003 06.29, Greg KH wrote:
> > > > On Mon, Jul 14, 2003 at 12:58:24PM +0200, Fredrik Tolf wrote:
> > > > > If the input layer userspace interface code has been compiled as
> > > > > modules, and you have a ordinary (not hotplug) device, eg. a gameport
> > > > > joystick, can really the hotplug interface be used to load joydev.o
> > > > > when /dev/input/js0 is opened?
> > > >
> > > > No, you want to load the joydev.o driver when you plug in the gameport
> > > > joystick.  Which will be before you open the /dev node.
> > >
> > > Not necessarily. When the joystick is plugged in, you want to load the
> > > hardware driver modules. There's really no need for the userspace
> > > interface until someone requests it. At least that's the way I see it.
> > > And in any case, even if you do want to load joydev.o when the joystick
> > > is plugged in, I don't see how that could be done on-demand when the
> > > joystick port isn't hotplug compatible, such as is the case with
> > > gameports, right?
> >
> > True, but then if you try to open the port, you will only get the base
> > joydev.o module loaded, not the gameport driver, which is what you
> > _really_ want to have loaded, right?
> 
> Huh? Look at it this way: As it is now, if you have a non-hotplug joystick, 
> then you can't load anything automatically, not even the hardware drivers.

Correct.

> If you have demand-loading in the input layer, on the other hand, you can have 
> "above" directives in modules.conf (or "install" directives in modprobe.conf) 
> to pull in the hardware drivers along with joydev.

Where do you get the hardware driver coming along with joydev?

I must be missing something here...

> So not only does demand-loading permit hardware drivers and userspace
> interfaces independently of each other, it also provides for loading
> hardware drivers on demand for non-hotplug hardware.

That would be very nice, but I still don't see how your patch enables
this to happen.

thanks,

greg k-h
