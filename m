Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWEXFtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWEXFtA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 01:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWEXFs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 01:48:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:45753 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932210AbWEXFs7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 01:48:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YZrVB6fHLFM9qi+39tXI5t3ZGe4p38qNg2j9VFVM4QWtAAmhMgnbnQuANwR6ScKMd69HeFCqyRo10bjQ+3g1dQDAAkFG8aRSQ43gsyJ5bxfxPAYlN35kVpj/ibzXiIpKCkjLN0nKEMDdkbRqc9YNZB/1Zn8TPv274aO/+61SpNw=
Message-ID: <21d7e9970605232248t48b303dfwcc481adc5c34932a@mail.gmail.com>
Date: Wed, 24 May 2006 15:48:58 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605240130.14879.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605240017.45039.dhazelton@enter.net>
	 <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
	 <200605240130.14879.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Step 1: add a layer between fbdev and DRM so that they can see each other.
> >
> > Do *NOT* merge fbdev and DRM this is the "wrong answer". They may end
> > up merged but firstly let them at least become away of each others
> > existence, perhaps a lowerlayer driver that handles PCI functionality.
> > All other Step 1s are belong to us.
>
> Okay. This won't be simple, won't be pretty, but I should be able to handle
> it. The problem then becomes: What exactly should this system do? A layer
> that sits on top of the PCI/AGP stuff and mediates it for DRM/fbdev? Isn't
> easy, isn't simple but I think it is possible.

The scope of the lower layer system isn't defined, it should be able
to do what a driver needs it to do, so this can be in the simple case
provide a flag to tell the DRM the fb driver is loaded and vice versa,
up to doing suspend/resume handling and PCI handling.  I think at the
very least it will have to do PCI handling and device model support.

> If DRM makes use of the lower-level driver, and so does fbdev, then it's
> likely possible that the system can provide the information needed to allow
> the kernel to composite error messages onto the framebuffer.

That is the theory, the DRM usually knows where X has the framebuffer.

> to compile DRM or fbdev out of the kernel there is no way that one could
> depend on the other. Having them intercommunicate, it seems, would require a
> third mechanism. Any pointers?

Yes you could move some common functionality into a lowlevel driver
which they could talk to, then compiling out either one wouldn't
matter.

> > I could even drop the last hack I did in some sort of patch form
> > somewhere, I might even have a git tree (not sure...)
>
> That might be helpful.

Okay I've put up two patches at
http://www.skynet.ie/~airlied/patches/merge/three_tier.diff
http://www.skynet.ie/~airlied/patches/merge/three_tier_2.diff

The first is from Dec 27th of last year, the other from March 24 this
year, the three_tier_2 is probably the later patch, and I think is
from some kernel like 2.6.13 or something.

Neither of these do what I wanted to do but they give a lot of ideas
on how to do it, the device model required in the end using a bus to
do this, I actually had some thoughts about it at the X.org developers
conference earlier in the year while reading LDD, but I've been
swamped since and probably won't get back to it until OLS.

Dave.
