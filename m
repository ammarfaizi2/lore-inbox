Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWEXFa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWEXFa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 01:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWEXFa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 01:30:26 -0400
Received: from smtp.enter.net ([216.193.128.24]:31761 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932596AbWEXFaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 01:30:25 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 24 May 2006 01:30:14 +0000
User-Agent: KMail/1.8.1
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605240017.45039.dhazelton@enter.net> <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
In-Reply-To: <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605240130.14879.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 May 2006 05:14, Dave Airlie wrote:
> > > All the other designs and stuff people have mentioned have all been
> > > discussed to death before, people seem to love discussing graphics,
> > > but no-one seems to care about fixing it properly, in nice incremental
> > > steps that doesn't break older systems. The current systems are very
> > > very fixable, however there always seem to be lots of people who want
> > > to re-write it because it is a) ugly in their opinion b) don't care
> > > about backwards compat.
> >
> > I'd never advocate just killing a functioning system. What I've been
> > talking about is building a new system that sits alongside the existing
> > one in the tree, depends on EXPERIMENTAL and BROKEN in the Kconfig system
> > and takes the place of the traditional framebuffer system if someone
> > decides to use it.
> >
> > I say have it depend on BROKEN because that should keep the masses away
> > from it while it's being heavily tested, and I say it should sit
> > alongside the existing code and be *new* for exactly the reason you've
> > pointed out. Modifying the existing systems to integrate the new
> > technology would require either changing the driver model or a lot fo
> > dirty hacks. Neither seems that good of an option to me.
>
> Not going to happen at this stage I believe, while people are in NIH
> mode against trying to fix the current system, we are not going to
> merge a third incompatible graphics layer into the kernel, we have
> enough of them to do the job, we need people to fix the current crap
> not add more.
>
> The current system is fixable, we've discussed how to fix it a number
> of times, however there have never been resources to do it, we
> explained to Jon on a number of occasion how we as the maintainers
> felt it should be fixed, the patches he produced didn't follow the
> direction we wanted, he stated "the writer decides", we stated "the
> maintainers don't accept it".

Okay. In this case, is there any way you provide me with the same information?

I suggested what I have because I lack the information about what exactly is 
wrong/bad and needs to be fixed.

> Step 1: add a layer between fbdev and DRM so that they can see each other.
>
> Do *NOT* merge fbdev and DRM this is the "wrong answer". They may end
> up merged but firstly let them at least become away of each others
> existence, perhaps a lowerlayer driver that handles PCI functionality.
> All other Step 1s are belong to us.

Okay. This won't be simple, won't be pretty, but I should be able to handle 
it. The problem then becomes: What exactly should this system do? A layer 
that sits on top of the PCI/AGP stuff and mediates it for DRM/fbdev? Isn't 
easy, isn't simple but I think it is possible.

Any other option though, would seem to require rebuilding a good deal of both 
DRM and fbdev, if not replacing the driver model, because of difficulties you 
have previously pointed out.

If DRM makes use of the lower-level driver, and so does fbdev, then it's 
likely possible that the system can provide the information needed to allow 
the kernel to composite error messages onto the framebuffer.

And, really, if there is a common PCI layer beneath the two graphics systems, 
they could potentially have some interaction... though to retain the capacity 
to compile DRM or fbdev out of the kernel there is no way that one could 
depend on the other. Having them intercommunicate, it seems, would require a 
third mechanism. Any pointers?

> I could even drop the last hack I did in some sort of patch form
> somewhere, I might even have a git tree (not sure...)

That might be helpful. 

DRH
