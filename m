Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136138AbRD0RkC>; Fri, 27 Apr 2001 13:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136139AbRD0Rj4>; Fri, 27 Apr 2001 13:39:56 -0400
Received: from www.wen-online.de ([212.223.88.39]:55824 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S136138AbRD0Rjb>;
	Fri, 27 Apr 2001 13:39:31 -0400
Date: Fri, 27 Apr 2001 19:38:34 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104260526020.2416-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0104271930070.225-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Linus Torvalds wrote:

> Have you looked at "free_pte()"? I don't like that function, and it might
> make a difference. There are several small nits with it:

snip

> I _think_ the logic should be something along the lines of: "freeing the
> page amounts to a implied down-aging of the page, but the 'accessed' bit
> would have aged it up, so the two take each other out". But if so, the
> free_pte() logic should have something like
>
> 	if (page->mapping) {
> 		if (!pte_young(pte) || PageSwapCache(page))
> 			age_page_down_ageonly(page);
> 		if (!page->age)
> 			deactivate_page(page);
> 	}

Hi,

I tried this out today after some more reading.

virgin pre7 +Rik
real    11m44.088s
user    7m57.720s
sys     0m36.420s

+Rik +Linus
real    11m48.597s
user    7m55.620s
sys     0m37.860s

+Rik +Linus +HarshAging
real    11m17.758s
user    7m57.650s
sys     0m36.350s

None of them make much difference.

	-Mike

