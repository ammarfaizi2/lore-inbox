Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267010AbRGILSo>; Mon, 9 Jul 2001 07:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbRGILSe>; Mon, 9 Jul 2001 07:18:34 -0400
Received: from www.wen-online.de ([212.223.88.39]:7174 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S267010AbRGILSW>;
	Mon, 9 Jul 2001 07:18:22 -0400
Date: Mon, 9 Jul 2001 13:17:25 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Christoph Rohland <cr@sap.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107091130580.448-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0107091315190.278-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, Mike Galbraith wrote:

> On 9 Jul 2001, Christoph Rohland wrote:
>
> > Hi Mike,
> >
> > On Mon, 9 Jul 2001, Mike Galbraith wrote:
> > > --- mm/shmem.c.org	Mon Jul  9 09:03:27 2001
> > > +++ mm/shmem.c	Mon Jul  9 09:03:46 2001
> > > @@ -264,8 +264,8 @@
> > >  	info->swapped++;
> > >
> > >  	spin_unlock(&info->lock);
> > > -out:
> > >  	set_page_dirty(page);
> > > +out:
> > >  	UnlockPage(page);
> > >  	return error;
> > >  }
> > >
> > > So, did I fix it or just bust it in a convenient manner ;-)
> >
> > ... now you drop random pages. This of course helps reducing memory
> > pressure ;-)
>
> (shoot.  I figured that was too easy to be right)

Urk!  Yeah, removing the only thing in the world keeping ramfs/tmpfs
page pegged was kinda.. dumb.  I'd ask for a browm paper baggie, but
my pointy head might damage it ;-)

> > But still this may be a hint.

_Anyway_, tmpfs is growing and growing from stdout.  If I send
output to /dev/null, no growth.  Nothing in tmpfs is growing, so I
presume the memory is disappearing down one of X or KDE's sockets.

No such leakage without tmpfs, and I can do all kinds of normal
file type use of tmpfs with no leakage.

	-Mike


