Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271149AbTGPWKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271147AbTGPWIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:08:20 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:7186 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S271161AbTGPWGt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:06:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Input layer demand loading
Date: Thu, 17 Jul 2003 00:21:43 +0200
User-Agent: KMail/1.4.3
References: <200307131839.49112.fredrik@dolda2000.cjb.net> <200307162323.31836.fredrik@dolda2000.cjb.net> <20030716215452.GB2773@kroah.com>
In-Reply-To: <20030716215452.GB2773@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307170019.48988.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 July 2003 23.54, you wrote:
> On Wed, Jul 16, 2003 at 11:23:31PM +0200, Fredrik Tolf wrote:
> > On Wednesday 16 July 2003 18.26, Greg KH wrote:
> > > On Wed, Jul 16, 2003 at 02:57:42PM +0200, Fredrik Tolf wrote:
> > > > On Wednesday 16 July 2003 06.29, Greg KH wrote:
> > > > > On Mon, Jul 14, 2003 at 12:58:24PM +0200, Fredrik Tolf wrote:
> > > > > > If the input layer userspace interface code has been compiled as
> > > > > > modules, and you have a ordinary (not hotplug) device, eg. a
> > > > > > gameport joystick, can really the hotplug interface be used to
> > > > > > load joydev.o when /dev/input/js0 is opened?
> > > > >
> > > > > No, you want to load the joydev.o driver when you plug in the
> > > > > gameport joystick.  Which will be before you open the /dev node.
> > > >
> > > > Not necessarily. When the joystick is plugged in, you want to load
> > > > the hardware driver modules. There's really no need for the userspace
> > > > interface until someone requests it. At least that's the way I see
> > > > it. And in any case, even if you do want to load joydev.o when the
> > > > joystick is plugged in, I don't see how that could be done on-demand
> > > > when the joystick port isn't hotplug compatible, such as is the case
> > > > with gameports, right?
> > >
> > > True, but then if you try to open the port, you will only get the base
> > > joydev.o module loaded, not the gameport driver, which is what you
> > > _really_ want to have loaded, right?
> >
> > If you have demand-loading in the input layer, on the other hand, you can
> > have "above" directives in modules.conf (or "install" directives in
> > modprobe.conf) to pull in the hardware drivers along with joydev.
>
> Where do you get the hardware driver coming along with joydev?
>
> I must be missing something here...
>
> > So not only does demand-loading permit hardware drivers and userspace
> > interfaces independently of each other, it also provides for loading
> > hardware drivers on demand for non-hotplug hardware.
>
> That would be very nice, but I still don't see how your patch enables
> this to happen.

It could be done by adding this to your modules.conf (or the modprobe.conf 
equivalent if you're using module-init-tools):

alias input-dev-0 joydev
above joydev joy_driver

Admittedly, "above" isn't the preferred way to load modules, but I'd say it's 
far better than nothing. The gameport framework module will be pulled in with 
the joystick driver from the dependency information.

Fredrik Tolf

