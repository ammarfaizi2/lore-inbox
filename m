Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265191AbSKDFP5>; Mon, 4 Nov 2002 00:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265284AbSKDFP5>; Mon, 4 Nov 2002 00:15:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:47767 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265191AbSKDFP4>;
	Mon, 4 Nov 2002 00:15:56 -0500
Date: Sun, 3 Nov 2002 21:18:01 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Davide Libenzi <davidel@xmailserver.org>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, <hch@lst.de>,
       Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: interrupt checks for spinlocks
In-Reply-To: <Pine.LNX.4.44.0211031731270.954-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33L2.0211032117190.10796-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Davide Libenzi wrote:

| On Sun, 3 Nov 2002, William Lee Irwin III wrote:
|
| > On Sun, 3 Nov 2002, William Lee Irwin III wrote:
| > [...]
| > >> The only action taken is printk() and dump_stack(). No arch code has
| > >> been futzed with to provide irq tainting yet. Looks like a good way
| > >> to shake out lurking bugs to me (somewhat like may_sleep() etc.).
| >
| > On Sun, Nov 03, 2002 at 04:15:46PM -0800, Davide Libenzi wrote:
| > > Wouldn't it be interesting to keep a ( per task ) list of acquired
| > > spinlocks to be able to diagnose cross locks in case of stall ?
| > > ( obviously under CONFIG_DEBUG_SPINLOCK )
| >
| > That would appear to require cycle detection, but it sounds like a
| > potential breakthrough usage of graph algorithms in the kernel.
| > (I've always been told graph algorithms would come back to haunt me.)
| > Or maybe not, deadlock detection has been done before.
| >
| > A separate patch/feature/whatever for deadlock detection could do that
| > nicely, though. What I've presented here is meant only to flag far more
| > trivial errors with interrupt enablement/disablement than the full
| > deadlock detection problem.
|
| It's not realy a graph Bill.  Each task has a list of acquired locks (
| by address ). You keep __LINE__ and __FILE__ with you list items. When
| there's a deadlock you'll have somewhere :
|
|    TSK#N	TSK#M
|    -------------
|    ...		...
|    LCK#I	LCK#J
|    ...		...
| -> LCK#J	LCK#I
|
| Then with a SysReq key you dump the list of acquired locks for each task
| who's spinning for a lock. IMO it might be usefull ...

What's a task in this context?  Are we (you) talking about
kernel threads/drivers etc. or userspace?

-- 
~Randy
"I'm a healthy mushroom."

