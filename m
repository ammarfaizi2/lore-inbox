Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133078AbRAGWU5>; Sun, 7 Jan 2001 17:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135304AbRAGWUs>; Sun, 7 Jan 2001 17:20:48 -0500
Received: from inje.iskon.hr ([213.191.128.16]:46090 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S133078AbRAGWUi>;
	Sun, 7 Jan 2001 17:20:38 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] mm-cleanup-1 (2.4.0)
In-Reply-To: <Pine.LNX.4.21.0101071912570.21675-100000@duckman.distro.conectiva>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 07 Jan 2001 23:20:21 +0100
In-Reply-To: Rik van Riel's message of "Sun, 7 Jan 2001 19:16:47 -0200 (BRDT)"
Message-ID: <877l4757iy.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 7 Jan 2001, Zlatko Calusic wrote:
> 
> > The following patch cleans up some obsolete structures from the
> > mm & proc code.
> > 
> > Beside that it also fixes what I think is a bug:
> > 
> >         if ((rw == WRITE) && atomic_read(&nr_async_pages) >
> >                        pager_daemon.swap_cluster * (1 << page_cluster))
> > 
> > In that (swapout logic) it effectively says swap out 512KB at
> > once (at least on my memory configuration). I think that is a
> > little too much.
> 
> Since we submit a whole cluster of (1 << page_cluster)
> size at once, your change would mean that the VM can
> only do one IO at a time...
> 
> Have you actually measured your changes or is it just
> a gut feeling that the current default is too much?
>

Well, to be honest I didn't find any change after the modification. :)

But, anyway, Marcelo explained to me what's going on and I have
already agreed there is no need to change that. Instead I'll modify my
patch to introduce new /proc entry with meaningful name:
max_async_pages.

> (I can agree with 1/2 MB being a bit much, but doing
> just one IO at a time is probably wrong too...)
>

I can only add that I share your opinion. :)

> 
> The cleanup part of your patch is nice. I think that
> one should be submitted as soon as the 2.4 bugfix
> period is over ...
>

Right.

> (and yes, I'm not submitting any of my own trivial
> patches either unless they're REALLY needed, lets make
> sure Linus has enough time to focus on the real bugfixes)
> 

I'll check your new patch as soon as I have investigated few more
things and got a little more acquainted with the mm code in the
2.4.0. It's a pity I found some free time this late, but then again I
see myself much more involved with the mm code in the future. It's
just that I'll need some help in the start thus so much questions on
the lists. :)
-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
