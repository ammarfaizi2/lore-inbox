Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQJ3QjN>; Mon, 30 Oct 2000 11:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbQJ3QjD>; Mon, 30 Oct 2000 11:39:03 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:54003 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129044AbQJ3Qiy>; Mon, 30 Oct 2000 11:38:54 -0500
Date: Mon, 30 Oct 2000 14:36:39 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andi Kleen <ak@suse.de>, dean gaudet <dean-list-linux-kernel@arctic.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>, kumon@flab.fujitsu.co.jp,
        Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        linux-kernel@vger.kernel.org, Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was:
In-Reply-To: <20001030162815.B21935@athlon.random>
Message-ID: <Pine.LNX.4.21.0010301435050.16609-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000, Andrea Arcangeli wrote:
> On Mon, Oct 30, 2000 at 07:29:51AM +0100, Andi Kleen wrote:
> > It should not be needed anymore for 2.4, because the accept() wakeup has been
> > fixed.
> 
> Certainly sleeping in accept will be just way better than file any locking.
> 
> OTOH accept() is still _wrong_ as it wake-one FIFO while it
> should wake-one LIFO (so that we optimize the cache usage skip
> TLB flushes and allow the redundand tasks to be paged out). I
> can only see cons in doing FIFO wake-one.

LIFO wakeup is indeed the way to go for things like accept().

For stuff like ___wait_on_page(), OTOH, you really want FIFO
wakeup to avoid starvation (yes, I know we're currently doing
wake_all in ___wait_on_page ;))...

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
