Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTLDABi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTLDABh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:01:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:19862 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262777AbTLDAA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:00:28 -0500
Date: Wed, 3 Dec 2003 16:00:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kendall Bennett <KendallB@scitechsoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <3FCDE5CA.2543.3E4EE6AA@localhost>
Message-ID: <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
References: <3FCDE5CA.2543.3E4EE6AA@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Kendall Bennett wrote:
>
> I have heard many people reference the fact that the although the Linux
> Kernel is under the GNU GPL license, that the code is licensed with an
> exception clause that says binary loadable modules do not have to be
> under the GPL.

Nope. No such exception exists.

There's a clarification that user-space programs that use the standard
system call interfaces aren't considered derived works, but even that
isn't an "exception" - it's just a statement of a border of what is
clearly considered a "derived work". User programs are _clearly_ not
derived works of the kernel, and as such whatever the kernel license is
just doesn't matter.

And in fact, when it comes to modules, the GPL issue is exactly the same.
The kernel _is_ GPL. No ifs, buts and maybe's about it. As a result,
anything that is a derived work has to be GPL'd. It's that simple.

Now, the "derived work" issue in copyright law is the only thing that
leads to any gray areas. There are areas that are not gray at all: user
space is clearly not a derived work, while kernel patches clearly _are_
derived works.

But one gray area in particular is something like a driver that was
originally written for another operating system (ie clearly not a derived
work of Linux in origin). At exactly what point does it become a derived
work of the kernel (and thus fall under the GPL)?

THAT is a gray area, and _that_ is the area where I personally believe
that some modules may be considered to not be derived works simply because
they weren't designed for Linux and don't depend on any special Linux
behaviour.

Basically:
 - anything that was written with Linux in mind (whether it then _also_
   works on other operating systems or not) is clearly partially a derived
   work.
 - anything that has knowledge of and plays with fundamental internal
   Linux behaviour is clearly a derived work. If you need to muck around
   with core code, you're derived, no question about it.

Historically, there's been things like the original Andrew filesystem
module: a standard filesystem that really wasn't written for Linux in the
first place, and just implements a UNIX filesystem. Is that derived just
because it got ported to Linux that had a reasonably similar VFS interface
to what other UNIXes did? Personally, I didn't feel that I could make that
judgment call. Maybe it was, maybe it wasn't, but it clearly is a gray
area.

Personally, I think that case wasn't a derived work, and I was willing to
tell the AFS guys so.

Does that mean that any kernel module is automatically not a derived work?
HELL NO! It has nothing to do with modules per se, except that non-modules
clearly are derived works (if they are so central to the kenrel that you
can't load them as a module, they are clearly derived works just by virtue
of being very intimate - and because the GPL expressly mentions linking).

So being a module is not a sign of not being a derived work. It's just
one sign that _maybe_ it might have other arguments for why it isn't
derived.

		Linus
