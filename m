Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271192AbRHOOGt>; Wed, 15 Aug 2001 10:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271198AbRHOOGj>; Wed, 15 Aug 2001 10:06:39 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:47884 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S271192AbRHOOG2>; Wed, 15 Aug 2001 10:06:28 -0400
Date: Wed, 15 Aug 2001 17:20:09 +0300 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ivan Kalvatchev <iive@yahoo.com>, kernelbug <linux-kernel@vger.kernel.org>
Subject: Re: DoS tmpfs,ramfs, malloc, saga continues
In-Reply-To: <E15Wl1I-0001ua-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0108151544520.2660-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Aug 2001, Alan Cox wrote:

> If you cant crash windows nt by running out of memory you aren't doing the
> right things.

Alan, although I didn't completely get what patch Ivan refered, 2.4.8
seems to be the far most instable when OOM happens (it just never
survived the 2nd wave of memory stressing for me).

> The basic answer is "Set resource limits". The default ones fit typical

Sure, every experienced user knows that but many people are lazy, busy,
etc to do it properly and most newcomers, desktop users basically don't
want to know about it. Forget distributors setting unreasonable limits
for them, kernel just shouldn't crash in OOM - it could handle it in the
past. This OOM issue wasn't such big problem in the past but recently
it's really getting scary. I've ported the OOM killer to 2.2 and added
reserved root VM support and AFAIR I mentioned only once here, google
indexed the page and people hits it increasingly -- about 10-20 times
more often then OOM problems pop up here. Most of them USER_AGENT
contains the Windows word - and yes, they are explicitely looking for
solution for Linux related OOM problems.

> usage of a system well but not your case. The more complex answer is to
> provide the option for very precise group based resource accounting (aka
> the beancounter patch). That is for those who want to pay the probable 2%
> or so system penalty for being able to precisely manage a system resource
> set. With the beancounter infrastructure you can then get to the point where

It's not ready for use. It was touched last time about one year ago for
2.4.0-test7.

> Somewhere in the middle there is address space accounting, where you never
> allow the total address space to violate

BTW, 2.4 has another feature. vm_enough_memory() in 2.2 underestimated
the available free memory (memory is overcommited anyway) and apps got
more frequently ENOMEM. 2.4 overestimates free memory (because
e.g. nobody knows how much cache could be freed) so apps get killed
mostly by OOM killer.

[ ... non-overcommitting algorithm ...]
> That is much more lightweight and covers all the general cases. However
> nobody wants it much as is evident by the fact nobody has either contributed
> code or paid for the work to be done

In most cases I would definitely agree with this argument but I think in
this case people who have this problem either can't code it themself or
"can't" pay for it - they just expect (unconsciously) Linux can handle
OOM just as good as others or even better.

	Szaka

