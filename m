Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbUKHAqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUKHAqy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 19:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbUKHAqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 19:46:54 -0500
Received: from mx.inch.com ([216.223.198.27]:19473 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S261719AbUKHAqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 19:46:51 -0500
Date: Sun, 7 Nov 2004 19:46:43 -0500 (EST)
From: John McGowan <jmcgowan@inch.com>
To: Dave Airlie <airlied@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: (non) "bug" in 810 (kernel 2.6.9)
In-Reply-To: <21d7e99704110714276228ff9b@mail.gmail.com>
Message-ID: <20041107193648.H67112@shell.inch.com>
References: <20041106212327.GA3592@localhost.localdomain>
 <21d7e99704110714276228ff9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Dave Airlie wrote:

> > I had reported a problem with getting a working screen in X with kernel
> > 2.6.9. It is not a bug, but a change.
> >
>
> I can't reproduce this on my system at all, I've got an i815 (slightly
> newer chipset than i810 - maybe something in that...) but I've just
> compiled a kernel with the i810 drm built in and started X in 24-bit
> color on 2.6.9 without incident...

I have been finding more problems. Even with DRM not configured in the
kernel, I have explicitly to kill (NoAccel) all 2D acceleration to
get things working.

I put DRM back in.

I have managed to avoid having to kill ALL 2D acceleration by selectively
disabling parts of it. My xorg.conf now has:

        Option "XaaNoScanlineCPUToScreenColorExpandFill" "true"
        Option "XaaNoSolidFillRect" "true"
        Option "XaaNoScreenToScreenCopy" "true"
        Option "XaaNoMono8x8PatternFillRect" "true"

(the first blocked access to the xterm windows ice put up,
 the second caused the junk on the screen,
 the third was to get text inside Mozilla to scroll and
 the last was to get the MonoPattern in the xterm scrollbar)
(perhaps there will be more things I have to disable)
(I found that disabling all individual options worked and so
then enabled then one at a time until a problem arose to find
out what had to be disabled to get things working)

I can then get DRI working in 16 bit mode (actually I can get it
working with just the first two disabling options but put in the
others for general use).

This is for xorg-x11-6.8.1-12 (rpm, fedora core2 development branch,
rebuilt under kernel 2.6.9).

> I'm running Xorg 6.8.0-rc3.... its wierd I've no idea what could be
> causing it ...

Nor I.

Maybe that's why they brought out the 815 chipset :-)


Regards from:

    John McGowan  |  jmcgowan@inch.com                [Internet Channel]
                  |  jmcgowan@coin.org                [COIN]
    --------------+-----------------------------------------------------
