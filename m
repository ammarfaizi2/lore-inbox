Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131990AbRDCCUm>; Mon, 2 Apr 2001 22:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132224AbRDCCUd>; Mon, 2 Apr 2001 22:20:33 -0400
Received: from chromium11.wia.com ([207.66.214.139]:24082 "EHLO neptune.kirkland.local") by vger.kernel.org with ESMTP id <S131990AbRDCCU0>; Mon, 2 Apr 2001 22:20:26 -0400
Message-ID: <3AC93417.7B7814FC@chromium.com>
Date: Mon, 02 Apr 2001 19:23:19 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: a quest for a better scheduler
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I sent a message a few days ago about some limitations I found in the
linux scheduler.

In servers like Apache where a large (> 1000) number of processes can be
running at the same time and where many of them are runnable at the same
time, the default Linux scheduler just starts trashing and the machine
becomes very rapidly unusable.

Performance degradations are quite noticeable on a two-way SMP machine
(20-30% of the CPU gets lost) and are even more glaring on a multi-cpu
machine. As an example, an 8-way Compaq Proliant just crawls with linux.

>From the feedback I received I realized that there are at least two
possible solutions to the problem:

    http://lse.sourceforge.net/scheduling/

    http://resourcemanagement.unixsolutions.hp.com/WaRM/schedpolicy.html

Indeed I've tried the patches available on the sites for the multi-queue
scheduler and I was amazed by the performance improvement that I got.
Both patches allow me to get to a 100% real CPU utilization on a two way
machine running ~1500 processes.

What those patches do is quite simple, instead of having the single
global process queue present in the normal Linux scheduler, they add
multiple queues (one per CPU). In this way the scheduling decision can
be greatly simplified and almost made local to each CPU. No hotspots, no
global locks (well, almost).

Although some scalability problems are still there (there still is a
global decision to make), the performance improvement obtained and the
simplicity of the solution are remarkable.

The HP patch is probably the most interesting, since it consists of
really a few lines of code and it gets (for what I could measure) the
same kind of performance improvement of the more elaborate (but still
quite simple) sourceforge patch.

Is there any special reason why any of those patches didn't make it to
the mainstream kernel code?

TIA, ciao,

 - Fabio


