Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266037AbRF1RGp>; Thu, 28 Jun 2001 13:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266040AbRF1RGf>; Thu, 28 Jun 2001 13:06:35 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:26127 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266037AbRF1RG2>; Thu, 28 Jun 2001 13:06:28 -0400
Date: Thu, 28 Jun 2001 10:05:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Patrick Dreker <patrick@dreker.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        <jffs-dev@axis.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <01062809432100.00590@wintermute>
Message-ID: <Pine.LNX.4.33.0106280956030.15199-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Jun 2001, Patrick Dreker wrote:
>
> Am Donnerstag, 28. Juni 2001 00:16 schrieb Linus Torvalds:
> > I don't _have_ any instances of my name being printed out to annoy the
> > user, so that's a very theoretical argument.
>
> Err.... Just nitpicking...
>
> dreker@wintermute:~> dmesg | grep -C Linus
> hub.c: 2 ports detected
> uhci.c:  Linus Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti
> Fliegl, Thomas Sailer, Roman Weissgaerber

Oh, damn.

It wasn't addded by me, though, and if somebody wants to change the name
to "Frodo Rabbit", I wouldn't holler loudly.

Let's make it policy that we _never_ print out annoying messages that have
no useful purpose for debugging or running the system, ok?

"Informational" messages aren't informational, they're just annoying, and
they hide the _real_ stuff.

Things like version strings etc sound useful, but the fact is that the
only _real_ problem it has ever solved for anybody is when somebody thinks
they install a new kernel, and forgets to run "lilo" or something. But
even that information you really get from a simple "uname -a".

Do we care that when you boot kernel-2.4.5 you get "net-3"? No. Do we care
that we have quota version "dquot_6.4.0"? No. Do we want to get the
version printed for every single driver we load? No.

If people care about version printing, it (a) only makes sense for modules
and (b) should therefore maybe be done by the module loader. And modules
already have the MODULE_DESCRIPTION() thing, so they should NOT printk it
on their own.  modprobe can do it if it wants to.

So let's simply disallow versions, author information, and "good status"
messages, ok? For stuff that is useful for debugging (but that the driver
doesn't _know_ is needed), use KERN_DEBUG, so that it doesn't actually end
up printed on the screen normally.

Authors willing to start sending me patches?

		Linus

