Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317539AbSFRSXx>; Tue, 18 Jun 2002 14:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSFRSXw>; Tue, 18 Jun 2002 14:23:52 -0400
Received: from web12308.mail.yahoo.com ([216.136.173.106]:12297 "HELO
	web12308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317539AbSFRSXu>; Tue, 18 Jun 2002 14:23:50 -0400
Message-ID: <20020618182351.78368.qmail@web12308.mail.yahoo.com>
Date: Tue, 18 Jun 2002 11:23:51 -0700 (PDT)
From: Myrddin Ambrosius <imipak@yahoo.com>
Subject: Re: Drivers, Hardware, and their relationship to Bagels.
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1024416087.1019.5.camel@nomade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Xavier Bestel <xavier.bestel@free.fr> wrote:
> Le mar 18/06/2002 à 17:06, Myrddin Ambrosius a écrit
> :
> > The issue is this. My understanding is that -all-
> > hardware access should be through the kernel,
> partly
> > so that similar hardware can have a similar API,
> but
> > also so that kernel security code (eg:
> capabilities)
> > applies to ALL hardware and ALL lower-level
> > operations.
> 
> You want to forbid XFree86's DRI ?

No, the kernel's DRM provides a nice kernel layer for
XFree's DRI, which covers all the security issues.
Well, provided the DRM code gets enough drivers.

Personally, I'd like to see more fine-control of
graphics hardware end up in the kernel, partly to
avoid some of the nastier security risks (such as
having to run X servers as root! bleagh!) but also
because the kernel has to have a whole lot of control
anyway.

The sheer number of possible displays you can put into
any given one of the fantastically large number of
virtual consoles makes for an interesting challange.
(On older kernels, changing to and from virtual
terminal when running an svgalib app could do some
VERY interesting things to your display.)

When you start looking at running X under multiple
resolutions on the same machine, or even running
multiple X servers (which I -think- is now possible),
things don't get any better.

If the kernel's various graphics components (DRM,
framebuffers, etc) handled the low-level stuff, you
don't get multiple pieces of software each trying to
drive the screen at a different rate. You could even
have two pieces of software access the same virtual
terminal at different resolutions, because the kernel
would eliminate the "conflict".

I understand that, prior to framebuffers going in,
there were a number of (cough!) lengthy discussions on
the safety and stability of high-level code in the
kernel. I honestly believe that this is the flip-side
of that same debate. Whether it is safe and stable to
have low-level code in userland.

I honestly believe that too much low-level code or
access in userland is just as destabilizing (and
potentially far more dangerous) than high-level code
in the kernel.

Someone else mentioned all the wonderful stuff root
can do. Root's a cool toy, but in the end, root is
still a product of the kernel's imagination. There is
no physical chunk of machinary in a computer that can
be called "root". Unless your spider-plant has grown.

Therefore, to argue that root can do anything is not
entirely true. (In fact, Linux' Capabilities
demonstrates this, nicely. It is possible to set the
capabilities such that nothing root can do can
re-enable any capabilities removed.)

It would be too soon to "retire" root, because I don't
think anyone's entirely happy with the alternatives
that exist. (If they were, Linux would have lost root
before version 1.0! I can remember patches almost the
size of the kernel!) Maybe, someday, someone'll figure
out a rootless system that is generally acceptable.

On the other hand, if the small handful of actual
instructions (not apps, not even functions, just the
instructions) that -need- super-user privs were all
encapsulated inside kernel system calls, then you
don't risk running a root-kit-o-matic every time you
boot X, or some other server that currently needs root
privs.

One reason for NOT doing this is that it takes time to
switch between contexts. Deliberately adding a whole
bunch of switches would seem to be remarkably stupid.
Doubly so, when you're adding switches to maybe run
half a dozen lines. For stuff that's used heavily,
there's probably less time penalty in typing the code
in by hand into the server, and running as root, than
all the constant switching.

I don't have to like it, but I can't find any solid
argument against this. Good solutions are efficient,
and efficient != slower than a snail on salt.


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
