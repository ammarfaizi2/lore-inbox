Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbREPH0X>; Wed, 16 May 2001 03:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbREPH0G>; Wed, 16 May 2001 03:26:06 -0400
Received: from aeon.tvd.be ([195.162.196.20]:63080 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S261806AbREPHZT>;
	Wed, 16 May 2001 03:25:19 -0400
Date: Wed, 16 May 2001 09:23:23 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Timothy A. Seufert" <tas@appsig.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B019F2E.7CC8C39A@appsig.com>
Message-ID: <Pine.LNX.4.05.10105160921480.23225-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Timothy A. Seufert wrote:
> Linus Torvalds <torvalds@transmeta.com> wrote:
> >On Tue, 15 May 2001, Alexander Viro wrote:
> >> Driver can export a tree and we mount it on fb0. After that you have
> >> the whole set - yes, /dev/fb0/colourspace, etc. - no problem. And no
> >> need to do mknod, BTW. Yes, we'll need to use /dev/fb0/frame for
> >> frame itself. BFD...
> >
> >Actually, we can just continue to use "/dev/fb0", which would continue to
> >work the way ti has always worked.
> >
> >It's a mistake to think that a directory has to be a directory. Or to
> >think that a device node has to be a device node. It's perfectly ok to
> >just think of it as namespaces. So opening /dev/fb0 continues to open the
> >"master fd", whatever that means (in this case, the actual frame
> >buffer). The namespaces _under_ /dev/fb0 would be the control channels, or
> >in fact _anything_ that the frame buffer driver wants to expose.
> 
> Why not take it a step further than just devices?  This is a perfect
> model for supporting named forks.
> 
> In fact, I believe this is how MacOS X is exposing HFS+ named forks to
> the UNIX side of things.  (HFS+ supports not just the old style
> Macintosh data and resource forks but an arbitrary number of named
> forks.)  So: you open "foo", you get what an older MacOS would consider
> the "data" fork.  Open "foo/rsrc" and you get the resource fork.  Open
> "foo/joesfork" and you get whatever Joe wanted to use a named fork for.

How to find out which forks are available? UNIX semantics for directories are
that a directory is just a file that you open to get the directory contents.
But if your `directory' is a file, you'll get the file's contents if you open
it. Or should we open wigth O_DIRECTORY to get at the fork directory?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

