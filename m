Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266913AbRGQSxI>; Tue, 17 Jul 2001 14:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266922AbRGQSw6>; Tue, 17 Jul 2001 14:52:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12416 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266913AbRGQSww>; Tue, 17 Jul 2001 14:52:52 -0400
Date: Tue, 17 Jul 2001 14:52:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alex Ivchenko <aivchenko@ueidaq.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6 possible problem
In-Reply-To: <3B54878E.F1CC19FE@ueidaq.com>
Message-ID: <Pine.LNX.3.95.1010717144738.5421A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2001, Alex Ivchenko wrote:

> Well,
> 
> > funct()
> > {
> >     size_t ticks;
> >     wait_queue_head_t wqhead;
> >     init_waitqueue_head(&wqhead);
> > 
> >     ticks = 1 * HZ;        /* For 1 second */
> >     while((ticks = interruptible_sleep_on_timeout(&wqhead, ticks)) > 0)
> >                   ;
> > }
> Well, this works.

Good.

> 
> The question is: should I call init_waitqueue_head() every time I call
> interruptible_sleep_on_timeout() or is it enough to call it once in
> init_module() ?

Just once is fine.

> 
> Another one: should I call wake_up_interruptible() to
> release pending request?

Nope. If you got control back due to the timeout, it's done. You
have been awakened. If somebody else wants to wake up your sleeping
giant (like an interrupt), it calls wake_up_interruptible() with
the pointer to the wait-queue it wants to affect.

> --
> Alex Ivchenko, Ph.D.
> United Electronic Industries, Inc.
> "The High-Performance Alternative (tm)"
> --
> 10 Dexter Avenue
> Watertown, Massachusetts 02472
> Tel: (617) 924-1155 x 222 Fax: (617) 924-1441
> http://www.ueidaq.com
> 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


