Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267574AbSLMBKy>; Thu, 12 Dec 2002 20:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbSLMBKy>; Thu, 12 Dec 2002 20:10:54 -0500
Received: from dsl093-058-082.blt1.dsl.speakeasy.net ([66.93.58.82]:7919 "EHLO
	beohost.scyld.com") by vger.kernel.org with ESMTP
	id <S267574AbSLMBKw>; Thu, 12 Dec 2002 20:10:52 -0500
Date: Thu, 12 Dec 2002 20:18:51 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Roger Luethi <rl@hellgate.ch>, <netdev@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pci-skeleton duplex check
In-Reply-To: <3DF90208.3010208@pobox.com>
Message-ID: <Pine.LNX.4.44.0212121743500.10674-100000@beohost.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, Jeff Garzik wrote:
> Donald Becker wrote:
> > On Thu, 12 Dec 2002, Jeff Garzik wrote:
> >>Donald Becker wrote:
> 	[[ I don't know why I bother. The people that now control what
> 	   goes into the kernel would rather put in random patches from
> 	   other people than accept a correct fix from me. ]]
> I'm sure you'll continue making snide comments on every mailing list you 
> maintain, but the fact remains:
> I would much rather accept a fix from you.

Perhaps we have a different idea of "fix".

You want are looking for a patch to modifications you have made to code
I have written.  In the meantime I have been providing working code, and
have been updating that code to work with new hardware.  So a fix is the
working, continuously maintained version of the driver. 

To put an admittedly simplified spin on it, you are saying "I want you
to tell me what I have broken when I changed this", and to continuously
monitor and test your changes, made for unknown reasons on a very
divergent source base.

> > The drivers in the kernel are now heavily modified and have significantly
> > diverged from my version.  Sure, you are fine with having someone else
> > do the difficult and unrewarding debugging and maintenance work, while
> > you work on just the latest cool hardware, change the interfaces and are
> > concerned only with the current kernel version.
> 
> While I disagree with this assessment, I think we can safely draw the 
> conclusion that the problem is _not_ people ignoring your patches, or 
> preferring other patches over yours.

I can point to specific instances.  Just looking at the drivers in the
kernel, it is clear that this has happened.

> > A good example is the tulip driver.  You repeatedly restructured my
...
> I take responsibility for fixing it, I just haven't fixed it yet :)

> > It's easy to make the first few patches, when you don't have to deal
> > with reversion testing, many different models, and have an unlimited
> > sandbox where it doesn't matter if a specific release works or not.

I think that these two statements fit well together.


> > But
> > it takes a huge of work to keep a stable, traceable driver development
> > process that works with many different kernel versions and hardware
> > environments.
> 
> We're slowly getting there, in terms of regression and stress testing.

But it existed before, and was discarded!
Yes, the kernel is now _returning_ to a stable state while making
improvements.  But there was a period of time when interface stability
and detailed correctness was thrown away in favor of many inexperienced
people quickly and repeatedly restructuring interfaces without
understanding the underlying requirements.

I could mention VM, but I'll go back to one that had a very large direct
impacted on me: CardBus.  CardBus is a difficult case of hot-swap PCI --
the device can go away without warning, and it's usually implemented on
machines where suspend and resume must work correctly.  We had perhaps
the best operational implementation in the industry, and I had written
about half of the CardBus drivers.  Yet my proven interface
implementation was completely discarded in favor one that needed to be
repeatedly changed as the requirements were slowly understood. 

> I would love to integrate your drivers directly, but they don't come 
> anywhere close to using current kernel APIs.  The biggie of biggies is 
> not using the pci_driver API.  So, given that we cannot directly merge 

Yup, that is just what I was talking about.  Let me continue: 

The result is that today other systems now have progressed to a great
implementation of suspend/resume, while Linux distributions now default
to unloading and reloading drivers to avoid various suspend bugs.  And
when the driver cannot be unloaded because some part of the networking
stack is holding the interface, things go horribly wrong...

You might be able to naysay the individual details, but the end
technical result is clear.

> your drivers, and you don't send patches to kernel developers, what is 
> the next best alternative?  (a) let kernel net drivers bitrot, or (b) 
> maintain them as best we can without Don Becker patches?  I say that "b" 
> is far better than "a" for Linux users.

Or perhaps recognizing that when someone that has been a significant,
continuous contributer since the early days of Linux says "this is
screwed up", they might have a point.  When Linux suddenly had thousands
of people wanting to submit patches, that didn't means that there were
more people that could understand, implement and maintain complex
systems.

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Scyld Beowulf cluster system
Annapolis MD 21403			410-990-9993


