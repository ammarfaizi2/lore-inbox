Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289668AbSAJUol>; Thu, 10 Jan 2002 15:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289661AbSAJUoc>; Thu, 10 Jan 2002 15:44:32 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:46845 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S289668AbSAJUoT>; Thu, 10 Jan 2002 15:44:19 -0500
Message-ID: <3C3DFCAB.3D918176@mvista.com>
Date: Thu, 10 Jan 2002 12:42:19 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <20020108114355.GA25718@krispykreme> <Pine.LNX.4.33.0201081533270.7255-100000@localhost.localdomain> <20020109231513.GA10002@krispykreme> <20020109170928.A4365@twiddle.net> <20020110200446.A695@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> 
> On Wed, Jan 09, 2002 at 05:09:28PM -0800, Richard Henderson wrote:
> > Careful.  The following is really quite a bit better on Alpha:
> >
> > static inline int
> > sched_find_first_zero_bit(unsigned long *bitmap)
> > {
> >         unsigned long b0 = bitmap[0];
> >         unsigned long b1 = bitmap[1];
> >         unsigned long b2 = bitmap[2];
> >         unsigned long ofs = MAX_RT_PRIO;
> >
> >         if (unlikely(~(b0 & b1) != 0)) {
> >                 b2 = (~b0 == 0 ? b0 : b1);
> >                 ofs = (~b0 == 0 ? 0 : 64);
> >         }
> >
> >         return ffz(b2) + ofs;
> > }
> 
> True. Minor correction:
> -               b2 = (~b0 == 0 ? b0 : b1);
> -               ofs = (~b0 == 0 ? 0 : 64);
> +               b2 = (~b0 ? b0 : b1);
> +               ofs = (~b0 ? 0 : 64);
> 
> Note that comment for this function is a bit confusing:
>  * ... It's the fastest
>  * way of searching a 168-bit bitmap where the first 128 bits are
>  * unlikely to be set.

What if we want a 2048-bit bitmap???
> 
> s/set/cleared/
> 
> > While we're on the subject of sched_find_first_zero_bit, I'd
> > like to complain about Ingo's choice of header file.  Why in
> > the world did you choose mmu_context.h?  Invent a new asm/sched.h
> > if you must, but please don't choose headers at random.
> 
> Agreed. Apparently asm/bitops.h?
> 
> Ivan.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
