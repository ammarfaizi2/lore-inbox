Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268510AbRGXXIu>; Tue, 24 Jul 2001 19:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268509AbRGXXIl>; Tue, 24 Jul 2001 19:08:41 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:776 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268508AbRGXXI2>; Tue, 24 Jul 2001 19:08:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 00:41:12 +0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>, Ben LaHaise <bcrl@redhat.com>,
        Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.LNX.4.33L.0107241903410.20326-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0107241903410.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01072500411205.00520@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wednesday 25 July 2001 00:05, Rik van Riel wrote:
> On Tue, 24 Jul 2001, Marcelo Tosatti wrote:
> > On Tue, 24 Jul 2001, Daniel Phillips wrote:
> > > Today's patch tackles the use-once problem, that is, the problem
> > > of
> >
> > Well, as I see the patch should remove the problem where
> > drop_behind() deactivates pages of a readahead window even if
> > some of those pages are not "used-once" pages, right ?
> >
> > I just want to make sure the performance improvements you're
> > seeing caused by the fix of this _particular_ problem.
>
> Fully agreed.
>
> Especially since it was a one-liner change from worse
> performance to better performance (IIRC) it would be
> nice to see exactly WHY the system behaves the way it
> does.  ;)

Oh, it wasn't an accident, I knew what I was trying to achieve.
It's just that I didn't immediately understand all the curlicues in
the page life cycles just from staring at the code.  I had to see
the machine moving first.  It was very instructive to see what
happened on reverting to a fifo strategy.  It might even be a good
idea to put a proc hook in there to allow on-the-fly dumbing down
of the lru machinery.  That way we can measure system behaviour
against a baseline without having to go through the
compile-reboot-bench cycle every time, which eats a major amount
of time.

> Reading a bunch of 2Q, LRU/k, ... papers and thinking
> about the problem very carefully should help us a bit
> in this.  Lots of researches have already looked into
> this particular problem in quite a lot of detail.

Yep, unfortunately the subject of memory management in operating
systems seems to have received a lot less attention than memory
management in databases.

--
Daniel
