Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbRFGVGA>; Thu, 7 Jun 2001 17:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263159AbRFGVFu>; Thu, 7 Jun 2001 17:05:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:11282 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263160AbRFGVFk>; Thu, 7 Jun 2001 17:05:40 -0400
Date: Thu, 7 Jun 2001 16:30:08 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Background scanning change on 2.4.6-pre1
In-Reply-To: <Pine.LNX.4.21.0106071345190.6604-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0106071618580.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Linus Torvalds wrote:

> 
> Forgot one comment..
> 
> > > This is going to make all pages have age 0 on an idle system after some
> > > time (the old code from Rik which has been replaced by this code tried to 
> > > avoid that)
> 
> There's another reason why I think the patch may be ok even without any
> added logic: not only does it simplify the code and remove a illogical
> heuristic, but there is nothing that really says that "age 0" is
> necessarily very bad.
> 
> We should strive to keep the active/inactive lists in LRU order anyway, so
> the ordering does tell you something about how recent (and thus how
> important) the page is. Also, it's certainly MUCH preferable to let pages
> age down to zero, than to let pages retain a maximum age over a long time,
> like the old code used to do.
> 
> If, after long periods of inactivity, we start needing fresh pages again,
> it's probably actually an _advantage_ to give the new pages a higher
> relative importance. Caches tend to lose their usefulness over time, and
> if the old cached pages are really relevant, then the new spurt of usage
> will obviously mark them young again.
> 
> And if, after the idle time, the behaviour is different, the old pages
> have appropriately been aged down and won't stand in the way of a new
> cache footprint.
> 
> Do you actually have regular usage that shows the age-down to be a bad
> thing? 

Fill the active list of cache and wait for a while to get the inactive
list full.

When that happens and pressure begins, refill_inactive_scan() from
try_to_free_pages() will not be called because the inactive list is full
(the kernel "thinks" we dont have an inactive shortage). Well, not sure if
this is a bad thing in the end. 

