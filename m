Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268377AbTCCGPV>; Mon, 3 Mar 2003 01:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268383AbTCCGPV>; Mon, 3 Mar 2003 01:15:21 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:60622 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S268377AbTCCGPU>;
	Mon, 3 Mar 2003 01:15:20 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303030625.h236Pgj08874@csl.stanford.edu>
Subject: Re: [CHECKER] potential deadlocks
To: akpm@digeo.com (Andrew Morton)
Date: Sun, 2 Mar 2003 22:25:42 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030302221806.59836766.akpm@digeo.com> from "Andrew Morton" at Mar 02, 2003 10:18:06 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dawson Engler <engler@csl.stanford.edu> wrote:
> >
> > BTW, are there known deadlocks (harmless or otherwise)?  Debugging
> > the checker is a bit hard since false negatives are silent...
> 
> Known deadlocks tend to get fixed.  But I am surprised that you did not
> encounter more of them.

;-)

I sent out a *very* small subset of the checker's output.  There are
hundreds of messages.  I wanted to check on validity before flooding
people.


> btw, the filesystem transaction operations can be treated as sleeping locks. 
> So for ext3, journal_start()/journal_stop() may, for lock-ranking purposes,
> be treated in the same way as taking and releasing a per-superblock
> semaphore.  Other filesystems probably have similar restrictions.
> 
> Other such "hidden" sleeping locks are lock_sock() and wait_on_inode().  The
> latter is rather messy because there is no clear API function which sets
> I_LOCK.
> 
> And pte_chain_lock() is a custom spinlock.

Good deal.  Thanks for the pointers, I was missing all of these besides
lock_sock.

One nice thing is that the race detector has been OK at pointing out
when a locking function is missing from our list.

Dawson
