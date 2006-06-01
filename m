Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWFACTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWFACTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 22:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWFACTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 22:19:47 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:43657 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751500AbWFACTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 22:19:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BSnPC0qlVji1FTqfyxPX+Ne11laKJk9fQrruEMejoV3ad+BPtk77Foz4NXGUisBjmiNPBKwrGKg/mRCK1JowUBsFw83CR2BPHIAEeOTz/p5w52C3ya7mTGeZ+PMRkD63YN9oN6Rhg8tXFFL2u64MpAwLCaBGQak+sG07zOd0zyo=
Message-ID: <9e4733910605311919x2cd1847cx90b5353cf6b325f6@mail.gmail.com>
Date: Wed, 31 May 2006 22:19:34 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Dave Airlie" <airlied@gmail.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <447E493E.1090808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605302314.25957.dhazelton@enter.net>
	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
	 <200605310026.01610.dhazelton@enter.net>
	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
	 <447E39DD.7000007@gmail.com>
	 <9e4733910605311837w97316c8q3ac13798f74cb211@mail.gmail.com>
	 <447E493E.1090808@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > 4) Some things are so tiny it is pointless to move them to user space
> > and they need root to work. Things like screen blank, set the hardware
> > cursor, set the cmap, etc. I think these are best implemented as
> > additions to the DRM driver.
>
> These small things (cmap, blanking) are sometimes difficult to do, and
> the driver is not always right about that. A user helper may be needed.
> vesafb in x86_64 may not be able to set the cmap properly without calling
> out to the BIOS.

Call out to user space if it is complex. But it only takes few lines
of code to to these things on a radeon.

> > 7) Since there isn't much left to a device specific fbdev driver after
> > you push mode setting out to user space, I would just add the
> > remaining functions to the device specific DRM driver. But that would
> > be 'evil' since it merges fbdev and DRM.
> >
>
> Actually, there's no need for a merge as there is nothing in DRM that
> is absolutely needed by fbdev or the other way around, as long as
> console acceleration is disabled. In-kernel fbdev drivers may not even
> be necessary.

Something needs to bind to the hardware, that code is in the device
specific fbdev drivers currently. The fbdev drivers also contain those
small functions I mentioned like cmap, cursor, etc. Some of the fbdev
drivers also contain initialization code.

If fbdev is eliminated the DRM code will need to provide a compatible
fbdev device in user space for legacy apps. It makes sense to get that
code from fbdev.

Any concerns about having two device nodes for a single piece of
hardware, fb0 and dri0? Since dri0 has a single user it may be
possible to rework its IOCTLs to use the fb0 device.

As part of multiuser support you need to make one device per head
instead of one device per card. Each independent user needs their own
deivce to control.

-- 
Jon Smirl
jonsmirl@gmail.com
