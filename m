Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268564AbRGYM5q>; Wed, 25 Jul 2001 08:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268565AbRGYM5g>; Wed, 25 Jul 2001 08:57:36 -0400
Received: from inway98.cdi.cz ([213.151.81.98]:5621 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S268564AbRGYM5X>;
	Wed, 25 Jul 2001 08:57:23 -0400
Posted-Date: Wed, 25 Jul 2001 14:57:27 +0200
Date: Wed, 25 Jul 2001 14:57:27 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <E15PJuY-0000A3-00@wintermute>
Message-ID: <Pine.LNX.4.10.10107251426540.4963-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

I read whole this thread and it started to interest me.

If I understood the code correctly, the used bit on ptes
is tested once per 64 second (for particular page) from
kswapd or more often under mem pressure and only for
pages on active list. Correct ?

Would it be possible to do cost-based eviction of pages ?
Like to compute cost for each page periodically (with variable
period - resort page to finner-period list when u bit was set for 
too long) and resort page into hash bucket with key equal to 
the cost (cost would be in moderate integer range).

Then you can simply evict pages from lowest hash bucket list
and move them to free list (after cleaning them).

It would allow developers to modify and test various cost
schemas including LRU,LRU/2,aging ... with simple change
of cost function.

I tried to create statistical model of page eviction and after
some simplify it seems that cost c = (Tw-t)^2+(Tr-t)^2
where Tr/w is expected time of next page reference/dirtying
based on EWMA averaging could minimize disc activity during
page eviction.

I wanted to try it but I'd like to know opinions of others.
Probably someone have got similar idea ..
Maybe it would be so expensive ..
fill other "maybe" here .. :-)

devik

