Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289644AbSAJT07>; Thu, 10 Jan 2002 14:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289624AbSAJT0q>; Thu, 10 Jan 2002 14:26:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17823 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289638AbSAJT0A>;
	Thu, 10 Jan 2002 14:26:00 -0500
Date: Thu, 10 Jan 2002 10:20:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Mike Kravetz <kravetz@us.ibm.com>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.33.0201101457390.4885-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201101017380.2723-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, Ingo Molnar wrote:
>
> First it cleans up the load balancer's interaction with the timer tick.
> There are now two functions called from the timer tick: busy_cpu_tick()
> and idle_cpu_tick(). It's completely up to the scheduler to use them
> appropriately.

This is _wrong_. The timer doesn't even know whether something is an idle
task or not.

Proof: kapmd (right now the scheduler doesn't know this either, but at
least we could teach it to know).

Don't try to make the timer code know stuff that the timer code should not
and does not know about. Just call the scheduler on each tick, and let the
scheduler make its decision.

		Linus

