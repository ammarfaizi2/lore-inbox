Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBJVpJ>; Sat, 10 Feb 2001 16:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbRBJVo6>; Sat, 10 Feb 2001 16:44:58 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:55291 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129027AbRBJVoj>; Sat, 10 Feb 2001 16:44:39 -0500
Date: Sat, 10 Feb 2001 19:44:10 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.Linu.4.10.10102101805380.562-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0102101942550.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001, Mike Galbraith wrote:
> On Sat, 10 Feb 2001, Rik van Riel wrote:
> > On Sat, 10 Feb 2001, Marcelo Tosatti wrote:
> > > On Sat, 10 Feb 2001, Mike Galbraith wrote:
> > > 
> > > > This change makes my box swap madly under load.
> > > 
> > > Swapped out pages were not being counted in the flushing limitation.
> > > 
> > > Could you try the following patch? 
> > 
> > Marcelo's patch should do the trick wrt. to making page_launder()
> > well-behaved again.  It should fix the problems some people have
> > seen with bursty swap behaviour.
> 
> It's still reluctant to shrink cache.  I'm hitting I/O saturation
> at 20 jobs vs 30 with ac5.  (difference seems to be the delta in
> space taken by cache.. ~same space shows as additional swap volume).

Indeed, to "fix" that we'll need to work at refill_inactive().

However, I am very much against tuning the VM for one particular
workload. If you can show me that this problem also happens under
other workloads we can work at changing it, but I don't think it's
right to optimise the VM for a specific workload...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
