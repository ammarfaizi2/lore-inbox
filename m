Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264522AbRFJMAr>; Sun, 10 Jun 2001 08:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264523AbRFJMA1>; Sun, 10 Jun 2001 08:00:27 -0400
Received: from t2.redhat.com ([199.183.24.243]:19194 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264522AbRFJMAQ>; Sun, 10 Jun 2001 08:00:16 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <m1593mW-001RQEC@mozart> 
In-Reply-To: <m1593mW-001RQEC@mozart> 
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Dawson Engler <engler@csl.Stanford.EDU>
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Jun 2001 12:59:29 +0100
Message-ID: <20904.992174369@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rusty@rustcorp.com.au said:
> In message <19317.992115181@redhat.com> you write:
> > torvalds@transmeta.com said:
> > >  Good point. Spinlocks (with the exception of read-read locks, of
> > > course) and semaphores will deadlock on recursive use, while the BKL
> > > has this "process usage counter" recursion protection.
> > 
> > Obtaining a read lock twice can deadlock too, can't it
> > Or do we not make new readers sleep if there's a writer waiting?
>
> We can never[1] make new readers sleep if there's a writer waiting, as
> Linus guaranteed that an IRQ handler which only ever grabs a read lock
> means the rest of the code doesn't need to block interrupts on its
> read locks (see Documentation/spinlock.txt IIRC).

You're right. Despite the fact that upon closer examination it's obvious
that Linus was only referring to rw-spinlocks as safe, I was actually
thinking of rw-semaphores. 

--
dwmw2


