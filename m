Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSHQBOt>; Fri, 16 Aug 2002 21:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSHQBOs>; Fri, 16 Aug 2002 21:14:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318216AbSHQBOs>; Fri, 16 Aug 2002 21:14:48 -0400
Date: Fri, 16 Aug 2002 18:21:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Larry McVoy <lm@work.bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE?
In-Reply-To: <20020817003328.GA3587@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0208161808560.1674-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Andries Brouwer wrote:
> 
> Of course, "IDE maintainer" implies work on the interface with the hardware
> and work on the interface with the block I/O subsystem of the kernel.
> Some people know all about the hardware, others know much less about
> hardware but have good ideas about the driver interface.
> There is no reason to force the "IDE maintainer" to be a single person.

There isn't in theory, but because a minor change to one part will make
other drivers fail subtly, one person has to be the one that holds the bag 
in the end. Because somebody _will_ be the one that everybody looks at 
when something breaks.

That is probably one of the largest reasons for the "IDE disease". The
symptoms of the disease is that people complain about the stuff not
working, and the maintainer eventually getting so fed up with the
complaints that he stops interacting with reality, and starts worrying
about compliance with the documentation instead, hoping that that will fix
everything.

Which would work fine, except a lot of the time the problems aren't due to 
things in the documentation, but simply due to hardware that isn't really 
in spec and needs to have workarounds etc. So once the "this is how it is 
documented, and if it doesn't work your machine is broken" disease starts, 
it's all downhill from there.

I will claim that this happens for a lot of other hardware too, but in
other hardware there often isn't quite as much baggage (people in the end
throw out the core and start on a new one without historical cruft), and
the inter-driver linkages do not exist to _nearly_ the same degree. When a
developer can work with just one chipset, it's still possible to believe
that you can keep up. But when you get blamed for all the different IDE
problems, you crawl into your shell and go away.

This is why I believe that the only sane result in the end is to have
independent drivers that probably end up having a lot of duplication (the
same way hd.c and ide.c started out with a lot of duplication), but where
there truly _can_ be multiple people in charge of their own drivers (and
also clear _whose_ problem it is when one IDE controller driver doesn't
work).

(Some of the infrastructure could be made truly generic, but the generic
part should _only_ be for stuff that is truly hardware-independent, and
simply _cannot_ be impacted by quirks and outright bugs in the hw
implementations. In short, only stuff that can be argued about on a
logical and clear level, and where the rules are made up by us, not by
quirky hardware).

		Linus

