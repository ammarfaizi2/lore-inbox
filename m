Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131257AbRARBcW>; Wed, 17 Jan 2001 20:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131464AbRARBcM>; Wed, 17 Jan 2001 20:32:12 -0500
Received: from [129.94.172.186] ([129.94.172.186]:13297 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131257AbRARBb5>; Wed, 17 Jan 2001 20:31:57 -0500
Date: Thu, 18 Jan 2001 12:32:01 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Subtle MM bug
In-Reply-To: <87wvburowk.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.31.0101181230020.31432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 2001, Zlatko Calusic wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
>
> > > Second test: kernel compile make -j32 (empirically this puts the
> > > VM under load, but not excessively!)
> > >
> > > 2.2.17 -> make -j32  392.49s user 47.87s system 168% cpu 4:21.13 total
> > > 2.4.0  -> make -j32  389.59s user 31.29s system 182% cpu 3:50.24 total
> > >
> > > Now, is this great news or what, 2.4.0 is definitely faster.
> >
> > One problem is that these tasks may be waiting on kswapd when
> > kswapd might not get scheduled in on time. On the one hand this
> > will mean lower load and less thrashing, on the other hand it
> > means more IO wait.
>
> Hm, if all tasks are waiting for memory, what is stopping kswapd
> to run? :)

Suppose you have 8 high-priority tasks waiting on kswapd
and one lower-priority (but still higher than kswapd)
process running and preventing kswapd from doing its work.
Oh .. and also preventing the higher-priority tasks from
being woken up and continuing...


Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
