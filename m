Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268739AbUILOUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268739AbUILOUp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 10:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268742AbUILOUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 10:20:45 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:46494 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268739AbUILOUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 10:20:41 -0400
Date: Sun, 12 Sep 2004 16:17:01 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040912141701.GA21626@nocona.random>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910153421.GD24434@devserv.devel.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 05:34:21PM +0200, Arjan van de Ven wrote:
> disabling is actually not a bad idea; hard irq handlers run for a very short

you mean hard irq handlers "should run" for a very short time. There can
be slow hardware that needs a long time, and fast hardware that needs a
short time, and in turn it makes perfect sense to allow nesting to give
low latency to the "fast" onces, like it has always happened so far (not
only in linux AFIK). Disabling nesting completely sounds a very bad
idea to me, when "limiting nesting" can be achieved easily as confirmed
by Alan too.

> time, but when they nest you effectively have like a semi context switch in
> the middle of the work so performance suffers...

It's not nearly a semi context switch, it's like the timer irq that runs
on top of userspace, not nearly the cost of a context switch (no time
wasted calling the scheduler or the softirqs either for obvious reasons).
