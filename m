Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155477AbQEORxc>; Mon, 15 May 2000 13:53:32 -0400
Received: by vger.rutgers.edu id <S155437AbQEORxV>; Mon, 15 May 2000 13:53:21 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:2670 "EHLO smtp1.cern.ch") by vger.rutgers.edu with ESMTP id <S155268AbQEORxI>; Mon, 15 May 2000 13:53:08 -0400
Date: Mon, 15 May 2000 20:05:43 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Jeff V. Merkey" <jmerkey@timpanogas.com>
Cc: linux-kernel@vger.rutgers.edu, torvalds@transmeta.com
Subject: Re: Proposal for task_queue() WorkToDo Optimization for Network File Systems
Message-ID: <20000515200543.A22270@pcep-jamie.cern.ch>
References: <391B77F6.14E6F9DA@timpanogas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <391B77F6.14E6F9DA@timpanogas.com>; from jmerkey@timpanogas.com on Thu, May 11, 2000 at 09:18:14PM -0600
Sender: owner-linux-kernel@vger.rutgers.edu

Jeff V. Merkey wrote:
> Work To Do Model in NetWare
> ---------------------------

Dynamic thread creation, where when one WTD thread blocks another is
automatically created for the next task, would be useful in user space
too.  This has been discussed before but nothing much came of it.

It's my understanding that clone() thread creation is pretty fast
already -- so if you could provide a mechanism for "when thread A blocks
wake up (or create if you prefer) thread B" that is equally usable by
user and kernel threads, that would be a nice mechanism for a number of
scheduling problems.

The other part: where an interrupt routine can schedule a task to be run
on exit from the interrupt, is already implemented many different ways
in Linux.  Tasklets, BHs and "soft real-time" tasks all fall into this
category.

There are some bugs in the main kernel which mean that real-time tasks
aren't always run on time, and within the kernel, it is not preemptible
in general.  But both of these things are addressed pretty well by
Ingo's low-latency patch, and as a mere performance optimisation that
probably isn't required anyway.

enjoy,
-- Jamie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
