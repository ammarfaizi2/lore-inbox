Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135358AbRAGWdj>; Sun, 7 Jan 2001 17:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135493AbRAGWda>; Sun, 7 Jan 2001 17:33:30 -0500
Received: from inje.iskon.hr ([213.191.128.16]:11023 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S135358AbRAGWdM>;
	Sun, 7 Jan 2001 17:33:12 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.21.0101071919120.21675-100000@duckman.distro.conectiva>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 07 Jan 2001 23:33:08 +0100
In-Reply-To: Rik van Riel's message of "Sun, 7 Jan 2001 19:37:06 -0200 (BRDT)"
Message-ID: <87u27b3sd7.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 7 Jan 2001, Zlatko Calusic wrote:
> 
> > Things go berzerk if you have one big process whose working set
> > is around your physical memory size.
> 
> "go berzerk" in what way?  Does the system cause lots of extra
> swap IO and does it make the system thrash where 2.2 didn't
> even touch the disk ?
>

Well, I think yes. I'll do some testing on the 2.2 before I can tell
you for sure, but definitely the system is behaving badly where I
think it should not.

> > Final effect is that physical memory gets extremely flooded with
> > the swap cache pages and at the same time the system absorbs
> > ridiculous amount of the swap space.
> 
> This is mostly because Linux 2.4 keeps dirty pages in the
> swap cache. Under Linux 2.2 a page would be deleted from the
> swap cache when a program writes to it, but in Linux 2.4 it
> can stay in the swap cache.
>

OK, I can buy that.

> Oh, and don't forget that pages in the swap cache can also
> be resident in the process, so it's not like the swap cache
> is "eating into" the process' RSS ;)
>

So far so good... A little bit weird but not alarming per se.

> > For instance on my 192MB configuration, firing up the hogmem
> > program which allocates let's say 170MB of memory and dirties it
> > leads to 215MB of swap used.
> 
> So that's 170MB of swap space for hogmem and 45MB for
> the other things in the system (daemons, X, ...).
>

Yes, that's it. So it looks like all of my processes are on the
swap. That can't be good. I mean, even Solaris (known to eat swap
space like there's no tomorrow :)) would probably be more polite.

> Sounds pretty ok, except maybe for the fact that now
> Linux allocates (not uses!) a lot more swap space then
> before and some people may need to add some swap space
> to their system ...
>

Yes, I would say really a lot more. Big diffeence.

Also, I don't see a diference between allocated and used swap space on
the Linux. Could you elaborate on that?

> 
> Now if 2.4 has worse _performance_ than 2.2 due to one
> reason or another, that I'd like to hear about ;)
> 

I'll get back to you later with more data. Time to boot 2.2. :)
-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
