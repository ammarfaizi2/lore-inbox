Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbRGIJjs>; Mon, 9 Jul 2001 05:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbRGIJji>; Mon, 9 Jul 2001 05:39:38 -0400
Received: from www.wen-online.de ([212.223.88.39]:11531 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S266997AbRGIJjZ>;
	Mon, 9 Jul 2001 05:39:25 -0400
Date: Mon, 9 Jul 2001 11:38:22 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Christoph Rohland <cr@sap.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <m38zhya1rn.fsf@linux.local>
Message-ID: <Pine.LNX.4.33.0107091130580.448-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jul 2001, Christoph Rohland wrote:

> Hi Mike,
>
> On Mon, 9 Jul 2001, Mike Galbraith wrote:
> > --- mm/shmem.c.org	Mon Jul  9 09:03:27 2001
> > +++ mm/shmem.c	Mon Jul  9 09:03:46 2001
> > @@ -264,8 +264,8 @@
> >  	info->swapped++;
> >
> >  	spin_unlock(&info->lock);
> > -out:
> >  	set_page_dirty(page);
> > +out:
> >  	UnlockPage(page);
> >  	return error;
> >  }
> >
> > So, did I fix it or just bust it in a convenient manner ;-)
>
> ... now you drop random pages. This of course helps reducing memory
> pressure ;-)

(shoot.  I figured that was too easy to be right)

> But still this may be a hint. You are not running out of swap, aren't
> you?

I'm running oom whether I have swap enabled or not.  The inactive
dirty list starts growing forever, until it's full of (aparantly)
dirty pages and I'm utterly oom.

With swap enabled, I keep allocating until there's nothing left.
Actual space usage is roughly 30mb (of 256mb), but when you can't
allocate anymore you're toast too, with the same dirt buildup.

	-Mike

