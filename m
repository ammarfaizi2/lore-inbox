Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280088AbRKEBHC>; Sun, 4 Nov 2001 20:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280086AbRKEBGw>; Sun, 4 Nov 2001 20:06:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11788 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280089AbRKEBGm>; Sun, 4 Nov 2001 20:06:42 -0500
Date: Sun, 4 Nov 2001 17:03:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM: qsbench numbers
In-Reply-To: <3.0.6.32.20011104221747.01ff8d30@pop.tiscalinet.it>
Message-ID: <Pine.LNX.4.33.0111041657060.14237-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 Nov 2001, Lorenzo Allegrucci wrote:
> >
> >Does "free" after a run has completed imply that there's still lots of
> >swap used? We _should_ have gotten rid of it at "free_swap_and_cache()"
> >time, but if we missed it..
>
> 70.590u 7.640s 2:31.06 51.7%    0+0k 0+0io 19036pf+0w
> lenstra:~/src/qsort> free
>              total       used       free     shared    buffers     cached
> Mem:        255984       6008     249976          0        100       1096
> -/+ buffers/cache:       4812     251172
> Swap:       195512       5080     190432

That's not a noticeable amount, and is perfectly explainable by simply
having deamons that got swapped out with truly inactive pages. So a
swapcache leak does not seem to be the reason for the unstable numbers.

> >What happens if you make the "vm_swap_full()" define in <linux/swap.h> be
> >unconditionally defined to "1"?
>
> 70.530u 7.290s 2:33.26 50.7%    0+0k 0+0io 19689pf+0w
> 70.830u 7.100s 2:29.52 52.1%    0+0k 0+0io 18488pf+0w
> 70.560u 6.840s 2:28.66 52.0%    0+0k 0+0io 18203pf+0w
>
> Performace improved and numbers stabilized.

Indeed.

Mind doing some more tests? In particular, the "vm_swap_full()" macro is
only used in two places: mm/memory.c and mm/swapfile.c. Are you willing to
test _which_ one (or is it both together) it is that seems to bring on the
unstable numbers?

		Linus

