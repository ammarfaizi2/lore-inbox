Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSCHXOj>; Fri, 8 Mar 2002 18:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287421AbSCHXOU>; Fri, 8 Mar 2002 18:14:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:47321 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274862AbSCHXOK>; Fri, 8 Mar 2002 18:14:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Fri, 8 Mar 2002 18:15:02 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203081258070.1412-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203081258070.1412-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020308231405.CADDC3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 March 2002 04:02 pm, Linus Torvalds wrote:
> On Fri, 8 Mar 2002, Hubertus Franke wrote:
> > But what about compatibility with i368, no cmpxchg or cmpxchg8b
> > Can't we have to types and infer from the op in the kernel what
> > the correct size in user space is.
>
> I think the next step should be to map in one page of kernel code in a
> user-readable location, and just do it there.
>

Your kidding .....
Seriously, how can we guarantee that we correctly determine the 
lock holder, due to memory corruption problems. If we can't do 
it correctly all the times, why do it at all ?

> It's not just 386 vs later due to cmpxchg. It's also the simple issue of
> UP vs SMP - a UP system still wants to do locking, but it doesn't need the
> lock prefix. And that lock prefix makes a _huge_ difference
> performance-wise.

Fail to see why that matters. User level locking is mostly beneficial on SMPs.
So, you lock the bus for the atomic update. This is UP, nothing's going on 
on the bus anyway.
In your experience, what is the overhead in cycles for "incl" vs "lock;incl".
Even if its a few more cycles, still beats the heck out of using other 
heavyweight kernel APIs

> So my suggestion is: ignore i386 for now (no _relevant_ SMP boxes exist
> anyway), and plan on solving the problem with a separate library page
> before 2.6.x gets released.
>

Any rough design.. 
> 			Linus

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
