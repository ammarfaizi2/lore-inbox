Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311079AbSCHUmX>; Fri, 8 Mar 2002 15:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311091AbSCHUmS>; Fri, 8 Mar 2002 15:42:18 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46788 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S311079AbSCHUmK>;
	Fri, 8 Mar 2002 15:42:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Fri, 8 Mar 2002 15:29:28 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203081109390.2749-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203081109390.2749-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020308202836.7D8163FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 March 2002 02:22 pm, Linus Torvalds wrote:
> On Fri, 8 Mar 2002, Hubertus Franke wrote:
> > Could you also comment on the functionality that has been discussed.
>
> First off, I have to say that I really like the current patch by Rusty.
> The hashing approach is very clean, and it all seems quite good. As to
>
Agreed, Rusty did a marvelous job pulling all the right thinks together
and adding the hashing.

> specific points:
> > (I) the fairness issues that have been raised.
> >     do you support two wakeup mechanism: FUTEX_UP and FUTEX_UP_FAIR
> >     or you don't care about fairness and starvation
>
> I don't think fairness and starvation is that big of a deal for
> semaphores, usually being unfair in these things tends to just improve
> performance through better cache locality with no real downside. That
> said, I think the option should be open (which it does seem to be).
>
Yip, I'd prefer to leave it up to the user on what one exactly wants
fair or non-fair wakeup.

> For rwlocks, my personal preference is the fifo-fair-preference (unlike
> semaphore fairness, I have actually seen loads where read- vs
> write-preference really is unacceptable). This might be a point where we
> give users the choice.
>
> I do think we should make the lock bigger - I worry that atomic_t simply
> won't be enough for things like fair rwlocks, which might want a
> "cmpxchg8b" on x86.
>

But what about compatibility with i368, no cmpxchg or cmpxchg8b
Can't we have to types and infer from the op in the kernel what 
the correct size in user space is.

> So I would suggest making the size (and thus alignment check) of locks at
> least 8 bytes (and preferably 16). That makes it slightly harder to put
> locks on the stack, but gcc does support stack alignment, even if the code
> sucks right now.
>
> 		Linus

Keeping it small, allows for the common case of mutex integration into data
objects, though its not a big deal.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
