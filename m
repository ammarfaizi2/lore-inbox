Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRGYRl6>; Wed, 25 Jul 2001 13:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268598AbRGYRls>; Wed, 25 Jul 2001 13:41:48 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:40209 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267196AbRGYRlb>; Wed, 25 Jul 2001 13:41:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 19:46:01 +0200
X-Mailer: KMail [version 1.2]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.LNX.4.33L.0107251340550.20326-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0107251340550.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <0107251946010C.00907@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wednesday 25 July 2001 18:41, Rik van Riel wrote:
> On Wed, 25 Jul 2001, Daniel Phillips wrote:
> > On Wednesday 25 July 2001 08:33, Marcelo Tosatti wrote:
> > > Now I'm not sure why directly adding swapcache pages to the
> > > inactive dirty lits with 0 zero age improves things.
> >
> > Because it moves the page rapidly down the inactive queue towards
> > the ->writepage instead of leaving it floating around on the active
> > ring waiting to be noticed.  We already know we want to evict that
> > page,
>
> We don't.
>
> The page gets unmapped and added to the swap cache the first
> time it wasn't referenced by the process.
>
> This is before any page aging is done.

True, it's more accurate to say that we already know we want to *try* 
evicting that page.  A wrong guess should not make it all the way down 
the inactive queue.

--
Daniel
