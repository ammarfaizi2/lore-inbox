Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292325AbSBBQxK>; Sat, 2 Feb 2002 11:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292324AbSBBQxC>; Sat, 2 Feb 2002 11:53:02 -0500
Received: from mustard.heime.net ([194.234.65.222]:52908 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S292323AbSBBQwo>; Sat, 2 Feb 2002 11:52:44 -0500
Date: Sat, 2 Feb 2002 17:52:32 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Roger Larsson <roger.larsson@norran.net>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Errors in the VM - detailed (or is it Tux? or rmap? or those
 together...)
In-Reply-To: <Pine.LNX.4.30.0202021736520.11143-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.30.0202021751430.11143-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Roy, did you notice the mail from Andrew Morton:
> > > heh.  Yep, Roger finally nailed it, I think.
> > >
> > > Roy says the bug was fixed in rmap11c.  Changelog says:
> > >
> > >
> > > rmap 11c:
> > >   ...
> > >   - elevator improvement                                  (Andrew Morton)
> > >
> > > Which includes:
> > >
> > > -       queue_nr_requests = 64;
> > > -       if (total_ram > MB(32))
> > > -               queue_nr_requests = 128;
> > >                              +       queue_nr_requests = (total_ram >> 9) &
> > > ~15;     /* One per half-megabyte */
> > > +       if (queue_nr_requests < 32)
> > > +               queue_nr_requests = 32;
> > > +       if (queue_nr_requests > 1024)
> > > +               queue_nr_requests = 1024;
> >
> > rmap11c changed the queue_nr_requests, that problem went away.
> > But another one showed its ugly head...
> >
> > Could you please try this part of rmap11c only? Or the very simple one
> > setting queue_nr_request to = 2048 for a test drive...
>
> u mean - on a 2.4.1[18](-pre.)? kernel?
>
> I'll try

er..

# grep queue_nr_requests /usr/src/packed/k/2.4.17-rmap-11c
#


---
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

