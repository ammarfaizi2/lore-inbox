Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLTSW2>; Wed, 20 Dec 2000 13:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbQLTSWS>; Wed, 20 Dec 2000 13:22:18 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:27379 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129340AbQLTSWF>; Wed, 20 Dec 2000 13:22:05 -0500
Date: Wed, 20 Dec 2000 15:48:06 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre2
In-Reply-To: <20001220162456.G7381@athlon.random>
Message-ID: <Pine.LNX.4.21.0012201543010.1613-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Andrea Arcangeli wrote:
> On Thu, Dec 21, 2000 at 01:57:15AM +1100, Andrew Morton wrote:
> > If a task is on two waitqueues at the same time it becomes a bug:
> > if the outer waitqueue is non-exclusive and the inner is exclusive,
> 
> Your 2.2.x won't allow that either. You set the
> `current->task_exclusive = 1' and so you will get an exclusive
> wakeups in both waitqueues. You simply cannot tell register in
> two waitqueue and expect a non-exlusive wakeup in one and an
> exclusive wakeup in the other one.

Why not?  Having a wake-all wakeup on one event and a
wake-one wakeup on another kind of event seems perfectly
reasonable to me at a first glance. Is there something
I've overlooked ?

> > Anyway, it's academic.  davem would prefer that we do it properly
> > and move the `exclusive' flag into the waitqueue head to avoid the 
> > task-on-two-waitqueues problem, as was done in 2.4.  I think he's
> 
> The fact you could mix non-exclusive and exlusive wakeups in the
> same waitqueue was a feature not a misfeature. Then of course
> you cannot register in two waitqueues one with wake-one and one
> with wake-all but who does that anyways?

The "who does that anyways" argument could also be said about
mixing exclusive and non-exclusive wakeups in the same waitqueue.
Doing this seems rather confusing ... would you know any application
which needs this ?

> I think the real reason for spearating the two things as davem
> proposed is because otherwise we cannot register for a LIFO
> wake-one in O(1) as we needed for accept.

Do you have any reason to assume Davem and Linus lied about
why they changed the semantics? ;)  I'm pretty sure the reason
why Linus and Davem changed the semantics is the same reason
they mailed to this list ... ;)


I think it would be good to have the same semantics in 2.2 as
we have in 2.4. Using different semantics will probably only
lead to confusion. If there is a good reason to go with the
semantics Andrea proposed over the semantics Linus and Davem
have in 2.4, we should probably either change 2.4 or use the
2.4 semantics in 2.2 anyway just to avoid the confusion...

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
