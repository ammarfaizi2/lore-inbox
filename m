Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313568AbSDHGa7>; Mon, 8 Apr 2002 02:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313569AbSDHGa6>; Mon, 8 Apr 2002 02:30:58 -0400
Received: from adsl-203-134.38-151.net24.it ([151.38.134.203]:10235 "EHLO
	morgana.systemy.it") by vger.kernel.org with ESMTP
	id <S313568AbSDHGay>; Mon, 8 Apr 2002 02:30:54 -0400
Date: Mon, 8 Apr 2002 08:30:38 +0200
From: Alessandro Rubini <rubini@gnu.org>
To: pasky@pasky.ji.cz, j.mencak@hud.ac.uk, gpm@lists.linux.it,
        linux-kernel@vger.kernel.org
Subject: Re: [gpm]Re: gpmselection
Message-ID: <20020408083038.A13359@morgana.systemy.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Free Lance in Pavia, Italy.
In-Reply-To: <20020407214445.GD3218@pasky.ji.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> What I am aiming at is an echange of data between X and a console. I 
>> have a program `xsel' which does the same thing with X-Window selection.

> [...]
> The stuff you want to rewrite is at /usr/src/linux/drivers/char/selection.c,
> maybe random bits at /usr/src/linux/drivers/char/vt.c.

Adding one or two more "commands" in console.c::tioclinux (one to get
the current selection buffer, one to copy he buffer for user space,
possibly), is all that's needed.

> And, obviously GPM, as you want to move this functionality there.

This is a different issue altogether. I agree it would be a good move,
but it's not the original point.

> You probably want to completely remove concept of selections from
> kernel, make GPM to read content of /dev/vcc/X when grabbing a
> selection and output proper escape sequences for inverting the
> appropriate stuff

You don't need to send that, just use /dev/vcs. The problem, rather,
is ensuring the console doesn't get modified. Currently, it can be
blocked with existing ioctls() while the user selects, but any
highlight should be removed before the console is unlocked unless
other means are designed (not a good thing, in my opinion, as it
wouldn't actually take stuff out of the kernel any more).

> write handler for /dev/vcc/X to the kernel so that you can simulate
> keyboard input on the terminal

That's already there, nothing to add here. The problem, rather, is
handling not-direct mapping from glyphs to keyboard input, not always
trivial.

/alessandro, not the gpm maintainer any more
