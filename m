Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSEYSLp>; Sat, 25 May 2002 14:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSEYSLo>; Sat, 25 May 2002 14:11:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4878 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315191AbSEYSLn>; Sat, 25 May 2002 14:11:43 -0400
Date: Sat, 25 May 2002 11:12:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Wolfgang Denk <wd@denx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020525175035.3580211972@denx.denx.de>
Message-ID: <Pine.LNX.4.44.0205251057370.6515-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Wolfgang Denk wrote:
>
> What do you think: it it OK (both from the legal and from  the  ethic
> point  of  view)  that  somebody  writes  and distributes proprietary
> application code?

That's not my point.

My point is that from a technical standpoint, I think giving user land
higher priorities than the kernel is _wrong_.

It gets you into all the priority inversion stuff, where you suddently
must not do simple system calls because the regular kernel locks are no
longer safe to use. That's a HUGE design mistake, and a classic one. Yes,
others have done it that way. A billion flies _can_ be wrong - I'd rather
eact lamb chops than shit.

In short:

 - I think the microkernel approach is fundamentally broken. Karim claims
   there is no priority inversion, but he must have his blinders on. Every
   single spinlock in the kernel assumes that the kernel isn't preempted,
   which means that user apps that can preempt the kernel cannot use them.

   (Or RTAI just handles the priority inversion the way that it has been
   handled in other places: by dropping the priority on the floor when
   calling into the kernel. Whatever. It's still priority inversion, and
   it's still broken).

   It's worse than that. Something as simple as growing your stack a bit
   too much will cause a hard kernel failure (or failure of the RT part,
   assuming that the priority is dropped). Karim claims to give "user
   land" hard-real-time abilities, but the fact is, it's not "user land"
   any more. it's a limited shadow, and a _perversion_ of what user land
   is supposed to be all about.

   This is my _technical_ reason for saying that user-land hard realtime
   sucks, and SHOULD NOT BE DONE. That way lies madness, and crap.

 - My other argument is one of FUD against the patent. People claim that
   the RTLinux patent stands in their way, and they are full of _crap_.

	- The patent only covers a specific way of doing things, which as
	  far as I can tell isn't even an issue with RTAI. In short, the
	  RTLinux patent has about as much to do with "holding up
	  real-time development on Linux" as every other patent out there.

	- Yes, if you go the RTLinux way, you either need to make your RT
	  kernel modules GPL'd, or you need to pay FSMlabs. Since I would
	  strongly suggest you make kernel modules GPL'd anyway, this just
	  isn't an issue. The fact that FSMlabs can get people to pay for
	  their patent is just another "tax on stupidity".

	  And "tax on stupidity" is fine by me. People who don't want to
	  use the GPL might as well pay for it, either by paying FSMlabs
	  or by paying somebody else. I don't care.

Have I made myself sufficiently clear by splitting up the issues into a
technical part and a FUD part?

		Linus

