Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWE2Mtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWE2Mtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWE2Mtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:49:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15537 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750820AbWE2Mtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:49:32 -0400
Date: Mon, 29 May 2006 14:48:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Airlie <airlied@gmail.com>
Cc: "D. Hazelton" <dhazelton@enter.net>, Jon Smirl <jonsmirl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060529124840.GD746@elf.ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <20060529102339.GA746@elf.ucw.cz> <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Now, lets take common hardware like radeon. You want these
> >combinations to be supported:
> >
> >vgacon
> >vesafb ( + unaccelerated X )
> >radeonfb ( + unaccelerated X )
> >
> >vgacon + accelerated X
> >vesafb + accelerated X
> >radeonfb + accelerated X
> >
> >vgacon + DRM + accelerated X
> >vesafb + DRM + accelerated X
> >radeonfb + DRM + accelerated X
> >
> >...that's crazy! You claim that for various reasons (mostly bugs) we
> >need to keep that complexity. That's not the way forward, with
> >manpower we have I'm afraid.
> 
> We have to support what we support now, regressions in what we support
> are not acceptable, we would spend all our time just having Linus
> backing out changes, I'm sorry Pavel I respect what you've done with
> input, but your list below cuts out a number of currently support
> configurations the main ones currently in use are:

Vojtech Pavlik is the one who done inputs... not me. (I admit we have
similar names).

> vgacon + DRM + accelerated X
> vesafb + DRM + accelerated X

Okay, we are in deeper trouble then I thought, then.

> >vgacon
> >vesafb ( + unaccelerated X )
> >radeonfb ( + unaccelerated X )
> >radeonfb + accelerated X
> >radeonfb + DRM + accelerated X
> 
> Again this gets rid of the two most popular combinations in use today.
> I don't think this is acceptable, and you'll also break suspend/resume
> on every radeon based laptop in use today, but I'm sure you thought
> about all of that before posting :-)

No, to the contrary. suspend/resume can't ever work properly with
vgacon and vesafb. It works okay with radeonfb tooday, and in fact
radeonfb is neccessary today for saving power over S3.

> Here are the rules:
> 1. No regressions.
> 2. Doesn't require lockstep changes in X and kernel, i.e. a new kernel
> can't break old X, and new kernel can't require a new X, new config
> features in the kernel can require a new X of course but anything
> using and old config feature must still work.

These are very reasonable rules... but still, I think we need to move
away from vgacon/vesafb. We need proper hardware drivers for our
hardware.

Now, having DRM depend on framebuffer driver sounds like a right
long-term solution. We probably need to do something with
vesafb/vgacon... like stub it out or something, and deprecate them,
long-term.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
