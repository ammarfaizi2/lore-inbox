Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264583AbSIVWln>; Sun, 22 Sep 2002 18:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264587AbSIVWlm>; Sun, 22 Sep 2002 18:41:42 -0400
Received: from mx2.elte.hu ([157.181.151.9]:21457 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264583AbSIVWlm>;
	Sun, 22 Sep 2002 18:41:42 -0400
Date: Mon, 23 Sep 2002 00:55:06 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: bob <bob@watson.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, <okrieg@us.ibm.com>, <trz@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <15758.14124.935684.460733@k42.watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0209230052580.28641-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, bob wrote:

> > (this is in essence a moving spinlock at the tail of the trace buffer -
> > same problem.)
> 
> No, we use lock-free atomic operations to reserve a place in the buffer
> to write the data.  What happens is you attempt to atomic move the
> current index pointer forward.  If you succeed then you have bought
> yourself that many data words in the queue.  In the unlikely event you
> happened to collide with someone you perform the atomic operation again.

you have not understood what i have written.

what you do has the same (bad) effect as a global spinlock, it in essence
has the same cache effect as a constantly moving spinlock at the 'end' of
the trace buffer. Cachelines bounce between CPUs. Only completely per-CPU
trace buffers solve this problem.

	Ingo

