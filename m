Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVABMEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVABMEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 07:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVABMEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 07:04:42 -0500
Received: from one.firstfloor.org ([213.235.205.2]:45493 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261250AbVABMEk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 07:04:40 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.5isms
References: <20041231230624.GA29411@andromeda> <41D60C35.9000503@yahoo.com.au>
	<m1acrt7bqy.fsf@muc.de> <41D743BE.3060207@yahoo.com.au>
From: Andi Kleen <ak@muc.de>
Date: Sun, 02 Jan 2005 13:04:39 +0100
In-Reply-To: <41D743BE.3060207@yahoo.com.au> (Nick Piggin's message of "Sun,
 02 Jan 2005 11:43:42 +1100")
Message-ID: <m1brc882aw.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:
>
> I'm curious about a couple of points though. First, is that it is basically
> just adding a cache colouring to the stack, right? In that case why do only
> older HT CPUs have bad performance without it? And wouldn't it possibly make

Intel improved the HT implementation over time (there are at least
three generations) In particular the latest "Prescott" CPUs lost a lot
of problems earlier versions have.  As far as I know they improved the
caches to make the cache thrashing problem less severe.


> even non HT CPUs possibly slightly more efficient WRT caching the stacks of
> multiple processes?

Not on x86 no because they normally have physically indexed caches
(except for L1, but that is not really preserved over a context switch)
HT is just a special case because two threads essentially share cache.

In theory it could help on non x86 CPUs with virtually indexed caches,
but it is doubtful if they don't need more advanced forms of cache 
colouring.

> Second, on what workloads does performance suffer, can you remember? I wonder
> if natural variations in the stack pointer as the program runs would mitigate
> the effect of this on all but micro benchmarks?

iirc on lots of different workloas that run code on both virtual
CPUs at the same time. Without it you would get L1 cache thrashing,
which can slow things down quite a lot.

And yes it made a real difference. The P4 cache have some pecularities
("64K aliasing") that made the problem worse.

-Andi
