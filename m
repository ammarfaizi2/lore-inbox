Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbRLGAiY>; Thu, 6 Dec 2001 19:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285345AbRLGAiP>; Thu, 6 Dec 2001 19:38:15 -0500
Received: from trillium-hollow.org ([209.180.166.89]:8454 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S285338AbRLGAiH>; Thu, 6 Dec 2001 19:38:07 -0500
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Loadable drivers [was SMP/cc Cluster description ] 
In-Reply-To: Your message of "Thu, 06 Dec 2001 17:34:55 +0100."
             <20011206173455.104b6a02.skraw@ithnet.com> 
Date: Thu, 06 Dec 2001 16:37:36 -0800
From: erich@uruk.org
Message-Id: <E16C91E-00080K-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephan von Krawczynski <skraw@ithnet.com> wrote:

> erich@uruk.org wrote:
> 
> > Hmm.  There is little fundamentally incompatible with having splits in
> > the core kernel and sets of drivers, and getting most of what you want
> > here.
> 
> There is. You double the administrational work. Most updates are
> performed because you want the latest bugfixes. If you get more bugfixes
> than you intended - lucky.
> Currently you draw the latest kernel-tree (or the latest _you_ like to
> use), use your old .config and it works out - as long as you do not use
> closed-source drivers.

And if something breaks out of it - unlucky?

I again think your statement that "...and it works out" is naive.

See below for more.


> If you split things up, you draw _two_ archives, compile and install
> both.

Actually, that's something of my point.

I think the control to install one or the other, certainly for the
systems I want to be most reliable (firewalls/other servers), is of
high benefit, hence my proposing this in the first place.

All these things tied together means they all stand or fall together
for most people, it's only people like many on this list or other
kernel hackers that end up being able to do anything about it.

There are many important reasons why those in charge of so many
production computing environments around the world try to, when
faced with some broken component, want to *only* change that one
and not all or even a large subset of them.  It is risky.

Even if you want to upgrade wholesale, then the ability to rev
backward something that doesn't work in the new set, but you know
works in the old form, is very valuable.


> Oops. Then you have a severe problem in understanding how linux _should_
> be worked with. Obviously you can go and buy some distribution and it
> may work out pretty well. But being a serious administrator you _will_
> do kernel updates apart from the distro (sooner or later). If there are
> drivers in a newer kernel release, that do not work any longer, compared
> to an older release, you should say so. Best place would be the listed
> maintainer. Because if it doesn't do the job for your configuration any
> longer, chances are high others were hit, too.
> The maintainer cannot know, if you do not tell him.
> I guess we have the mutual agreement here, that maintained drivers
> should get better not worse through the revisions. This means
> configurations once successful are not meant to break later on.
> This basically is what I intended to say with "being happy" :-)

OK, you're telling me that people "should fix it", but my point, and
one I haven't heard any contradiction to yet, is that often enough
people don't.

So, the response has been to hold the drivers close in so when
interfaces change/a bug is found, they can all be changed together.
I think there is some merit to that when you find a bug, but
otherwise this becomes a statistical shooting gallery.

My reasoning?  Each time driver code is touched, in particular without
testing done afterward, there is some probability of another bug
being induced.


> > I don't object to producing well-tested full sets of driver source that
> > go with kernel versions, I just don't want them to be tied if I have
> > a need to pull something apart (a driver from one version and from
> > another are the only ones that run stably), which frankly happens too
> > often for my taste.  Even if it didn't I'd still want it as much as
> > possibly for the fall-back options it provides.
> 
> Can you give a striking example for this? (old driver ok, new driver
> broken, both included in kernel releases)

Not really striking per se, but 2 off of the top of my head I've had to
deal with:

  --  integrated 10/100 MBit Enet network in a SiS735 motherboard,
      effectively SiS900 chipset.  Worked fine in later RH 7.1
      kernel (2.4.3-rhat), but not with 7.2 kernel(s) (2.4.7-rhat &
      2.4.9-rhat).
  --  drivers for the Lucent pcmcia Orinoco series of cards work/
      don't work across different revisions from 2.4.0-ish -> present.


Yes, I've reported various problems with other bits before, and
debugged some of my own, submitted patches, etc.

You can make the argument that some of them are young drivers/etc., but
that just proves my point that I want the control, not just for me, but
for others to easily load across drivers across different kernel
versions.

My issue with the current process is that it's developer-centric, and
though I've been able to work past these problems, none of the non-
kernel hackers I've known would generally care to.

In fact, several others who I know with similar hardware just gave up
when I told them they had to install a kernel/hacked driver patches.


> Ok, lets put it this way: they use a completely split up model of
> driver maintenance to get the most out of the market (anybody can
...
> hardware component - which it does in a significant percentage. And if
> you upgrade from (e.g.) win95 to win98, you will draw all drivers again
> and completely reinstall everything.
> 
> To tell the pure truth: nobody cares about anything on w*indoze.

I can't believe you just said that.  Maybe nobody *on this list*, but
in general, this makes it hard to take you at all seriously.


...
> > My general feeling is that binary drivers are ok/should be supported well
> > across versions since that is the thing you load in at boot/bring-system-
> > up time.  Having separate (and usually many) step(s) to getting a driver
> > and having it load on your system is a major and I'm thinking artificial
> > pain.
> 
> I have learned something over the recent years: I guess RMS pointed in the
> right direction. I _don't_ think binary drivers are ok. I want to control
> my environment, and don't let _anybody_ control it _for_ me. And if
> something goes wrong, I have a look. And if I am too dumb, I can ask
> somebody who isn't. And there may be a lot of those.

Huh?  I didn't ask you to use them.

I'm just pointing out that binary drivers are the end-product (you don't
"insmod driver.c"), so it's kind of hard to just hand-wave them out of
existence.  Not everyone has a fully self-hosted system with compilers
just sitting around to do your bidding.

Also, the model you present above is only suitable for a small fraction
of users.  It is irrelevant to most users if the code is fixable.  If
it doesn't work as is and there is no easy other thing they can try,
it is effectively broken.


--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
