Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbRGQBdj>; Mon, 16 Jul 2001 21:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267747AbRGQBd3>; Mon, 16 Jul 2001 21:33:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7442 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267405AbRGQBdK>; Mon, 16 Jul 2001 21:33:10 -0400
Date: Mon, 16 Jul 2001 21:01:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Kanoj Sarcar <kanojsarcar@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>,
        Dirk Wetter <dirkw@rentec.com>, Mike Galbraith <mikeg@wen-online.de>,
        linux-mm@kvack.org, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] Separate global/perzone inactive/free shortage 
In-Reply-To: <20010716155126.37887.qmail@web14306.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0107162059060.6679-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Jul 2001, Kanoj Sarcar wrote:

> 
> --- Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> > Hi,
> > 
> > As well known, the VM does not make a distiction
> > between global and
> > per-zone shortages when trying to free memory. That
> > means if only a given
> > memory zone is under shortage, the kernel will scan
> > pages from all zones. 
> > 
> > The following patch (against 2.4.6-ac2), changes the
> > kernel behaviour to
> > avoid freeing pages from zones which do not have an
> > inactive and/or
> > free shortage.
> > 
> > Now I'm able to run memory hogs allocating 4GB of
> > memory (on 4GB machine)
> > without getting real long hangs on my ssh session.
> > (which used to happen
> > on stock -ac2 due to exhaustion of DMA pages for
> > networking).
> > 
> > Comments ? 
> > 
> > Dirk, Can you please try the patch and tell us if it
> > fixes your problem ? 
> > 
> > 
> 
> Just a quick note. A per-zone page reclamation
> method like this was what I had advocated and sent
> patches to Linus for in the 2.3.43 time frame or so.
> I think later performance work ripped out that work.
> I guess the problem is that a lot of the different
> page reclamation schemes first of all do not know
> how to reclaim pages for a specific zone, and secondly
> have to go thru a lot of work before they discover the
> page they are trying to reclaim does not belong to the
> shortage zone, hence wasting a lot of work/cputime.
> try_to_swap_out is a good example, which can be solved
> by rmaps. 

Oh sure, rmaps would fix the performance problem caused by this. But I we
dont have rmaps right now, and I doubt we want rmaps for 2.4.

Besides, the performance degradation of doing the perzone
aging/deactivation this way is nothing compared to _not_ doing the thing
on a perzone basis at all, IMHO.

