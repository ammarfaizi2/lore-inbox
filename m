Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277951AbRJRUGM>; Thu, 18 Oct 2001 16:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277942AbRJRUGA>; Thu, 18 Oct 2001 16:06:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:29202 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277894AbRJRUFJ>;
	Thu, 18 Oct 2001 16:05:09 -0400
Date: Thu, 18 Oct 2001 18:05:30 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fork() failing
In-Reply-To: <Pine.LNX.4.21.0110181633270.12429-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0110181803540.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, Marcelo Tosatti wrote:

> Imagine people changing the point where the
>
> 	if ((gfp_mask & __GFP_FAIL))
> 		return;
>
> check is done (inside the freeing routines).
>
> I would like to have a _defined_ meaning for a "fail easily" allocation,
> and a simple unique __GFP_FAIL flag can't give us that IMO.

Actually, I guess we could define this to be the same point
where we'd end up freeing memory in order to satisfy our
allocation.

This would result in __GFP_FAIL meaning "give me memory if
it's available, but don't waste time freeing memory if we
don't have enough free memory now".

Space-wise these semantics could change (say, pages_low
vs. pages_min), but they'll stay the same when you look at
"how hard to try" or "how much effort to spend".

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

