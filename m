Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSKDBZO>; Sun, 3 Nov 2002 20:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264615AbSKDBZO>; Sun, 3 Nov 2002 20:25:14 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:10385 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264614AbSKDBZN>; Sun, 3 Nov 2002 20:25:13 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 3 Nov 2002 17:39:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, <hch@lst.de>,
       Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: interrupt checks for spinlocks
In-Reply-To: <20021104003906.GB12891@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0211031731270.954-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, William Lee Irwin III wrote:

> On Sun, 3 Nov 2002, William Lee Irwin III wrote:
> [...]
> >> The only action taken is printk() and dump_stack(). No arch code has
> >> been futzed with to provide irq tainting yet. Looks like a good way
> >> to shake out lurking bugs to me (somewhat like may_sleep() etc.).
>
> On Sun, Nov 03, 2002 at 04:15:46PM -0800, Davide Libenzi wrote:
> > Wouldn't it be interesting to keep a ( per task ) list of acquired
> > spinlocks to be able to diagnose cross locks in case of stall ?
> > ( obviously under CONFIG_DEBUG_SPINLOCK )
>
> That would appear to require cycle detection, but it sounds like a
> potential breakthrough usage of graph algorithms in the kernel.
> (I've always been told graph algorithms would come back to haunt me.)
> Or maybe not, deadlock detection has been done before.
>
> A separate patch/feature/whatever for deadlock detection could do that
> nicely, though. What I've presented here is meant only to flag far more
> trivial errors with interrupt enablement/disablement than the full
> deadlock detection problem.

It's not realy a graph Bill.  Each task has a list of acquired locks (
by address ). You keep __LINE__ and __FILE__ with you list items. When
there's a deadlock you'll have somewhere :

   TSK#N	TSK#M
   -------------
   ...		...
   LCK#I	LCK#J
   ...		...
-> LCK#J	LCK#I

Then with a SysReq key you dump the list of acquired locks for each task
who's spinning for a lock. IMO it might be usefull ...



- Davide



