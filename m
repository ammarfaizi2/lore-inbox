Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVKWMRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVKWMRg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVKWMRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:17:36 -0500
Received: from styx.suse.cz ([82.119.242.94]:45701 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750740AbVKWMRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:17:36 -0500
Date: Wed, 23 Nov 2005 13:17:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123121726.GA7328@ucw.cz>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 04:13:01PM -0500, Jon Smirl wrote:

> On 11/22/05, Greg KH <greg@kroah.com> wrote:
> > On Tue, Nov 22, 2005 at 01:31:16PM -0500, Jon Smirl wrote:
> > >
> > > 4) Merge klibc and fix up the driver system so that everything is
> > > hotplugable. This means no more need to configure drivers in the
> > > kernel, the right drivers will just load automatically.
> >
> > What driver subsystem is not hotplugable and does not have automatically
> > loaded modules today?
> 
> All of the legacy stuff - VGA, Vesafb, PS2, serial, parallel,
> joystick, floppy, gameport, etc.

You can remove these from the list:

ps/2 and serial (for input devices) use the 'serio' layer, which does
have automatic loading.

gameport is missing, but planned. Unfortunately you can't probe for
joysticks before you load the specific modules, so it simply will have
to load all available drivers. On the other hand, gameports are a dying
breed, replaced by USB, which is good.

And the others:

VGA drivers are autoloaded by the PCI subsystem.

VESAfb can't ever be autoloaded.

serial, parallel, gameport, etc are using the PnP subsystem and will be
autoloaded if ACPIPnP reports these devices.

And floppy, well, I think it isn't using ACPIPnP but possibly could ...

> Those drivers could be in initramfs
> and only load if the hardware is found. Most of these legacy devices
> have poor sysfs support too. Also, it's not just x86 legacy device all
> of the platforms have them.

The hardware is often found only by the driver, like in the joystick
case. Hopefully ACPIPnP will list all the devices ...

> Currently you have to compile most of this stuff into the kernel.

You don't.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
