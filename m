Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132776AbRDURtT>; Sat, 21 Apr 2001 13:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132777AbRDURtJ>; Sat, 21 Apr 2001 13:49:09 -0400
Received: from www.wen-online.de ([212.223.88.39]:22795 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132776AbRDURs6>;
	Sat, 21 Apr 2001 13:48:58 -0400
Date: Sat, 21 Apr 2001 19:48:25 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: try_to_swap_out() deactivating pages w. count > 2
In-Reply-To: <Pine.LNX.4.21.0104211336390.1685-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0104211925170.327-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Rik van Riel wrote:

> On Sat, 21 Apr 2001, Mike Galbraith wrote:
>
> > 30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:29 count:164 [164? 1]
> > 30:04: [pid-4] page:c10599a8 deact:0 cache:0 age:26 count:164
>
> > 1.  what kind of page has 164 references?
>
> mmap(/lib/libc.so, FLAGS);

I figured that out too in the meantime.  (14hrs at a stretch makes
more than eyeballs bleary..)

> > 2.  why deactivate pages (lots) with count > 2?  PINGpong.
>
> They're not deactivated, they're removed from this proces' virtual
> memory mapping.

blush.. yup.

> What I _am_ worried about is the fact that we do this to pages with
> a really high page age. These things are in active use and cannot
> be swapped out any time soon, yet we do claim swap space for it ...

I'll see if it makes any noticable difference tomorrow.  Enough
fruitless effort for one day.

:) Am I likely to learn more about how swapcache works when I try
to instantly donate these to page_launder() tomorrow morning?

[4] mm:c2ce9f00 page:c1001060 deact:0 cache:1 buf:0 age:5 cnt:1
[2285] mm:c67ef760 page:c1002b18 deact:0 cache:1 buf:0 age:5 cnt:1

	-Mike

