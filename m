Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270939AbTGPQSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270940AbTGPQSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:18:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:54964 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270939AbTGPQSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:18:52 -0400
Date: Wed, 16 Jul 2003 09:26:39 -0700
From: Greg KH <greg@kroah.com>
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input layer demand loading
Message-ID: <20030716162639.GB7513@kroah.com>
References: <200307131839.49112.fredrik@dolda2000.cjb.net> <200307141258.24458.fredrik@dolda2000.cjb.net> <20030716042916.GC3929@kroah.com> <200307161457.42862.fredrik@dolda2000.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307161457.42862.fredrik@dolda2000.cjb.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:57:42PM +0200, Fredrik Tolf wrote:
> On Wednesday 16 July 2003 06.29, Greg KH wrote:
> > On Mon, Jul 14, 2003 at 12:58:24PM +0200, Fredrik Tolf wrote:
> > > On Monday 14 July 2003 08.22, Greg KH wrote:
> > > > On Sun, Jul 13, 2003 at 06:39:49PM +0200, Fredrik Tolf wrote:
> > > > > Why does the input layer still not have on-demand module loading? How
> > > > > about applying this?
> > > >
> > > > What's wrong with the current hotplug interface for the input layer? 
> > > > If you want to implement this, add some input hotplug scripts to the
> > > > linux-hotplug package.
> > >
> > > Correct me if I'm wrong, but AFAIK that can only be smoothly used to load
> > > hardware driver modules.
> >
> > In a way, yes.
> >
> > > If the input layer userspace interface code has been compiled as modules,
> > > and you have a ordinary (not hotplug) device, eg. a gameport joystick,
> > > can really the hotplug interface be used to load joydev.o when
> > > /dev/input/js0 is opened?
> >
> > No, you want to load the joydev.o driver when you plug in the gameport
> > joystick.  Which will be before you open the /dev node.
> 
> Not necessarily. When the joystick is plugged in, you want to load the 
> hardware driver modules. There's really no need for the userspace interface 
> until someone requests it. At least that's the way I see it.
> And in any case, even if you do want to load joydev.o when the joystick is 
> plugged in, I don't see how that could be done on-demand when the joystick 
> port isn't hotplug compatible, such as is the case with gameports, right?

True, but then if you try to open the port, you will only get the base
joydev.o module loaded, not the gameport driver, which is what you
_really_ want to have loaded, right?

So there really isn't much benifit to doing this, sorry.

greg k-h
