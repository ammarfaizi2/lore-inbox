Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbUBYBVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbUBYBVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:21:48 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:34317 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262558AbUBYBVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:21:45 -0500
Date: Wed, 25 Feb 2004 01:21:39 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Otto Solares <solca@guug.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
In-Reply-To: <20040224214106.GA17390@guug.org>
Message-ID: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sure, hopefully fbdev drivers became more 'intelligent', with just a
> 
> echo "1024x768x16-75" > /sys/class/fbdev/0/geometry
> 
> they will compute internally the timings or get it from EDID and
> glad the user with something correct for the hardware.
> 
> cat /sys/class/fbdev/0/modes
> 
> will give you the modes supported by the card.

Yes.
 
> On the other side i see a lot of effort in the fbdev acceleration,
> it is nice but that effort should be better spent on fixing the layer,
> imo, the only user for acceleration is fbcon, any userland app that
> use fbdev disables that acceleration so it can map the vmem and ioregs,
> and do it's own voodoo if it wants acceleration.  That acceleration
> is not "exported" to user space.  I am working in a open source project
> that uses mesa-solo with fbdev and many limitations from the layer
> itself have been seen.

That is true so far for fillrect and copyarea functions. Imageblit will be 
used for read and writes on /dev/fbX. Also it is used for software 
cursors. 

> By 'fixing the layer' i mean some simple things that could make fbdev
> a real graphics solution for linux in the long term:
> 
> - fbdev_core (will handle the fbdev/sysfs registration, shared by all
>               drivers, most important is the modes handling interface).

Pretty much done.

> - fbdev_xxx  (driver for specific hw, it will only export the interesting
>               bits like vmem, ioregs, will handle mmap stuff and ioctl's,
>               video modes, no accel of any kind).

Have it.

> - fbdev_xxx_accel (acceleration hooks if any for xxx driver, optional module)

We need it for the above reasons.

> - fbdev_con  (handle console -- already modular in 2.6, will use accel hooks
>               if not NULL, optional).

We always need the accel hooks. Some how we have to draw the fonts.

> - fbdev_xxx_drm (will handle the DRM for xxx using hooks from fbdev, so we
>               could have just a single entity inside the kernel handling a
>               specific device, and not the current mess within fbdev and
>               drm, optional).

That will be the future.

> We have now with 2.6 a good input and sound layers.  Just by fixing
> the graphics layer many interesting userland projects could be born.

I agree. The graphics layer is the last frontier.


