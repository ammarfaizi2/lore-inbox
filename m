Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270387AbRHHH2a>; Wed, 8 Aug 2001 03:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270388AbRHHH2W>; Wed, 8 Aug 2001 03:28:22 -0400
Received: from [63.209.4.196] ([63.209.4.196]:45572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270387AbRHHH2E>; Wed, 8 Aug 2001 03:28:04 -0400
Date: Wed, 8 Aug 2001 00:24:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.21.0108080240250.13133-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0108080020120.923-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Aug 2001, Marcelo Tosatti wrote:
>
> Having "zone->pages_low" as the low water mark to when start kswapd does
> _not_ mean we want "zone->pages_low" as the freetarget (or the "free
> shortage" indicator).

Right. We want the free target to obviously be larger than the low target,
to avoid hysteresis around it.  And at the same time the free target
obviously has to be smaller than the more-than-enough "plenty" case.

So we actually have _three_ numbers, not two.

> Could you be more verbose ?

I already was, our mails crossed. I think the main thing I have decided to
be a "Good Feature (tm)" is to consider the free target to be more of a
global thing, and not a per-zone thing. While the low water mark and
"plenty" mark obviously have to be per-zone decisions.

And we've actually done exactly this - this is how "inactive_target" works
already, and how "global_free_shortage()" ends up working too. We just
didn't write it down explicitly.

		Linus

