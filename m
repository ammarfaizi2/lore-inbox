Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264590AbSIVWr1>; Sun, 22 Sep 2002 18:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264591AbSIVWr0>; Sun, 22 Sep 2002 18:47:26 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:59094 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S264590AbSIVWrX>; Sun, 22 Sep 2002 18:47:23 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Sep 2002 18:52:19 -0400 (EDT)
To: Ingo Molnar <mingo@elte.hu>
Cc: bob <bob@watson.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       <okrieg@us.ibm.com>, <trz@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <Pine.LNX.4.44.0209230052580.28641-100000@localhost.localdomain>
References: <15758.14124.935684.460733@k42.watson.ibm.com>
	<Pine.LNX.4.44.0209230052580.28641-100000@localhost.localdomain>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15758.18582.488305.152950@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > On Sun, 22 Sep 2002, bob wrote:
 > 
 > > > (this is in essence a moving spinlock at the tail of the trace buffer -
 > > > same problem.)
 > > 
 > > No, we use lock-free atomic operations to reserve a place in the buffer
 > > to write the data.  What happens is you attempt to atomic move the
 > > current index pointer forward.  If you succeed then you have bought
 > > yourself that many data words in the queue.  In the unlikely event you
 > > happened to collide with someone you perform the atomic operation again.
 > 
 > you have not understood what i have written.
 > 
 > what you do has the same (bad) effect as a global spinlock, it in essence
 > has the same cache effect as a constantly moving spinlock at the 'end' of
 > the trace buffer. Cachelines bounce between CPUs. Only completely per-CPU
 > trace buffers solve this problem.

As per previous email, we are moving to a per-CPU scheme.  On a technical
note: a cache-line ping-ponging is bad - a global spinlock is horrendous.
They're different - the lock-less MP scheme gets rid of them both.

>  - do not disable interrupts when writing events. I used this method in
>    a tracer and it works well. Just get an irq-safe index to the trace
>    ring-buffer and fill it in. [eg. on x86 incl can be used for this
>    purpose.]

The lock-less scheme does not disable interrupts - we've eliminated that.

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com
