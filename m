Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRLGNfU>; Fri, 7 Dec 2001 08:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279981AbRLGNfL>; Fri, 7 Dec 2001 08:35:11 -0500
Received: from ns.ithnet.com ([217.64.64.10]:21523 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S279778AbRLGNfE>;
	Fri, 7 Dec 2001 08:35:04 -0500
Date: Fri, 7 Dec 2001 14:34:07 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: erich@uruk.org
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Loadable drivers [was SMP/cc Cluster description ]
Message-Id: <20011207143407.0c24b041.skraw@ithnet.com>
In-Reply-To: <E16C91E-00080K-00@trillium-hollow.org>
In-Reply-To: <20011206173455.104b6a02.skraw@ithnet.com>
	<E16C91E-00080K-00@trillium-hollow.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2001 16:37:36 -0800
erich@uruk.org wrote:

> > If you split things up, you draw _two_ archives, compile and install
> > both.
> 
> Actually, that's something of my point.
> 
> I think the control to install one or the other, certainly for the
> systems I want to be most reliable (firewalls/other servers), is of
> high benefit, hence my proposing this in the first place.

Only in an environment with little evolution going on. But whats the use of
updating anyway, then?
Another thing that really jumps right into my face from your arguments:
you say "administrator needs to have a way to change core kernel, without
changing any drivers, and is not able to read and understand the source of both
core and drivers, so it is best for him to change as little as possible."
But wait: how does _he_ know then, that a standard update (kernel _and_
drivers, as currently) will not work. I mean, you trust the work of some people
building one set of core and drivers, but do not trust the same people to give
you a newer set of core and drivers? And all this, although you are not able or
willing to have a look at the _sources_ to really make sure.
I am definitely not fond of the proposed MS idea, that anybody can administrate
any server, he only needs to know how to perform mouse-clicks. If you can't
drive a car, you should probably not take the seat at the drivers side.

> All these things tied together means they all stand or fall together
> for most people, it's only people like many on this list or other
> kernel hackers that end up being able to do anything about it.

What is wrong with this idea? If you are joe-user, then take your preferred
distro and live with it (quite well nowadays). If you are an experienced user,
then tune your setup according to your needs. If you are really good at it,
then get yourself a job as an administrator for servers people work and rely on
- and read sources. And last, if you have some ideas, go ahead and write source
and give it to the public to verify and tune its quality. And if your real good
it may well be, that god will take your code and you suddenly become one of the
kernel-driver-maintainers. This is a pretty simple and straight-forward world.
And there is noone coming round the corner and tell you: "btw, we changed the
world just yesterday, everything is easy, only you should throw away your old
code."

> There are many important reasons why those in charge of so many
> production computing environments around the world try to, when
> faced with some broken component, want to *only* change that one
> and not all or even a large subset of them.  It is risky.

I really don't get it: if your system works, why upgrade? if your system does
not work: why did you give it to the people in the first place?

> Even if you want to upgrade wholesale, then the ability to rev
> backward something that doesn't work in the new set, but you know
> works in the old form, is very valuable.

Ever heard of lilo? It can boot multiple kernel-images. And guess what: they
are all finding their corresponding modules if you do it right.

> OK, you're telling me that people "should fix it", but my point, and
> one I haven't heard any contradiction to yet, is that often enough
> people don't.

Interesting. I in fact never heard of anyone complaining about a driver (that
is maintained) that does not get fixed if you tell the people about a problem.
If they don't have the hardware to test, simply give it to them.

> My reasoning?  Each time driver code is touched, in particular without
> testing done afterward, there is some probability of another bug
> being induced.

There is always another bug. This is fundamental in software development. This
is why it is really important to talk about bugs you came across. If you do not
use new code, no code will ever become better.

> > Can you give a striking example for this? (old driver ok, new driver
> > broken, both included in kernel releases)
> 
> Not really striking per se, but 2 off of the top of my head I've had to
> deal with:
> 
>   --  integrated 10/100 MBit Enet network in a SiS735 motherboard,
>       effectively SiS900 chipset.  Worked fine in later RH 7.1
>       kernel (2.4.3-rhat), but not with 7.2 kernel(s) (2.4.7-rhat &
>       2.4.9-rhat).

Okay, this is my personal tip for administrators: do not use distro-kernels, do
use linus-kernels, and do not update to very fresh ones. If you wanna be
brilliant, read LKML to know whats going on. This is no hint for joe-user.

>   --  drivers for the Lucent pcmcia Orinoco series of cards work/
>       don't work across different revisions from 2.4.0-ish -> present.

Haha. This is a real good example for real life not matching my ideas, perhaps
david hinds and linus should find some solution for it. If you want to have a
working set of lucent pcmcia you need to draw the latest pcmcia-package and
tools from david and install them on top of standard kernel. This has worked
since the civil war, believe me, I use it everyday with _lots_ of different
kernels and hardware setups. Only annoying part: it is not part of the kernel.
Therefore it is pretty interesting to hear you complaining about a _split away_
drivers' issue. :-)

> My issue with the current process is that it's developer-centric, and
> though I've been able to work past these problems, none of the non-
> kernel hackers I've known would generally care to.

Tell you what, this happened about 2 months ago:
I build a nice and simple hardware for a desktop. It contained Asus Board,
PIII-500, 512MB, ATI graphics card, IDE-10G-hd and ATAPI cdrom, keyboard,
PS/2-mouse and soundblaster . It didn't look all that non-standard.
I tried to install:

win95-orig: 
install fails right away, win95 cannot CD-boot

win98:
doesn't install with 512 MB, install fails.

win ME:
doesn't even get recognised by the BIOS as bootable CD

win 2K:
hangs in hardware detection cycle, I switched it off after 3 hours of continous
hd seeking at about 50%.

SuSE 7.2 (Linux):
install takes about 15 minutes, everything works.

What do we learn of this: win scales everybody down to joe-user-level, and you
cannot do a thing against it. I guess it is definitely not developer-centric. 

> > To tell the pure truth: nobody cares about anything on w*indoze.
> 
> I can't believe you just said that.  Maybe nobody *on this list*, but
> in general, this makes it hard to take you at all seriously.

I have seen to many things on windows to come to a different conclusion.

> Also, the model you present above is only suitable for a small fraction
> of users.  It is irrelevant to most users if the code is fixable.  If
> it doesn't work as is and there is no easy other thing they can try,
> it is effectively broken.

Again, you are talking about joe-user here. If joe-user has a problem, he
should call up the distro-hotline he bought, they will help him with
installation problems (mostly for free). He does not need a compiler or
anything.

And the experienced guy (or girl, hey there are some :-) will have a large
number of options available, including the source and his (her) brain.

Regards,
Stephan

