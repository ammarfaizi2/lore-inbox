Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWFBE23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWFBE23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 00:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWFBE23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 00:28:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:44822 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751105AbWFBE23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 00:28:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mjy9mZ2NoHuJ4YeEJePc3f1s2HZDgvK0Gbtuepr7pikUoRGQYH2Vx4KUKN8MwS0O/VBWvc0/QyaGJWcYhLM08mauDdDgo+szULSUFixWSzEzipa5ijS0bJ1G+6Qarci1yyABAdKtSm+VZaQ6VWOiPXtSNXWPP0nfIOD7l2kNNlw=
Message-ID: <9e4733910606012128h5bdc293dwfa3c58985bbceb07@mail.gmail.com>
Date: Fri, 2 Jun 2006 00:28:18 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Ondrej Zajicek" <santiago@mail.cz>, "D. Hazelton" <dhazelton@enter.net>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <9e4733910606012027y2567c194yf02a96319fe33e63@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
	 <200605310026.01610.dhazelton@enter.net>
	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
	 <20060601092807.GA7111@localhost.localdomain>
	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
	 <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com>
	 <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com>
	 <21d7e9970606011945i57e2cfd2la77459fc7273b6e7@mail.gmail.com>
	 <9e4733910606012027y2567c194yf02a96319fe33e63@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 6/1/06, Dave Airlie <airlied@gmail.com> wrote:
> > > > 15) re-use as much of the X drivers as possible, otherwise it will KGI.
> > >
> > > I would broaden this to use the best code where ever it is found. Of
> > > course X is a major source.
> >
> > I'm not considering using knowledge from X drivers, I'm considering
> > using the X drivers, I don't personally care about things like X's
> > over use of typedefs and that sort of stuff, that is what I term
> > semantic, people who work on X drivers know X drivers, and writing the
> > drivers is the biggest part of any graphic systems.
>
> I have considered that option too. It is a good place for a quick
> start but it is not maintainable in the long run. The driver code has
> to be divorced from X and not require having the entire X system
> around to build a new driver.
>
> Have you checked the dependencies needed for loading X drivers?
> Modularization may have helped but loading an X driver used to
> effectively suck in the entire X server due to dependencies. Sucking
> in all of X is not fair to alternative windowing systems.
>
> I do agree that this is a workable starting point but it can't be the
> long term solution.

I just checked the Xorg R7 drivers. The ones I checked are statically
linked to their X components so there are no big X dependencies. That
makes them usable as standalone drivers.

What do you think about wrapping them with EGL instead of using their
entry points directly? That would remove the temptation to use
acceleration code in the X drivers and encourage use of DRM instead.

Wrapping them with EGL was my plan for getting Xegl up last summer
when Nvidia wouldn't implement the API. Using the X driver was the
only solution available for Nvidia/ATI hardware.

This still needs to be classified as a temporary solution. Long term
the code needs to be extracted from X and converted to a standalone
build system. They could be turned in to real EGL drivers at that
point.

-- 
Jon Smirl
jonsmirl@gmail.com
