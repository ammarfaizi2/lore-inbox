Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbSLETzK>; Thu, 5 Dec 2002 14:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267416AbSLETzK>; Thu, 5 Dec 2002 14:55:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48657 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267415AbSLETzH>; Thu, 5 Dec 2002 14:55:07 -0500
Date: Thu, 5 Dec 2002 12:03:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Shane Helms <shanehelms@eircom.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: is KERNEL developement finished, yet ???
In-Reply-To: <200212051952.25772.shanehelms@eircom.net>
Message-ID: <Pine.LNX.4.44.0212051157360.3342-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Thu, 5 Dec 2002, Shane Helms wrote:
>
> Being curious, I was wondering, since we're not changing much in kernel core,
> and developement implies adding additional code and layers for security,
> enhancements and support for further hardware and etc.
> Does this not slow down the kernel ? or is the execution code still the same
> ??

Oh, some things do get slower. We try to avoid hitting the critical paths,
and supporting new hardware for example (which tends to be a large portion
of kernel development, even if it isn't as sexy as new features) doesn't
impact the rest of the kernel negatively at all.

What we'll probably see in 2.6.x for example, is that many microbenchmarks
show slight deprovement (fork() and execve() have become noticeably slower
due to the rmap patches), but to at least somewhat offset that we get much
nicer worst-case behaviour and better scalability.

And many things _can_ be done without throwing out old designs.
Implementation improvements are quite possible without trying to make
something totally new to the outside. That's how things like the dcache
come about, for example - keeping the standard old boring UNIX filesystem
approach, while internally caching it in new ways, improving performance
tremendously.

Not throwing out the baby with the bath-water doesn't mean that you cannot
improve the system. I'm only arguing against stupid people who think they
need a revolution to improve - most real improvements are evolutionary.

		Linus

