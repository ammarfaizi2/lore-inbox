Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132772AbRDURni>; Sat, 21 Apr 2001 13:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132771AbRDURn2>; Sat, 21 Apr 2001 13:43:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:6159 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132772AbRDURnO>; Sat, 21 Apr 2001 13:43:14 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: try_to_swap_out() deactivating pages w. count > 2
Date: 21 Apr 2001 10:42:57 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9bsgr1$hcd$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0104211741020.346-100000@mikeg.weiden.de> <Pine.LNX.4.21.0104211336390.1685-100000@imladris.rielhome.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0104211336390.1685-100000@imladris.rielhome.conectiva>,
Rik van Riel  <riel@conectiva.com.br> wrote:
>
>What I _am_ worried about is the fact that we do this to pages with
>a really high page age. These things are in active use and cannot
>be swapped out any time soon, yet we do claim swap space for it ...

Ehh... And if we didn't do that, then how could they every become less
active?

We should _absolutely_ do the swap space reclaiming without looking at
the page count. If we don't, you will never free those pages, and I have
a trivial exploit for you that will basically mlock all pages in memory.

try_to_swap_out() _absolutely_ does the right thing.  Also note how it
will need to allocate the swap space backing store only once. 

		Linus
