Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318472AbSHPXzS>; Fri, 16 Aug 2002 19:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318778AbSHPXzS>; Fri, 16 Aug 2002 19:55:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45575 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318472AbSHPXzR>; Fri, 16 Aug 2002 19:55:17 -0400
Date: Fri, 16 Aug 2002 17:02:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IDE?
In-Reply-To: <20020816163642.D31052@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0208161657240.1674-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Larry McVoy wrote:
> On Fri, Aug 16, 2002 at 04:34:14PM -0700, Linus Torvalds wrote:
> > I'm dreaming of an IDE maintainer that people (including, very much, me)
> > can work with. I don't know why, but IDE has pretty much since day one
> > been a fairly problematic area, and has caused a lot more maintainer
> > headache than the rest of the kernel put together..
> 
> This may be politically incorrect, but could you (or anyone) provide a 
> history of the IDE maintainers to date and why they didn't work out 
> and what would need to change to make them work out?

I actually don't think it's the people as much as it is the ridiculous 
linkages inside ide.c and the hugely complicated rules. The code is messy.

The network drivers have various setups that share the same chipset, but 
there they tend to be individual drivers that just share helper routines. 
Each driver still does their own PCI driver registration etc. In contrast, 
when it comes to IDE, you're supposed to be an IDE driver first, and a PCI 
chipset driver second, and that putting o fthe cart before the horse 
results in problems.

Even something as simple as a PIIX driver (which _should_ just register 
itself as a driver for the piix chipsets) doesn't do that. Instead, we 
have ide-pci.c, which has a list of all the chipsets it knows about, and 
then does initialization and calls the init routines that it knows about. 
That's just incestuous.

And we all know where incest leads. Hereditary insanity.

		Linus

