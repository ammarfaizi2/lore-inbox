Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbTAIVai>; Thu, 9 Jan 2003 16:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267772AbTAIVai>; Thu, 9 Jan 2003 16:30:38 -0500
Received: from [213.171.53.133] ([213.171.53.133]:28688 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S267765AbTAIVah>;
	Thu, 9 Jan 2003 16:30:37 -0500
Date: Fri, 10 Jan 2003 00:39:06 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Adam Belay <ambx1@neo.rr.com>
cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54][PATCH] SB16 convertation to new PnP layer.
In-Reply-To: <20030109152654.GC17701@neo.rr.com>
Message-ID: <Pine.BSF.4.05.10301100003580.97976-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Adam Belay wrote:
> On Thu, Jan 09, 2003 at 06:35:12PM +0300, Ruslan U. Zakirov wrote:
> > 1) As I've understood we need to free all reserved resources when
> > remove function called, am I right?
> 
> Yes, all resources must be freed or the device will not work if it is
> attached to the driver a second time.  This is becuase the driver will
> think the device is busy when actually the resources were just never
> freed from the previous session.  Also the resources must be freed to
> safetly disable the device.
Here I have strange behavior under 2.5.55 vanilla with my patch.
rmmod snd_*
OK, and it understandable for me. We just unload KO(->remove was called)
and didn't free resources(remove is empty now).
modprobe snd_sbawe isapnp=0 (I've got legacy card)
This cause an oops not error(logical behavior as I think because
resources busy), but module loads anyway and sound works.
I must reinstall binutils to install ksymoops, i'll do it tomorow after my
exam.
> 
> 
> > 2) Who decide card is accessible at some time or not?
> 
> This is determined by both the pnp layer and the driver model.  Becuase a
> card is a group of devices the individual devices must also not be matched
> to more than one driver.  PnP Card Services have a few bugs in this area,
> all of which have been resolved in the patch I released last week.  Greg,
> could you please forward that to Linus.
I've this patch and going to try write remove function.

> > 3) And the last, where is the place of ISA not PnP cards in the device
> > lists? As I think, they are fit with PnP bus, but their resources
> > static(not configurable) or it's just lays under ALSA, apears in
> > /proc/asound only and ALSA internals?
> 
> Currently the pnp layer does not support legacy non PnP devices.  I plan
> to add support for them soon.  This support should achieve two objectives.
> 1.) Reserve resources used by the legacy devices
> 	a.) if the resources match an existing pnp devices, bind to that
> 	    device
> 	b.) if they conflict but do not match exactly return an error
> 	c.) otherwise reserve the resources and prevent pnp devices from
> 	    using them.
> 2.) Represent these legacy devices in sysfs.  Maybe the current legacy dir
>     could be used or I may have to create "pnp_legacy".  Needs more research.
OK. Waiting for new changes.

