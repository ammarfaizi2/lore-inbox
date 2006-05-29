Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWE2Kgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWE2Kgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 06:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWE2Kgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 06:36:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:24690 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750825AbWE2Kgy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 06:36:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t4ezSNqAJPDyGKEBGcmBrKuCe5ICbDeo//q09dcguRqrtjbDes4tOGjwIiNaFeNfDCdyu5AL6MM/H5QTFTYC5x1ldIi2KJuhCunL6Gn4Mvr8V1dyLRbeOmohF7VpFFkQjYfybP8VjWWrii4+XaGNLCIzLBmiFhCkDPu12up8n14=
Message-ID: <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
Date: Mon, 29 May 2006 20:36:53 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Jon Smirl" <jonsmirl@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060529102339.GA746@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <20060529102339.GA746@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > a) we don't always have a fully functional fbdev driver, see intel fb
> > drivers.
>
> Well, we need to write those fbdev drivers, then.

And you propose to get specs from hw vendors how? (please provide
solutions for practical problems)

> > b) loading fbdev drivers breaks X in a lot of cases, we need to be a
> > bit more careful.
>
> Fix X and/or fbdev, then.

we don't have the manpower to do even that...

> > c) Lots of distros don't use fbdev drivers, forcing this on them to
> > use drm isn't an option.
>
> Let the distros catch up with current state of technology....
>
> I mean, it is crazy. We have complex subsystem (graphics), that is
> made even more complex because of crazy design (independend fbdev and
> DRM, X handling PCI from userspace).

and you are not going to fix it with a big lot of code, you need to
fix it one problem at a time,

> Now, lets take common hardware like radeon. You want these
> combinations to be supported:
>
> vgacon
> vesafb ( + unaccelerated X )
> radeonfb ( + unaccelerated X )
>
> vgacon + accelerated X
> vesafb + accelerated X
> radeonfb + accelerated X
>
> vgacon + DRM + accelerated X
> vesafb + DRM + accelerated X
> radeonfb + DRM + accelerated X
>
> ...that's crazy! You claim that for various reasons (mostly bugs) we
> need to keep that complexity. That's not the way forward, with
> manpower we have I'm afraid.

We have to support what we support now, regressions in what we support
are not acceptable, we would spend all our time just having Linus
backing out changes, I'm sorry Pavel I respect what you've done with
input, but your list below cuts out a number of currently support
configurations the main ones currently in use are:

vgacon + DRM + accelerated X
vesafb + DRM + accelerated X

If you take a look at the stuff required to get r300 support in the
drm and X into the kernel without breaking current systems you'll get
an idea of what we have to do..

Linus has so far reverted a number of patches from the DRM as they
cause regressions, anything done in this area has to be careful to
have a complete understanding of the area.

> vgacon
> vesafb ( + unaccelerated X )
> radeonfb ( + unaccelerated X )
> radeonfb + accelerated X
> radeonfb + DRM + accelerated X
>

Again this gets rid of the two most popular combinations in use today.
I don't think this is acceptable, and you'll also break suspend/resume
on every radeon based laptop in use today, but I'm sure you thought
about all of that before posting :-)

I'm not knocking solutions here for the fun of it, I've tried a lot of
different combinations of things to find an answer, and until someone
supplies some code that doesn't regress or works in an incremental
manner to improve the situation....

Here are the rules:
1. No regressions.
2. Doesn't require lockstep changes in X and kernel, i.e. a new kernel
can't break old X, and new kernel can't require a new X, new config
features in the kernel can require a new X of course but anything
using and old config feature must still work.

Dave.
