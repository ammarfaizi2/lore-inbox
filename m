Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbRGRXAy>; Wed, 18 Jul 2001 19:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264096AbRGRXAo>; Wed, 18 Jul 2001 19:00:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:25613 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263960AbRGRXAf>; Wed, 18 Jul 2001 19:00:35 -0400
Date: Wed, 18 Jul 2001 15:59:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch
In-Reply-To: <0107190057100H.12129@starship>
Message-ID: <Pine.LNX.4.33.0107181555181.1237-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Jul 2001, Daniel Phillips wrote:
>
> I don't really see much use for inactive_shortage_total() by itself,
> except maybe deciding when to scan vs sitting idle.

Absolutely. But that's an important decision in itself. Getting that
decision wrong means that we either scan too little (and which point the
question of per-zone shortages becomes moot, because by the time we start
scanning we're too deep in trouble to be able to do a good gradual job
anyway). Or we scan too much, and then the per-zone shortage just means
that we'll always have so much inactive stuff in all the zones that we'll
continue scanning forever - because none of the zones (correctly) feel
that they have any reason to actually free anything.

So the global inactive_shortage() decision is certainly an important one:
it should trigger early enough to matter, but not so early that we trigger
it even when most local zones are really totally saturated and we really
shouldn't be scanning at all.

		Linus

