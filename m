Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSLWCCD>; Sun, 22 Dec 2002 21:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbSLWCCC>; Sun, 22 Dec 2002 21:02:02 -0500
Received: from dp.samba.org ([66.70.73.150]:64932 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265643AbSLWCCA>;
	Sun, 22 Dec 2002 21:02:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module. 
In-reply-to: Your message of "Sat, 21 Dec 2002 14:22:26 -0000."
             <20021221142226.GA24941@suse.de> 
Date: Mon, 23 Dec 2002 12:10:47 +1100
Message-Id: <20021223021009.C6CC32C0E3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021221142226.GA24941@suse.de> you write:
> On Fri, Dec 20, 2002 at 06:29:18PM -0500, Ed Tomlinson wrote:
>  > Dave, with the pull from this morning (8am EST), it almost works modular.
>  > I get:
>  > 
>  > Dec 20 18:20:19 oscar upsd[636]: Communication established
>  > Dec 20 18:20:47 oscar kernel: Linux agpgart interface v0.100 (c) Dave Jone
s
>  > Dec 20 18:20:47 oscar kernel: agpgart: Detected VIA MVP3 chipset
>  > Dec 20 18:20:47 oscar kernel: agpgart: AGP aperture is 64M @ 0xe0000000
>  > Dec 20 18:20:58 oscar kernel: [drm] Initialized mga 3.1.0 20021029 on mino
r 0
>  > Dec 20 18:20:58 oscar kernel: Module agpgart cannot be unloaded due to uns
afe usage in drivers/char/ag
>  > p/backend.c:58
> 
> This one is due to the way AGPGART does (or has done for the last 3
> years) its module locking. It does a MOD_INC_USE_COUNT as soon as
> someone calls the acquire routines.

Which is racy under SMP, and under preempt, which is why it's
deprecated.

> (So you can't unload agpgart whilst you've a 3d using app (like X)
> open).  This seems quite sensible, but these days you can't unload
> agpgart.ko anyway because the chipset module (via-agp.ko in your
> case) already has it 'in use', so I'm tempted to drop those bits.

If this is true (it usually is), you can simply drop them.  There are
other cases where the caller is not grabbing references, so
MOD_INC_USE_COUNT is better than nothing (should the warning stay for
2.6?  Good question).

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
