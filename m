Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbRGKCiA>; Tue, 10 Jul 2001 22:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267189AbRGKChv>; Tue, 10 Jul 2001 22:37:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21267 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267183AbRGKChg>; Tue, 10 Jul 2001 22:37:36 -0400
Date: Tue, 10 Jul 2001 22:05:36 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Christoph Rohland <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33.0107091130580.448-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0107102201360.2021-100000@freak.distro.conectiva>
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
> 
> > But still this may be a hint. You are not running out of swap, aren't
> > you?
> 
> I'm running oom whether I have swap enabled or not.  The inactive
> dirty list starts growing forever, until it's full of (aparantly)
> dirty pages and I'm utterly oom.

We can make sure if this (inactive full of dirty pages) is really the case
with the tracing code.

The shmem fix in 2.4.7-pre5 is the solution for your problem ?
 
If not, I'll port the tracing code to the pre5 and hopefully we can
actually figure out what is going on here. 

