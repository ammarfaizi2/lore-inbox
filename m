Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267201AbSK3BsP>; Fri, 29 Nov 2002 20:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbSK3BsP>; Fri, 29 Nov 2002 20:48:15 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:2230 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267201AbSK3BsO>; Fri, 29 Nov 2002 20:48:14 -0500
Date: Fri, 29 Nov 2002 23:55:24 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Javier Marcet <jmarcet@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
In-Reply-To: <20021130013832.GF15682@jerry.marcet.dyndns.org>
Message-ID: <Pine.LNX.4.44L.0211292349550.15981-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Nov 2002, Javier Marcet wrote:

> >First, lets get one thing straight:  the problem is the slowness,
> >not necessarily the swap usage.  It is very easy to jump to wrong
>
> OK, you might be right on this point.

> root # vmstat 1
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  0  1 265048   5248  32248 119108    6   15    65    62  252   585 21  6 73  0
>  1  6 266648   4480  32316 120300    0 4656  2152  4652 1348   821 13  8 79  0
>  1  0 265052   4496  31036 120184    8  336  1668   340 1226   765 15  7 78  0
>  0  1 265052   4496  31112 121564    4    0  3152     0 1198   894 18  8 74  0
>  1  0 265052   4504  31076 123112    0    0  3024  8576 1229   857 17  7 76  0
                                      ^^^^^^^^^^^^^^^^^^^

Looks like my guess was right after all.  The amount of swap
IO is maybe 10% of the amount of filesystem IO in your vmstat
snippet above.

> This is after the system has been in use with a 512MB swap partition for
> around 1 hour. I must say it is barely usable as a desktop, way _far_
> from a responsive environment. looking at the memory numbers it's easy
> to think I need more memory, but with other kernels,

> So yes, you are right that swap usage is not the problem. It seems more
> like memory getting too dirty.

Two things could be happening here:

1) the kernel decides to cache the wrong things in the
   page cache

and/or

2) the IO scheduler is giving worse latencies now

If the problem is (1) it might get resolved by using the -rmap
or -aa kernels.  If the problem is (2) you'll want Andrew Morton's
read_latency patch (which I'll port to 2.4.20 real soon now).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

