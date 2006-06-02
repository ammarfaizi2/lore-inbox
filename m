Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWFBCqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWFBCqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWFBCqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:46:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:8169 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751162AbWFBCqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:46:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qZfynGmx45dni7LfYecktC/eLKFm6x13TW6CzkPoouJw8aj5v7xLtsysWu+sagQ7gtjSuRhs1JY92yAmIkK5XYdYrYqfD2StXvTrIZgA15cvBqKiBUzy8xVb+SbdxpUXXc7oqxAux/nEOrOs5cJ8pqe74gUc1E5bMjA1/ZxkCHA=
Message-ID: <21d7e9970606011945i57e2cfd2la77459fc7273b6e7@mail.gmail.com>
Date: Fri, 2 Jun 2006 12:45:54 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Ondrej Zajicek" <santiago@mail.cz>, "D. Hazelton" <dhazelton@enter.net>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605302314.25957.dhazelton@enter.net>
	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
	 <200605310026.01610.dhazelton@enter.net>
	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
	 <20060601092807.GA7111@localhost.localdomain>
	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
	 <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com>
	 <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > not really necessary.. nor should it be... fbset works, something like
> > it would be good enough..
>
> I meant support for Korean, Chinese, etc. You can't draw some of the
> complex scripts without using something like Pango. Do we want to
> build a system where people can use console in their native language?
> You can use these languages from xterm but not console today. I have
> no strong opinion on this point other that I believe it should be
> discussed and input from non-English speakers should be considered. No
> one on this list has a problem with this area since we all speak
> English.

Sorry misinterpreted, a userspace console would be possible now, if
someone implements it we can use it, but I'm not sure a freetype
accelrated console is necessary for us to do everything else.

> > 14) backwards compatible, an old X server should still run on a new
> > kernel. I will allow for new options to be enabled at run-time so that
> > this isn't possible, but just booting a kernel and starting X should
> > work.
>
> I'm not sure we want to continue supporting every X server released in
> the last 25 years. But we should definitely support any X server
> released in a 2.6 based kernel distribution. What are reasonable
> limits?

Yes at least a 2.6 distro based X should always work, I'm sure 2.4 DRM
doesn't work with new X in a lot of cases anyways as no-one tested it
at the time and it just got broken...

> > 15) re-use as much of the X drivers as possible, otherwise it will KGI.
>
> I would broaden this to use the best code where ever it is found. Of
> course X is a major source.

I'm not considering using knowledge from X drivers, I'm considering
using the X drivers, I don't personally care about things like X's
over use of typedefs and that sort of stuff, that is what I term
semantic, people who work on X drivers know X drivers, and writing the
drivers is the biggest part of any graphic systems.

> > 16) secure - no direct IO or MMIO access, modesetting is slow anyways
> > having the kernel checking the mmio access won't make it much slower.
>
> This needs some expansion. Secure is good, but it's not clear what you
> are requiring with this point.

I'm talking the recent secure thread that came from OpenBSD, we should
have no unchecked access to the I/O ports from userspace, even for
root or special graphics processes, MMIO needs to be mapped R/O to
userspace and accessed via either real DMA or pseudo-DMA mechanism in
the kernel. I don't think putting modesetting into the kernel is
sufficent to fix all needed uses for MMIO so I'd rather add a checking
mechanism ala what the DRM does now.

Dave.
