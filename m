Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271657AbRICJ6j>; Mon, 3 Sep 2001 05:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271658AbRICJ6a>; Mon, 3 Sep 2001 05:58:30 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:9484 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271657AbRICJ6P>;
	Mon, 3 Sep 2001 05:58:15 -0400
Date: Mon, 3 Sep 2001 06:58:12 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Samium Gromoff <_deepfire@mail.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: Rik`s ac12-pmap2 vs ac12-vanilla perfcomp
In-Reply-To: <20010902165742Z16375-32383+3005@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109030641320.10545-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Sep 2001, Daniel Phillips wrote:

> It's nice to see these tests aren't running any slower (and not
> crashing!) but as I understand it, reverse mapping is a win only for
> shared mmaps and swapping, which you aren't doing.  So it's not clear
> what effect is being measured.

For one, with this thing we can actually "see" the referenced
bits in the page tables from refill_inactive(), so page aging
could potentially be better.

Samium's numbers, showing how much better, were a tad surprising
to me too, though ;)

> One thing that goes away with rmaps is the need to scan process page
> tables. It's possible that this takes enough load off L1 cache to
> produce the effects you showed, though it would be surprising.

CPU overhead seems to be a bit lower in the tests I ran, where
"a bit" should mostly be significant in the case of many shared
pages.

The real savings should be better pageout selection and lots of
flexibility to do interesting things, though.

> (Note that I'm in the "reverse maps are good" camp, and I think Rik's
> design is fundamentally correct.)

Btw, I just released a new version of the patch, which:
- moves page_remove_pmap() one line down in mremap(), so it
  works now ;)
- starts making the reverse mapping patch SMP safe, removing
  try_to_swap_out() and replacing it by allocate_swap_space()
  and try_to_unmap()
- move architecture-specific magic to <asm/pmap.h> so it's now
  easy to port to other architectures  (yes, this stuff is all
  documented)

	http://www.surriel.com/patches/2.4/2.4.8-ac12-pmap3

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

