Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422632AbVKYQrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbVKYQrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 11:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbVKYQrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 11:47:25 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:59035
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1161126AbVKYQrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 11:47:24 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Fri, 25 Nov 2005 10:47:09 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511250218.56755.rob@landley.net> <Pine.LNX.4.61.0511251337240.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511251337240.1609@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251047.09185.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 November 2005 09:02, Roman Zippel wrote:
> Hi,
>
> On Fri, 25 Nov 2005, Rob Landley wrote:
> > > I don't really disagree, a proper implementation of the concept would
> > > also be technically quite different.
> >
> > But would the user interface?
>
> It would be a bit different from what you propose.

You mean that what I've been happily using for eight months.

What would the different interface be, and what would the advantage be?  (Are 
you proposing a different file format?)

> > Uh-huh.  So doing this requires a complete rewrite of kconfig.  And how
> > long is this rewrite expected to take?  (Will it be in python and called
> > CML2?)
>
> Rob, if you want me to just ignore you, then please continue like this.

You've already made up your mind about the patch, based entirely on opinion 
rather than technical arguments.  I'm not convinced you've even read my list 
of reasons for the patch.  (You certainly haven't responded to any of the 
actual reasons, such as failure to find the config file being grounds for a 
build break with miniconfig but not for allnoconfig.  You're already ignoring 
that.)

If you'd like to ignore the rest, I'm not sure what real difference it would 
make.

> > Meanwhile, I have a small patch that provides this (from a user
> > perspective) now.  Working today.
>
> The point is that it's close enough to allnoconfig, so that it's IMO not
> worth it.

So far, this statement of pure opinion is the sum total of your technical 
arguments.

I've been working around kconfig for most of a year to do this functionality, 
until your recent changes broke what I'd been doing.  Your recent changes 
replaced the way I've been doing it with a new way of doing it, but I don't 
believe you had what I've been doing all along in mind when you did them.  
You primarily seem to have been interested in offloading decisions like 
allyesconfig not enabling broken drivers not expected to compile.  The fact 
that it's useful to me seems entirely accidental.

Are you saying you had something like miniconfig in mind when you made these 
changes?  If so, why was there no documentation?  Why was there no way to 
make a mini.config from a normal config?  Why was the user interface wrong in 
several different obvious ways that were easy to fix?  (You've already 
admitted that the stdout output is useless, and O= should take the config 
from the target directory.)

I was cheerfully using this functionality for eight months before you added 
allno.config, and what you did is closer but not a perfect fit for for what 
I've been doing.

> I'm trying to explain, what would be needed to do it properly, 

What exactly does the patch I posted do wrong?  (Other than the makemini.sh 
being a hack, but it's a hack to replace a complete absence of this feature.)

You seem to be simultaneously arguing that allnoconfig by itself is so good 
that it needs no change (despite there being no way at all to automatically 
create a miniconfig from a big .config), and that supporting miniconfig is an 
excuse for such an extensive rewrite that not just kconfig but kbuild must be 
adjusted to compensate.

Pick one.

> but either I failed to make myself understandable or you're not listening.

I feel _exactly_ the same way about you.

> > > > However, you seem to be forgetting that .config is read by the kernel
> > > > build infrastructure.  The tools are generating what _used_ to be a
> > > > human editable file.
> > >
> > > Oh, really?
> >
> > This is a slightly vague.  Is this "Oh, really?" arguing that it didn't
> > used to be a human readable format?
>
> At this point I was just wondering, whether you realize that I wrote the
> new kconfig stuff.

Why do you think I cc'd you?

> > > > I don't personally _care_ about the other config targets.
> > >
> > > Well, that's the problem, I do care about them.
> >
> > I think you're too focused on the implementation to see the users.  What
> > I'm trying to document is miniconfig, and as such any kallsyms target
> > allnoconfig is not _useful_.
>
> I'm actually quite interested in the needs of the users, but OTOH users
> have to realize that they are not always _exactly_ get what they want.
> Users often have very specific wishes and I try to provide a generic
> framework, which not only solves specific problems but also a broad range
> of problems, which often means to compromise as user needs can be very
> contradictory.

I'm trying to see how this applies.  Really I am...

> > > I want to keep it working without obfuscating it with thousands little
> > > features, so we have to figure out how to integrate it properly into
> > > the big picture.
> >
> > Do you have a suggestion that does not involve a complete rewrite of
> > kbuild over the next year or more?  I just posted one, and I've just
> > started work on another.
> >
> > I'm still not entirely certain you understand what I'm trying to
> > accomplish, and I'm sorry I can't make you understand why I need this. 
> > I'm not convinced that your "new config format" will be at all useful.
>
> I think I understand you quite well. Again, the basic functionality you
> want is already provided by allnoconfig

It was previously provided by
make allnoconfig && cat mini.config >> .config && yes "" | make oldconfig
Although that admittedly wasn't reliable because oldconfig is based on 
defconfig rather than allnoconfig, but yes "n" could go into an endless loop 
because oldconfig stupidly re-queries for numeric constants indefinitely.

> and the advanced features need a 
> bit more work than the few hacks you added to conf.c.

Why?  What advanced features?

> I like the idea of a minimum config, which e.g. users can send to
> developers or they can use for upgrading kernels, but this has to work not
> just for you, but also for the majority of users and this requires a
> better specification of how this feature should work in various
> situations.

If I wanted it to work just for me, would I have bothered writing up 
documentation first thing?  Would I have bothered posting the patch here at 
all?

What situations does the patch I posted previously not work in?

> bye, Roman

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
