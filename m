Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290671AbSA3WTA>; Wed, 30 Jan 2002 17:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290656AbSA3WSI>; Wed, 30 Jan 2002 17:18:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64009 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290665AbSA3WRy>; Wed, 30 Jan 2002 17:17:54 -0500
Date: Wed, 30 Jan 2002 14:17:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Eli Carter <eli.carter@inet.com>
cc: Georg Nikodym <georgn@somanetworks.com>, Larry McVoy <lm@bitmover.com>,
        Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C586C8D.2C100509@inet.com>
Message-ID: <Pine.LNX.4.33.0201301408290.2618-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Eli Carter wrote:
> > However, you are obviously correct that any changes are inherently
> > dependent on the context those changes are in. And there are multiple
> > contexts.
>
> What about the design context?
>
> I'm a bit concerned about the design-level inter-dependencies of
> changesets that don't result in source-level dependencies.

Well, I'm personally worried about _no_ inter-dependencies that show up as
source-level dependencies that are impossible to break.

If you want to have a "known working version", that's what tagging is for:
basically a list of all patch-sets that makes up the current tree. That
includes all the dependencies.

> Hypothetical situation:
> Changeset adds driver for device Q.  Now, let's further suppose that in
> 2.5.x we have perfect modularity for drivers and at that time Q is
> added... we just add a directory, linux/drivers/Qdrv.  It won't conflict
> with 2.5, 2.4.x, 2.2.x, etc..  However, because 2.2.x does not have the
> hooks necesary to see it, Q won't work on those kernels.  There is a
> design-level dependency in changeset q.

Not so hypothetical, and entirely true. Which is, why I suggest that such
"deep merging" wouldn't actually go past tags.

Let's face it, the source control tool cannot know what works and what
doesn't. The only thing it can ever know about is "what applies". It can
take the approach that everything only applies to the last branch - which
is the traditional approach, but which introduces dependencies that simply
aren't there, and that _cannot_ be cut. This is what bk does now.

But the other approach is to say "whatever applies, applies, and as long
as I don't lose revision information I'll move it backwards". That has
other problems (as you point out), but now those problems are manageable,
and have solutions.

I'd rather take the problem that can be solved over the problem that
cannot.

The fact is, development _often_ is in the situation where somebody does a
quick-and-dirty fix, and then only later goes in and digs deeper and does
the right fix that makes the original fix completely unnecessary.

The way BK works now, if we call the quick-and-dirty fix "A", and the real
fix "B", the developer has a really hard time just sending "B" to me. He'd
have to re-clone an earlier BK tree, re-do B in that tree, and then send
me the second version.

I'm suggesting that he just send me B, and get rid of his tree. There are
no dependencies on A, and I do not want _crap_ in my tree just because A
was a temporary state for him.

			Linus

