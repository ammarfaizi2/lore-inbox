Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132216AbRAQEtH>; Tue, 16 Jan 2001 23:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132316AbRAQEs5>; Tue, 16 Jan 2001 23:48:57 -0500
Received: from [129.94.172.186] ([129.94.172.186]:10737 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S132216AbRAQEsq>; Tue, 16 Jan 2001 23:48:46 -0500
Date: Wed, 17 Jan 2001 15:48:39 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Subtle MM bug
In-Reply-To: <87y9wlh4a7.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.31.0101171546130.5464-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jan 2001, Zlatko Calusic wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
>
> > Now if 2.4 has worse _performance_ than 2.2 due to one
> > reason or another, that I'd like to hear about ;)
> >
>
> Oh, well, it seems that I was wrong. :)
>
> First test: hogmem 180 5 = allocate 180MB and dirty it 5 times (on a
> 192MB machine)
>
> kernel | swap usage | speed
> -------------------------------
> 2.2.17 |  48 MB     | 11.8 MB/s
> -------------------------------
> 2.4.0  | 206 MB     | 11.1 MB/s
> -------------------------------
>
> So 2.2 is only marginally faster. Also it can be seen that 2.4
> uses 4 times more swap space. If Linus says it's ok... :)

I have been working on some changes to page_launder() which
might just fix this problem. Quick and dirty patches are on
my home page and I'll try to clean things up and make something
correct & clean later today or tomorrow ;)

> Second test: kernel compile make -j32 (empirically this puts the
> VM under load, but not excessively!)
>
> 2.2.17 -> make -j32  392.49s user 47.87s system 168% cpu 4:21.13 total
> 2.4.0  -> make -j32  389.59s user 31.29s system 182% cpu 3:50.24 total
>
> Now, is this great news or what, 2.4.0 is definitely faster.

One problem is that these tasks may be waiting on kswapd when
kswapd might not get scheduled in on time. On the one hand this
will mean lower load and less thrashing, on the other hand it
means more IO wait.

This is another area where we may be able to improve some things.

(btw, according to Alan the 2.4 kernel is the first one to break
the 1.2 kernel compiling speed record on an 8MB machine he has ;))

cheers,

Rik  (stuck in australia on a conference)
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
