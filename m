Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155983AbQEOTKH>; Mon, 15 May 2000 15:10:07 -0400
Received: by vger.rutgers.edu id <S155956AbQEOTIx>; Mon, 15 May 2000 15:08:53 -0400
Received: from ix.netcorps.com ([207.1.125.106]:36322 "EHLO ix.netcorps.com") by vger.rutgers.edu with ESMTP id <S156176AbQEOTAf>; Mon, 15 May 2000 15:00:35 -0400
Message-ID: <3920494B.CF6C93B7@timpanogas.com>
Date: Mon, 15 May 2000 13:00:27 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.com>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.rutgers.edu, torvalds@transmeta.com
Subject: Re: Proposal for task_queue() WorkToDo Optimization for Network File  Systems
References: <391B77F6.14E6F9DA@timpanogas.com> <20000515200543.A22270@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu



Jamie Lokier wrote:
> 
> Jeff V. Merkey wrote:
> > Work To Do Model in NetWare
> > ---------------------------
> 
> Dynamic thread creation, where when one WTD thread blocks another is
> automatically created for the next task, would be useful in user space
> too.  This has been discussed before but nothing much came of it.

It's very useful for file systems that need to acquire a context for a
retry or failover operation -- fast paths in NetWare try do to as much
as possible in the interrupt service routine, and only defer a limited
class of operations to WTD's, which really speeds things up.  

> 
> It's my understanding that clone() thread creation is pretty fast
> already -- so if you could provide a mechanism for "when thread A blocks
> wake up (or create if you prefer) thread B" that is equally usable by
> user and kernel threads, that would be a nice mechanism for a number of
> scheduling problems.

Ditto.

> 
> The other part: where an interrupt routine can schedule a task to be run
> on exit from the interrupt, is already implemented many different ways
> in Linux.  Tasklets, BHs and "soft real-time" tasks all fall into this
> category.

I've seen the wondorous variety of implementations of this semantic in
the kernel code.  WTD is a very generic way to do this, though.  The
optimization NetWare uses, though, isn't so much in the scheduling
primitive, as in how it's used.  Zero Copy Network I/O.

> 
> There are some bugs in the main kernel which mean that real-time tasks
> aren't always run on time, and within the kernel, it is not preemptible
> in general.  But both of these things are addressed pretty well by
> Ingo's low-latency patch, and as a mere performance optimisation that
> probably isn't required anyway.

The reason you put the current running process back on the head and not
the tail in the WTD optimization is to preserve non-preeemptive kernel
behaviors (which the linux kernel proper exhibits in many areas) and
ordering dependent code.  This also always allows I/O get the highest
priority possible.  I've already coded the WTD code -- just need to
splice it in at the right points.

:-)

Jeff

> 
> enjoy,
> -- Jamie
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
