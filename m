Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbRBXK25>; Sat, 24 Feb 2001 05:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRBXK2i>; Sat, 24 Feb 2001 05:28:38 -0500
Received: from v25.hebdomag.com ([207.253.212.25]:54022 "EHLO trader-tcp.com")
	by vger.kernel.org with ESMTP id <S129180AbRBXK2d>;
	Sat, 24 Feb 2001 05:28:33 -0500
Message-ID: <3A978DF8.FB1890E@trader.com>
Date: Sat, 24 Feb 2001 11:33:28 +0100
From: Joseph Bueno <joseph.bueno@trader.com>
X-Mailer: Mozilla 4.73 [fr] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM balancing problems under 2.4.2-ac1
In-Reply-To: <Pine.LNX.4.31.0102232120531.8568-100000@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel a écrit :
> 
> On 23 Feb 2001, Adam Sampson wrote:
> 
> > The VM balancing updates in the recent ac kernels seem to have caused
> > some interesting performance problems on my desktop machine. I've got
> > 160Mb of RAM, and 2.4.2-ac1 appears to be using excessively large
> > amounts of it for buffers and cache while pushing stuff out to
> > swap. This means that Mozilla, for instance, runs significantly worse
> > than under 2.4.0, since bits of it are being swapped in and out.
> 
> This is a known problem which I'll fix as soon as I have a
> solution.
> 
> The problem is that we still have no good way to balance
> how much memory we take from the cache and how much memory
> we take from processes.
> 
> This means that for some workloads we'll be evicting too
> much cache while for other workloads we'll be evicting too
> much process pages...
> 
> If anybody as a good idea to make this code auto-balancing,
> please let me know.
> 
> regards,
> 
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
>                 http://www.surriel.com/
> http://www.conectiva.com/       http://distro.conectiva.com.br/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Hi Rik,

I understand that auto-balancing code that deals with all
situations is very hard to design; so let me share my experience
on other Unix systems (from a user/administrator point of view):

I have used Unix systems (mainly HPUX) for several years as personal
workstations or servers and buffer cache usage were very differents:

On workstations, you are mainly looking for fast interactive response
time and  you want to dedicate as much memory as possible to running
processes so limiting buffer cache to 10% of physical memory (these
workstations had typically 32 - 64 Mb of RAM) was good.

On file servers, interactive response time is much less important than
file/network througput. In this case, having 80% of RAM used for buffer
cache is good and you may even want to not let it go below 50% even if
it slows down some batch processes.

Both cases were easily handled by 2 HPUX kernel tunable parameters that
defined minimum and maximum number of pages that could be used by the
buffer cache.
This could be implemented on Linux via /proc. I know it is already done
for minimum limit (in 2.2, I have no experience with 2.4 yet).
I have found some situations where not being able to force a maximum
limit was a problem.

You could argue that with a good load balancing algorithm user
defined limits are useless. Believe me, my experience on HPUX
workstations showed that lowering its max. limit from 50% (default
value) to 10% turned some sluggish machines into speed daemons !

Just my 0.02$
Hope this helps
--
Joseph Bueno
