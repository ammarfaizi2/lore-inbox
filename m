Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267476AbTBPUEi>; Sun, 16 Feb 2003 15:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267482AbTBPUEi>; Sun, 16 Feb 2003 15:04:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5129 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267476AbTBPUEh>; Sun, 16 Feb 2003 15:04:37 -0500
Date: Sun, 16 Feb 2003 12:10:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
In-Reply-To: <Pine.LNX.4.44.0302162100140.24528-100000@dbl.q-ag.de>
Message-ID: <Pine.LNX.4.44.0302161206540.2952-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Manfred Spraul wrote:
> But these lines are not in 2.4 or 2.5.61.
> The current rule to nesting tasklist_lock and task_lock is
> - read_lock(&tasklist_lock) and task_lock can be mixed in any order.
> - write_lock_irq(&tasklist_lock) and task_lock are incompatible.

Oh, you're right, and you're right exactly _because_ "task->signal" isn't
protected by the task lock right now. Aurgh. I had already mentally done
that protection, which is why I thought we already had the bug.

So never mind. 2.4.x is obviously also ok.

> What about this minimal patch? The performance critical operation is 
> signal delivery - we should fix the synchronization between signal 
> delivery and exec first.

The patch looks ok, although I'd also remove the locking and testing from
collect_sigign_sigcatch() once it is done at a higher level.

And yeah, what about signal delivery? Put back the same lock there?

		Linus

