Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262183AbTCHUOV>; Sat, 8 Mar 2003 15:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbTCHUOV>; Sat, 8 Mar 2003 15:14:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16644 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262183AbTCHUOT>; Sat, 8 Mar 2003 15:14:19 -0500
Date: Sat, 8 Mar 2003 12:22:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: "David S. Miller" <davem@redhat.com>, <zippel@linux-m68k.org>,
       <david.lang@digitalinsight.com>, <hpa@zytor.com>,
       <rmk@arm.linux.org.uk>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <20030308170741.GB29789@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0303081210100.19334-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Mar 2003, Larry McVoy wrote:
> 
> Actually, I think this libc is very useful and at the risk of depressing hpa
> even more, we may well link BitKeeper against it.  We make no use of anything
> glibc specific since we run on all sorts of platforms and having libc be
> part of the image would be cool if it were small.

Mixing basic libraries on the same host can be a damn pain, which is one
reason why libraries have a hard time getting competition (and if they
don't have competition, they have little incentives to becomes smaller and
leaner and faster)

For example, I bet you'll find problems with simple things like
disagreements over configuration. Things like user/host lookups (NIS,
files, whatever?) etc. You'll get BK to behave differently from other
binaries because it uses a different library that is configured
differently..

And then there will be some feature that isn't there, because the klibc 
people really don't care. So then you'll have a mixed environment..

Yeah, it sucks. A basic standard C library _should_ probably be so small
that it really doesn't make any real sense to have shared libraries for it
at all. But because of all the nasty corner cases for the "extended 
functionality", you often end up wanting to lump a lot of new stuff into 
the standard library, so you get all these connections that are hard to 
break.

And nobody wants to have to add "-lresolv" (or even "-lm") etc to their
builds, so there's the user base too that by being lazy really advocates a 
big library. And once it is big it really wants to be shared. And once 
_that_ happens, you want even more to combine libraries that would 
otherwise have been fine as two separate libs, since you don't want to 
make the startup costs worse than they already are by having to mmap many 
different files.

In short: some stuff would be better off static, simply because it's 
smaller that way, and it helps startup costs if it can be all linked into 
the binary. But it's _only_ smaller if you don't have to do the dynamic 
linking _anyway_, which means that the cases where it really pays off are 
only for the simple stuff. 

And there's a _lot_ of simple stuff, but even then you have to live 
together with stuff that isn't simple, so now the simple stuff has to live 
by the rules of the complex stuff. And the complex stuff doesn't mind 
doing complex things if it makes other things more convenient, so the 
complex parts really don't care about living together with the small and 
simple stuff.

Yeah, I'm pessimistic. It's just _damned_hard_ to be small any more, when 
you have to live in harmony with projects that long since stopped caring 
about the small stuff, because it just didn't even register on their 
radar any more.

		Linus

