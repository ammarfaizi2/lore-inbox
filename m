Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268335AbTCFUd4>; Thu, 6 Mar 2003 15:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268376AbTCFUd4>; Thu, 6 Mar 2003 15:33:56 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:19604 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S268335AbTCFUdy>; Thu, 6 Mar 2003 15:33:54 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 6 Mar 2003 12:52:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HT and idle = poll
In-Reply-To: <Pine.LNX.4.44.0303061204120.8404-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.50.0303061219270.1670-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0303061204120.8404-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Linus Torvalds wrote:

>
> On Thu, 6 Mar 2003, Davide Libenzi wrote:
> >
> > Not only. The polling CPU will also shoot a strom of memory requests,
> > clobbering the CPU's memory I/O stages.
>
> Well, that would only be true with a really crappy CPU with no caches.
>
> Polling the same location (as long as it's a pure poll, not trying to do
> some locked read-modify-write cycle) should be fine. At least for
> something like idle-polling, where the one location it _is_ polling should
> not actually be touched by anybody else until the wakeup actually happens.

We are talking about HT, don't we ? Cores share execution units and memory
requests are shot on the memory I/O units of the CPU. Before there is a
cache circuitry intervention. Something like "while (!run);" will generate
an enormous amount of memory I/O requests on the CPU's memory units. That
are shared by cores. Even with non-HT CPU, the above loop creates problems
respect of the latency to exit the loop itself when the condition will
become true. This because of the huge number of alloc request issued, that
must be, exiting the loop, 1) discarded 2) checked against reordering. But
I don't think the exit latency matters a lot here.



- Davide

