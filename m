Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131486AbQKJVnH>; Fri, 10 Nov 2000 16:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130364AbQKJVm5>; Fri, 10 Nov 2000 16:42:57 -0500
Received: from smartmail.smartweb.net ([207.202.14.198]:61202 "EHLO
	smartmail.smartweb.net") by vger.kernel.org with ESMTP
	id <S131859AbQKJVmn>; Fri, 10 Nov 2000 16:42:43 -0500
Message-ID: <3A0C6BD6.A8F73950@dm.ultramaster.com>
Date: Fri, 10 Nov 2000 16:42:46 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Mike Galbraith <mikeg@wen-online.de>, Jens Axboe <axboe@suse.de>,
        MOLNAR Ingo <mingo@chiara.elte.hu>,
        Rik van Riel <H.H.vanRiel@phys.uu.nl>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping 
 process,2.4.0-test10
In-Reply-To: <Pine.LNX.4.10.10011091005390.1909-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
...
> 
> And it has everything to do with the fact that the way Linux semaphores
> are implemented, a non-blocking process has a HUGE advantage over a
> blocking one. Linux kernel semaphores are extreme unfair in that way.
>
...
> The original running process comes back faulting again, finds the
> semaphore still unlocked (the "ps" process is awake but has not gotten to
> run yet), gets the semaphore, and falls asleep on the IO for the next
> page.
> 
> The "ps" process actually gets to run now, but it's a bit late. The
> semaphore is locked again.
> 
> Repeat until luck breaks the bad circle.
> 

But doesn't __down have a fast path coded in assembly?  In other words,
it only hits your patched code if there is already contention, which
there isn't in this case, and therefore the bug...?

David Mansfield
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
