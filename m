Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292320AbSBBQjz>; Sat, 2 Feb 2002 11:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292321AbSBBQjp>; Sat, 2 Feb 2002 11:39:45 -0500
Received: from mustard.heime.net ([194.234.65.222]:48300 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S292320AbSBBQjf>; Sat, 2 Feb 2002 11:39:35 -0500
Date: Sat, 2 Feb 2002 17:39:22 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Roger Larsson <roger.larsson@norran.net>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Errors in the VM - detailed (or is it Tux? or rmap? or those
 together...)
In-Reply-To: <200202021627.g12GRhM12101@mailf.telia.com>
Message-ID: <Pine.LNX.4.30.0202021736520.11143-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How do you know that it gets into this at RAMx2? Have you added 'bi' from
> vmstat?

yes

> One interesting thing to notice from vmstat is...
>
> r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy id
> When performing nicely:
> 0 200  1   1676   3200   3012 786004   0 292 42034   298  791   745   4  29 67
> 0 200  1   1676   3308   3136 785760   0   0 44304     0  748   758   3  15 82
> 0 200  1   1676   3296   3232 785676   0   0 44236     0  756   710   2  23 75
> Later when being slow:
> 0 200  0  3468   3316  4060 784668  0   0  1018    0  613   631   1   2 97
> 0 200  0  3468   3292  4060 784688  0   0  1034    0  617   638   0   3 97
> 0 200  0  3468   3200  4068 784772  0   0  1066    6  694   727   2   4 94
>
> No swap activity (si + so == 0), mostly idle (id > 90).
> So it is waiting - on what??? timer? disk?

I don't know. All I know is that with rmap-11c, it works

> Roy, did you notice the mail from Andrew Morton:
> > heh.  Yep, Roger finally nailed it, I think.
> >
> > Roy says the bug was fixed in rmap11c.  Changelog says:
> >
> >
> > rmap 11c:
> >   ...
> >   - elevator improvement                                  (Andrew Morton)
> >
> > Which includes:
> >
> > -       queue_nr_requests = 64;
> > -       if (total_ram > MB(32))
> > -               queue_nr_requests = 128;
> >                              +       queue_nr_requests = (total_ram >> 9) &
> > ~15;     /* One per half-megabyte */
> > +       if (queue_nr_requests < 32)
> > +               queue_nr_requests = 32;
> > +       if (queue_nr_requests > 1024)
> > +               queue_nr_requests = 1024;
>
> rmap11c changed the queue_nr_requests, that problem went away.
> But another one showed its ugly head...
>
> Could you please try this part of rmap11c only? Or the very simple one
> setting queue_nr_request to = 2048 for a test drive...

u mean - on a 2.4.1[18](-pre.)? kernel?

I'll try

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

