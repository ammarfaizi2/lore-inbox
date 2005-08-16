Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbVHPH0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbVHPH0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 03:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVHPH0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 03:26:42 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:54714 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932633AbVHPH0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 03:26:42 -0400
Date: Tue, 16 Aug 2005 09:34:23 +0200
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays - bisection complete
Message-ID: <20050816073423.GA31570@aitel.hist.no>
References: <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com> <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no> <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no> <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org> <20050815221109.GA21279@aitel.hist.no> <21d7e99705081516182e97b8a1@mail.gmail.com> <21d7e99705081516241197164a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e99705081516241197164a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 09:24:25AM +1000, Dave Airlie wrote:
> > > I'm a little surprised, as a ppc64 fix theoretically shouldn't matter for
> > > x86_64? But perhaps they share something?
> > 
> > My guess is that it is maybe the DRM changes that have done it... the
> > 32/64-bit code in 2.6.13-rc6 may have issues, but they've been tested
> > on a number of configurations (none of them by me... I can't test what
> > I don't have...)
> >
> 
> Actually after looking back 2.6.13-rc4-mm1 which you say works doesn't
> contain any of the later 32/64-bit changes.. so maybe you can try just
> applying the git-drm.patch from that tree to see if it makes a
> difference...
> 
> I'm getting less and less sure this is caused by the drm, (have you
> built with DRM disabled completely??)
> 
No, but I can try that after work today.

> Do you have any fb support in-kernel (I know you might have answered
> this already but I'm getting a bit lost on this thread...)

There is no fb support at all. I have the vga console,
agp support (which obviously only applies to the agp g550)
drm/dri support for g550 and for the pci radeon.
Could the new patches possibly have issues with the case
where AGP support is compiled into the kernel, but
the card is pci so it isn't supposed to _use_ it?
Also, the two cards aren't used by the same user, it
is two desktops, not one big one.

The X freeze comes fast if I play "cuyo", a nice 2D game
somewhat similiar to tetris. I don't think it
uses DRM, unless x.org 6.8.2 somehow uses it to
speed up 2D operations.

The bisection search:
a46e812620bd7db457ce002544a1a6572c313d8a good
e0b98c79e605f64f263ede53344f283f5e0548be good
fd3113e84e188781aa2935fbc4351d64ccdd171b good
2757a71c3122c7653e3dd8077ad6ca71efb1d450 good
ba17101b41977f124948e0a7797fdcbb59e19f3e good
saw lots of drm recompile for the next one:
561fb765b97f287211a2c73a844c5edb12f44f1d bad

6ade43fbbcc3c12f0ddba112351d14d6c82ae476 good
And then the final one also seemed good.
If the stop condition could be off by one,
wonder what the next patch is?

Helge Hafting
