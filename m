Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVKYITO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVKYITO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 03:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVKYITO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 03:19:14 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:49051
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750707AbVKYITN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 03:19:13 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Fri, 25 Nov 2005 02:18:54 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511241145.24037.rob@landley.net> <Pine.LNX.4.61.0511250022330.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511250022330.1609@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511250218.56755.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 19:48, Roman Zippel wrote:
> Hi,
>
> On Thu, 24 Nov 2005, Rob Landley wrote:
> > > On Mon, 21 Nov 2005, Rob Landley wrote:
> > > > Add "make miniconfig", plus documentation, plus the script that
> > > > creates a minimal mini.config from a normal .config file.
> > >
> > > The difference between miniconfig and allnoconfig is IMO too small to
> > > be really worth it right now.
> >
> > I disagree, fairly strongly.  The technical difference may be small, but
> > the conceptual difference is huge.
>
> I don't really disagree, a proper implementation of the concept would also
> be technically quite different.

But would the user interface?

> Hacking it into conf.c is the wrong to go (or to even start).

Hang on, you want a new user interface that does _not_ modify conf.c?

I can do that.  One ./configure wrapper script coming up...

> > So it would be different from the format of the busybox .config file, the
> > uClibc .config file, or anybody else out there who's adopted the kernel's
> > format over the past decade-plus?
>
> Did I say it would go away? No.
> It actually makes quite some sense to separate the .config used by kbuild
> from the config used by kconfig.
> .config isn't always correctly reread after a manual edit. The syntax
> rules needed by kbuild are more strict than needed for kconfig. The "is
> not set" syntax is not exactly user friendly and all the derived symbols
> aren't needed by kconfig.

Uh-huh.  So doing this requires a complete rewrite of kconfig.  And how long 
is this rewrite expected to take?  (Will it be in python and called CML2?)

Meanwhile, I have a small patch that provides this (from a user perspective) 
now.  Working today.  And I can also do a wrapper script so that Linux uses 
approximately the same ./configure; make; make install semantics as 95% of 
the other projects out there.

The fact that my patch works today is not an excuse for a complete rewrite of 
kconfig.  If you want to rewrite kconfig from scratch, fine.  But what I'm 
trying to do is not a reason for it.

> My current plan is to somewhere create a copy of .config replacing
> the include/config/MARKER mechanism, which then is also used by kbuild.

So you have to modify not just kconfig but kbuild also for your plan.  What 
are the advantages of doing this again?

> In a second step it then would be simple to allow an alternative name
> or even formats for the primary config file.

How far will they be allowed to diverge?  Will the use the same symbol names, 
or will there be some kind of translation table?

> > However, you seem to be forgetting that .config is read by the kernel
> > build infrastructure.  The tools are generating what _used_ to be a human
> > editable file.
>
> Oh, really?

This is a slightly vague.  Is this "Oh, really?" arguing that it didn't used 
to be a human readable format?

> > So how would you make use of this new minimized version, then?  If
> > somebody file attached one in a linux kernel message and a developer
> > wanted to debug their issue?
>
> $ cp ... linux/config
> $ make
>
> > I don't personally _care_ about the other config targets.
>
> Well, that's the problem, I do care about them.

I think you're too focused on the implementation to see the users.  What I'm 
trying to document is miniconfig, and as such any kallsyms target allnoconfig 
is not _useful_.

> I want to keep it working without obfuscating it with thousands little
> features, so we have to figure out how to integrate it properly into the big
> picture. 

Do you have a suggestion that does not involve a complete rewrite of kbuild 
over the next year or more?  I just posted one, and I've just started work on 
another.

I'm still not entirely certain you understand what I'm trying to accomplish, 
and I'm sorry I can't make you understand why I need this.  I'm not convinced 
that your "new config format" will be at all useful.

But oh well.  If you prefer I treat kbuild's user interface as something 
broken to be worked around with a wrapper script, I'm fine with that.  You're 
right, I don't really need to touch the implementation of kconfig.  Thanks 
for pointing that out.

> bye, Roman

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
