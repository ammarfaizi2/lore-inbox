Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130654AbQJ1DOx>; Fri, 27 Oct 2000 23:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130773AbQJ1DOo>; Fri, 27 Oct 2000 23:14:44 -0400
Received: from al-pt3.sonet.pt ([195.8.11.81]:2564 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S130654AbQJ1DOk>;
	Fri, 27 Oct 2000 23:14:40 -0400
Date: Sat, 28 Oct 2000 04:14:23 +0100 (WEST)
From: Rui Sousa <rsousa@grad.physics.sunysb.edu>
To: Jens Axboe <axboe@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Blocked processes <=> Elevator starvation?
In-Reply-To: <20001027134603.A513@suse.de>
Message-ID: <Pine.LNX.4.21.0010280408520.1157-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000, Jens Axboe wrote:

...
> > So it seems the process is either in a loop in ___wait_on_page()
> > racing for the PageLock or it never wakes-up... (I guess I could add a
> > printk to check which)
> > Unfortunately I didn't find anything obviously wrong with the code.
> > I hope you can do a better job tracking the problem down.
> 
> Rik is right, just because you are seeing long waits on wait_on_page
> doesn't make it a vm problem. When a I/O on a page completes, the
> page will be unlocked and wait_on_page can grab it -- so I/O stalls
> would results in this behaviour.
> 
> Could you try this patch:
> 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test10-pre6/blk-7.bz2
> 
> and see if it makes a difference?

After adding

#define ELEVATOR_HOLE_MERGE     3

to linux/include/linux/elevator.h it compiled ok.
There were still some stalls but they only lasted a couple of
seconds. The patch did make a difference and for the better.

Rui Sousa

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
