Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWE2Dnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWE2Dnn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 23:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWE2Dnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 23:43:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:35420 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751152AbWE2Dnn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 23:43:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gJvYr+PJGm3vPbfRAOHjGxt7xr2gToqRhfLcuPZ1tabGfXcJt4p9NQjSSLYrq8i8px/WcQs3q9PablecEEK+UaRh12daAaZNLJKaqATM/9CID8A/NAe4kNteP/1ZL1WQm0iNnUwoIfctNZiGp1nnvCAqeSxkBhEGqFOTe4K8Q7I=
Message-ID: <21d7e9970605282043g7767b62cq100be81b2e99e1a8@mail.gmail.com>
Date: Mon, 29 May 2006 13:43:42 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605282316.50916.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <200605282316.50916.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > numerous occasions and to be honest do not have the time to do so
> > again,
> >
> > I will not accept patches to make DRM drivers rely on fbdev drivers in
> > the kernel for many many many reasons, two quick ones :
>
> So it's a personal thing? God, kernel politics are starting to sicken me.

Dude, calm down, this isn't about any kernel politics, I see you've
been talking to Jon off-thread if I had to guess..

Jon is trying to force something into the kernel that no-one wanted
then, an no-one wants now, he is the one playing politics, we've
described a perfectly workable solution a number of times.

We all agree that "one driver for one piece of hardware" is the ideal,
unfortunately sometimes you have to take a view of the way things are,
and forcing the DRM on top of the fbdev drivers is not the way to do
it, not alone will I NACK the patches I'm pretty sure no other kernel
maintainer is going to try and put them in.

> Okay. That means the intel fbdev drivers will advance significantly through
> the process of having the DRM drivers rely on the fbdev driver as a lower
> layer. I've already started work on this and find that the current fbdev code
> does things in a strange manner, not even using the PCI bus mechanisms in the
> kernel to find the hardware.

No they won't. the intel fbdev drivers can only progress via
information from Intel on how their cards work, all the wishing the
world on your part won't help that. From my point of view I've already
done a lot of work on the intelfb drivers just to get them into a
state for EGL on i915.

> Yes, a few drivers do this, but by and large any system currently in use will
> have it's video card on the PCI or AGP bus, including all those cards now
> being manufactured for the PCI-E systems.

Lots of the world isn't a PCI device, and of the 60 fbdev drivers that
Jon relishes in mentioning (at least 5 times in this thread so far), a
lot of them are for arcane hw that needs an fbdev driver to show
anything.... these don't need to be worked on, they are old drivers,
if someone wants to pick them up they can, we just make sure they
still work. THERE IS NO NEED TO PORT 60 DRIVERS, Jon just likes saying
numbers to discourage one course of action over another....

>
> > b) loading fbdev drivers breaks X in a lot of cases, we need to be
> > a bit more careful.
>
> Unlike what Jon says about this being a problem with X, I happen to feel this
> is more likely a problem with the way only 2 (of 60 or so) fbdev drivers find
> and bind to the hardware.

no I'm sorry you've been listening to Jon, the kernel fbdev drivers on
x86 are generally very very difficult to get working in all situations
, and while you may claim that is fixable it would be a pretty major
regression over what we have so no-one will accept it.

> Yes, this is a strange thing to do, relying on finding the ROM of a card at a
> specific location and requiring said ROM to have certain signatures. An
> easier method is to use PCI bus discovery - pci_get_subsys() and
> pci_dev_get() - for locating the cards.

ISA? SBUS? NUBUS? should I go on? have you got a copy of Linux Device
Drivers v3 at least to read?

Look I don't care how pissed off or not you are, I've got a job to do
in the real world and maintaining this stuff is just part-time
work.... I'm telling you what is acceptable in the kernel from my
point of view and the point-of-view of a number of kernel developers
that I've discussed this with over the past 2 years, Jon's view isn't
acceptable otherwise we would have accepted his patches.

There is no reason for the DRM to live on top of fbdev and any
attempts to make it live there will not be accepted by me into the
DRM, for technical reasons not whatever reasons Jon wants to use
(licensing, political etc..). If you can convince Andrew or Linus or
Antonio (the fbdev maintainer) to accept your patches I'll work with
them, but we've been over this at Kernel Summit last year we all
agreed on the way forward, it hasn't moved due to manpower not due to
clarity of direction. Jon just further obscures the directional
clarity by getting involved at all and I'd thank him to please stop,
his world view is not correctly aligned with the actual world in this
area.

Dave.
