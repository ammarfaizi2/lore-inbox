Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131101AbQLVE4x>; Thu, 21 Dec 2000 23:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbQLVE4o>; Thu, 21 Dec 2000 23:56:44 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:24389 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131101AbQLVE43>; Thu, 21 Dec 2000 23:56:29 -0500
Date: Thu, 21 Dec 2000 22:26:00 -0600 (CST)
From: Paul Cassella <pwc@sgi.com>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
In-Reply-To: <3A42B353.D0D249C1@innominate.de>
Message-ID: <Pine.LNX.4.21.0012212221220.32526-100000@mindy.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2000, Daniel Phillips wrote:

> But isn't this actually a simple situation?  How about:

I had only adapted that example because it had already been posted showing
one way to do it, and so provided something to compare the sv approach to.

>     dmabuf_alloc(...)
>     {
>             while (1) {
>                     spin_lock(&dmabuf_lock);
>                     attempt to grab a free buffer;
>                     spin_unlock(&dmabuf_lock);
>                     if (success)
>                            return;
>                     down(&dmabuf_wait);
>             }
>     }

>     dmabuf_free(...)
>     {
>             spin_lock(&dmabuf_lock);
>             free up buffer;
>             spin_unlock(&dmabuf_lock);
>             up(&dmabuf_wait);
>     }

This does things a little differently than the way the original did it.  
I thought the original implied that dmabuf_free() might free up multiple
buffers.  There's no indication in the comments that this is the case, but
the original, by using vall_sema(), wakes up all dmabuf_alloc()'s that had
gone to sleep.

The example wasn't meant to be an ideal use of sv's, but merely as an
example of how they could be used to achieve the same behavior as the code
that was posted.

--
Paul Cassella
pwc@sgi.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
