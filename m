Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbUAIIFl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 03:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266438AbUAIIFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 03:05:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:10899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266436AbUAIIFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 03:05:35 -0500
Date: Fri, 9 Jan 2004 00:00:13 -0800
From: Greg KH <greg@kroah.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] sysfs sound class patches - [0/2]
Message-ID: <20040109080012.GB15962@kroah.com>
References: <20040107232137.GC2540@kroah.com> <s5hvfnmxs3r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hvfnmxs3r.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 06:33:44PM +0100, Takashi Iwai wrote:
> At Wed, 7 Jan 2004 15:21:37 -0800,
> Greg KH wrote:
> > 
> > Here are 2 sysfs sound class patches against 2.6.1-rc2 (but should apply
> > to 2.6.0) that add sysfs support for OSS and ALSA drivers.  This enables
> > udev to see sound devices and create nodes for them.
> > 
> > I've divided it up into 2 patches:
> > 	- sound support for OSS drivers
> > 	- sound support for ALSA drivers
> > 
> > The ALSA driver patch requires the OSS driver (due to where struct
> > sound_class is declared),
> 
> oh, sound_core.c is not the OSS driver ;)

Heh, but the changes I made to it are in the OSS specific parts :)

> >  and it also modifies the i810 ALSA sound
> > driver to provide a symlink in sysfs to the pci device being controlled
> > by the device node.
>  
> it looks nice and easy.  i'll do that for all pci drivers, too, once
> when these patches are merged.

Thanks.

> > I can provide patches to the other ALSA drivers to also add this
> > information, as it's quite useful if you have more than one sound device
> > in your system at once.
> 
> not only pci but also isapnp devices can provide dev pointer.

Exactly.  So does USB.

> in that case, should the driver gives symlinks of each isapnp devices,
> too?

Yes.  If the dev pointer is valid, the driver core will create the
symlinks.

> a module usually holds one isapnp card struct and several isapnp
> devices below it.  but, hmm, it will need far more codes...

Just set the dev pointer to the device that is associated with the sound
device.  That's the best you can do.

thanks,

greg k-h
