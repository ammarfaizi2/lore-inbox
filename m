Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268512AbTBOA5j>; Fri, 14 Feb 2003 19:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268513AbTBOA5j>; Fri, 14 Feb 2003 19:57:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18962 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268512AbTBOA5i>; Fri, 14 Feb 2003 19:57:38 -0500
Date: Fri, 14 Feb 2003 17:03:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <Pine.LNX.4.50.0302141553020.988-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0302141554120.1296-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Feb 2003, Davide Libenzi wrote:
> 
> I would personally like it a lot to have timer events available on
> pollable fds. Am I alone in this ?

I don't know.

HOWEVER, judging from the discussion following, I do know that there are a 
lot of people who want to have just "random things" available.

That's not what this patch was about. I'm not in the least interested in
some "generic event" mechanism, and it's not where I think this should
even go. This was very much about signals, and while I can see the
potential to extend the notion of signals to things like timers, I don't 
think it's necessarily a good idea to extend it too far.

For example, you _can_, with the existing patch, already get timers. You 
won't get any _new_ timers, but all the normal itimer signal stuff would 
come down the sigfd() pipe the same way any other signal does.

Could we extend that to bind "other" timers to the sigfd()? Yes. And maybe 
we could make it easier in general to "bind" events to the fd, instead of 
having the coupling be static (ie right now it's a static coupling at 
"sigfd()" call time, it could be split up into a "create descriptor" and 
"bind descriptor" thing).

> About that, I think we should make an utility function to be shared among
> all the code that need to create "fake" inodes to expose fds. Right now
> many component ( pipes, futexes, epoll, ... ) uses the basic code, sharing
> the same needs, and duplicating basically the same code.

Some of it can be pulled in. However, the way the dynamic inode allocation
works, different kinds of inodes _have_ to have different superblocks,
since that's the level where the inode allocation and caching works. So
the fake inodes for a pipe, for example, are _not_ the same as the fake
inodes for the sigfd's. So not all of it is shared.

		Linus

