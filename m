Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131098AbRAGVMM>; Sun, 7 Jan 2001 16:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130573AbRAGVMC>; Sun, 7 Jan 2001 16:12:02 -0500
Received: from magla.iskon.hr ([213.191.128.32]:520 "EHLO magla.iskon.hr")
	by vger.kernel.org with ESMTP id <S130615AbRAGVLx>;
	Sun, 7 Jan 2001 16:11:53 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] mm-cleanup-1 (2.4.0)
In-Reply-To: <Pine.LNX.4.21.0101071701250.4416-100000@freak.distro.conectiva>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 07 Jan 2001 22:11:45 +0100
In-Reply-To: Marcelo Tosatti's message of "Sun, 7 Jan 2001 17:07:59 -0200 (BRST)"
Message-ID: <dnitnrcbji.fsf@magla.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Notus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> On 7 Jan 2001, Zlatko Calusic wrote:
> 
> > The following patch cleans up some obsolete structures from the mm &
> > proc code.
> > 
> > Beside that it also fixes what I think is a bug:
> > 
> >         if ((rw == WRITE) && atomic_read(&nr_async_pages) >
> >                        pager_daemon.swap_cluster * (1 << page_cluster))
> > 
> > In that (swapout logic) it effectively says swap out 512KB at once (at
> > least on my memory configuration). I think that is a little too much.
> > I modified it to be a little bit more conservative and send only
> > (1 << page_cluster) to the swap at a time. Same applies to the
> > swapin_readahead() function. Comments welcome.
> 
> 512kb is the maximum limit for in-flight swap pages, not the cluster size 
> for IO. 
> 
> swapin_readahead actually sends requests of (1 << page_cluster) to disk
> at each run.
>  

OK, maybe I was too fast in concluding with that change. I'm still
trying to find out why is MM working bad in some circumstances (see my
other email to the list).

Anyway, I would than suggest to introduce another /proc entry and call
it appropriately: max_async_pages. Because that is what we care about,
anyway. I'll send another patch.
-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
